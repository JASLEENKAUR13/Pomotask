import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pomotask/backend_code/CrudOperations.dart';
import 'package:pomotask/backend_code/google_auth.dart';
import 'package:pomotask/custome_assets/customBottomNavBar.dart';
import 'package:pomotask/custome_assets/customBottomSheetDrawer.dart';
import 'package:pomotask/custome_assets/customeAppBar.dart';
import 'package:pomotask/custome_assets/tasksClass.dart';
import 'package:pomotask/custome_assets/tasksTile.dart';
import 'package:pomotask/custome_assets/customBottomNavBar.dart' show buildItem;
import 'package:pomotask/my_pages/Screen_edit.dart';
import 'package:pomotask/my_pages/pomodoro.dart';
import 'package:pomotask/my_pages/screen_AllList.dart';

class ScreenMain  extends StatefulWidget{
  
   
  _screenmain createState() => _screenmain();
  
  

}

class _screenmain extends State<ScreenMain>{


int selectedidx = 0;

@override
void initState() {
  super.initState();
  _loadUserId(); // Add this to load userId when screen initializes
}



onTap(int index){
      setState(() {
        selectedidx = index;
       
       
      });
    }

     


Future<void> _loadUserId() async {
  try {
    final id = await Auth().getUID();
    setState(() {
      userId = id;
    });
  } catch (e) {
    // Handle error - maybe navigate to login screen
    debugPrint("Error getting user ID: $e");
  }
}

String? userId ;


  
  @override
  Widget build(BuildContext context)  {
     if (userId == null) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(child: CircularProgressIndicator()),
    );
  }
  
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      
      appBar: CustomAppBar(userId: userId!),



      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, 
        isScrollControlled: true, // Allows sheet to resize for keyboard
            backgroundColor: Color(0xFF363636), // Set background here if needed, or let the content handle it
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),

        builder: (BuildContext context){
          return AddList(userId: userId!);

        });
      } ,  
      child : Icon(Icons.add) ,

      foregroundColor:   Color(0xFF363636),
      backgroundColor:  Colors.white,
      elevation: 10,
      shape: CircleBorder(),

  ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,




       bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all( 3 ),
        height:  60,
        
        elevation: 8,
        color:  Color(0xFF363636),
        notchMargin: 10,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:  bottomnavitems.map(
            (item) => buildItem(
              item.id , 
              selectedidx == item.id ,
              item ,
             onTap,
            ),

          ).toList(),
        )
         )



     ,
      body: Container(width: double.infinity,
      height: double.infinity,color :Color(0xFF121212),

      child: Padding(padding: EdgeInsets.symmetric(horizontal: 20.0) , 
      child : selectedidx == 0
              ?  ScreenAllList(userId: userId!,)
              : Pomodoro()
      )

    ));
    
  }

}




Widget EmptylistScreen(){

  String mysvg = 'Assets/Images/welcome (1).svg';

  return  Container(
    width : double.infinity,
    height : double.infinity , 
    color : Colors.transparent,

    child: Column(
     
      children: [
         Spacer(),
        SvgPicture.asset(mysvg , width : 200 , height : 200 ),
        SizedBox(height : 8),
        Text("What do you want to do today?" , 
        style: TextStyle(color : Colors.white, fontSize: 20),) ,
        SizedBox(height : 4),
         Text("Tap + to add your tasks",
         style: TextStyle(color : Colors.white, fontSize: 16)), 
         Spacer(),

      ],

    ),

  );
  
}






