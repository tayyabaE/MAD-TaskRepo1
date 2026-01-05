import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ---------------------------------------------------------
// 1. Stateful Widget
// ---------------------------------------------------------
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;

  // Function to increment counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Function to reset counter
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter first app",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Stateful & Stateless Widgets"),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // 1. Stateful Widget Section
              const Text(
                "1. Stateful Widget",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                "Counter: $_counter",
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),

              // Add Button
              ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                child: const Text("Add"),
              ),

              const SizedBox(height: 10),

              // Reset Button
              ElevatedButton(
                onPressed: _resetCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                child: const Text("Reset"),
              ),

              const Divider(height: 50),

              // 2. Stateless + Stateful Widget Section
              const Text(
                "2. Stateless + Stateful Widget",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              CounterScreen(
                counter: _counter,
                onIncrement: _incrementCounter,
                onReset: _resetCounter,
              ),

              const Divider(height: 50),

              // 3. Stateless Widget Section
              const Text(
                "3. Stateless Widget",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const GreetingWidget(name: "My first Flutter App"),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. Stateless + Stateful Widget (Child Widget)
// ---------------------------------------------------------
class CounterScreen extends StatelessWidget {
  final int counter;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  const CounterScreen({
    super.key,
    required this.counter,
    required this.onIncrement,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Counter: $counter",
          style: const TextStyle(fontSize: 20),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Add Button
            ElevatedButton(
              onPressed: onIncrement,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
              ),
              child: const Text("Add"),
            ),

            const SizedBox(height: 10),

            // Reset Button
            ElevatedButton(
              onPressed: onReset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
              ),
              child: const Text("Reset"),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// 3. Stateless Widget
// ---------------------------------------------------------
class GreetingWidget extends StatelessWidget {
  final String name;

  const GreetingWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello, $name!",
      style: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
    );
  }
}