import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
          ),
          body: Column(
            children: [
              Text(
                'This is a Text.',
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Primary',
                    fontSize: 32.sp),
              ),
              Text(
                'This is a Text.',
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Secondary',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )),
    );
  }
}
