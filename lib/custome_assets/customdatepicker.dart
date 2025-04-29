

// import 'package:flutter/material.dart';

// Future<DateTime?> mydatepicker(BuildContext mycontext) async {

//  return await showDialog<DateTime>(context: mycontext,
//  barrierDismissible: false
//  , builder: (BuildContext context){
//   DateTime selecteddate = DateTime.now();
//   return Dialog(
    
//      backgroundColor: Color(0xFF1E1E1E),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         // content: Container(
//         //   padding: EdgeInsets.all(16),
//         //   child: Column( mainAxisSize: MainAxisSize.min,
//         //     children: [

//         //       Row(
//         //         children: [
//         //           IconButton(onPressed: (){Navigator.pop(mycontext);},
//         //            icon: Icon(Icons.cancel)),
//         //           Text("Select Date" , style: TextStyle(fontSize: 20 ,
//         //            fontWeight: FontWeight.bold),),
//         //            Divider(color: Colors.grey),
//         //            const SizedBox(height : 16),
//                    content  :SizedBox(
//                     height: 300,
//                     child: Theme(
//                       data: ThemeData.dark().copyWith(
//                         colorScheme: const ColorScheme.dark(
//                           primary: Color(0xFF9E57E0), // Purple accent
//                       onPrimary: Colors.white,
//                       surface: Color(0xFF2D2D2D),
//                         ),
                        
//                       ),
//                       child: DatePickerDialog(firstDate: DateTime.now(), 
//                       lastDate: DateTime(2100)),
//                     ) ,
//                    ) 


                
//               );
// });}
        


    
 



// Future<TimeOfDay> myTimepicker(BuildContext mycontext) async {

//  return await showDialog(context: mycontext
//  , builder: (BuildContext context){
// TimeOfDay selectedtime = TimeOfDay.now();
//   return Dialog(
    
//      backgroundColor: Color(0xFF1E1E1E),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Container(
//           padding: EdgeInsets.all(16),
//           child: Column( mainAxisSize: MainAxisSize.min,
//             children: [

//               Row(
//                 children: [
//                   IconButton(onPressed: (){Navigator.pop(mycontext);},
//                    icon: Icon(Icons.cancel)),
                   
//                   Text("Select Date" , style: TextStyle(fontSize: 20 ,
//                    fontWeight: FontWeight.bold),),
//                    Divider(color: Colors.grey),
//                    const SizedBox(height : 16),
//                    SizedBox(
//                     height: 300,
//                     child: Theme(
//                       data: ThemeData.dark().copyWith(
//                         colorScheme: const ColorScheme.dark(
//                           primary: Color(0xFF9E57E0), // Purple accent
//                       onPrimary: Colors.white,
//                       surface: Color(0xFF2D2D2D),
//                         ),
                        
//                       ),
//                       child: TimePickerDialog(initialTime: TimeOfDay.now())
//                     ) ,
//                    ) 


//                 ],
//               )
//             ],),
//         )


//     )
// ;
//  } );
// }