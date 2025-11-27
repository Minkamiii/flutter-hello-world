import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/component/notification/snack_bar_notification.dart';
import 'package:hello_world/extension/transaction_type_localization.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/ui/pages/add_transaction/state/add_transaction_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/description_field.dart';
import 'package:hello_world/component/text_field/money_field.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/ui/pages/add_transaction/state/add_transaction_event.dart';
import 'package:hello_world/repository/transaction_repository.dart';
import 'package:hello_world/ui/pages/add_transaction/state/add_transaction_state.dart';
import 'package:hello_world/ui/pages/main/base_page.dart';

class AddTransaction extends StatelessWidget {

  final TextEditingController amount = TextEditingController();
  final TextEditingController description = TextEditingController();

  AddTransaction({super.key});

  void addTransactionListener(BuildContext context, AddTransactionState state){
    final loc = AppLocalizations.of(context)!;
    if(state is AddTransactionSuccess){
      SnackBarNotification().showSnackBar(
        context: context,
        text: loc.create_transaction_success,
      );

      context.go("/home");
    }
    if(state is AddTransactionFailed){
      SnackBarNotification().showSnackBar(
        context: context,
        text: state.error,
        success: false,
      );
    }
  }

  Widget addTransactionBuilder(BuildContext context, AddTransactionState state){
    if(state is AddTransactionLoading){
      return CircularProgressIndicator();
    }
    final selectedType = (state is AddTransactionInitial) ? state.selectedType : TransactionType.gain;
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.create_new_transaction,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 30),
          MoneyField(label: loc.amount, controller: amount),

          SizedBox(height: 12),
          Text(loc.transaction_type, style: TextStyle(fontSize: 18)),
          SizedBox(height: 7),
          DropdownButton<TransactionType>(
            isExpanded: true,
            value: selectedType,
            onChanged: (TransactionType? newValue) => {
              if(newValue != null){
                context.read<AddTransactionBloc>().add(SelectedTypeChanged(newValue))
              }
            },
            items: TransactionType.values
                .map(
                  (type) => DropdownMenuItem<TransactionType>(
                    value: type,
                    child: Text(type.localized(context)),
                  ),
                )
                .toList(),
          ),

          SizedBox(height: 12),
          DescriptionField(
            label: loc.description, 
            controller: description
          ),

          SizedBox(height: 20),
          LoginButton(
            onPressed: (() {
              context.read<AddTransactionBloc>().add(
                AddTransactionButtonClicked(
                  int.parse(amount.text), 
                  description.text, 
                  selectedType
                )
              );
            }), 
            text: loc.create_new_transaction
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      onCreate: (_) => AddTransactionBloc(TransactionRepository(), AppLocalizations.of(context)!),
      listener: addTransactionListener,
      builder: addTransactionBuilder,
    );
  }
}