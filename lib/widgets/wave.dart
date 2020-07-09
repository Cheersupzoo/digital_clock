import 'package:flutter/material.dart';
import 'dart:math';

class Wave extends StatefulWidget {
  Wave({Key key, this.color}) : super(key: key);
  Color color;

  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<Wave> with TickerProviderStateMixin {
  Color color;
  AnimationController time;
  double waveOffset;
  double randomOffset;

  @override
  void initState() {
    randomOffset = Random().nextInt(40)/0.1;
    color = widget.color ?? Colors.grey[800];
    time = AnimationController(vsync: this,duration: Duration(seconds: 40));
    time.addListener(() {
      setState(() {});
    });
    waveOffset = Tween<double>(begin: 0,end: 2*pi).animate(time).value;
    time.repeat();

    super.initState();
  }

  @override
  void dispose() {
    time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: WavePainter(color,waveOffset,randomOffset));
  }
}

class WavePainter extends CustomPainter {
  Color color;
  double waveOffset;
  double randomOffset;

  WavePainter(this.color,this.waveOffset,this.randomOffset);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final highestWaveHeight =
        (2 * sin(0.3 * (pi / 2)) + 5 * sin(0.7 * (pi / 2))) * 0.2;

    Path path = Path();
    path.moveTo(0, ypos(0) + highestWaveHeight);

    for (var xpos = 1.0; xpos <= width+1; xpos = xpos + 1)
      path.lineTo(xpos, ypos(xpos) + highestWaveHeight);

    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  double ypos(double xpos) {
    final currenttime = DateTime.now().millisecondsSinceEpoch * 0.0003;
    final waveHeightVariance = 6 + 1*sin(currenttime*2);
    final offset = waveOffset + randomOffset;
    final waveHeightScale = 4;
    final wave = 6 * sin(0.01 * xpos + offset);
    final waveVariance = waveHeightVariance * sin(0.03 * xpos + offset + currenttime);
    return (wave + waveVariance) * waveHeightScale;
  }

  @override
  bool shouldRepaint(CustomPainter oldCanvas) {
    return true;
  }
}
