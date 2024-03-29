// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

// creating a single expense to insert data to expenses collection
createExpense(String costDescription, String expenseAmount) async {
  try {
    // store user id as token in the device
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('user_id');
    // var docId = FirebaseFirestore.instance.collection('expenses');
    // print(docId.id);
    // insert expense data in expenses collection
    await FirebaseFirestore.instance.collection('expenses').add({
      'cost_description': costDescription,
      'expense_amount': num.parse(expenseAmount),
      'uid': userId,
      'mark': false,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    }).then((value) {
      // get doc id
      print(value.id);
    });
  } catch (e) {
    print(e);
  }
}

// update a single expense from expenses collection
updateExpense(String costDescription, String expenseAmount, bool mark,
    Timestamp createdAt, String docId) async {
  try {
    // store user id as token in the device
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('user_id');

    // update a single document of expenses collection
    await FirebaseFirestore.instance.collection('expenses').doc(docId).update({
      'cost_description': costDescription,
      'expense_amount': num.parse(expenseAmount),
      'uid': userId,
      'mark': false,
      'createdAt': createdAt.toDate(),
      'updatedAt': DateTime.now(),
    });
  } catch (e) {
    print(e);
  }
}

// delete a single expense from expenses collection
deleteExpense(String docId) async {
  try {
    // store user id as token in the device
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString('user_id');

    // delete a single document from expenses collection
    await FirebaseFirestore.instance.collection('expenses').doc(docId).delete();
  } catch (e) {
    print(e);
  }
}
