class Registry {
  final String registryId;
  final String title;
  final String description;
  String accountId;
  final String ownerId;
  final double amount;
  final bool isDeposit;
  final String date;

  Registry({
    required this.ownerId,
    required this.registryId,
    required this.title,
    required this.description,
    required this.accountId,
    required this.amount,
    required this.isDeposit,
    required this.date,
  });
}