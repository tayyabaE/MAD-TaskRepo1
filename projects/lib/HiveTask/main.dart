import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapter
  Hive.registerAdapter(StudentAdapter());

  // Open box
  await Hive.openBox<Student>('studentsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }

}
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  final studentsBox = Hive.box<Student>('studentsBox');

  void saveStudent() {
    final name = nameController.text.trim();
    final ageText = ageController.text.trim();

    if (name.isEmpty || ageText.isEmpty) return;

    final age = int.tryParse(ageText);
    if (age == null) return;

    final student = Student(name: name, age: age);

    studentsBox.add(student);

    nameController.clear();
    ageController.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive Student Storage')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Student Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Student Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: saveStudent,
              child: Text("Save Student"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentsBox.listenable(),
                builder: (context, box, _) {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final student = box.get(index);
                      return ListTile(
                        title: Text(student!.name),
                        subtitle: Text("Age: ${student.age}"),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
