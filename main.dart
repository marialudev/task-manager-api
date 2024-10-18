import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/conversion_history_screen.dart';
import 'services/api_service.dart';


//import 'package:flutter/material.dart';
//import 'package:projects/screens/login_screen.dart';
//import 'package:projects/screens/register_screen.dart';
//import 'package:projects/screens/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMaster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',  // Define a tela de login como inicial
      routes: {
        '/login': (context) => LoginScreen(), // Rota para a tela de login
        '/home_page': (context) => TaskListScreen(),
      },
    );
  }
} 