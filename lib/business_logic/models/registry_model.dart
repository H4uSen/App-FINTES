class Registry {
  final String registryId;
  final String title;
  final String description;
  String accountId;
  final String ownerId;
  final double amount;
  final bool isDeposit;
  final String date;
  String comesFrom = '';

  String accountName = '';
  String accountType; 

  Registry({
    required this.ownerId,
    this.registryId = "",
    required this.title,
    required this.description,
    required this.accountId,
    required this.accountType,
    required this.amount,
    required this.isDeposit,
    required this.date,
  });

  factory Registry.fromJson(Map<String, dynamic> json, String id) {
    return Registry(
      registryId: id,
      ownerId: json['ownerId'],
      title: json['title'],
      description: json['description'],
      accountId: json['accountId'],
      accountType: json['accountType'],
      amount: double.parse(json['amount'].toString()),
      isDeposit: json['isDeposit'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'accountId': accountId,
      'accountType': accountType,
      'amount': amount,
      'isDeposit': isDeposit,
      'date': date,
    };
  }
}