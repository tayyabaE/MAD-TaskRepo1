import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  bool _showText = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Animation for the icon
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // keeps animating back & forth
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleText() {
    setState(() {
      _showText = !_showText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Task",
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter Task 2")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),

                //text container
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.black12,
                  child: const Text(
                    "MAD Lab 2",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 30),

                //star with animation
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.2).animate(_controller),
                  child: const Icon(Icons.star, color: Colors.yellow, size: 50),
                ),
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.2).animate(_controller),
                  child: const Icon(Icons.star, color: Colors.yellow, size: 50),
                ),
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.2).animate(_controller),
                  child: const Icon(Icons.star, color: Colors.yellow, size: 50),
                ),

                const SizedBox(height: 20),

                //pics in a row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset(
                      "assets/pic1.jpg",
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      "assets/pic2.jpg",
                      height: 130,
                      width: 130,
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      "assets/pic3.jpg",
                      height: 130,
                      width: 130,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 4. Button
                ElevatedButton(
                  onPressed: _toggleText,
                  child: const Text("Show/Hide Text"),
                ),

                const SizedBox(height: 20),

                //to show the button in clicked
                if (_showText)
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.green[100],
                    child: const Text(
                      "You clicked the button!",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                //padding
                Container(
                  padding: const EdgeInsets.all(30), // inside space
                  color: Colors.blue[100],
                  child: const Text(
                    "This container has Padding",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 20),

                //margin
                Container(
                  margin: const EdgeInsets.all(30), // outside space
                  color: Colors.orange[100],
                  child: const Text(
                    "This container has Margin",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Stack(
                  children: [
                    Container(height: 100, width: 100, color: Colors.green),
                    Positioned(left: 20, top: 20,
                      child: Container(height: 100, width: 100, color: Colors.blue),
                    ),
                    Positioned(left: 40, top: 40,
                      child: Container(height: 100, width: 100, color: Colors.red),
                    ),
                    Positioned(left: 60, top: 60,
                      child: Container(height: 100, width: 100, color: Colors.yellow),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}