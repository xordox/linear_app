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
                    return Column(
                      children: [
                        const SizedBox(height: 40,),
                        CircularProgressWidget(
                          counter: (state.elasped! / 20).toDouble(),
                        ),
                        const SizedBox(height: 40,),
                        LinearProgressWidget(
                          counter: (state.elasped! / 20).toDouble(),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              const TextFormWidget(
                ),
              const TextFormWidget(
                ),
              const TextFormWidget(
                ),
              const TextFormWidget(
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularProgressWidget extends StatefulWidget {
  final double counter;
  const CircularProgressWidget({
    required this.counter,
    Key? key,
  }) : super(key: key);

  @override
  State<CircularProgressWidget> createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: 50,height: 50,
          child: CircularProgressIndicator(
          value: widget.counter,
      ),
        ),

        const SizedBox(width: 50,height: 50,child:  Icon(Icons.person)),
    ]);
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
                      if(!isPressed){
                        log("isPressed: $isPressed");
                      BlocProvider.of<TimerCubit>(context).checkIsPressed(0.3);
                       setState(() {
                          isPressed = true;
                        });
                    }
                  }),),
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
