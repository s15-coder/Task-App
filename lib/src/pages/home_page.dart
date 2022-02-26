import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "HomePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('HomePage'),
      ),
    );
  }
}
