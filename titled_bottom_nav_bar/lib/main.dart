import 'package:flutter/material.dart';
import 'package:titled_bottom_nav_bar/bottom_navi_bar.dart';

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
  bool isOn = false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Titled Bottom Bar'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Reverse"),
              Switch(
                  value: isOn,
                  onChanged: (value) {
                    setState(() {
                      isOn = value;
                    });
                  })
            ],
          ),
        ),
        bottomNavigationBar: BottomNaviBar(
          isReversed: isOn,
          selectedIconColor: Colors.blue,
          selectedLabelColor: Colors.blue,
          backgroundColor: Colors.white,
          items: [
            BottomNaviBarItem(
              icon: const Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNaviBarItem(
              icon: const Icon(Icons.search),
              label: "Search",
            ),
            BottomNaviBarItem(
              icon: const Icon(
                Icons.shopping_bag,
              ),
              label: "Bag",
            ),
            BottomNaviBarItem(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              label: "Orders",
            ),
            BottomNaviBarItem(
              icon: const Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
          onTap: (selectedIndex) {},
        ));
  }
}
