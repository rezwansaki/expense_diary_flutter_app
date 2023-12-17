import 'package:expense_diary/constant/variables.dart';
import 'package:expense_diary/controllers/auth_controller.dart';
import 'package:expense_diary/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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
                Text(
                  'Register',
                  style: TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 5.h),
                Image.asset(
                  'assets/images/login.jpg',
                  width: 200.w,
                  height: 120.h,
                ),
                SizedBox(height: 5.h),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    label: Text(
                      'Full Name',
                    ),
                    hintText: 'Type your full name',
                    hintStyle: TextStyle(color: Colors.amber),
                    icon: Icon(Icons.people),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    label: Text(
                      'Address',
                    ),
                    hintText: 'Type your address',
                    hintStyle: TextStyle(color: Colors.amber),
                    icon: Icon(Icons.location_city),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  controller: _genderController,
                  decoration: const InputDecoration(
                    label: Text(
                      'Gender',
                    ),
                    hintText: 'Just type Male or Female',
                    hintStyle: TextStyle(color: Colors.amber),
                    icon: Icon(Icons.abc),
                  ),
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
                SizedBox(height: 5.h),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.amber),
                    icon: Icon(Icons.key),
                  ),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: () {
                    createUserWithEmailAndPassword(
                        context,
                        _emailController.text,
                        _passwordController.text,
                        _nameController.text,
                        _addressController.text,
                        _genderController.text);
                  },
                  child: Text(
                    'Register',
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
                    "Already have an account? Login",
                    style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 15.sp,
                        color: Colors.blue,
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
