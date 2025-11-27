import 'package:hello_world/enumerator/type.dart';

abstract class AddTransactionEvent {}
class AddTransactionButtonClicked extends AddTransactionEvent{
  final int amount;
  final String? description;
  final TransactionType type;

  AddTransactionButtonClicked(this.amount, this.description, this.type);
}
class SelectedTypeChanged extends AddTransactionEvent{
  final TransactionType type;
  SelectedTypeChanged(this.type);
}