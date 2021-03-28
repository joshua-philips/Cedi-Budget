import 'package:cloud_firestore/cloud_firestore.dart';

class Budget {
  DateTime startDate;
  DateTime endDate;
  Map<String, double> items;
  double amount;
  String notes;
  double amountUsed;
  double amountSaved;
  bool hasItems;
  String documentId;
  List ledger;

  Budget(
      {this.startDate, this.endDate, this.amount, this.items, this.hasItems});

  /// No argument constuctor
  Budget.noArgument() {
    this.startDate = DateTime.now();
    this.endDate = DateTime.now().add(Duration(days: 7));
    this.amount = 0;
    this.items = {};
    this.hasItems = false;
    this.ledger = [];
  }

  /// Formatting for upload to Firebase
  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'amount': amount,
      'notes': notes,
      'items': items,
      'amountUsed': amountUsed,
      'amountSaved': amountSaved,
      'hasItems': hasItems,
      'ledger': ledger,
    };
  }

  /// Creating a Trip object from a firebase snapshot
  Budget.fromSnapshot(DocumentSnapshot documentSnapshot)
      : startDate = documentSnapshot.data()['startDate'].toDate(),
        endDate = documentSnapshot.data()['endDate'].toDate(),
        amount = documentSnapshot.data()['amount'] ?? 0.0,
        notes = documentSnapshot.data()['notes'],
        items = Map<String, double>.from(documentSnapshot.data()['items']),
        amountUsed = documentSnapshot.data()['amountUsed'] ?? 0.0,
        amountSaved = documentSnapshot.data()['amountSaved'] ?? 0.0,
        hasItems = documentSnapshot.data()['hasItems'],
        documentId = documentSnapshot.id,
        ledger = documentSnapshot.data()['ledger'];

  /// Total days of the budget
  int getTotalDaysofBudget() {
    return endDate.difference(startDate).inDays;
  }

  updateLedger(String amount, String type) {
    double amountDouble = double.parse(amount);
    if (type == 'spent') {
      amountUsed = amountUsed + amountDouble;
    } else {
      amountSaved = amountSaved + amountDouble;
    }
    ledger.add({
      'date': DateTime.now(),
      'amountUsed': type == 'spent' ? amountDouble : 0,
      'amountSaved': type != 'spent' ? amountDouble : 0,
    });
  }
}
