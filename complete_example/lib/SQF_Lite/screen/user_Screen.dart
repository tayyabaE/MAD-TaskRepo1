import 'package:flutter/material.dart';
import 'package:complete_example/SQF_Lite/model/user.dart';
import 'package:complete_example/SQF_Lite/dbHelper/dbhelper.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isEditing = false;
  bool isLoading = true;

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }
  Future<void> getUsers() async{
    setState(() => isLoading = true);

    final result = await DbHelper.instance.getAll();
    users = result;
    setState(() => isLoading = false);
  }

  void clearFields(){
    idController.clear();
    nameController.clear();
    roleController.clear();

    setState((){
      isEditing = false;
    });
  }

  void addHandler() async{
    User user = User(
      // id: 0,
      name: nameController.text,
      role: roleController.text,
    );
    int res = await DbHelper.instance.addUser(user);
    if (res > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Saved Successfully")),
      );
      clearFields();
      getUsers();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error Failed")),
      );
    }
  }

  void updateHandler(int id) async {
    User user = User(
      id: id,
      name: nameController.text,
      role: roleController.text,
    );

    int res = await DbHelper.instance.updateUser(id, user);

    if (res > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Updated Successfully")),
      );
      clearFields();
      getUsers();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error Failed")),
      );
    }
  }

  void deleteHandler(int id) async {
    await DbHelper.instance.deleteUser(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User Deleted Successfully")),
    );

    clearFields();
    getUsers();
  }

  void getUser(User user) {
    idController.text = user.id.toString();
    nameController.text = user.name;
    roleController.text = user.role;

    setState(() {
      isEditing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "User Name",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: roleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Role",
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: clearFields,
                child: const Text("Clear"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: isEditing
                    ? () => updateHandler(int.parse(idController.text))
                    : addHandler,
                child: Text(isEditing ? "Update" : "Add"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          users.isNotEmpty
              ? Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text("${user.id}: ${user.name}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${user.name}"),
                      Text("Role: ${user.role}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => getUser(user),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteHandler(user.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
              : const Center(child: Text("No Cars Exist...")),
        ],
      ),
    );
  }
}