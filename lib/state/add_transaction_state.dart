abstract class AddTransactionState {}
class AddTransactionInitial extends AddTransactionState{}
class AddTransactionLoading extends AddTransactionState{}
class AddTransactionSuccess extends AddTransactionState{}
class AddTransactionFailed extends AddTransactionState{
  final String error;
  AddTransactionFailed(this.error);
}