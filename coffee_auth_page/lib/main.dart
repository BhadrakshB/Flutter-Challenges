import 'dart:developer';

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
        primaryColor: Colors.brown[600],
      ),
      initialRoute: '/main_page',
      routes: {
        '/main_page': (context) => const MyHomePage(),
        '/signing_page': (context) => NextPage(),
      },
    );
  }
}

class NextPage extends StatefulWidget {
  NextPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  bool isSignIn = true;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final imageLinks = args['carousel'] as List;
    final currentIndex = args['current_index'] as int;
    final PageController pageController = PageController(
      initialPage: currentIndex,
    );
    final PageController signOptionController = PageController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              bottom: 400,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Hero(
                tag: 'page_view',
                child: PageView.builder(
                  itemCount: imageLinks.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          imageLinks.elementAt(index),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  },
                ),
              )),
          Positioned(
            bottom: 420,
            left: 30,
            child: FloatingActionButton(
              heroTag: 'FB1',
              autofocus: false,
              child: isSignIn
                  ? const Icon(Icons.person)
                  : const Icon(Icons.group_add),
              onPressed: () {},
            ),
          ),
          Positioned(
            height: 50,
            top: 295,
            right: 30,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Button("Sign In", () {
                  setState(() {
                    isSignIn = true;
                    signOptionController.animateToPage(0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInCubic);
                  });
                }),
                Button("Sign Up", () {
                  setState(() {
                    isSignIn = false;
                    signOptionController.animateToPage(1,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInCubic);
                  });
                }),
              ],
            ),
          ),
          AnimatedPositioned(
            left: isSignIn ? 242 : 242 + 72,
            top: 340,
            duration: const Duration(milliseconds: 250),
            child: Container(
              height: 2,
              width: 60,
              color: Colors.white,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            bottom: WidgetsBinding.instance.window.viewInsets.bottom != 0.0
                ? -500
                : -400,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView.builder(
              itemCount: 2,
              onPageChanged: (value) {
                setState(() {
                  if (value == 1) {
                    isSignIn = false;
                    signOptionController.animateToPage(1,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeIn);
                  } else if (value == 0) {
                    isSignIn = true;
                    signOptionController.animateToPage(0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeIn);
                  }
                });
              },
              controller: signOptionController,
              itemBuilder: (context, index) {
                return index == 1 ? SignIn() : SignUp();
              },
            ),
          ),
          Positioned(
            bottom: 10,
            width: MediaQuery.of(context).size.width,
            child: AnimatedOpacity(
              opacity: WidgetsBinding.instance.window.viewInsets.bottom > 0.0
                  ? 0.0
                  : 1.0,
              duration: const Duration(milliseconds: 100),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back),
                          Text(
                            "Social Login",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.brown[700],
                      heroTag: 'FB2',
                      child: const Icon(
                        Icons.arrow_forward,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  TextButton Button(String string, Function() onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        string.toUpperCase(),
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget SignIn() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        bottom: 470,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Email Address",
              icon: Icon(
                Icons.email,
                color: Colors.brown.shade700,
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Password",
              counterText: 'Forgot?',
              icon: Icon(
                Icons.key,
                color: Colors.brown.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget SignUp() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        bottom: 470,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Name",
              icon: Icon(
                Icons.person,
                color: Colors.brown.shade700,
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Email Address",
              icon: Icon(
                Icons.email,
                color: Colors.brown.shade700,
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Password",
              counterText: "Forgot?",
              icon: Icon(
                Icons.key,
                color: Colors.brown.shade700,
              ),
            ),
          ),
        ],
      ),
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
  final imageLinks = <String>[
    'https://www.adamgault.co.uk/wp-content/uploads/2015/11/TradeIndustry038.jpg',
    'https://img.etimg.com/thumb/msid-66650613,width-643,imgsize-801611,resizemode-4/coffee.jpg',
    'https://img.etimg.com/thumb/msid-66650613,width-643,imgsize-801611,resizemode-4/coffee.jpg',
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'page_view',
              child: PageView.builder(
                itemCount: imageLinks.length,
                onPageChanged: (value) {
                  currentIndex = value;
                },
                itemBuilder: (context, index) {
                  return Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            height: 1000,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                imageLinks.elementAt(index),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.95),
                            child: Text(
                              'Coffee Beans'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const Alignment(0, -0.80),
                            child: Text(
                              'Monthly Subscriptions'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment(0, 0.95),
                            child: Text(
                              'I am a coffe fanatic. Once you have a proper cup of coffe,\nyou CANNOT go back',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                Text('Sign in to continue'.toUpperCase()),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(icon: const Icon(Icons.camera)),
                    SocialButton(icon: const Icon(Icons.wb_cloudy)),
                    SocialButton(icon: const Icon(Icons.wb_sunny)),
                    SocialButton(
                      icon: const Text("Email"),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/signing_page',
                          arguments: {
                            'current_index': currentIndex,
                            'carousel': imageLinks,
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  InkWell SocialButton({
    required Widget icon,
    Function()? onPressed,
  }) =>
      InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(200),
          ),
          padding: const EdgeInsets.all(10),
          child: icon,
        ),
      );
}
