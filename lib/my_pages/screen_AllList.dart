import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pomotask/backend_code/CrudOperations.dart';

import 'package:pomotask/my_pages/screen_showTodo.dart'; // Import your todo screen

class ScreenAllList extends StatelessWidget {
  final String userId;
  
  const ScreenAllList({required this.userId, Key? key}) : super(key: key);

  Future<void> _deleteList(BuildContext context, String listId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete List"),
          content: const Text("Are you sure you want to delete this List?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await deleteList(listId, userId);
                      
                      if (context.mounted) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: "List deleted successfully",
                          backgroundColor: Colors.green,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: 'Failed to delete List: ${e.toString()}',
                          backgroundColor: Colors.red,
                        );
                        debugPrint("Delete error: $e");
                      }
                    }
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: StreamBuilder(
          stream: getUserLists(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return EmptylistView();
            }

            final lists = snapshot.data!.docs;

            return ListView.builder(
              itemCount: lists.length,
              itemBuilder: (context, index) {
                final list = lists[index];
                final listId = list.id;
                final listTitle = list['ListTitle'] ?? "Untitled List";

                return Card(
                  color: const Color(0xFF363636), 
                  elevation: 29,
                  child: InkWell(
                    onTap: () {
                      // Navigate to ScreenShowtodo when tile is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenShowtodo(
                            userId: userId,
                            listid: listId,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: const Icon(Icons.list),
                      title: Text(
                        listTitle,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () async {
                              await showUpdateListNameDialog( context: context , userId : userId,  listId :listId, currentName:list['ListTitle']);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () => _deleteList(context, listId),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  
  Future<void> showUpdateListNameDialog({
  required BuildContext context,
  required String userId,
  required String listId,
  required String currentName,
}) async {
  final TextEditingController _controller = TextEditingController(text: currentName);
  

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Color(0xFF1E1E1E),
            title: Text(
              'Rename List',
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter new list name',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed:(){  Navigator.pop(context);} ,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final newName = _controller.text.trim();
                  if (newName.isEmpty) {
                    Fluttertoast.showToast(msg: "Name cannot be empty");
                    return;
                  }
                  
                 
                  try {
                    await updateListName(userId, listId, newName);
                    if (context.mounted) Navigator.pop(context);
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Error updating list");
                  } 
                },
                child: 
                      Text(
                        'Update',
                        style: TextStyle(color: Colors.blue),
                      ),
              ),
            ],
          );
        },
      );
    },
  );
 
}
}

Widget EmptylistView() {
  const String mysvg = 'Assets/Images/welcome (1).svg';
  
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.transparent,
    child: Column(
      children: [
        const Spacer(),
        SvgPicture.asset(mysvg, width: 200, height: 200),
        const SizedBox(height: 8),
        const Text(
          "No List Yet?",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 4),
        const Text(
          "Tap + to add new List",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const Spacer(),
      ],
    ),
  );
}