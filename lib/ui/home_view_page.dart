import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/bloc/transaction_bloc.dart';
import 'package:hello_world/event/transaction_event.dart';
import 'package:hello_world/repository/transaction_repository.dart';
import 'package:hello_world/state/transaction_state.dart';
import 'package:intl/intl.dart';

class HomeViewPage extends StatelessWidget {

  const HomeViewPage({super.key});

  void transactionListener(BuildContext context, TransactionState state){
    if(state is TransactionFailed){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error))
      );
    }
  }

  Widget transactionBuilder(BuildContext context, TransactionState state){
    if (state is TransactionLoading) return CircularProgressIndicator();
    if(state is TransactionLoaded){
      int totalAmount = state.totalAmount;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              'Purse: $totalAmount VND', 
              style: TextStyle(
                fontSize: 30,
                color: totalAmount >= 0 ? Colors.green[400] : Colors.red[400],
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: state.transactions
                    .map(
                      (t) => ListTile(
                        title: Text(
                          '${t.amount} VND',
                          style: TextStyle(
                            fontSize: 16,
                            color: t.amount >= 0
                                ? Colors.green[400]
                                : Colors.red[400],
                          ),
                        ),
                        subtitle:
                            t.description != null && t.description!.isNotEmpty
                            ? Text(t.description!)
                            : null,
                        trailing: Text(
                          DateFormat('dd/MM/yyyy HH-mm').format(t.time!),
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    )
                    .toList(),
              )
            )
          ],
        ),
      );
    }
    return Center();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionBloc(TransactionRepository())..add(LoadTransactions()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.go("/add/transaction"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          child: Icon(Icons.add, size: 28),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: BlocListener<TransactionBloc, TransactionState>(
          listener: transactionListener,
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: transactionBuilder
          ),
        ),
      )
    );
  }

}