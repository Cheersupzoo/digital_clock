import 'package:digital_clock/widgets/digit.dart';
import 'package:digital_clock/widgets/wave.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digi Clock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Digi Clock'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<int> second0;
  ValueNotifier<int> second1;
  ValueNotifier<int> minute0;
  ValueNotifier<int> minute1;
  ValueNotifier<int> hour0;
  ValueNotifier<int> hour1;
  ValueNotifier<bool> isDark;
  double dashWidth = 8.0 * 0.7;
  double dashHeight = 40.0 * 0.7;

  DateTime current;
  Stream<DateTime> timer;

  @override
  void initState() {
    super.initState();
    second0 = ValueNotifier<int>(8);
    second1 = ValueNotifier<int>(8);
    minute0 = ValueNotifier<int>(8);
    minute1 = ValueNotifier<int>(8);
    hour0 = ValueNotifier<int>(8);
    hour1 = ValueNotifier<int>(8);
    current = DateTime.now();
    timer = Stream.periodic(Duration(seconds: 1), (i) {
      current = DateTime.now().add(Duration(seconds: 1));
      return current;
    });

    timer.listen((time) {
      second0.value = time.second % 10;
      second1.value = (time.second / 10).floor();
      minute0.value = time.minute % 10;
      minute1.value = (time.minute / 10).floor();
      hour0.value = time.hour % 10;
      hour1.value = (time.hour / 10).floor();
    });

    isDark = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // calculate Dash length
    if ((MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height) <
        (14.3 / 5)) {
      dashWidth = MediaQuery.of(context).size.width / (143 / 2);
      dashHeight = dashWidth * 5;
    } else {
      dashHeight = (MediaQuery.of(context).size.height - 100.0) / (13 / 5);
      dashWidth = dashHeight / 5;
    }
    return Scaffold(
        backgroundColor: isDark.value ? Colors.grey[900] : Colors.grey[50],
        body: SafeArea(
          child: Stack(children: <Widget>[
            _buildBackgroundWave(context),
            _buildClock(),
            _buildSwitch()
          ]),
        ));
  }

  Center _buildClock() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildHourDash(),
          _buildDot(),
          _buildMinuteDash(),
          _buildDot(),
          _buildSecondDash(),
        ],
      ),
    );
  }

  Row _buildDot() {
    return Row(
      children: <Widget>[
        SizedBox(width: dashHeight / 2),
        Container(
            width: dashWidth,
            height: dashWidth,
            color: isDark.value ? Colors.grey[300] : Colors.grey[850]),
        SizedBox(width: dashHeight / 2),
      ],
    );
  }

  Widget _buildSecondDash() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Digit(
          dashLength: dashHeight,
          numberNotifier: second1,
          isDark: isDark,
        ),
        SizedBox(width: dashHeight / 2),
        Digit(
          dashLength: dashHeight,
          numberNotifier: second0,
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildMinuteDash() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Digit(
          dashLength: dashHeight,
          numberNotifier: minute1,
          isDark: isDark,
        ),
        SizedBox(width: dashHeight / 2),
        Digit(
          dashLength: dashHeight,
          numberNotifier: minute0,
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildHourDash() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Digit(
          dashLength: dashHeight,
          numberNotifier: hour1,
          isDark: isDark,
        ),
        SizedBox(width: dashHeight / 2),
        Digit(
          dashLength: dashHeight,
          numberNotifier: hour0,
          isDark: isDark,
        ),
      ],
    );
  }

  Positioned _buildSwitch() {
    return Positioned(
      top: 16,
      right: 16,
      child: Switch(
          value: isDark.value,
          activeColor: Colors.grey[600],
          onChanged: (state) {
            isDark.value = state;
            setState(() {});
          }),
    );
  }

  Stack _buildBackgroundWave(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: Wave(
                  color: Colors.grey[700],
                ))),
        Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4.5,
                child: Wave(
                  color: Colors.black38,
                ))),
        Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: Wave(
                  color: Colors.black26,
                ))),
      ],
    );
  }
}
