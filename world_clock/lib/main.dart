import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:location/location.dart';
import 'dart:math' as math;
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
  int currPage = 0;
  String hour = '0';
  String minute = '0';
  String seconds = '0';
  double hourPercent = 0;
  double minutePercent = 0;
  double secondsPercent = 0;
  String AMPM = DateTime.now().hour > 12 ? 'PM' : 'AM';
  DateTime now = DateTime.now();
  Location locationData = Location();

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration.zero, (t) {
      setState(() {
        secondsPercent = double.parse(seconds) / 60;
        minutePercent = double.parse(minute) / 60;
        hourPercent = DateTime.now().hour / 12;
        hour = DateTime.now().hour < 12
            ? DateTime.now().hour.toString().padLeft(2, '0')
            : (DateTime.now().hour - 12).toString().padLeft(2, '0');
        minute = (DateTime.now().minute).toString().padLeft(2, '0');
        seconds = DateTime.now().second.toString().padLeft(2, '0');
        AMPM = DateTime.now().hour > 12 ? 'PM' : 'AM';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        iconSize: 35,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade600,
        onTap: (value) => setState(() {
          currPage = value;
        }),
        currentIndex: currPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Clock'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, -0.2),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      offset: Offset(3, 3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(40),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                    ),
                    CustomPaint(
                      size: const Size(260, 260),
                      painter: LinePainter(
                        secondPercent: secondsPercent,
                        minutePercent: minutePercent,
                        hourPercent: hourPercent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'India',
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$hour:$minute:$seconds $AMPM",
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                splashColor: Colors.black,
                child: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 10)
                      ]),
                  child: const Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final double hourPercent;
  final double minutePercent;
  final double secondPercent;

  LinePainter(
      {required this.hourPercent,
      required this.minutePercent,
      required this.secondPercent});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4;

    Paint second = Paint()
      ..color = Colors.red
      ..strokeWidth = 3;

    Paint minute = Paint()
      ..color = Colors.grey
      ..strokeWidth = 3;

    Paint hour = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;

    double offset = 110;
    int length = 15;
    int divisions = 24;
    double angle = 2 * math.pi / divisions;
    int radius = 140;

    for (int i = 0; i < 24; i++) {
      canvas.drawLine(
          Offset(size.width / 2 + radius * math.sin(angle * i),
              offset + radius * math.cos(angle * i)),
          Offset(
            size.width / 2 + (radius - length) * math.sin(angle * i),
            offset + (radius - length) * math.cos(angle * i),
          ),
          paint);
    }

    double secondRadius = 100;
    double minuteRadius = 85;
    double hourRadius = 70;

    double secondAngle = 2 * math.pi * secondPercent;
    double minuteAngle = 2 * math.pi * minutePercent;
    double hourAngle = 2 * math.pi * hourPercent;

    Offset secondOffset = Offset(110 + secondRadius * math.sin(secondAngle),
        110 - secondRadius * math.cos(secondAngle));

    Offset minuteOffset = Offset(110 + minuteRadius * math.sin(minuteAngle),
        110 - minuteRadius * math.cos(minuteAngle));

    Offset hourOffset = Offset(110 + hourRadius * math.sin(hourAngle),
        110 - hourRadius * math.cos(hourAngle));

    canvas.drawLine(
        secondOffset, Offset(size.height / 2, size.width / 2), second);
    canvas.drawLine(
        minuteOffset, Offset(size.height / 2, size.width / 2), minute);
    canvas.drawLine(hourOffset, Offset(size.height / 2, size.width / 2), hour);
    return;
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(LinePainter oldDelegate) => false;
}
