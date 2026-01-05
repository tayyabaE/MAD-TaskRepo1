import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:complete_example/Hive/model/user.dart';

class UserScreen extends StatefulWidget{
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>{
  final Box<User> userBox = Hive.box<User>('userBox');

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final roleController = TextEditingController();

  bool isEditing = false;

  void clearFields(){
    setState(() {
      isEditing = false;
    });
    idController.clear();
    nameController.clear();
    roleController.clear();
  }

  void addHandler(){
    if (nameController.text.isNotEmpty && roleController.text.isNotEmpty){
      userBox.add(
        User(
          name: nameController.text,
          role: roleController.text,
        ),
      );
      clearFields();
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields required")));
    }
  }

  void updateHandler() {
    if (idController.text.isEmpty) return;

    userBox.putAt(
      int.parse(idController.text),
      User(
        name: nameController.text,
        role: roleController.text,
      ),
    );
    clearFields();
  }


  void deleteHandler(int i){
    userBox.deleteAt(i);
  }

  void getUser(int i, User user){
    setState(() {
      isEditing = true;
    });
    idController.text = i.toString();
    nameController.text = user.name;
    roleController.text = user.role;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          TextFormField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
          TextFormField(controller: roleController, decoration: InputDecoration(labelText: "Role")),

          isEditing
          ? ElevatedButton(onPressed: updateHandler, child: Text("Update"))
          : ElevatedButton(onPressed: addHandler, child: Text("Add")),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: userBox.listenable(),
              builder: (context, Box<User> box, _) {
                if (box.isEmpty) {
                  return const Center(child: Text('No student exists'));
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final user = box.getAt(index)!;

                    return ListTile(
                      leading: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        child: Text(index.toString()),
                      ),

                      title: Text(user.name),
                      subtitle: Text(
                        'Role: ${user.role}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => getUser(index, user),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteHandler(index),
                          ),
                        ],
                      ),
                    );

                  },
                );
              },
            ),
          ),
    ]
      )
    );
  }
}