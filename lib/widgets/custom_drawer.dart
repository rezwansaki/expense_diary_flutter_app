import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_diary/constant/variables.dart';
import 'package:expense_diary/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String userName = '';
  String userEmail = '';
  getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('user_id');
    final db = FirebaseFirestore.instance;
    db.collection("users").where("uid", isEqualTo: userId).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          setState(() {
            userName = docSnapshot.data()['fullname'];
            userEmail = docSnapshot.data()['email'];
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Text(
                    appName,
                    style: TextStyle(
                        fontFamily: 'Secondary',
                        fontWeight: FontWeight.w800,
                        fontSize: 32.sp,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                        fontFamily: 'Secondary',
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                        color: Colors.white),
                  ),
                  Text(
                    userEmail,
                    style: TextStyle(
                        fontFamily: 'Primary',
                        fontWeight: FontWeight.w800,
                        fontSize: 12.sp,
                        color: Colors.white),
                  ),
                ],
              )),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 3'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const AboutListTile(
            icon: Icon(
              Icons.info,
            ),
            applicationName: appName,
            applicationVersion: appVersion,
            applicationLegalese: applicationLegalese,
            aboutBoxChildren: [Text('Test')],
            child: Text('About'),
          ),
          ElevatedButton(
            onPressed: () {
              signOut(context);
              Navigator.pop(context);
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
