class Budget {
  DateTime startDate;
  DateTime endDate;
  Map<String, double> items;
  double amount;
  String notes;
  double amountUsed;
  double amountSaved;
  String documentId;

  Budget({this.startDate, this.endDate, this.amount, this.items});

  /// No argument constuctor
  Budget.noArgument() {
    this.startDate = DateTime.now();
    this.endDate = DateTime.now().add(Duration(days: 7));
    this.amount = 0;
    this.items = {};
  }

  /// Formatting for upload to Firebase
  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'amount': amount,
      'notes': notes,
      'amountUsed': amountUsed,
      'amountSaved': amountSaved,
    };
  }
}
