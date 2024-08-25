import 'package:flutter/material.dart';
import 'package:custom_circular_progress/custom_circular_progress.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Circular Progress Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Custom Circular Progress Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _progress = 0.0;

  void _incrementProgress() {
    setState(() {
      _progress = (_progress + 0.1).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Basic Usage:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            CustomCircularProgressIndicator(
              progress: _progress,
              filledColor: Colors.blue,
              unfilledColor: Colors.grey.shade300,
            ),
            SizedBox(height: 40),
            Text(
              'Custom Colors and Size:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            CustomCircularProgressIndicator(
              progress: _progress,
              filledColor: Colors.green,
              unfilledColor: Colors.red.shade100,
              size: 150,
              strokeWidth: 15,
            ),
            SizedBox(height: 40),
            Text(
              'Multiple Indicators:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCircularProgressIndicator(
                  progress: _progress,
                  filledColor: Colors.purple,
                  unfilledColor: Colors.purple.shade100,
                  size: 80,
                  strokeWidth: 8,
                ),
                CustomCircularProgressIndicator(
                  progress: _progress * 0.7,
                  filledColor: Colors.orange,
                  unfilledColor: Colors.orange.shade100,
                  size: 80,
                  strokeWidth: 8,
                ),
                CustomCircularProgressIndicator(
                  progress: _progress * 1.3,
                  filledColor: Colors.teal,
                  unfilledColor: Colors.teal.shade100,
                  size: 80,
                  strokeWidth: 8,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementProgress,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}