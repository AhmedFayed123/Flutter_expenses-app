import 'package:expenses_app/expenses_list/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        useMaterial3: true,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white70
        ),
        cardTheme: CardTheme().copyWith(
          color: Colors.lightBlueAccent,
          margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8)
        )
      ),
      home: const Expenses(),
    );
  }
}


