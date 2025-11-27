import 'package:equatable/equatable.dart';
import 'package:hello_world/service/sqlite/model/transaction_model.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadTransactions extends TransactionEvent{}

class AddTransaction extends TransactionEvent{
  final Transaction transaction;
  AddTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}