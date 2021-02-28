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

  Budget(
      {this.startDate, this.endDate, this.amount, this.items, this.hasItems});

  /// No argument constuctor
  Budget.noArgument() {
    this.startDate = DateTime.now();
    this.endDate = DateTime.now().add(Duration(days: 7));
    this.amount = 0;
    this.items = {};
    this.hasItems = false;
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
    };
  }

  /// Creating a Trip object from a firebase snapshot
  Budget.fromSnapshot(DocumentSnapshot documentSnapshot)
      : startDate = documentSnapshot.data()['startDate'].toDate(),
        endDate = documentSnapshot.data()['endDate'].toDate(),
        amount = documentSnapshot.data()['amount'].toDouble(),
        notes = documentSnapshot.data()['notes'],
        items = Map<String, double>.from(documentSnapshot.data()['items']),
        amountUsed = documentSnapshot.data()['amountUsed'],
        amountSaved = documentSnapshot.data()['amountSaved'],
        hasItems = documentSnapshot.data()['hasItems'],
        documentId = documentSnapshot.id;
}
