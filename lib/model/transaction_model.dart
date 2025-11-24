class Transaction {
  final int? id;
  final int userId;
  final int amount;
  final String? description;
  final DateTime? time;

  Transaction({
    this.id,
    required this.userId,
    required this.amount,
    this.description,
    this.time,
  });

  Transaction.newTransaction({
    this.id,
    required this.userId,
    required this.amount,
    this.description
  }) : time = DateTime.now();

  Map<String, dynamic> toNewJson() => {
    'userid': userId,
    'amount': amount,
    'description': description,
    'time': time.toString()
  };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json['id'],
    userId: json['userid'], 
    amount: json['amount'],
    description: json['description'],
    time: DateTime.parse(json['time']),
  );

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      userId: map['userid'],
      amount: map['amount'],
      description: map['description'],
      time: DateTime.parse(map['time']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'description': description,
      'time': time
    };
  }
}