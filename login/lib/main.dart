import 'dart:ui';

import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.all(35),
            height: 290,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFf45d27), Color(0xFFf5851f)],
              ),
            ),
            child: Stack(
              children: const [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 75,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  child: Textfields(
                    placeholder: "Email",
                    icon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  child: Textfields(
                    placeholder: "Password",
                    icon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFf45d27),
                          Color(0xFFf5851f),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Textfields extends StatelessWidget {
  final String placeholder;
  final Icon icon;
  const Textfields({Key? key, required this.placeholder, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      width: 340,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
          hintText: placeholder,
          prefixIcon: icon,
        ),
      ),
    );
  }
}
