import 'package:flutter/material.dart';

Widget mytextfield(
  String hintText,
  Icon myicon,
  TextInputType inputType,
  
  TextEditingController mycontroller, 
  bool isPassword ,
  String? Function(dynamic value) validator,
  bool isloading, 
) {
  bool obscureText = isPassword; // Initialize with password check

  return StatefulBuilder(builder: (context , setState){
    return TextFormField(
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
   
    keyboardType: inputType,
    obscureText: obscureText,
    decoration: InputDecoration(
      
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
      prefixIcon: myicon,
      prefixIconColor: Colors.white10,
      suffixIcon: isPassword // Add eye icon toggle for password fields
          ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.white54,
              ),
              onPressed: () {
                setState((){
                  obscureText = !obscureText;

                });
                
                
              },
            )
          : null,
          enabled: !isloading,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.white10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    controller: mycontroller,
    style: TextStyle(color: Colors.white),
    cursorColor: Colors.white,
    validator : validator,
  );

  });
}