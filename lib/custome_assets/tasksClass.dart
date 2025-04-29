import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  final String id ;
  final String title;
  final String description;
  bool isCompleted ;
  bool isImportant;
   final Timestamp createdAt; 
   final String userId; 
  

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.isImportant,
    required this.createdAt,  
    required this.userId,
    
  });

//for converting doc into task
  static Task fromdocument(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
     return Task(id: doc.id,
     title: data['title'] ?? "Task", 
     description :data['desc'] ?? "", 
     isCompleted: data["isCompleted"] ?? false, 
     isImportant: data["important"] ?? false,
     //userId : 
     createdAt: data["createdAt"] ?? Timestamp.now(),
     userId: data['userId'],
     );
  
}

//for conveting task into doc

Map<String , dynamic> toMap(){
  return {
    "title" : title,
    'desc' : description,
    'isCompleted' : isCompleted,
    'important' : isImportant
    , 'createdAt': createdAt,  
    'userId' : userId
  };

}

}


