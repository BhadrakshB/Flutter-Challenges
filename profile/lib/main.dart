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
  final String url =
      'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/09/04/15/lionel-messi-0.jpg?';
  final Color green = const Color(0xFF1E8161);

  Widget iconText(IconData icon, String text, bool up) => Column(
        children: [
          Icon(
            icon,
            color: up ? Colors.white : Colors.black45,
          ),
          Text(
            text,
            style: TextStyle(
              color: up ? Colors.white : Colors.black45,
            ),
          ),
        ],
      );

  Widget topContainer(BuildContext context) => Container(
        height: 425,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          
        color: green,
            borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Familiar",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        "8",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 175,
                        width: 175,
                        child: Image.network(
                          url,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text(
                        "ID: 14552566",
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Following",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        "18",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Text(
              "Herman Jimenez",
              style: TextStyle(
                fontSize: 27,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  iconText(Icons.group_add, "Friends", true),
                  iconText(Icons.group, "Groups", true),
                  iconText(Icons.videocam, "Videos", true),
                  iconText(Icons.favorite, "Likes", true),
                ],
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: green,
          title: const Text('Profile'),
          leading: const Icon(Icons.arrow_back_ios_new_rounded),
          actions: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.search),
            ),
          ]),
      body: Column(
        children: [
          topContainer(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: [
                  iconText(Icons.table_chart, "Leaders", false),
                  iconText(Icons.show_chart, "Level Up", false),
                  iconText(Icons.card_giftcard, "Leaders", false),
                  iconText(Icons.qr_code, "QR Code", false),
                  iconText(Icons.blur_circular, "Daily Bonus", false),
                  iconText(Icons.visibility, "Visitors", false),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
