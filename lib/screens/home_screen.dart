import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_diary/constant/variables.dart';
import 'package:expense_diary/controllers/expense_controller.dart';
import 'package:expense_diary/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    data.docs.forEach((element) {
      tempList.add(element.data());
    });
    setState(() {
      items = tempList;
      isLoaded = true;
    });
    print(items);
  }

  @override
  void initState() {
    // TODO: implement initState
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Expense Information',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Secondary',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                // isLoaded ? Text(items.toString()) : const Text('No data found')
                isLoaded
                    ? ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Expanded(
                            child: ListTile(
                              title: Text(items[index]['cost_description']),
                            ),
                          );
                        })
                    : const Text('No Daa')
              ],
            ),
          )),
    );
  }
}
