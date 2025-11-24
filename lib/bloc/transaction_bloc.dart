import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/event/transaction_event.dart';
import 'package:hello_world/repository/transaction_repository.dart';
import 'package:hello_world/state/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  
  final TransactionRepository transaction;

  TransactionBloc(this.transaction) : super(TransactionInitial()) {
    on<LoadTransactions>(_loadTransactions);
    on<AddTransaction>(_addTransaction);
  }

  Future<void> _loadTransactions(LoadTransactions event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try{
      final transactions = await transaction.getAllTransactions();
      final totalAmount = await transaction.totalAmount();
      emit(TransactionLoaded(transactions, totalAmount));
    }
    catch (e){
      emit(TransactionFailed(e.toString()));
    }
  }

  Future<void> _addTransaction(AddTransaction event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try{
      await transaction.createTransaction(event.transaction);
      if(state is TransactionLoaded){
        final current = (state as TransactionLoaded).transactions;
        final totalAmount = (state as TransactionLoaded).totalAmount;

        emit(TransactionLoaded([...current, event.transaction], totalAmount + event.transaction.amount));
      }
    }
    catch (e){
      emit(TransactionFailed(e.toString()));
    }
  }

}