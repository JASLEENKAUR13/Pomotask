import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pomotask/backend_code/auth_wrapper.dart';
import 'package:pomotask/backend_code/google_auth.dart';
import 'package:pomotask/my_pages/screen_logIn.dart';

import 'package:pomotask/custome_assets/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomotask/my_pages/screen_main.dart';

class ScreenSignup extends StatefulWidget {
  _signupscreen createState() => _signupscreen();
}

class _signupscreen extends State<ScreenSignup> {
  String email = "", password = "", name = "";

  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  bool isloading = false;
  Auth myauth = Auth();

  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String image = 'Assets/Images/producitivity (1).svg';

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF121212),
        child: Padding(
          padding: EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  SvgPicture.asset(image, width: 200, height: 200),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),

                  mytextfield(
                    "Enter Your Name",
                    Icon(Icons.person),
                    TextInputType.name,
                    namecontroller,
                    false,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    isloading,
                  ),

                  SizedBox(height: 20),

                  mytextfield(
                    "Enter Your Email",
                    Icon(Icons.email),
                    TextInputType.emailAddress,
                    emailcontroller,
                    false,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (!value.contains('@')) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    isloading,
                  ),

                  SizedBox(height: 20),

                  mytextfield(
                    "Enter Password",
                    Icon(Icons.password),
                    TextInputType.visiblePassword,
                    passcontroller,
                    true,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at leat 6 chracters';
                      }
                      return null;
                    },
                    isloading,
                  ),
                  SizedBox(height: 35),

                  ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() => isloading = true); // Start loading
                        try {
                          final user = await myauth.signUp(
                            
                            emailcontroller.text.trim(),
                            passcontroller.text.trim(),
                            //namecontroller.text.trim(),
                          );
                          if(user != null){
                          Navigator.pushReplacement(context,
                           MaterialPageRoute(builder: (context) => ScreenMain()), 
                           );
                         }
                        } finally {
                          if (mounted) {
                            setState(() => isloading = false); // Stop loading
                          }
                        }
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                        255,
                        158,
                        87,
                        224,
                      ), // Button color
                      foregroundColor: Colors.white, // Text color
                      minimumSize: Size(double.infinity, 50), // Full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Rounded corners
                      ),

                      elevation: 5, // Shadow
                    ),
                    child: Text("Continue", style: TextStyle(fontSize: 18)),
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isloading = true;
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
                          setState(() => isloading = false); // Stop loading
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Transparent background
                      foregroundColor: Colors.white,

                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: const Color.fromARGB(255, 158, 87, 224),
                        ), // Outline border
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.google,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 15),

                        Text(
                          "SignUp With Google",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child:
                        isloading
                            ? CircularProgressIndicator()
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already A User?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScreenLogin(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16,

                                      color: const Color.fromARGB(
                                        255,
                                        158,
                                        87,
                                        224,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
