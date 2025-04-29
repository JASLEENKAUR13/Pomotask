import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pomotask/backend_code/CrudOperations.dart';
import 'package:pomotask/custome_assets/customdatepicker.dart';
import 'package:pomotask/custome_assets/tasksClass.dart';

class AddList extends StatefulWidget {
  final String userId;
  const AddList({required this.userId, Key? key}) : super(key: key);
  addListWidget createState() => addListWidget();
}

class addListWidget extends State<AddList> {
  var myimp = false;
 

  var textcontroller = TextEditingController();
  //var descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20.0,
        right: 20.0,
        top: 20.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create New List ",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),

          TextField(
            controller: textcontroller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Add List Name",
              hintStyle: TextStyle(color: const Color.fromARGB(255, 136, 134, 134)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.white), // Highlight border
              ),

              contentPadding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 15.0,
              ),


            ),
          ),
          

          SizedBox(height : 30),


          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
           
            IconButton(icon: Icon(Icons.send, size: 30,color: const Color.fromARGB(
                        255,
                        158,
                        87,
                        224,
                      ), ),
                      onPressed: () async {
                        await createList(widget.userId, textcontroller.text.toString());


  
  Navigator.pop(context);
},),

            ]
  )

          
              ],
            ));

            
   
  }
  @override
  void dispose() {
    textcontroller.dispose();
    super.dispose();
  }

 
}

