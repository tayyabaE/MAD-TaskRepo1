import 'package:flutter/material.dart';
import 'dbHelper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  /// LOAD DATA
  void fetchComments() async {
    final data = await dbHelper.instance.getComments();
    setState(() {
      comments = data;
    });
  }

  /// INSERT DATA
  void insertComment() async {
    if (nameController.text.isEmpty || commentController.text.isEmpty) return;

    await dbHelper.instance.insertComment({
      'name': nameController.text,
      'comment': commentController.text,
    });

    nameController.clear();
    commentController.clear();
    fetchComments();
  }

  /// DELETE DATA
  void deleteComment(int id) async {
    await dbHelper.instance.deleteComment(id);
    fetchComments();
  }

  /// EDIT DATA
  void editComment(int id, String oldName, String oldComment) {
    TextEditingController editName = TextEditingController(text: oldName);
    TextEditingController editComment = TextEditingController(text: oldComment);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Comment"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editName,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: editComment,
              decoration: InputDecoration(labelText: "Comment"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text("Update"),
            onPressed: () async {
              await dbHelper.instance.updateComment(id, {
                'name': editName.text,
                'comment': editComment.text,
              });

              Navigator.pop(context);
              fetchComments();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQL Flite CRUD Example")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: commentController,
              decoration: InputDecoration(labelText: "Comment"),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: insertComment,
              child: Text("Add"),
            ),

            SizedBox(height: 20),

            Expanded(
              child: comments.isEmpty
                  ? Center(child: Text("No Records Found"))
                  : ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(comments[index]['name']),
                    subtitle: Text(comments[index]['comment']),

                    // SHOW EDIT AND DELETE ICONS ON THE RIGHT SIDE
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => editComment(
                            comments[index]['id'],
                            comments[index]['name'],
                            comments[index]['comment'],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteComment(comments[index]['id']),
                        ),
                      ],
                    ),
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
