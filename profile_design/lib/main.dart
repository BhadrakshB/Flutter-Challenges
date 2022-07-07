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
  Widget dataWidget(String heading, String data, bool isUp) => SizedBox(
        height: isUp ? 80 : null,
        child: Column(
          mainAxisAlignment:
              isUp ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                data,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );

  Widget cutomCard(String title, String value) => Padding(
        padding: const EdgeInsets.only(left: 15),
        child: SizedBox(
          height: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                value,
                style: const TextStyle(),
              ),
            ],
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    Color color = Colors.black.withRed(255).withBlue(80).withGreen(80);
    String imageURL =
        "https://img.olympicchannel.com/images/image/private/t_1-1_600/f_auto/v1538355600/primary/wfrhxc0kh2vvq77sonki";
    final String url =
        'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/09/04/15/lionel-messi-0.jpg?';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.menu),
        actions: const [
          Icon(Icons.notifications),
          SizedBox(
            width: 10,
          ),
        ],
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: color,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: Clip(),
            child: Container(
              height: 235,
              decoration: BoxDecoration(
                color: color,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        height: 110,
                        child: Column(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: CircleAvatar(
                                  radius: 45,
                                  foregroundImage:
                                      NetworkImage(imageURL, scale: 0.5),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Milian Short",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      dataWidget(
                        "Schedule",
                        '8',
                        true,
                      ),
                      dataWidget(
                        'Events',
                        '12',
                        true,
                      ),
                      dataWidget(
                        'Routines',
                        '4',
                        true,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      dataWidget("Savings", "20K", false),
                      const SizedBox(
                        width: 40,
                      ),
                      dataWidget("July Goals", "50K", false),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.rotate(
                        angle: 0.17,
                        child: SizedBox(
                          height: 28,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          cutomCard("Name", "Milan Short"),
          cutomCard("Email", "milan@gmail.com"),
          cutomCard("Loation", "New York, USA"),
          cutomCard("Language", "English, French"),
          cutomCard("Occupation", "Employee"),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    Path path = Path();
    path.lineTo(0, height - 75);
    path.lineTo(width, height);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
