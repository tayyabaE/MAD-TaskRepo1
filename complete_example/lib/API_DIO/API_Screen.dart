import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class APIScreen extends StatefulWidget {
  const APIScreen({super.key});

  @override
  State<APIScreen> createState() => _APIScreenState();
}
class _APIScreenState extends State<APIScreen>{
    final Dio dio = Dio();
    List<dynamic> posts= [];
    final _formKey = GlobalKey<FormState>();

    final TextEditingController  nameController = TextEditingController();

    Future<void> fetchPosts() async{
      try{
        final resp = await dio.get("https://jsonplaceholder.typicode.com/posts");
        setState(() {
          posts=resp.data;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data Fetched"))
        );
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to fetch data $e"),)
        );
      }
    }

    Future<void> createPost() async{
      if(!_formKey.currentState!.validate())
        return;
      try{
        final resp = await dio.post(
          "https://jsonplaceholder.typicode.com/posts",
          data: {
            "title": nameController.text,
            "body": "Post Created",
            "userId": 1,
          }
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Post created: ${resp.statusCode}"),)
        );
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("DIO Post error $e"),)
        );
      }
    }

    void resetHandler(){
      setState(() {
        posts.clear();
      });
    }

    @override
  Widget build(BuildContext context){
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child:
                TextFormField(
                  controller: nameController,
                  validator: (value){
                    if(value==null || value.trim().isEmpty){
                      return "Field can't be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name"
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(onPressed: fetchPosts, child: Text("GET API")),
                  ElevatedButton(onPressed: createPost, child: Text("POST API")),
                  ElevatedButton(onPressed: resetHandler, child: Text("Reset")),
                ],
              ),

              Expanded(
                  child: posts.isEmpty
              ? const Center(child: Text("No data"))
                  : ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index){
                      final post = posts[index];
                      return Card(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text("ID: ${post['id']}"),
                              Text("Title:"),
                              Text(post['title']),
                              Text("Body:"),
                              Text(post['body']),
                            ],
                          ),
                        ),
                      );
                },
              )
              )
            ],
          ),
        )
        ,
      );
    }
}

