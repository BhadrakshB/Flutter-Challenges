import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:qr_flutter/qr_flutter.dart';

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
      initialRoute: 'Open Page',
      routes: {
        'Open Page': (context) => const OpeningPage(),
        'Home Page': (context) => const MyHomePage(),
        'Track Page': (context) => const TrackPage(),
        'Scan Page': (context) => const ScanPage(),
        'Panic Page': (context) => const PanicPage(),
      },
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
  final String src = "assets/Adriana-Lima.jpg";

  Widget _topBar(BuildContext context, double x, double y) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 187,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 187,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    x,
                  ),
                  bottomRight: Radius.circular(
                    x,
                  ),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF6037D6),
                    Color(0xFF6137D7),
                    Color(0xFFBC3358),
                  ],
                  stops: [0, 0.3, 1],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_alert,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shield,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0, 2),
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    foregroundImage: AssetImage(
                      src,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget card(Widget icon, Text label) {
    return Card(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: SizedBox(
        height: 120,
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 25),
            label,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBar(context, 90, 100),
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButton(defaultValue: true),
                const Text(
                  "Active Track",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Image.asset(
              "assets/maps.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (() => Navigator.pushNamed(context, "Track Page")),
                  child: card(
                    Icon(
                      Icons.track_changes,
                      size: 30,
                      color: Colors.red.shade900,
                    ),
                    const Text(
                      'Track',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (() => Navigator.pushNamed(context, "Scan Page")),
                  child: card(
                    Icon(
                      Icons.people,
                      size: 30,
                      color: Colors.red.shade900,
                    ),
                    const Text(
                      'Member',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                card(
                  Icon(
                    Icons.question_answer,
                    color: Colors.red.shade900,
                    size: 30,
                  ),
                  const Text(
                    'Public Info',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Hero(
            tag: "Panic Button",
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "Panic Page");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                fixedSize: const Size(150, 150),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
              ),
              child: const Text(
                'PANIC',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Click 3 times to send emergency message",
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ToggleButton extends StatefulWidget {
  bool defaultValue;
  ToggleButton({
    Key? key,
    required this.defaultValue,
  }) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Colors.indigo,
      value: widget.defaultValue,
      onChanged: (value) {
        setState(
          () {
            widget.defaultValue = value;
          },
        );
      },
    );
  }
}

class OpeningPage extends StatefulWidget {
  const OpeningPage({Key? key}) : super(key: key);

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  bool showBottomSheet = false;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      (() => setState(
            () {
              showBottomSheet = true;
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6037D6),
                  Color(0xFF6137D7),
                  Color(0xFFBC3358),
                ],
                stops: [0, 0.1, 0.7],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.asset(
                    "assets/shield.png",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "FamGuard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: MediaQuery.of(context).size.width,
              height: showBottomSheet ? 135 : 0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 20,
                ),
                child: ListView(children: [
                  const Text(
                      'Use the button below to authenticate using your Google Account.'),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "Home Page"),
                    child: Text("GOOGLE SIGN-IN",
                        style: TextStyle(color: Colors.red.shade900)),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrackPage extends StatelessWidget {
  const TrackPage({Key? key}) : super(key: key);
  final String src = "assets/Adriana-Lima.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text("Track"),
      ),
      body: ListView(
        children: [
          Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    foregroundImage: AssetImage(
                      src,
                    ),
                  ),
                  title: const Text("Emily"),
                  subtitle: const Text(
                    "0.8 KM for your position",
                    style: TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Row(
                  children: [
                    ToggleButton(defaultValue: true),
                    const Text("Track"),
                  ],
                )
              ],
            ),
          ),
          Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    foregroundImage: AssetImage(
                      src,
                    ),
                  ),
                  title: const Text("Paula"),
                  subtitle: const Text(
                    "0.8 KM for your position",
                    style: TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Row(
                  children: [
                    ToggleButton(defaultValue: true),
                    const Text("Track"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);
  final String src = "assets/Adriana-Lima.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        toolbarHeight: 230,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Container(
          color: Colors.white,
          height: 180,
          width: 180,
          padding: const EdgeInsets.all(8),
          child: QrImage(
            data:
                "Simple Bar Code. Hehe making text long for beautiful QR Code",
            version: QrVersions.auto,
          ),
        ),
      ),
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: (MediaQuery.of(context).size.width / 2) / 70,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: AssetImage(
                          src,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Emily"),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: AssetImage(
                          src,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Paula"),
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   leading: CircleAvatar(
              //     foregroundImage: AssetImage(
              //       src,
              //     ),
              //   ),
              //   title: const Text("Paula"),
              // ),
            ]
                .map(
                  (e) => SizedBox(
                    height: 50,
                    child: e,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class PanicPage extends StatelessWidget {
  const PanicPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.red.shade900,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, 0.93),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: const Size(120, 20),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  ),
                  child: Text(
                    'STOP',
                    style: TextStyle(
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "Panic Button",
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        fixedSize: const Size(150, 150),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24),
                      ),
                      child: Text(
                        'PANIC',
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              fixedSize: const Size(50, 50),
                              shape: const CircleBorder(),
                            ),
                            child: Icon(
                              Icons.monitor_heart,
                              color: Colors.red.shade900,
                            ),
                          ),
                          const Text(
                            "Health",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              fixedSize: const Size(50, 50),
                              shape: const CircleBorder(),
                            ),
                            child: Icon(
                              Icons.monetization_on,
                              color: Colors.red.shade900,
                            ),
                          ),
                          const Text(
                            "Robbery",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              fixedSize: const Size(50, 50),
                              shape: const CircleBorder(),
                            ),
                            child: Icon(
                              Icons.monitor_heart,
                              color: Colors.red.shade900,
                            ),
                          ),
                          const Text(
                            "Health",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
