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
      debugShowCheckedModeBanner: false,
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
  final player = AudioPlayer();//.setSourceAsset("/assets/BeepBeep.mp3") as AudioPlayer;
  //player.setSourceAsset('BeepBeep.mp3');

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    timerOn = true;
    player.play(AssetSource('BeepBeep.mp3'));
    player.resume();
    //print(yeet);
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
    timerOn = false;
    player.pause();
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    rand = Random().nextInt(21)+5;
    yeet = 45 + rand;
    count = 0;
    player.setPlaybackRate(1.0);
    player.stop();
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
    //String seconds = "off";

    dynamic background = Colors.deepPurple;
    if(timerOn == true) {
      //player.p
      if (count <= 30) {
        //seconds = "slow";
        background = Colors.green;
        player.setPlaybackRate(1.0);
      }
      else if (count <= 45) {
        //seconds = "medium";
        background = Colors.yellow;
        player.setPlaybackRate(1.5);
      }
      else if (count <= yeet) {
        //seconds = "fast";
        background = Colors.orange;
        player.setPlaybackRate(2.0);
      }
      else {
        //seconds = "done";
        background = Colors.red;
        player.pause();
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
              //Text(seconds),
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
