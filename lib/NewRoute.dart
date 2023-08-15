import 'package:flutter/material.dart';

class NewRoute extends StatelessWidget {
  const NewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('new route'),
        ),
        body: const Center(
          child: Text('this is a new rout'),
        ));
  }
}

class TipRoute extends StatelessWidget {
  const TipRoute({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('提示'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: <Widget>[
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, '我是返回值'),
                child: const Text('返回'),
              )
            ],
          ),
        ));
  }
}
