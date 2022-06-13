import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Timer",
      home: /*CountdownTimerDemo(),*/home(),
    );
  }
}


class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  //first speed 30 seconds
  //second speed 15 seconds
  //last speed between 5 and 25 seconds
  String start = "Start";
  String stop = "Stop";
  String reset = "Reset";
  Timer? countdownTimer;
  //Random random = Random();
  bool timerOn = false;
  static int count = 0;
  static int rand = Random().nextInt(21) + 5;//random.nextInt(31) + 5;
  static int yeet = 45 + rand;
  Duration myDuration = Duration(seconds: yeet);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    timerOn = true;
    //print(yeet);
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
    timerOn = false;
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    rand = Random().nextInt(21)+5;
    yeet = 45 + rand;
    count = 0;
    setState(() => myDuration = Duration(seconds: yeet));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      count++;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    int time = myDuration.inSeconds.remainder(60);
    String seconds = "off";
    dynamic background = Colors.deepPurple;
    if(timerOn == true) {
      if (count <= 30) {
        seconds = "slow";
        background = Colors.green;
      }
      else if (count <= 45) {
        seconds = "medium";
        background = Colors.yellow;
      }
      else if (count <= yeet) {
        seconds = "fast";
        background = Colors.orange;
      }
      else {
        seconds = "done";
        background = Colors.red;
        timerOn = false;
      }
    }
    //print(count);
    return Scaffold(
      body: Container(
        color: background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(seconds),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: ElevatedButton(onPressed: startTimer, child: Text(start)),
              ),
              ElevatedButton(onPressed: stopTimer, child: Text(stop)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: ElevatedButton(onPressed: resetTimer, child: Text(reset)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CountdownTimerDemo extends StatefulWidget {
  const CountdownTimerDemo({Key? key}) : super(key: key);

  @override
  State<CountdownTimerDemo> createState() => _CountdownTimerDemoState();
}

class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
  // Step 2
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 5);
  @override
  void initState() {
    super.initState();
  }
  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(days: 5));
  }
  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      //appBar: ...,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            // Step 8
            Text(
              '$hours:$minutes:$seconds',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
            const SizedBox(height: 20),
            // Step 9
            ElevatedButton(
              onPressed: startTimer,
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            // Step 10
            ElevatedButton(
              onPressed: () {
                if (countdownTimer == null || countdownTimer!.isActive) {
                  stopTimer();
                }
              },
              child: const Text(
                'Stop',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            // Step 11
            ElevatedButton(
                onPressed: () {
                  resetTimer();
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
