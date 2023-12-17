import 'package:expense_diary/constant/variables.dart';
import 'package:expense_diary/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(appName),
          ),
          drawer: const CustomDrawer(),
          body: Column(
            children: [
              Text(
                'This is a Text.',
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Primary',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                'This is a Text.',
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Secondary',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )),
    );
  }
}
