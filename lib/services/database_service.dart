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
}
