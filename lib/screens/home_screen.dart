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

  var collection = FirebaseFirestore.instance.collection("expenses");
  late List<Map<String, dynamic>> items;
  bool isLoaded = false;

  showAllData() async {
    List<Map<String, dynamic>> tempList = [];
    var data = await collection.get();
    for (var element in data.docs) {
      // print(element.id); // doc id
      tempList.add(element.data());
    }
    setState(() {
      items = tempList;
      isLoaded = true;
    });
  }

  @override
  void initState() {
    showAllData();
    super.initState();
  }

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
            child: Column(
              children: [
                isLoaded
                    ? Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                              ),
                              child: ListTile(
                                  title: Text(items[index]['cost_description']
                                      .toString()),
                                  subtitle: Text(
                                      "${DateFormat('yMMMMEEEEd').format(items[index]['updatedAt'].toDate())}"
                                      " \n ${items[index]['expense_amount']} tk"),
                                  trailing: SizedBox(
                                    width: 80.w,
                                    child: Row(children: [
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
                                                            text: items[index][
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
                                                    decoration:
                                                        const InputDecoration(),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    controller:
                                                        TextEditingController(
                                                      text: items[index]
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
                                                                    .text),
                                                            Navigator.pop(
                                                                context),
                                                          },
                                                      child:
                                                          const Text('Edit')),
                                                )
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
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ))
                                    ]),
                                  )),
                            );
                          },
                        ),
                      )
                    : const Text('No Data')
              ],
            ),
          )),
    );
  }
}
