// ignore_for_file: library_private_types_in_public_api

import 'dart:developer' as devtools;
import 'dart:math';

import 'package:bank_app_ui/Components/card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
        backgroundColor: const Color(0xFF311078),
        iconTheme: const IconThemeData(
          color: Colors.white70,
          size: 25,
        ),
      ),
      initialRoute: '/main_page',
      routes: {
        '/main_page': (context) => MainPage(),
        '/second_page': (context) => const SecondPage(),
      },
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        title: Text('Card Details'.toUpperCase()),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Hero(
        tag: Key(args['which_card']),
        child: Material(
          type: MaterialType.transparency,
          child: Transform(
            alignment: const Alignment(-0.6, -0.45),
            transform: Matrix4.identity()..rotateZ(pi / 2),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/main_page',
                );
              },
              child: CreditCard(
                key: Key(args['which_card']),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  List carouselWidgets = const [
    Indicator(
      isActive: true,
    ),
    Indicator(
      isActive: false,
    ),
    Indicator(
      isActive: false,
    ),
    Indicator(
      isActive: false,
    ),
  ];

  List<CreditCard> creditCardWidgets = const [
    CreditCard(),
    CreditCard(),
    CreditCard(),
    CreditCard(),
  ];

  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late PageController pageController = PageController(
    initialPage: selectedIndex,
  );

  @override
  void dispose() {
    pageController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF311078),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedBuilder(
            animation: controller,
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
              title: Text('Card Details'.toUpperCase()),
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              centerTitle: true,
            ),
            builder: (context, child) {
              return Positioned(
                top: -40 + (56 * controller.value),
                left: 1,
                right: 1,
                child: Opacity(opacity: controller.value, child: child),
              );
            },
          ),
          AnimatedBuilder(
            animation: controller,
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: [
                const SizedBox(
                  width: 40,
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
              title: Text('Home'.toUpperCase()),
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              centerTitle: true,
            ),
            builder: (context, child) {
              return Positioned(
                top: 16 - (56 * controller.value),
                left: 1,
                right: 1,
                child: Opacity(opacity: 1 - controller.value, child: child),
              );
            },
          ),
          AnimatedBuilder(
            animation: controller,
            child: CreditCardCarousel(context),
            builder: (context, child) {
              return controller.value == 0
                  ? Positioned(
                      top: 100,
                      left: 1,
                      right: 1 + (250 * controller.value),
                      child: child!)
                  : Positioned(
                      top: 110 + (60 * controller.value),
                      right: 1 + (180 * controller.value),
                      child: GestureDetector(
                        child: Transform.rotate(
                            angle: 90 * controller.value * pi / 180,
                            child: creditCardWidgets.elementAt(selectedIndex)),
                        onTap: () {
                          setState(() {
                            controller.reverse();
                            selectedIndex == 0;
                          });
                        },
                      ),
                    );
            },
          ),
          AnimatedBuilder(
            animation: controller,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text.rich(
                  TextSpan(
                    text: '\$\t',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white30,
                    ),
                    children: [
                      TextSpan(
                        text: '5,680',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [
                    Icon(Icons.payment, color: Colors.white30),
                    SizedBox(width: 8),
                    Text(
                      "Bank Card",
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [
                    Icon(Icons.money, color: Colors.white30),
                    SizedBox(width: 8),
                    Text(
                      "Bank Account",
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: const [
                    Icon(Icons.rss_feed, color: Colors.white30),
                    SizedBox(width: 8),
                    Text(
                      "Pay",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
            builder: (context, child) {
              return Positioned(
                top: 110 + (56 * controller.value),
                left: 190,
                right: 1,
                child: Opacity(opacity: controller.value, child: child),
              );
            },
          ),
          AnimatedBuilder(
            animation: controller,
            child: MainPage(),
            builder: (context, child) {
              return Positioned(
                bottom: 0 - (56 * controller.value),
                left: 1,
                right: 1,
                child: Opacity(opacity: 1 - controller.value, child: child),
              );
            },
          ),
          AnimatedBuilder(
            animation: controller,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Expenses',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 80,
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      lineTouchData: LineTouchData(
                        handleBuiltInTouches: true,
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(
                            color: Color(0xff4e4965),
                            width: 4,
                          ),
                          left: BorderSide(
                            color: Colors.transparent,
                          ),
                          right: BorderSide(
                            color: Colors.transparent,
                          ),
                          top: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        getDrawingVerticalLine: (value) => FlLine(
                          strokeWidth: 0,
                        ),
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.white,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, titleMeta) {
                              switch (value.toInt()) {
                                case 2:
                                  return const Text(
                                    'Jan',
                                    style: TextStyle(color: Colors.white70),
                                  );
                                case 7:
                                  return const Text(
                                    'Feb',
                                    style: TextStyle(color: Colors.white70),
                                  );
                                case 12:
                                  return const Text(
                                    'Mar',
                                    style: TextStyle(color: Colors.white70),
                                  );
                                default:
                                  return const Text(' ');
                              }
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(1, 1),
                            FlSpot(3, 1.5),
                            FlSpot(5, 1.4),
                            FlSpot(7, 3.3),
                            FlSpot(10, 2),
                            FlSpot(12, 2.2),
                            FlSpot(13, 1.8),
                          ],
                          isCurved: true,
                          color: Colors.green,
                          barWidth: 10,
                        ),
                        LineChartBarData(
                          spots: const [
                            FlSpot(1, 1),
                            FlSpot(3, 2.8),
                            FlSpot(7, 1.2),
                            FlSpot(10, 2.8),
                            FlSpot(12, 2.6),
                            FlSpot(13, 3.3),
                          ],
                          isCurved: true,
                          color: const Color(0xFFae06cf),
                          barWidth: 8,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: false,
                          ),
                          belowBarData: BarAreaData(
                            show: false,
                            color: const Color(0x00aa4cfc),
                          ),
                        ),
                        LineChartBarData(
                          spots: const [
                            FlSpot(1, 2.8),
                            FlSpot(3, 1.9),
                            FlSpot(6, 3),
                            FlSpot(10, 1.3),
                            FlSpot(13, 2.5),
                          ],
                          isCurved: true,
                          color: const Color(0xff27b6fc),
                          barWidth: 8,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: false,
                          ),
                          belowBarData: BarAreaData(
                            show: false,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            builder: (context, child) {
              return Positioned(
                bottom: 50 - (56 * (1 - controller.value)),
                left: 25,
                child: Opacity(opacity: controller.value, child: child),
              );
            },
          ),
        ],
      ),
    );
  }

  SizedBox CreditCardCarousel(BuildContext context) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width - 100 + (200 * controller.value),
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        itemCount: creditCardWidgets.length,
        itemBuilder: (context, index) {
          return Material(
            type: MaterialType.transparency,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  controller.forward();
                });
              },
              child: creditCardWidgets.elementAt(selectedIndex),
            ),
          );
        },
      ),
    );
  }

  Column MainPage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              carouselWidgets.length,
              (index) {
                if (index == selectedIndex) {
                  return const Indicator(isActive: true);
                } else {
                  return const Indicator(isActive: false);
                }
              },
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transactions',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.sort_sharp,
                  color: Colors.white70,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        SizedBox(
          height: 350,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: const [
              TransactionCard(
                transactionTo: 'iTunes',
                transactionType: 'Entertainment',
                amount: '450',
                transactionTime: '19:25 PM',
              ),
              TransactionCard(
                transactionTo: 'Google Pay',
                transactionType: 'Entertainment',
                amount: '500',
                transactionTime: '18:30 PM',
              ),
              TransactionCard(
                transactionTo: 'Amazon',
                transactionType: 'Groceries',
                amount: '100',
                transactionTime: '11:20 AM',
              ),
              TransactionCard(
                transactionTo: 'iTunes',
                transactionType: 'Entertainment',
                amount: '450',
                transactionTime: '19:25 PM',
              ),
              TransactionCard(
                transactionTo: 'iTunes',
                transactionType: 'Entertainment',
                amount: '450',
                transactionTime: '19:25 PM',
              ),
              TransactionCard(
                transactionTo: 'iTunes',
                transactionType: 'Entertainment',
                amount: '450',
                transactionTime: '19:25 PM',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {Key? key,
      required this.transactionTo,
      required this.transactionType,
      required this.amount,
      required this.transactionTime})
      : super(key: key);

  final String transactionTo;
  final String transactionType;
  final String amount;
  final String transactionTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12.5),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade600.withOpacity(0.25),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            Icons.account_balance_wallet,
            size: 22,
            color: Colors.white.withOpacity(.3),
          ),
        ),
        title: Text(
          transactionTo,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        subtitle: Text(
          transactionType,
          style: TextStyle(
            color: Colors.white70.withOpacity(0.3),
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '- ${double.parse(amount)} USD',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                transactionTime,
                style: TextStyle(
                  color: Colors.white70.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final isActive;

  const Indicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
