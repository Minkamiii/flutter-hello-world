import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/bloc/add_transaction_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/description_field.dart';
import 'package:hello_world/component/text_field/money_field.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/event/add_transaction_event.dart';
import 'package:hello_world/repository/transaction_repository.dart';
import 'package:hello_world/state/add_transaction_state.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransaction();

}

class _AddTransaction extends State<AddTransaction> {

  final TextEditingController amount = TextEditingController();
  final TextEditingController description = TextEditingController();
  TransactionType? selectedType = TransactionType.gain;

  void addTransactionListener(BuildContext context, AddTransactionState state){
    if(state is AddTransactionSuccess){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Create transaction successfull"))
      );

      context.go("/home");
    }
    if(state is AddTransactionFailed){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error))
      );
    }
  }

  Widget addTransactionBuilder(BuildContext context, AddTransactionState state){
    if(state is AddTransactionLoading){
      return CircularProgressIndicator();
    }
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create new transaction",
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 30),
          MoneyField(label: "Amount", controller: amount),

          SizedBox(height: 12),
          Text("Transaction type", style: TextStyle(fontSize: 18)),
          SizedBox(height: 7),
          DropdownButton<TransactionType>(
            isExpanded: true,
            value: selectedType,
            onChanged: (TransactionType? newValue) => {
              setState(() {
                selectedType = newValue;
              }),
            },
            items: TransactionType.values
                .map(
                  (type) => DropdownMenuItem<TransactionType>(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  ),
                )
                .toList(),
          ),

          SizedBox(height: 12),
          DescriptionField(
            label: "Description", 
            controller: description
          ),

          SizedBox(height: 20),
          LoginButton(
            onPressed: (() {
              context.read<AddTransactionBloc>().add(
                AddTransactionButtonClicked(
                  int.parse(amount.text), 
                  description.text, 
                  selectedType!
                )
              );
            }), 
            text: "Create new transaction"
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTransactionBloc(TransactionRepository()),
      child: Scaffold(
        body: BlocListener<AddTransactionBloc, AddTransactionState>(
          listener: addTransactionListener,
          child: BlocBuilder<AddTransactionBloc, AddTransactionState>(
            builder: addTransactionBuilder,
          ),
        ),
      )
    );
  }

}