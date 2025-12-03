import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/component/adaptive_layout/base_adaptive_layout.dart';
import 'package:hello_world/component/notification/snack_bar_notification.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/service/get_it/get_it.dart';
import 'package:hello_world/ui/pages/home_view/state/transaction_bloc.dart';
import 'package:hello_world/ui/pages/home_view/state/transaction_event.dart';
import 'package:hello_world/repository/transaction_repository.dart';
import 'package:hello_world/ui/pages/home_view/state/transaction_scope.dart';
import 'package:hello_world/ui/pages/home_view/state/transaction_state.dart';
import 'package:hello_world/ui/pages/main/base_page.dart';
import 'package:intl/intl.dart';

class HomeViewPage extends StatelessWidget with BaseAdaptiveLayout {

  const HomeViewPage({super.key});

  void transactionListener(BuildContext context, TransactionState state){
    if(state is TransactionFailed){
      SnackBarNotification().showSnackBar(
        context: context,
        text: state.error,
        success: false,
      );
    }
  }

  Widget transactionBuilder(BuildContext context, TransactionState state){
    return switch(state){
      var s when s is TransactionLoading => Center(child: CircularProgressIndicator()),
      var s when s is TransactionLoaded => TransactionScope(
        state: state, 
        child: adaptiveLayout(context)
      ),
      _ => Center()
    };
  }

  @override
  Widget buildPortraitMobile(BuildContext context, Size size) {
    final state = TransactionScope.of(context).state as TransactionLoaded;
    int totalAmount = state.totalAmount;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Text(
            AppLocalizations.of(context)!.purse_total(totalAmount),
            style: TextStyle(
              fontSize: 30,
              color: totalAmount >= 0 ? Colors.green[400] : Colors.red[400],
              fontWeight: FontWeight.bold,
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
                        DateFormat(
                          AppLocalizations.of(context)!.day_format,
                        ).format(t.time!),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage<TransactionBloc, TransactionState>(
      onCreate: (_) => TransactionBloc(getIt<TransactionRepository>(), AppLocalizations.of(context)!)..add(LoadTransactions()),
      listener: transactionListener,
      builder: transactionBuilder,
      floatingActionButton: (context, state) => FloatingActionButton(
        onPressed: () {
          context.go('/add/transaction');
        },
        child: Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}