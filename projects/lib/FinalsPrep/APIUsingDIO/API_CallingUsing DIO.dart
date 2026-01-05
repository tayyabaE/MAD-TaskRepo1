import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class APIScreen extends StatefulWidget {
  const APIScreen({super.key});

  @override
  State<APIScreen> createState() => _APIScreenState();
}

class _APIScreenState extends State<APIScreen> {

  final Dio dio = Dio();
  List<dynamic> posts = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  Future<void> fetchPosts() async {
    try {
      final response = await dio.get(
        "https://jsonplaceholder.typicode.com/posts",
      );
      setState(() {
        posts = response.data;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data fetched using Dio")),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dio GET Error: $e")),
      );
    }
  }

  Future<void> createPost() async {

    if (!_formKey.currentState!.validate()) return;

    try {
      final response = await dio.post(
        "https://jsonplaceholder.typicode.com/posts",
        data: {
          "title": nameController.text,
          "body": "Post created using Dio",
          "userId": 1,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Post created: ${response.statusCode}")),
      );

      nameController.clear();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dio POST Error: $e")),
      );
    }
  }


  void resetData() {
    setState(() {
      posts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Calling Using DIO"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Form(
              key: _formKey,
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name cannot be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Enter Name",
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: fetchPosts,
                  child: const Text("GET"),
                ),
                ElevatedButton(
                  onPressed: createPost,
                  child: const Text("POST"),
                ),
                ElevatedButton(
                  onPressed: resetData,
                  child: const Text("RESET"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: posts.isEmpty
                  ? const Center(child: Text("No Data Loaded"))
                  : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID: ${post['id']}",
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Title:",
                          ),
                          Text(post['title']),
                          const SizedBox(height: 6),
                          Text(
                            "Body:",
                          ),
                          Text(post['body']),
                        ],
                      ),
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
