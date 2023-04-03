import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter+=0.2;
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
          children: [

        LinearProgressWIdget(counter: _counter,),
            TextFormWidget(counter: _counter,incrementCounter: _incrementCounter,),
            TextFormWidget(counter: _counter,incrementCounter: _incrementCounter,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TextFormWidget extends StatefulWidget {
  const TextFormWidget({
    required this.counter,
    required this.incrementCounter,
    Key? key,
  }) : super(key: key);
  final double counter;
  final Function() incrementCounter;

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  bool isPressed = false;
  TextEditingController controller = TextEditingController(text:"");

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          controller: controller,
          onEditingComplete: (() => !isPressed?setState(() {
            widget.incrementCounter();
            isPressed = true;
          }):null)
        ),
        const Text(
          'You have pushed the button this many times:',
        ),
        Text(
          '${widget.counter}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}

class LinearProgressWIdget extends StatefulWidget {
  final double counter;
  const LinearProgressWIdget({required this.counter,
    Key? key,
  }) : super(key: key);

  @override
  State<LinearProgressWIdget> createState() => _LinearProgressWIdgetState();
}

class _LinearProgressWIdgetState extends State<LinearProgressWIdget> {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(minHeight:8,value: widget.counter,);
  }
}
