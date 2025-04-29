import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pomotask/backend_code/auth_wrapper.dart';
import 'package:pomotask/backend_code/google_auth.dart';

import 'package:pomotask/my_pages/screen_main.dart';
import 'package:pomotask/my_pages/screen_welcome.dart';


Future<void> main() async { // main is now async
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Wait here!
  runApp(_MyApp());
}

class _MyApp extends StatefulWidget{
  
  MyApp createState() => MyApp();
}

class MyApp extends State <_MyApp> {

  Widget curpage = ScreenWelcome();
  Auth myauth = Auth();

  
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: Color.fromARGB(255, 158, 87, 224),
        ),
      ),
      home: AuthWrapper(),
    );
  }
}



