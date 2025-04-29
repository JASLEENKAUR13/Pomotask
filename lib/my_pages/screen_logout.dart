

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pomotask/my_pages/screen_signup.dart';

class ScreenLogout extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  




  User? user = FirebaseAuth.instance.currentUser;

  Future<void> signout() async {
    await Future.wait([
      _googleSignIn.signOut(),
      _auth.signOut(),
      
    ]);

   }

   bool isLoggingout = false;

 
  

  

  
  @override
  Widget build(BuildContext context) {
    final userEmail  = user?.email?? 'No email available';
   return Scaffold(



    body:  Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFF121212),

      child: Padding( padding: EdgeInsets.all(20) ,child : Column(
        children: [
          SizedBox(height : 30),
          CircleAvatar(
            minRadius:  30,
            maxRadius:  50,
              backgroundImage:  user?.photoURL != null ?  
              NetworkImage(user!.photoURL!) : AssetImage(
                  'Assets/Images/Logo.jpg',
                 
                ) as ImageProvider,
            ) ,
            SizedBox(height : 15) ,

            Text(userEmail , style: TextStyle(fontSize:  18 , 
            fontWeight:  FontWeight.w400 ,
            
             color : Colors.white),) ,

            Spacer(),


            IconButton(onPressed:  () async {
              await signout();
              Navigator.pushAndRemoveUntil(context, 
              MaterialPageRoute(builder: (context) => ScreenSignup()), 
              (route) => false);
              

            }
            , icon: Icon(Icons.exit_to_app))

        ],
      ),)
    ),

   );

   

  }
 

}


