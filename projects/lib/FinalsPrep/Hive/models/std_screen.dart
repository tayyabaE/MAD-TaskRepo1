import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projects/FinalsPrep/Hive/models/student.dart';

class StdScreen extends StatefulWidget {
  @override
  State<StdScreen> createState() => _StdScreenState();
}

class _StdScreenState extends State<StdScreen> {

  final Box<Student> stdBox = Hive.box<Student>('studentBox');

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final courseController = TextEditingController();
  final ageController = TextEditingController();

  bool isEditing = false;

  void clearFields() {
    setState(() {
      isEditing = false;
    });
    idController.clear();
    nameController.clear();
    courseController.clear();
    ageController.clear();
  }

  void addHandler() {
    if (nameController.text.isNotEmpty && ageController.text.isNotEmpty) {
      stdBox.add(
        Student(
          name: nameController.text,
          course: courseController.text,
          age: int.parse(ageController.text),
        ),
      );
      clearFields();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please enter all fields')));
    }
  }

  void updateHandler() {
    stdBox.putAt(
      int.parse(idController.text),
      Student(
        name: nameController.text,
        course: courseController.text,
        age: int.parse(ageController.text),
      ),
    );
    clearFields();
  }

  void deleteHandler(int i) {
    stdBox.deleteAt(i);
  }

  void getStudent(int i, Student std) {
    setState(() {
      isEditing = true;
    });
    idController.text = i.toString();
    nameController.text = std.name;
    courseController.text = std.course;
    ageController.text = std.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive Project")),
      body: Column(
        children: [
          //TextFormField(controller: idController, decoration: const InputDecoration(labelText: 'Id')),
          TextFormField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
          TextFormField(controller: courseController, decoration: const InputDecoration(labelText: 'Course')),
          TextFormField(controller: ageController, decoration: const InputDecoration(labelText: 'Age')),

          isEditing
              ? ElevatedButton(onPressed: updateHandler, child: const Text('Update'))
              : ElevatedButton(onPressed: addHandler, child: const Text('Add')),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: stdBox.listenable(),
              builder: (context, Box<Student> box, _) {
                if (box.isEmpty) {
                  return const Center(child: Text('No student exists'));
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final student = box.getAt(index)!;

                    return ListTile(
                      leading: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        child: Text(index.toString()),
                      ),

                      title: Text(student.name),
                      subtitle: Text(
                        'Course: ${student.course} | Age: ${student.age}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => getStudent(index, student),
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
        ],
      ),
    );
  }
}
