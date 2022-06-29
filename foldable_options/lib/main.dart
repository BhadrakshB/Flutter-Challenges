import 'dart:core';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools;

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
  var globalPosition = "Offset(0.0,0.0)";

  List<double> getXandY(String offset) {
    RegExp myregex = RegExp("([0-9]+.[0-9]+)");
    var matches = myregex.allMatches(offset);
    return [
      double.parse(matches.elementAt(0)[0] ?? "0.0"),
      double.parse(matches.elementAt(1)[0] ?? "0.0"),
    ];
  }

  bool open = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App'),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          DraggableFloatingActionButton(
            initialOffset: const Offset(1, 1),
            onPressed: () {
              setState(() {
                open = !open;
              });
            },
            child: FoldableOptions(isOpen: open),
          ),
        ],
      ),
    );
  }
}

class FoldableOptions extends StatefulWidget {
  const FoldableOptions({Key? key, required this.isOpen}) : super(key: key);

  final bool isOpen;

  @override
  _FoldableOptionsState createState() => _FoldableOptionsState();
}

class _FoldableOptionsState extends State<FoldableOptions> {
  Widget outButton(Icon icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(size),
        ),
      ),
      height: size,
      width: size,
      child: Center(
        child: icon,
      ),
    );
  }

  double size = 40;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          bottom: widget.isOpen ? 90 : 0,
          child: outButton(
            const Icon(
              Icons.folder,
              color: Colors.white,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          right: widget.isOpen ? 60 : 0,
          bottom: widget.isOpen ? 60 : 0,
          child: outButton(
            const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          right: widget.isOpen ? 90 : 0,
          child: outButton(
            const Icon(
              Icons.visibility_off,
              color: Colors.white,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          right: widget.isOpen ? 60 : 0,
          top: widget.isOpen ? 60 : 0,
          child: outButton(
            const Icon(
              Icons.star_border,
              color: Colors.white,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: widget.isOpen ? 90 : 0,
          child: outButton(
            const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(size),
            ),
          ),
          height: size,
          width: size,
          child: AnimatedRotation(
            turns: widget.isOpen ? (1 / 8) : 0,
            duration: const Duration(milliseconds: 250),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DraggableFloatingActionButton extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final VoidCallback onPressed;

  DraggableFloatingActionButton({
    required this.child,
    required this.initialOffset,
    required this.onPressed,
  });

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  bool _isDragging = false;
  late Offset _offset;

  @override
  void initState() {
    super.initState();
    _offset = widget.initialOffset;
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          _updatePosition(pointerMoveEvent);

          setState(() {
            _isDragging = true;
          });
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          print('onPointerUp');

          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {
            widget.onPressed();
          }
        },
        child: widget.child,
      ),
    );
  }
}
