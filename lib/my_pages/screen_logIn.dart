
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pomotask/backend_code/auth_wrapper.dart';
import 'package:pomotask/backend_code/google_auth.dart';
import 'package:pomotask/my_pages/screen_main.dart';
import 'package:pomotask/my_pages/screen_signup.dart';

import 'package:pomotask/custome_assets/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenLogin  extends StatefulWidget{
  _screenlogin createState() => _screenlogin();

}

class _screenlogin extends State<ScreenLogin>{
  String image = 'Assets/Images/producitivity (1).svg';
  bool isloadingLogin = false;

  //var lognamecontroller = TextEditingController();
  var logemailcontroller = TextEditingController();
  var logpasscontroller = TextEditingController();
  Auth myauth =Auth();

  var myemail ="" , pass = "";

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
  
    logemailcontroller.dispose();
   logpasscontroller.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :  Container( width : double.infinity,height: double.infinity,color :  Color(0xFF121212) ,
      child :  Padding(padding : EdgeInsets.all(20),child : SingleChildScrollView(child : Form(
        key: _formkey,
        child : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          SizedBox(height: 50,),
          SvgPicture.asset(image , width : 200 , height : 200),
          SizedBox(height: 30),
          
          Row( mainAxisAlignment: MainAxisAlignment.start,children:[Text("Log In" , 
          style: TextStyle(fontSize: 32 , 
          fontWeight: FontWeight.bold , 
          color : Colors.white),)]),
          SizedBox(height : 30),

         
          mytextfield("Enter Your Email", 
          Icon(Icons.email), 

          TextInputType.emailAddress ,

           logemailcontroller , false ,
           (value){
             if(value == null || value.isEmpty){
              return 'Please enter your email';
            }
            if(!value.contains('@')) {
      return 'Please enter a valid email';
    }
            return null;
           } , isloadingLogin ),


          SizedBox(height : 20),

          mytextfield("Enter Password", 
          Icon(Icons.password), 
          TextInputType.visiblePassword , 
          logpasscontroller ,
           true , (value){
             if(value == null || value.isEmpty){
              return 'Please enter your password';
            } return null ;
           } ,isloadingLogin ),
           
           SizedBox(height: 50,),
          


          ElevatedButton(
                  onPressed: () async{
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        isloadingLogin=true;
                      });
                      try{
                       final user = await myauth.login(
                         logemailcontroller.text.trim(), 
                         logpasscontroller.text.trim());

                         if(user != null){
                          Navigator.pushReplacement(context,
                           MaterialPageRoute(builder: (context) => ScreenMain()), 
                           );
                         }



                      }finally{
                        if(mounted){
                          setState(() {
                            isloadingLogin=false;
                          });
                        }

                      }
                    }
                  },
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromARGB(255, 158, 87, 224), // Button color
                    foregroundColor: Colors.white, // Text color
                    minimumSize: Size(double.infinity, 50), // Full width
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    
                    elevation: 5, // Shadow
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 18),
                  ),
                ) , 

                SizedBox(height: 10,),


                ElevatedButton(
                onPressed: () async {
                      setState(() {
                        isloadingLogin = true;
                      });
                      try {
                        final user = await myauth.googleSignIn();
                        if(user != null){
                          Navigator.pushReplacement(context,
                           MaterialPageRoute(builder: (context) => ScreenMain()), 
                           );
                         }
                      } finally {
                        if (mounted) {
                          setState(() => isloadingLogin = false); // Stop loading
                        }
                      }
                    },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Transparent background
                  foregroundColor: Colors.white,
                  
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: const Color.fromARGB(255, 158, 87, 224)), // Outline border
                  ),
                ),
                
                child: Row( mainAxisAlignment: MainAxisAlignment.center,children : [ 
                 FaIcon(FontAwesomeIcons.google , size:20 , color: Colors.white,),
                   SizedBox(width: 15,),
                  Text(
                    

                 "Login With Google",
                  style: TextStyle(fontSize: 18),
                ),])
              ),
              SizedBox(height : 2),



                Padding(padding: EdgeInsets.only(top: 8) , child : isloadingLogin ? CircularProgressIndicator() : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New User?" , style:  TextStyle(fontSize: 16 , color: Colors.white ),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenSignup()));
                    }, 
                    child: Text("Sign Up" ,
                     style:  TextStyle(fontSize: 16 , 
                     color : const Color.fromARGB(255, 158, 87, 224)),), )
                  ],

                ))



          


        ]
      )
      )))
      )

    );
    
    
  }

}