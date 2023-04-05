import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linear_app/cubit/timer_cubit.dart';

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
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: [
              BlocBuilder<TimerCubit, TimerState>(
                builder: (context, state) {
                  if (state is TimerProgress) {
                    return LinearProgressWidget(
                      counter: (state.elasped! / 20).toDouble(),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const TextFormWidget(
                ),
              const TextFormWidget(
                ),
              Builder(builder: (context) {
                return const ElevatedButtonWidget();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => BlocProvider.of<TimerCubit>(context).startTimer(0),
      child: const Text("start"),
    );
  }
}

class TextFormWidget extends StatefulWidget {
  const TextFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  bool isPressed = false;
  TextEditingController controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         TextFormField(
                  controller: controller,
                  onEditingComplete: (() {
                    log("onEditingComplete");
                    //if (!BlocProvider.of<TimerCubit>(context).isPressed) {
                      if(!isPressed){
                      //BlocProvider.of<TimerCubit>(context).startTimer(0);
                      BlocProvider.of<TimerCubit>(context).checkIsPressed(0.3);
                       setState(() {
                          //widget.incrementCounter();
                          isPressed = true;
                        });
                    }
                  })),
      ],
    );
  }
}

class LinearProgressWidget extends StatefulWidget {
  final double counter;
  const LinearProgressWidget({
    required this.counter,
    Key? key,
  }) : super(key: key);

  @override
  State<LinearProgressWidget> createState() => _LinearProgressWidgetState();
}

class _LinearProgressWidgetState extends State<LinearProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: 8,
      value: widget.counter,
    );
  }
}
