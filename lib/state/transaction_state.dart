import 'package:equatable/equatable.dart';
import 'package:hello_world/model/transaction_model.dart';

abstract class TransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}
class TransactionInitial extends TransactionState{}
class TransactionLoading extends TransactionState{}
class TransactionLoaded extends TransactionState{
  final List<Transaction> transactions;
  final int totalAmount;
  TransactionLoaded(this.transactions, this.totalAmount);

  @override
  List<Object?> get props => [{transactions, totalAmount}];
}
class TransactionFailed extends TransactionState{
  final String error;
  TransactionFailed(this.error);

  @override
  List<Object?> get props => [error];
}