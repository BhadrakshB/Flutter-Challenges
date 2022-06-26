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
    IconThemeData iconTheme = const IconThemeData(
      color: Colors.white,
      size: 25,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 560,
              child: Column(
                children: const [
                  CustomCard(
                    label: Text(
                      'Tasks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    rightNumber: Text(
                      '1830',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leftNumber: Text(
                      '12',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: Icons.menu,
                  ),
                  CustomCard(
                    label: Text(
                      'Analytics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    rightNumber: Text(
                      '883',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leftNumber: Text(
                      '4',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: Icons.menu,
                  ),
                  CustomCard(
                    label: Text(
                      'Works',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    rightNumber: Text(
                      '326',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leftNumber: Text(
                      '2',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: Icons.menu,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Text label;
  final Text rightNumber;
  final Text leftNumber;
  final IconData icon;

  const CustomCard({
    Key? key,
    required this.label,
    required this.rightNumber,
    required this.leftNumber,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 175,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: label,
              ),
              Align(alignment: Alignment.bottomLeft, child: leftNumber),
              Align(alignment: Alignment.bottomRight, child: rightNumber),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.menu,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.pie_chart,
                  color: Color(0XFFFA2B0F),
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    IconThemeData iconTheme = const IconThemeData(
      color: Colors.white,
      size: 25,
    );
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        color: Color(0XFFFA2B0F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "All",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: IconTheme(
                    data: iconTheme,
                    child: const Icon(Icons.radio_button_checked),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: IconTheme(
                    data: iconTheme,
                    child: const Icon(Icons.home),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: IconTheme(
                    data: iconTheme,
                    child: const Icon(Icons.settings),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
