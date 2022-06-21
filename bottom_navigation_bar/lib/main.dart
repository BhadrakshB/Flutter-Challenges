import 'dart:developer';

import 'package:flutter/material.dart';

import 'bottom_navi_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bottom Navy Bar"),
      ),
      bottomNavigationBar: BottomNaviBar(
        backgroundColor: Colors.white,
        onTap: (value) {
          setState(() {
            index = value;
            log('$value');
          });
        },
        items: [
          BottomNaviBarItem(
            icon: const Icon(Icons.apps),
            label: "Home",
          ),
          BottomNaviBarItem(
            icon: const Icon(Icons.people),
            label: "Users",
          ),
          BottomNaviBarItem(
            icon: const Icon(Icons.message),
            label: "Messages",
          ),
          BottomNaviBarItem(
            icon: const Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
      body: Center(
        child: Text(
          (index + 1).toString(),
          style: const TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
