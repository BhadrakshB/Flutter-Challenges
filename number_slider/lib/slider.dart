import 'package:flutter/material.dart';
import 'dart:developer' as devtools;

class InheritedWid extends StatefulWidget {
  final Widget child;
  const InheritedWid({Key? key, required this.child}) : super(key: key);

  @override
  _InheritedWidState createState() => _InheritedWidState();
}

class _InheritedWidState extends State<InheritedWid>
    with TickerProviderStateMixin {
  bool isDragging = false;
  Offset position = const Offset(30, 0);

  late var _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void toTrue() {
    setState(
      () {
        isDragging = true;
        _controller.forward();
      },
    );
  }

  void toFalse() {
    setState(
      () {
        isDragging = false;
        _controller.reverse();
      },
    );
  }

  void changePosi(Offset offset) {
    setState(() {
      position = offset;
    });
  }

  @override
  Widget build(BuildContext context) => CurveProperties(
        position: position,
        isDragging: isDragging,
        stateWidget: this,
        controller: _controller,
        child: widget.child,
      );
}

class CurveProperties extends InheritedWidget {
  const CurveProperties({
    Key? key,
    required this.child,
    required this.isDragging,
    required this.stateWidget,
    required this.position,
    required this.controller,
  }) : super(key: key, child: child);

  final Widget child;
  final bool isDragging;
  final Offset position;
  final _InheritedWidState stateWidget;
  final controller;

  static _InheritedWidState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CurveProperties>()!
        .stateWidget;
  }

  @override
  bool updateShouldNotify(CurveProperties oldWidget) {
    return true;
  }
}

class NumberSlider extends StatefulWidget {
  const NumberSlider(
      {Key? key, required this.lowerLimit, required this.upperLimit})
      : super(key: key);
  final int lowerLimit;
  final int upperLimit;

  @override
  State<NumberSlider> createState() => _NumberSliderState();
}

class _NumberSliderState extends State<NumberSlider> {
  int currentValue(BuildContext context, int minVal, int maxVal) {
    var posi = CurveProperties.of(context).position;
    double leftBound = 30;
    double rightBound = MediaQuery.of(context).size.width - 56;
    double available = rightBound - leftBound;
    double percent = (posi.dx - leftBound) / available;
    var value = minVal + (maxVal - minVal) * percent;
    if (value <= minVal) {
      return minVal;
    } else if (value >= maxVal) {
      return maxVal;
    } else {
      return value.roundToDouble().toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDragging = CurveProperties.of(context).isDragging;
    var posi = CurveProperties.of(context).position;
    return SizedBox(
      height: 65,
      width: width,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 40,
            width: width,
            child: CustomPaint(
              foregroundPainter: ArcPainter(
                  context,
                  CurveProperties.of(context)._controller,
                  widget.lowerLimit,
                  widget.upperLimit),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutExpo,
            top: isDragging ? 18 : 35,
            child: DraggableFloatingActionButton(
              initialOffset: const Offset(30, 0),
              onPressed: () {},
            ),
          ),
          Positioned(
            top: 40,
            left: 5,
            child: Text("${widget.lowerLimit}"),
          ),
          Positioned(
            top: 40,
            left: MediaQuery.of(context).size.width - 30,
            child: Text("${widget.upperLimit}"),
          ),
          AnimatedPositioned(
            duration: const Duration(microseconds: 1),
            left: posi.dx + 32,
            child: Text(
              "${currentValue(context, widget.lowerLimit, widget.upperLimit)}",
            ),
          ),
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final BuildContext context;
  final _controller_percent;
  final int minValue;
  final int maxValue;

  ArcPainter(
      this.context, this._controller_percent, this.minValue, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    var posi = CurveProperties.of(context).position;

    Paint arcPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    Path path = Path();

    canvas.drawLine(
      Offset(0, size.height - 10),
      Offset(posi.dx - 30, size.height - 10),
      paint,
    );

    path.moveTo(posi.dx - 30, size.height - 10);

    path.cubicTo(
      posi.dx - 8, //x1
      _controller_percent.value * -2 + size.height - 10, //y1
      posi.dx - 10, //x2
      _controller_percent.value * -25 + size.height - 10, //y2
      posi.dx + 10, //x3
      _controller_percent.value * -25 + size.height - 10, //y3
    );

    path.cubicTo(
        posi.dx + 35, //x1
        _controller_percent.value * -25 + size.height - 10, //y1
        posi.dx + 28, //x2
        _controller_percent.value * -10 + size.height - 10, //y2
        posi.dx + 50, //x3
        size.height - 10 //y3
        );

    canvas.drawPath(path, arcPaint);

    canvas.drawLine(
      Offset(posi.dx + 50, size.height - 10),
      Offset(size.width, size.height - 10),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DraggableFloatingActionButton extends StatefulWidget {
  final Offset initialOffset;
  final VoidCallback onPressed;

  const DraggableFloatingActionButton({
    Key? key,
    required this.initialOffset,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  late Offset _offset;
  late Map<String, Offset> constraints;

  @override
  void initState() {
    super.initState();
    _offset = widget.initialOffset;
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;

    setState(() {
      _offset = Offset(newOffsetX, _offset.dy);
    });
  }

  void outsideBounds(Offset offset) {
    setState(() {
      _offset = offset;
    });
  }

  double diameter = 25;

  @override
  Widget build(BuildContext context) {
    bool isDragging = CurveProperties.of(context).isDragging;
    double width = MediaQuery.of(context).size.width;
    var posi = CurveProperties.of(context).position;
    return SizedBox(
      height: 30,
      width: width,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(microseconds: 1),
            left: _offset.dx,
            top: _offset.dy,
            child: Listener(
              onPointerMove: (PointerMoveEvent pointerMoveEvent) {
                if (_offset.dx >= 30 &&
                    _offset.dx <= MediaQuery.of(context).size.width - 55) {
                  _updatePosition(pointerMoveEvent);
                } else if (_offset <= Offset(30, _offset.dy)) {
                  outsideBounds(Offset(31, _offset.dy));
                } else if (_offset >=
                    Offset(
                        MediaQuery.of(context).size.width - 55, _offset.dy)) {
                  outsideBounds(Offset(
                      MediaQuery.of(context).size.width - 56, _offset.dy));
                } else {}

                setState(() {
                  CurveProperties.of(context).changePosi(_offset);
                });
              },
              onPointerUp: (PointerUpEvent pointerUpEvent) {
                setState(() {
                  CurveProperties.of(context).toFalse();
                });
              },
              onPointerDown: (PointerDownEvent pointerDownEvent) {
                setState(() {
                  CurveProperties.of(context).toTrue();
                });
              },
              child: Center(
                child: AnimatedContainer(
                  transformAlignment: Alignment.center,
                  duration: const Duration(milliseconds: 150),
                  alignment: Alignment.bottomCenter,
                  height: isDragging ? 25 : 20,
                  width: isDragging ? 25 : 20,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension Comparision on Offset {
  bool operator <=(Offset other) => dx <= other.dx && dy <= other.dy;
  bool operator >=(Offset other) => dx >= other.dx && dy >= other.dy;
}
