import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const APIs());
}

class APIs extends StatelessWidget {
  const APIs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FeedbackForm(),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  bool _isFetching = false;
  List<Map<String, dynamic>> _fetchedData = [];

  final RegExp _inputRegEx = RegExp(r'^(?=.*\S).+$');

  // POST request
  Future<void> sendData(String message) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    setState(() {
      _isSending = true;
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": message, "body": message, "userId": 1}),
      );

      final isOk = response.statusCode == 201;
      final msg = isOk ? "Data Sent!" : "Failed to send data";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("POST Exception: $e")),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  // GET request
  Future<void> fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    setState(() {
      _isFetching = true;
    });

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          _fetchedData = List<Map<String, dynamic>>.from(data.take(5));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("GET Error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("GET Exception: $e")),
      );
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("POST & GET using HTTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field with live validation
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: "Enter your feedback",
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || !_inputRegEx.hasMatch(value)) {
                    return "Feedback cannot be empty";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isSending
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      sendData(_messageController.text);
                    }
                  },
                  child: _isSending
                      ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                      : const Text("Send Data"),
                ),
                ElevatedButton(
                  onPressed: _isFetching ? null : fetchData,
                  child: _isFetching
                      ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                      : const Text("Fetch Data"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Display fetched data in simple containers
            if (_fetchedData.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _fetchedData.length,
                  itemBuilder: (context, index) {
                    final item = _fetchedData[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(item['body']),
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

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
