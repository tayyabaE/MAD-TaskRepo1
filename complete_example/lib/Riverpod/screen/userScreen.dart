import 'package:complete_example/Riverpod/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:complete_example/Riverpod/model/user.dart';
import 'package:complete_example/Riverpod/provider/userProvider.dart';

class UserScreen extends ConsumerWidget{
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    List<User> users = ref.watch(userProvider);
    final notifier = ref.watch(userProvider.notifier);

    final TextEditingController idController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController roleController = TextEditingController();

    void clearFields(){
      idController.clear();
      nameController.clear();
      roleController.clear();
    }

    void addHandler(){
      if(idController.text.isEmpty || nameController.text.isEmpty || roleController.text.isEmpty ){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("All fields required"))
        );
        return;
      }
      User user = User(id: int.parse(idController.text), name: nameController.text, role: roleController.text);
      notifier.add(user);
      clearFields();
    }

    void updateHandler(){
      if(idController.text.isEmpty || nameController.text.isEmpty || roleController.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("All fields required"))
        );
        return;
      }
      User user = User(id: int.parse(idController.text), name: nameController.text, role: roleController.text);
      notifier.update(user);
      clearFields();
    }

    void getOne(int id){
      User user = notifier.getOne(id);
      idController.text = user.id.toString();
      nameController.text = user.name;
      roleController.text = user.role;
    }

    void deleteHandler(User user){
      notifier.delete(user);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Deleted"))
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Total Users: ${users.length}"),
            Text("Present Users: ${notifier.totalPresent}"),
            Text("Absent Users: ${notifier.totalAbsent}"),

            TextFormField(
              controller: idController,
              decoration: InputDecoration(
                labelText: 'User Id'
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'User Name'
              ),
            ),
            TextFormField(
              controller: roleController,
              decoration: InputDecoration(
                  labelText: 'User Role'
              ),
            ),
            Row(
              children: [
                ElevatedButton(onPressed: addHandler, child: Text("Add")),
                ElevatedButton(onPressed: updateHandler, child: Text("Update")),
                ElevatedButton(onPressed: clearFields, child: Text("Reset")),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return ListTile(
                    title: Text(
                        '${user.name}'),
                    subtitle: Text(user.role),
                    trailing: Switch(
                      value: !user.isPresent,
                      onChanged: (_) => notifier.togglePresent(user.id),
                    ),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => getOne(user.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteHandler(user),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: notifier.markAllAbsent,
                  child: const Text('Mark All Absent'),
                ),
                ElevatedButton(
                  onPressed: notifier.markAllPresent,
                  child: const Text('Mark All Present'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}