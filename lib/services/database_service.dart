import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceries_budget_app/models/budget.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Save data to firestore
  Future saveBudgetToFirestore(Budget budget, String uid) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .add(budget.toJson());
  }

  /// Stream of users budget data in database sorted by endDate
  Stream<QuerySnapshot> getUsersBudgetStreamSnapshot(String uid) async* {
    yield* _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .orderBy('endDate', descending: true)
        .snapshots();
  }

  /// Stream of past budgets
  Stream<QuerySnapshot> getPastBudgetsStream(String uid) async* {
    yield* _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .where('endDate', isLessThanOrEqualTo: DateTime.now())
        .snapshots();
  }

  /// Update notes
  Future updateNotes(String uid, String newNotes, Budget budget) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .doc(budget.documentId)
        .update({'notes': newNotes});
  }

  /// Delete an entire budget
  Future deleteBudget(String uid, Budget budget) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .doc(budget.documentId)
        .delete();
  }

  /// Update amount used
  Future updateAmountUsed(String uid, Budget budget) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .doc(budget.documentId)
        .update({'amountUsed': budget.amountUsed});
  }

  /// Update amount saved
  Future updateAmountSaved(String uid, Budget budget) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .doc(budget.documentId)
        .update({'amountSaved': budget.amountSaved});
  }

  /// Update dates
  Future updateDates(String uid, Budget budget) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .doc(budget.documentId)
        .update({
      'startDate': budget.startDate,
      'endDate': budget.endDate,
    });
  }

  /// Update total amount and items
  Future updateAmountAndItems(String uid, Budget budget) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .doc(budget.documentId)
        .update({
      'hasItems': budget.hasItems,
      'items': budget.items,
      'amount': budget.amount,
    });
  }

  /// Feedback from user
  Future uploadFeeback(String uid, String feedback) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('feedback')
        .add({'message': feedback});
  }
}
