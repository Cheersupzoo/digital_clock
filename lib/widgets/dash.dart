import 'dart:math';

import 'package:flutter/material.dart';

class DashVertical extends StatefulWidget {
  const DashVertical(
      {Key key,
      @required this.status,
      @required this.width,
      @required this.height,
      this.onColorLight,
      this.offColorLight,
      this.onColorDark,
      this.offColorDark,
      this.isDark})
      : super(key: key);

  final ValueNotifier<bool> status;
  final double width;
  final double height;
  final Color onColorLight;
  final Color offColorLight;
  final Color onColorDark;
  final Color offColorDark;
  final ValueNotifier<bool> isDark;

  @override
  _DashVerticalState createState() => _DashVerticalState();
}

class _DashVerticalState extends State<DashVertical>
    with TickerProviderStateMixin {
  double width;
  double height;
  AnimationController animationController;
  Animation<double> animationValue;
  Color currentOpenColor;
  Color currentCloseColor;
  Color onColorLight;
  Color offColorLight;
  Color onColorDark;
  Color offColorDark;
  ValueNotifier<bool> isDark;

  void initColorValue() {
    onColorLight = widget.onColorLight ?? Colors.grey[850];
    offColorLight = widget.offColorLight ?? Colors.grey[300];
    onColorDark = widget.onColorDark ?? Colors.grey[300];
    offColorDark = widget.offColorDark ?? Colors.grey[850];
    isDark = widget.isDark ?? ValueNotifier(false);
    currentOpenColor = isDark.value ? onColorDark : onColorLight;
    currentCloseColor = isDark.value ? offColorDark : offColorLight;
  }

  void updateDash() {
    if (widget.status.value) {
      currentOpenColor = isDark.value ? onColorDark : onColorLight;
      currentCloseColor = isDark.value ? offColorDark : offColorLight;
    } else {
      currentOpenColor = isDark.value ? onColorDark : onColorLight;
      currentCloseColor = !isDark.value ? offColorDark : offColorLight;
    }
    animationController.forward(from: 0.0);
  }

  @override
  void initState() {
    initColorValue();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animationController.addListener(() {
      setState(() {});
    });
    animationValue = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 1.0, curve: Curves.fastLinearToSlowEaseIn)));

    widget.status.addListener(updateDash);
    widget.isDark.addListener(updateDash);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = widget.width;
    height = widget.height;
    return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, -0.001)
          ..rotateY(1 * pi * animationValue.value),
        origin: Offset(width / 2, height / 2),
        child: animationValue.value > 0.5
            ? CustomPaint(
                size: Size(width, height),
                painter: DashVerticalPainter(currentCloseColor))
            : CustomPaint(
                size: Size(width, height),
                painter: DashVerticalPainter(currentOpenColor),
              ));
  }
}

class DashVerticalPainter extends CustomPainter {
  Color dashColor;

  DashVerticalPainter(this.dashColor);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final arrowHeight = width / 2;
    final arrowWidth = width / 2;
    final barHeight = height - arrowHeight * 2;

    Path path = Path();
    path.moveTo(0, arrowHeight);
    path.lineTo(arrowWidth, 0);
    path.lineTo(width, arrowHeight);
    path.lineTo(width, arrowHeight + barHeight);
    path.lineTo(arrowWidth, arrowHeight + barHeight + arrowHeight);
    path.lineTo(0, arrowHeight + barHeight);
    path.close();

    Paint paint = Paint()
      ..color = dashColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldCanvas) {
    return true;
  }
}

class DashHorizontal extends StatefulWidget {
  const DashHorizontal(
      {Key key,
      @required this.status,
      this.width,
      this.height,
      this.onColorLight,
      this.offColorLight,
      this.onColorDark,
      this.offColorDark,
      this.isDark})
      : super(key: key);

  final ValueNotifier<bool> status;
  final double width;
  final double height;
  final Color onColorLight;
  final Color offColorLight;
  final Color onColorDark;
  final Color offColorDark;
  final ValueNotifier<bool> isDark;

  @override
  _DashHorizontalState createState() => _DashHorizontalState();
}

class _DashHorizontalState extends State<DashHorizontal>
    with TickerProviderStateMixin {
  double width;
  double height;
  AnimationController animationController;
  Animation<double> animationValue;
  Color currentOpenColor;
  Color currentCloseColor;
  Color onColorLight;
  Color offColorLight;
  Color onColorDark;
  Color offColorDark;
  ValueNotifier<bool> isDark;

  void initColorValue() {
    onColorLight = widget.onColorLight ?? Colors.grey[850];
    offColorLight = widget.offColorLight ?? Colors.grey[300];
    onColorDark = widget.onColorDark ?? Colors.grey[300];
    offColorDark = widget.offColorDark ?? Colors.grey[850];
    isDark = widget.isDark ?? ValueNotifier(false);
    currentOpenColor = isDark.value ? onColorDark : onColorLight;
    currentCloseColor = isDark.value ? offColorDark : offColorLight;
  }

  void updateClock() {
    if (widget.status.value) {
      currentOpenColor = isDark.value ? onColorDark : onColorLight;
      currentCloseColor = isDark.value ? offColorDark : offColorLight;
    } else {
      currentOpenColor = isDark.value ? onColorDark : onColorLight;
      currentCloseColor = !isDark.value ? offColorDark : offColorLight;
    }
    animationController.forward(from: 0.0);
  }

  @override
  void initState() {
    initColorValue();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animationController.addListener(() {
      setState(() {});
    });

    animationValue = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 1.0, curve: Curves.fastLinearToSlowEaseIn)));
    currentOpenColor = Colors.grey[850];
    currentCloseColor = Colors.grey[300];
    widget.status.addListener(updateClock);

    widget.isDark.addListener(updateClock);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = widget.width;
    height = widget.height;
    return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 1, 0.001)
          ..rotateX(1 * pi * animationValue.value),
        alignment: Alignment.center,
        child: animationValue.value > 0.5
            ? CustomPaint(
                size: Size(height, width),
                painter: DashHorizontalPainter(currentCloseColor))
            : CustomPaint(
                size: Size(height, width),
                painter: DashHorizontalPainter(currentOpenColor),
              ));
  }
}

class DashHorizontalPainter extends CustomPainter {
  Color dashColor;

  DashHorizontalPainter(this.dashColor);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final arrowHeight = height / 2;
    final arrowWidth = height / 2;
    final barWidth = width - arrowWidth * 2;

    Path path = Path();
    path.moveTo(0, arrowHeight);
    path.lineTo(arrowWidth, 0);
    path.lineTo(arrowWidth + barWidth, 0);
    path.lineTo(width, arrowHeight);
    path.lineTo(arrowWidth + barWidth, height);
    path.lineTo(arrowWidth, height);
    path.close();

    Paint paint = Paint()
      ..color = dashColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldCanvas) {
    return true;
  }
}