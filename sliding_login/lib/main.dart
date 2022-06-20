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
      home: const StateWidget(
        child: MyHomePage(),
      ),
    );
  }
}

class StateWidget extends StatefulWidget {
  final Widget child;
  const StateWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<StateWidget> createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  bool display = true;

  void changeFocus() {
    setState(() {
      display = !display;
    });
  }

  @override
  Widget build(BuildContext context) => DropDownInheritance(
        stateWidget: this,
        display: display,
        child: widget.child,
      );
}

class DropDownInheritance extends InheritedWidget {
  const DropDownInheritance(
      {Key? key,
      required this.stateWidget,
      required this.display,
      required this.child})
      : super(key: key, child: child);

  @override
  final Widget child;
  final bool display;
  final _StateWidgetState stateWidget;

  static of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DropDownInheritance>()!
        .stateWidget;
  }

  @override
  bool updateShouldNotify(DropDownInheritance oldWidget) {
    return true;
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
    bool visibility = DropDownInheritance.of(context)!.display;
    return Scaffold(
        body: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 325,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: visibility ? const SignUpScreen() : const SizedBox(),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 205,
          right: 0,
          top: 600,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: visibility ? const SizedBox() : signUpText(),
          ),
        ),
        const LogInDropDown()
      ],
    ));
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
      width: 300,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          border: Border.all()),
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

class LogInDropDown extends StatefulWidget {
  const LogInDropDown({Key? key}) : super(key: key);

  @override
  State<LogInDropDown> createState() => _LogInDropDownState();
}

class _LogInDropDownState extends State<LogInDropDown> {
  @override
  Widget build(BuildContext context) {
    bool visibility = DropDownInheritance.of(context)!.display;
    double radius = 200;
    return GestureDetector(
        onTap: () {
          DropDownInheritance.of(context)!.changeFocus();
        },
        child: AnimatedContainer(
          height: visibility ? 250 : 500,
          decoration: BoxDecoration(
            color: const Color(0XFF2a3ed7),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
            ),
          ),
          duration: const Duration(milliseconds: 250),
          child: Container(
            child: Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: visibility
                    ? Text(
                        'Log In'.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : ListView(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          const Textfields(
                            placeholder: "Email",
                            icon: Icon(Icons.email),
                          ),
                          const Textfields(
                            placeholder: "Password",
                            icon: Icon(Icons.vpn_key),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                primary: const Color(0XFF2a3ed7),
                                backgroundColor: const Color(0XFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                minimumSize: const Size(200, 50)),
                            child: Text(
                              "Log In".toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ].map((e) {
                          if (e.runtimeType.toString() == 'Textfields') {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 50),
                              child: e,
                            );
                          } else if (e.runtimeType.toString() == 'TextButton') {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 100),
                              child: e,
                            );
                          } else {
                            return e;
                          }
                        }).toList(),
                      ),
              ),
            ),
          ),
        ));
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Sign Up'.toUpperCase(),
            style: const TextStyle(
              color: Color(0XFF2a3ed7),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Textfields(
          placeholder: "Email",
          icon: Icon(Icons.email),
        ),
        const Textfields(
          placeholder: "Password",
          icon: Icon(Icons.vpn_key),
        ),
        const Textfields(
          placeholder: "Confirm Password",
          icon: Icon(Icons.vpn_key),
        ),
        const SizedBox(
          height: 50,
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: const Color(0XFF2a3ed7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              minimumSize: const Size(200, 50)),
          child: Text(
            "Sign Up".toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ].map((e) {
        if (e.runtimeType.toString() == 'Textfields') {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
            child: e,
          );
        } else if (e.runtimeType.toString() == 'TextButton') {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: e,
          );
        } else {
          return e;
        }
      }).toList(),
    );
  }
}

Widget signUpText() {
  return Text(
    'Sign Up'.toUpperCase(),
    style: const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Color(0XFF2a3ed7),
    ),
  );
}
