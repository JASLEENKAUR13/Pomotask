import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class Pomodoro extends StatefulWidget {
  _pomodoroScreen createState() => _pomodoroScreen();
}

class _pomodoroScreen extends State<Pomodoro> {
  int timeleft = 25 * 60;
  bool isRunning = false;
  Timer? _timer;
  bool _hasInteracted = false;
  DateTime? lastTap ;
  double scale = 1.0;

  void _startTimer() {
    setState(() {
      isRunning = true;
      _hasInteracted = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (timeleft > 0) {
          setState(() {
            timeleft--;
          });
        } else {
          stopTimer();
        }
      });
    });
  }

  
  void stopTimer() {
    _timer?.cancel();
    setState(() {
      _hasInteracted  = true;
    
      isRunning = false;
    });

    if(timeleft == 0){
      Vibration.vibrate(duration: 500);
      timeleft = 25*60;
    }
  }

  void reSet() {
    
    stopTimer();
    timeleft = 25 * 60;
  }

  String formatMin(int seconds) {
    int minutes = seconds ~/ 60;
    return '${minutes.toString().padLeft(2, '0')}';
  }

  String formatSeconds(int seconds) {
    int sec = seconds % 60;
    return '${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      extendBodyBehindAppBar: true,

      

      body: 
      InkWell( onTap:  isRunning ? stopTimer : _startTimer,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
       
      
      onDoubleTap:  reSet,
        child :  myPomo()

      ) 
         
         
      
    );
  }

  Widget myPomo() {
    return SafeArea(
      child: 
         Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              
              color: Color(0xFF363636),
              child: Padding(padding: EdgeInsets.all(20),child :Text(
                formatMin(timeleft),
                style: TextStyle(
                  fontSize: 90, // Large text
                  fontWeight: FontWeight.w300, // Thin font weight
                ),
              ),)
            ),
            Text(":" , style: TextStyle(
                  fontSize: 90, // Large text
                  fontWeight: FontWeight.w300, // Thin font weight
                ),),
            Card(
              //width: double.infinity/2,
              //height: 500,
              
              color: Color(0xFF363636),
              child: Padding(padding: EdgeInsets.all(20),child : Text(
                formatSeconds(timeleft),
                style: TextStyle(
                  fontSize: 90, // Large text
                  fontWeight: FontWeight.w300, // Thin font weight
                ),
              ),)
            ),
          ],


        ), 
        SizedBox(height : 30),

        AnimatedOpacity(opacity: _hasInteracted ? 0.0 : 1.0, 

        duration: Duration(milliseconds:  500),

        child: Column(
          children: [
            Icon(Icons.touch_app, size: 30, color: Colors.grey[600]),
                      SizedBox(height: 10),
                      Text(
                        'Tap to start/stop \nDouble-tap to reset',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                        
                      ),
                      

          ],
        )
        )
       
        ]
        ,
        
        



      ),
      
      );
    
  }
}
