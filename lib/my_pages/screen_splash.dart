


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pomotask/my_pages/screen_welcome.dart';


class ScreenSplash extends StatefulWidget {

_splashScreen createState() => _splashScreen(); 
}

class _splashScreen extends State<ScreenSplash>{
  String asset = 'Assets/Images/upto (1).svg';

  @override
  void initState() {
   
    super.initState();

   Future.delayed(Duration(seconds: 3), () {
  Navigator.pushReplacement(
    context, 
    MaterialPageRoute(builder: (context) => ScreenWelcome())
  );
});
  

    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container( 
        color :  Color(0xFF121212),
        width : double.infinity , 
        height : double.infinity ,
       child  : Center(
        
        child : Column( mainAxisAlignment: MainAxisAlignment.center, 
        crossAxisAlignment: CrossAxisAlignment.center,
         children :[SvgPicture.asset(asset , width:  200 , height : 200),
         SizedBox(height : 30),
         

        ],)

      ) , )
    );
  }

}