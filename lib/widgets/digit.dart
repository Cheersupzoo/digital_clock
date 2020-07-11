import 'package:digital_clock/widgets/dash.dart';
import 'package:flutter/material.dart';

class Digit extends StatefulWidget {
  Digit(
      {this.numberNotifier,
      this.dashLength,
      this.onColorLight,
      this.offColorLight,
      this.onColorDark,
      this.offColorDark,
      this.isDark,
      Key key})
      : super(key: key);

  final double dashLength;
  final ValueNotifier<int> numberNotifier;
  final Color onColorLight;
  final Color offColorLight;
  final Color onColorDark;
  final Color offColorDark;
  final ValueNotifier<bool> isDark;

  @override
  _DigitState createState() => _DigitState();
}

class _DigitState extends State<Digit> {
  final DigitDash digit = DigitDash();

  @override
  void initState() {
    widget.numberNotifier.addListener(() {
      for (var i = 0; i < 7; i++)
        digit.dash[i].value = digitTo7Seg[widget.numberNotifier.value][i];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashWidth = widget.dashLength / 5;
    final dashHeight = widget.dashLength;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DashHorizontal(
              status: digit.dash[0],
              width: dashWidth,
              height: dashHeight,
              onColorLight: widget.onColorLight,
              onColorDark: widget.onColorDark,
              offColorDark: widget.offColorDark,
              offColorLight: widget.offColorLight,
              isDark: widget.isDark,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DashVertical(
              status: digit.dash[5],
              width: dashWidth,
              height: dashHeight,
              onColorLight: widget.onColorLight,
              onColorDark: widget.onColorDark,
              offColorDark: widget.offColorDark,
              offColorLight: widget.offColorLight,
              isDark: widget.isDark,
            ),
            SizedBox(width: dashHeight),
            DashVertical(
              status: digit.dash[1],
              width: dashWidth,
              height: dashHeight,
              onColorLight: widget.onColorLight,
              onColorDark: widget.onColorDark,
              offColorDark: widget.offColorDark,
              offColorLight: widget.offColorLight,
              isDark: widget.isDark,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DashHorizontal(
              status: digit.dash[6],
              width: dashWidth,
              height: dashHeight,
              onColorLight: widget.onColorLight,
              onColorDark: widget.onColorDark,
              offColorDark: widget.offColorDark,
              offColorLight: widget.offColorLight,
              isDark: widget.isDark,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DashVertical(
              status: digit.dash[4],
              width: dashWidth,
              height: dashHeight,
              onColorLight: widget.onColorLight,
              onColorDark: widget.onColorDark,
              offColorDark: widget.offColorDark,
              offColorLight: widget.offColorLight,
              isDark: widget.isDark,
            ),
            SizedBox(width: dashHeight),
            DashVertical(
              status: digit.dash[2],
              width: dashWidth,
              height: dashHeight,
              onColorLight: widget.onColorLight,
              onColorDark: widget.onColorDark,
              offColorDark: widget.offColorDark,
              offColorLight: widget.offColorLight,
              isDark: widget.isDark,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DashHorizontal(
              status: digit.dash[3],
              width: dashWidth,
              height: dashHeight,
              onColorLight: widget.onColorLight,
              onColorDark: widget.onColorDark,
              offColorDark: widget.offColorDark,
              offColorLight: widget.offColorLight,
              isDark: widget.isDark,
            ),
          ],
        )
      ],
    );
  }

  var digitTo7Seg = [
    [false, false, false, false, false, false, true],   // 0
    [true, false, false, true, true, true, true],       // 1
    [false, false, true, false, false, true, false],    // 2
    [false, false, false, false, true, true, false],    // 3
    [true, false, false, true, true, false, false],     // 4
    [false, true, false, false, true, false, false],    // 5
    [false, true, false, false, false, false, false],   // 6
    [false, false, false, true, true, true, true],      // 7
    [false, false, false, false, false, false, false],  //  8
    [false, false, false, false, true, false, false],   // 9
  ];
}

class DigitDash {
  List<ValueNotifier<bool>> dash = [
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false)
  ];
}
