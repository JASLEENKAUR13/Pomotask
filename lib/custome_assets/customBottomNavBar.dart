import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomotask/my_pages/screen_logIn.dart';
import 'package:pomotask/my_pages/screen_welcome.dart';

class MyBottomNavItem{
  final int id;
  final IconData icon ; 
 
  final String label ;


  const MyBottomNavItem({
    required this.id,
    required this.icon , 
   
    required this.label,
  });

}




final List<MyBottomNavItem> bottomnavitems = 
const [
  MyBottomNavItem(id: 0 ,
   icon: Icons.checklist, 
  
    label:"tasks") ,

    MyBottomNavItem(id: 1 ,
   icon: Icons.timer, 
   
    label:"pomodoro") ,


];






Widget buildItem( int index , bool isselected , MyBottomNavItem item  , Function(int) onTap ){

  

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,

   // mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(  onPressed: (){
        onTap(index);
        
    
    
  }, 
  icon:   Icon(item.icon , 
  color : isselected ? Colors.white :  Color(0xFFAFAFAF), size : 30) , 
      )
    ],
  )
  ;
  
    

}





      