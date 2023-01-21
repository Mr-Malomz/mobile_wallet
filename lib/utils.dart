class AppConstant {
  final String databaseId = "63cc28af6dac3c463536";
  final String projectId = "63cc281e38eaf93b874c";
  final String userCollectionId = "63cc2969d7ab518e0aa4";
  final String transactionCollectionId = "63cc35d65ed20419ab3b";
  final String endpoint = "http://192.168.1.11/v1";
}

class User {
  String? $id;
  String name;
  int balance;

  User({this.$id, required this.name, required this.balance});

  Map<dynamic, dynamic> toJson() {
    return {"\$id": $id, "name": name, "balance": balance};
  }

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        $id: json['\$id'], name: json['name'], balance: json['balance']);
  }
}

class Transaction {
  String? $id;
  String userId;
  String name;
  String paymentMethod;
  int amount;

  Transaction({
    this.$id,
    required this.userId,
    required this.name,
    required this.paymentMethod,
    required this.amount,
  });

  Map<dynamic, dynamic> toJson() {
    return {
      "\$id": $id,
      "userId": userId,
      "name": name,
      "paymentMethod": paymentMethod,
      "amount": amount
    };
  }

  factory Transaction.fromJson(Map<dynamic, dynamic> json) {
    return Transaction(
        userId: json['userId'],
        name: json['name'],
        paymentMethod: json['paymentMethod'],
        amount: json['amount']);
  }
}
