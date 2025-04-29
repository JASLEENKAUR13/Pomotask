

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomotask/my_pages/screen_logout.dart';
import 'package:pomotask/my_pages/screen_signup.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  String userId;
   CustomAppBar({ required this.userId,
    super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return AppBar( 
      automaticallyImplyLeading: false,
       
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.white,
      //centerTitle: true,
   


      title: Text("Pomotask"),
      
      actionsPadding: EdgeInsets.only(right:15),
      actions: [
        InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenLogout()));
            },
            borderRadius: BorderRadius.circular(40),
            child: CircleAvatar(
              backgroundImage:  user?.photoURL != null ?  
              NetworkImage(user!.photoURL!) : AssetImage(
                  'Assets/Images/Logo.jpg',
                 
                ) as ImageProvider,
            )
            )



      ],

    );
    
  }
}






            