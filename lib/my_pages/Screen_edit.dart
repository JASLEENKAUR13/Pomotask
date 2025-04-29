import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomotask/backend_code/CrudOperations.dart';
import 'package:pomotask/custome_assets/tasksClass.dart';

class ScreenEdit extends StatefulWidget {
  final Task mytask;
  final String userId ; 
  final String listId ;

  ScreenEdit({required this.mytask , required this.userId , required this.listId});

  _screenedit createState() => _screenedit();
}

class _screenedit extends State<ScreenEdit> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  late bool mystar ;
  late bool mycompl ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(text: widget.mytask.title);
    _descriptionController = TextEditingController(
      text: widget.mytask.description,


    );

    mystar = widget.mytask.isImportant;
    mycompl = widget.mytask.isCompleted;



  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF121212),
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("Update task"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>  deletedialog(context),
            
            icon: Icon(Icons.delete),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10),
        child: Column(
          children: [
            // SizedBox(height: 10),
            Expanded(child: SingleChildScrollView(child: showScreen())),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(75, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 158, 87, 224),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var cur_mytask = Task(id: widget.mytask.id, 
                    
                    title: _titleController.text.trim(), 
                    
                    description: _descriptionController.text.trim(), 
                    isCompleted: mycompl,
                     isImportant: mystar,
                      createdAt: Timestamp.now(),
                       userId: widget.userId);


                   
                    
                    try{
                       await Update( widget.userId  , widget.listId,widget.mytask, cur_mytask);
                       if(mounted) Navigator.pop(context);

                    }catch(e){
                      Fluttertoast.showToast(msg:'Failed to update task' , backgroundColor: Colors.redAccent , fontSize:  15 , textColor: Colors.white );

                    }

                    

                   
                    
                     
                  },
                  child: Text("Update", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 158, 87, 224),
                    minimumSize: Size(75, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget showScreen() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 10,
            color: Color(0xFF1E1E1E),
            child: Padding(
              padding: EdgeInsets.only(top: 2, left: 6, bottom: 2),
              child: Row(
                children: [
                  Checkbox(
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

                    value: mycompl,

                    onChanged: (bool? MyisCompleted) {
                     setState(() {
                       mycompl = MyisCompleted ?? false;
                     });
                    },
                  ),

                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintText: 'Add title',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 66, 65, 65),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //SizedBox(height: 5),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 10,
            color: Color(0xFF1E1E1E),
            child: Padding(
              padding: EdgeInsets.only(top: 2, left: 10, bottom: 2),
              child: TextField(
                minLines: 4,
                maxLines: 6,

                controller: _descriptionController,
                style: TextStyle(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add description',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 66, 65, 65)),
                ),
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            color: Color(0xFF1E1E1E),
            child: InkWell(
              onTap: () {
                setState(() {
                            mystar = !mystar;
                          
                        });
                
              },
              child: Padding(
                padding: EdgeInsets.only(top: 2, left: 4, bottom: 2),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                         setState(() {
                            mystar = !mystar;
                          
                        });
                        
                     

                        
                      },
                      icon:
                          (mystar)
                              ? FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.yellow[600],
                              )
                              : FaIcon(
                                FontAwesomeIcons.star,
                                color: Color.fromARGB(255, 66, 65, 65),
                              ),
                    ),
                    SizedBox(width: 2),
                    mystar? Text(
                      "Marked Important",
                      style: TextStyle(
                        fontSize: 20,
                        color:
                          
                                 Colors.white
                               
                      ),
                    ):
                    Text(
                      "Mark Important",
                      style: TextStyle(
                        fontSize: 20,
                        color:
                           Color.fromARGB(255, 66, 65, 65),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }










Future<void> deletedialog(BuildContext context) async {

  return showDialog<void>( context:context , 
  barrierDismissible: false , 
  builder: (BuildContext context){

    return AlertDialog(

      title: Text("Delete task"),
      content: 
          Text("Are you sure you want to delete this task?"),

        
      
      actions: [
        Row( 
          mainAxisAlignment: MainAxisAlignment.end,
          
          
          children: [
            TextButton(onPressed: (){
              Navigator.pop(context);


            }, child: Text("Cancel")) ,

            TextButton(onPressed: () async {
                try{
              await Delete(widget.userId , widget.listId, widget.mytask);
              if(mounted){Navigator.pop(context);
              Navigator.pop(context);}
              }catch(e){
                Fluttertoast.showToast(msg: 'Failed to delete task' ,  
                backgroundColor: Colors.redAccent,
                fontSize: 15,
                textColor: Colors.white,);
              }
             


            }, child: Text("Delete" , style: TextStyle(color: Colors.redAccent),)) ,


          ],

        )

      ],

    );

  }

   );

}


}