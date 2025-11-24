import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/event/add_transaction_event.dart';
import 'package:hello_world/model/transaction_model.dart';
import 'package:hello_world/repository/transaction_repository.dart';
import 'package:hello_world/state/add_transaction_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransactionBloc extends Bloc<AddTransactionEvent, AddTransactionState> {

  final TransactionRepository repository;

  AddTransactionBloc(this.repository) : super(AddTransactionInitial()) {
    on<AddTransactionButtonClicked>((event, emit) async {
      emit(AddTransactionLoading());
      final localStorage = await SharedPreferences.getInstance();
      int userId = localStorage.getInt('userid')!;

      final res = await repository.createTransaction(
        Transaction.newTransaction(
          userId: userId, 
          amount: event.type == TransactionType.withdraw ? 0 - event.amount : event.amount,
          description: event.description
        )
      );

      if(res!=0){
        emit(AddTransactionSuccess());
      }
      else{
        emit(AddTransactionFailed("Can't create a new transaction"));
      }
    });
  }

}