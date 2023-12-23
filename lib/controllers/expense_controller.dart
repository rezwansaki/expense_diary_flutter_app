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

// update a single expense to insert data to expenses collection
updateExpense(String costDescription, String expenseAmount) async {
  try {
    // store user id as token in the device
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('user_id');

    // insert expense data in expenses collection
    await FirebaseFirestore.instance.collection('expenses').doc().update({
      'cost_description': costDescription,
      'expense_amount': num.parse(expenseAmount),
      'uid': userId,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    });
  } catch (e) {
    print(e);
  }
}
