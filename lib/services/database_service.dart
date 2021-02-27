import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:groceries_budget_app/models/budget.dart';

class DatabaseService {
  String uid;

  DatabaseService({@required this.uid});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Save data to firestore
  Future saveToFirestore(Budget budget) async {
    await _firestore
        .collection('userData')
        .doc(uid)
        .collection('budgets')
        .add(budget.toJson());
  }
}
