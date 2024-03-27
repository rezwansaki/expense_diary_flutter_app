import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_diary/constant/variables.dart';
import 'package:expense_diary/controllers/expense_controller.dart';
import 'package:expense_diary/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _costDescriptionController =
      TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();

  var collection = FirebaseFirestore.instance
      .collection("expenses")
      .orderBy('updatedAt', descending: true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(appName),
          ),
          drawer: const CustomDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => SimpleDialog(
                  children: [
                    Center(
                        child: Text(
                      'Add Expense',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Secondary',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Cost Description',
                        ),
                        style: const TextStyle(color: Colors.black),
                        controller: _costDescriptionController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Expense Amount',
                        ),
                        style: const TextStyle(color: Colors.black),
                        controller: _expenseAmountController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: () => {
                                createExpense(_costDescriptionController.text,
                                    _expenseAmountController.text),
                                setState(() {
                                  _costDescriptionController.clear();
                                  _expenseAmountController.clear();
                                }),
                                Navigator.pop(context),
                              },
                          child: const Text('Add')),
                    )
                  ],
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: EdgeInsets.all(8.w),
            child: StreamBuilder(
              stream: collection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final FirebaseAuth auth = FirebaseAuth.instance;
                        // final User? user = auth.currentUser;
                        // final uid = user?.uid;
                        // print(snapshot.data!.docs[index]['uid']);
                        // if (snapshot.data!.docs[index]['uid'] == uid) {
                        // logged in user can access only his or her data
                        return Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: ListTile(
                              title: Text(snapshot.data!.docs[index]
                                  ['cost_description']),
                              subtitle: Text(
                                  "${DateFormat('yMMMMEEEEd').format(snapshot.data!.docs[index]['updatedAt'].toDate())}"
                                  "\n ${snapshot.data!.docs[index]['expense_amount']} tk"
                                  // "\n ${snapshot.data!.docs[index].id}",
                                  ),
                              trailing: SizedBox(
                                  width: 80.w,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                SimpleDialog(
                                              children: [
                                                Center(
                                                    child: Text(
                                                  'Edit Expense',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Secondary',
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: TextField(
                                                    autofocus: true,
                                                    decoration:
                                                        const InputDecoration(),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    controller:
                                                        TextEditingController(
                                                            text: snapshot.data!
                                                                    .docs[index]
                                                                [
                                                                'cost_description']),
                                                    onChanged: (value) {
                                                      _costDescriptionController
                                                          .text = value;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: TextField(
                                                    autofocus: true,
                                                    decoration:
                                                        const InputDecoration(),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    controller:
                                                        TextEditingController(
                                                      text: snapshot
                                                          .data!
                                                          .docs[index]
                                                              ['expense_amount']
                                                          .toString(),
                                                    ),
                                                    onChanged: (value) {
                                                      _expenseAmountController
                                                          .text = value;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: ElevatedButton(
                                                      onPressed: () => {
                                                            updateExpense(
                                                                _costDescriptionController
                                                                    .text,
                                                                _expenseAmountController
                                                                    .text,
                                                                snapshot.data!
                                                                            .docs[
                                                                        index][
                                                                    'createdAt'],
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id
                                                                    .toString()),
                                                            Navigator.pop(
                                                                context),
                                                          },
                                                      child:
                                                          const Text('Edit')),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                      )),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text("Confirm"),
                                                    content:
                                                        const SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text("Are you sure?")
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        child: const Text("No"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        child:
                                                            const Text("Yes"),
                                                        onPressed: () {
                                                          deleteExpense(snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id
                                                              .toString());
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))),
                        );
                        // } else {
                        //   print('No data found!');
                        // }
                      },
                    ),
                  );
                } else {
                  const Text('data not found');
                }
                return const CircularProgressIndicator();
              },
            ),
          )),
    );
  }
}
