
import 'package:flutter/material.dart';
import 'package:newsappflutter/screens/MainScreen.dart';
import 'package:newsappflutter/screens/NewsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget
{
const LoginPage({super.key});

@override
State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> loginkey = GlobalKey<FormState>();

Future<void> login() async {
  if (loginkey.currentState!.validate()) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false,
    );
  }
}




@override
  void initState() {

  emailController.text = '';
  passwordController.text = '';
    super.initState();
  }
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Login'),
),
body: Form(
key: loginkey,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
children: [
TextFormField(
autovalidateMode: AutovalidateMode.onUserInteraction,
controller: emailController,
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your Email';
}
final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
if (!emailRegex.hasMatch(value)) {
return 'Enter a valid email';
}
return null;
},
decoration: const InputDecoration(
labelText: 'Email',
hintText: 'Enter your Email',
),
),
TextFormField(
autovalidateMode: AutovalidateMode.onUserInteraction,
controller: passwordController,
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your password';
}
return null;
},
decoration: const InputDecoration(
labelText: 'Password',
hintText: 'Enter your password',
),
obscureText: true,
),
const SizedBox(height: 30),
Row(
  children: [
    Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logging in...')),
          );
          await login(); // this will save to SharedPreferences and navigate
        },
        child: const Text('Login'),
      ),
    ),
  ],
),
],
),
),
),
);
}
}