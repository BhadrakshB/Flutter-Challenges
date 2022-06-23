import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white, opacity: 1.0),
      ),
      home: const Wrapper(
        child: MyHomePage(),
      ),
    );
  }
}

class Slider extends InheritedWidget {
  const Slider({
    Key? key,
    required this.data,
    required this.child,
    required this.slid,
  }) : super(key: key, child: child);

  final Widget child;
  final bool slid;
  final _WrapperState data;

  static _WrapperState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Slider>()!.data;
  }

  @override
  bool updateShouldNotify(covariant Slider oldWidget) {
    return slid != oldWidget.slid;
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;

  static _WrapperState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Slider>()!.data;

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool slid = false;

  void changeSlid() {
    setState(() {
      slid = !slid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      child: this.widget.child,
      slid: slid,
      data: this,
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var notifier = Slider.of(context);
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        const DrawerPage(),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInCirc,
          left: notifier.slid ? 250 : 0,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 250),
            scale: notifier.slid ? 0.8 : 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(notifier.slid ? 20.0 : 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const HomePage(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var inherited = Slider.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            inherited.changeSlid();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "shopping_basket",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "shopping_cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "person",
          ),
        ],
      ),
      body: Container(),
    );
  }
}

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF2a3ed7),
      body: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 65,
            ),
            ListTile(
              leading: SizedBox(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  foregroundImage: AssetImage(
                      "assets/stock-photo-profile-picture-of-smiling-millennial-asian-girl-isolated-on-grey-wall-background-look-at-camera-250nw-1836020740.jpg"),
                ),
              ),
              title: Text(
                "Taitiana",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.white,
              ),
              title: Text(
                "Search",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ),
              title: Text(
                "Basket",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              title: Text(
                "Discounts",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.code,
                color: Colors.white,
              ),
              title: Text(
                "Prom-codes",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.format_list_bulleted,
                color: Colors.white,
              ),
              title: Text(
                "Others",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 110,
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.headset_mic,
                color: Colors.white,
              ),
              title: Text(
                "Support",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
