import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/detail_provider.dart';
import 'package:to_do_app/providers/task_provider.dart';
import 'package:to_do_app/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>TaskProvider(),
          ),
          
          ChangeNotifierProvider(create: ((context) => DetailProvider()))
      ],
      child:  MaterialApp(
      theme: ThemeData(useMaterial3: true,

      ),
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      home:  const HomePage(),
      )
      );
  }
}


