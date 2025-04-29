
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pomotask/custome_assets/tasksClass.dart';
import 'package:pomotask/my_pages/Screen_edit.dart';


class taskTile extends StatefulWidget{
//final Key key;

  final Task  mytask;

  final bool isCompleted ; 
  
  final VoidCallback toggle ; 
  final VoidCallback delete  ;
  final bool isImportant ; 
  final VoidCallback markImp ;
  final Function(Task) onEditComplete ;
  final String userId ; 
  final String ListId ;
  
  


  const taskTile({
  required Key key,
  
    required this.mytask ,
    required this.isCompleted ,
   
    required this.toggle ,
    required this.delete   ,
    required this.isImportant ,
    required this.markImp ,
    required this.onEditComplete,

    required this.userId,  
    required this.ListId,

  }) : super(key : key) ;


@override
  _tile createState() => _tile();

  

}





class _tile extends State<taskTile> {

  Widget refreshbg(){
    return Container(alignment: Alignment.centerRight,
     padding: EdgeInsets.only(right : 20.0),
      color : Colors.red ,
      child: Icon(Icons.delete , color : Colors.white), 
      );
  }

  
  

  


  
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return InkWell( onTap: () async {
      
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) => ScreenEdit( mytask: widget.mytask,  userId:  widget.userId , listId:  widget.ListId,
      )));

      
      
    },
      child : Card (  color : Color(0xFF363636),
    margin: EdgeInsets.only(top : 5 , bottom:  5),

      child : Dismissible(
      key: Key(widget.mytask.id),
      background: refreshbg(),
      child: ListTile(
        leading: Checkbox(
          side: BorderSide(
                      color: Color.fromARGB(255, 141, 137, 137),
                      width: 2,
                    ),
          checkColor: Colors.white,
         
         fillColor: WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.green; // Color when checked
    }
    return Colors.transparent; // Color when unchecked
  }),
          value: widget.isCompleted, 
          onChanged: (_) => widget.toggle(),
        ),
        
        title:   
         Text(widget.mytask.title , 
        style :  
        
        TextStyle(color : Colors.white , fontSize: 18 , 
        decoration: widget.mytask.isCompleted? 
        TextDecoration.lineThrough:TextDecoration.none,
         decorationColor: Colors.white,   // Color of the strikethrough line
        decorationThickness: 2.0,
        )
        ), 
        
        trailing: IconButton(
          onPressed: widget.markImp,
          
          icon: widget.isImportant 
              ? FaIcon(FontAwesomeIcons.solidStar, color: Colors.yellow[600] ,) 
              : FaIcon(FontAwesomeIcons.star ,color:Color.fromARGB(255, 141, 137, 137),),
             
        ),
      ),
      onDismissed: (direction) {
       widget.delete();
      
      },
    )));
  }
}