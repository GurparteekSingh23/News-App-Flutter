

import 'package:flutter/material.dart';
import 'package:newsappflutter/screens/login.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';



import 'providers/ThemeProvider.dart';
import 'screens/MainScreen.dart';

void main() {
  runApp(

      ChangeNotifierProvider(create:(context)=>ThemeProvider(),
          child:  MainApp()
      ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {



  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
  @override
  void initState() {
    Provider.of<ThemeProvider>(context,listen: false).LoadMode();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.isDartModeChecked?ThemeData.dark():ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home:  FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            if (snapshot.data == true) {
              return const MainScreen();
            } else {
              return const LoginPage();
            }
          }
        },
      ),
    );
  }
}
