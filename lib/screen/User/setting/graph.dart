import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  GraphState createState() => GraphState();
}

class GraphState extends State<Graph> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Graph"),
      ),
    );
  }
}
