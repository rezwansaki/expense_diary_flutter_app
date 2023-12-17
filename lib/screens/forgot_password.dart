import 'package:expense_diary/constant/variables.dart';
import 'package:expense_diary/controllers/auth_controller.dart';
import 'package:expense_diary/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text(appName)),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 5.h),
                Image.asset(
                  'assets/images/login.jpg',
                  width: 250.w,
                  height: 200.h,
                ),
                SizedBox(height: 5.h),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text(
                      'Email',
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.amber),
                    icon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: () {
                    forgotPassword(context, _emailController.text);
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 15.sp,
                        color: Colors.cyan,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 15.sp,
                        color: Colors.cyan,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
