// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DetailsInfo extends StatefulWidget {
  dynamic singleData;
  DetailsInfo({super.key, required this.singleData});

  @override
  State<DetailsInfo> createState() => _DetailsInfoState(singleData);
}

class _DetailsInfoState extends State<DetailsInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  dynamic singleData;
  _DetailsInfoState(this.singleData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details Info'),
        ),
        body: Column(
          children: [
            // 'singleData' contains an object of a single data
            Text(
              singleData['cost_description'].toString(),
              style: TextStyle(fontSize: 20.sp),
            ),
            Text(
              "${singleData['expense_amount'].toString()} Tk.",
              style: TextStyle(fontSize: 15.sp),
            ),
            SizedBox(height: 15.h), // space between column's children
            Text(
                "Created date: ${DateFormat('yMMMMEEEEd').format(singleData['createdAt'].toDate())}"),
            Text(
                "Last update: ${DateFormat('yMMMMEEEEd').format(singleData['updatedAt'].toDate())}"),
            SizedBox(height: 15.h), // space between column's children
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            ),
          ],
        ));
  }
}
