import 'package:hello_world/enumerator/type.dart';

abstract class AddTransactionState {}
class AddTransactionInitial extends AddTransactionState{
  final TransactionType selectedType;
  AddTransactionInitial({this.selectedType = TransactionType.gain});
}
class AddTransactionLoading extends AddTransactionState{}
class AddTransactionSuccess extends AddTransactionState{}
class AddTransactionFailed extends AddTransactionState{
  final String error;
  AddTransactionFailed(this.error);
}