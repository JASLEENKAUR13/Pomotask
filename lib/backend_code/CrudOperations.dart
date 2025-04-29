

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pomotask/custome_assets/tasksClass.dart';



    
//add the list
Future<void> createList(String userId , String listTitle) async {

  try{
  await FirebaseFirestore.instance.collection('Users').doc(userId)
  .collection('Lists').add({
    'ListTitle' : listTitle,

  });
  }catch(e){
    Fluttertoast.showToast(msg: "error creating list");
  }
}

//upadte list name 
Future<void>  updateListName(String userId , String listId , var listname) async {

  try{

  
  await FirebaseFirestore.instance.collection('Users').doc(userId)
  .collection('Lists').doc(listId).update({
    'ListTitle':  listname

  });
  }catch(e){
    Fluttertoast.showToast(msg: "error updating lists");
  }

}

//delete the list
Future<void> deleteList(String listId ,String userId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception("Not authenticated");

  try {
    await FirebaseFirestore.instance.collection('Users').doc(userId)
        .collection('Lists')
        .doc(listId)
        .delete();
  } catch (e) {
    debugPrint("Delete failed: $e");
    rethrow;
  }
}


//add the todo task
Future<void> addTodo(String userId , String listId , Task task) async{

  
 try{ await FirebaseFirestore.instance.collection('Users').doc(userId)
  .collection('Lists').doc(listId).collection('todos').add({

    ...task.toMap(), 
    'createdAt' : FieldValue.serverTimestamp(),


  });}
  catch(e){
    Fluttertoast.showToast(msg: "error creating task");
  }


}




//toggle the todo button
Future<void> Toggle( String userId , String listId , Task task ) async {
 await FirebaseFirestore.instance.collection('Users').doc(userId)
  .collection('Lists').doc(listId).collection('todos').doc(task.id)
  .update({
            'isCompleted' : !task.isCompleted
          });
}





//delete the todo task
Future<void> Delete(  String userId , String listId , Task task ) async {
  try
 {await FirebaseFirestore.instance.collection('Users').doc(userId)
  .collection('Lists').doc(listId).collection('todos')
  .doc(task.id).delete();}
  catch(e){
    Fluttertoast.showToast(msg: "error dleteing task");
  }
}


//upadte isImportant of todo
Future<void> MarkImp(String userId , String listId ,  Task task ) async {
 try{await FirebaseFirestore.instance.collection('Users').doc(userId)
  .collection('Lists').doc(listId).collection('todos')
  .doc(task.id).update({
             'important' : !task.isImportant

          });}
          catch(e){
            Fluttertoast.showToast(msg: "error");
          }
}


//upadte todo 
Future<void> Update( String userId , String listId ,  Task task , var updatedTask ) async {
 try{await FirebaseFirestore.instance.collection('Users').doc(userId)
  .collection('Lists').doc(listId).collection('todos')
  .doc(task.id).update(updatedTask.toMap());}
  catch(e){
    Fluttertoast.showToast(msg: "error updating task");
  }
}


Stream<QuerySnapshot> getUserLists(String userId){
  return FirebaseFirestore.instance.collection('Users')
  .doc(userId).collection('Lists').snapshots();
}


Stream<QuerySnapshot> getUserTodos(String userId , String listId){
  return FirebaseFirestore.instance.collection('Users')
  .doc(userId).collection('Lists') .doc(listId).collection('todos')
  .snapshots();
}


