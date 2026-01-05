import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const APIsUsingDIO());
}

class APIsUsingDIO extends StatelessWidget {
  const APIsUsingDIO({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FeedbackForm(),
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

  final Dio _dio = Dio();
  final RegExp _inputRegEx = RegExp(r'^(?=.*\S).+$');

  // POST request using Dio
  Future<void> sendData(String message) async {
    setState(() {
      _isSending = true;
    });

    try {
      final response = await _dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {
          "title": message,
          "body": message,
          "userId": 1,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      final isOk = response.statusCode == 201;
      final msg = isOk ? " Data Sent Successfully!" : " Failed to send data";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("POST Error: ${e.message}")),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  // GET request using Dio
  Future<void> fetchData() async {
    setState(() {
      _isFetching = true;
    });

    try {
      final response =
      await _dio.get('https://jsonplaceholder.typicode.com/posts');

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data;
        setState(() {
          _fetchedData = data
              .take(5)
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("GET Error: Unexpected data format")),
        );
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("GET Error: ${e.message}")),
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
      appBar: AppBar(title: const Text("POST & GET using Dio")),
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
            // Display fetched data
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
                            item['title'] ?? "No Title",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(item['body'] ?? "No Content"),
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
