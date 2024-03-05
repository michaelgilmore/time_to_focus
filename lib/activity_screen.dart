import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'activity_block.dart';

class ActivityScreen extends StatefulWidget {
  ActivityScreen(this.block, {super.key});
  ActivityBlock? block;

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late ActivityBlock block;

  @override
  void initState() {
    super.initState();
    if(widget.block == null) {
      block = ActivityBlock('New Activity',
          DateTime.now(),
          DateTime.now().add(const Duration(hours: 1)),
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
      );
    }
    else {
      block = widget.block!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(block.title),
        ),
        body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            //Form for editing activity block fields
            TextFormField(
              decoration: const InputDecoration(hintText: 'Title'),
              initialValue: block.title,
              onChanged: (value) {
                block.title = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Start Time'),
              initialValue: block.startTime.toString(),
              onChanged: (value) {
                block.startTime = DateTime.parse(value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'End Time'),
              initialValue: block.endTime.toString(),
              onChanged: (value) {
                block.endTime = DateTime.parse(value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Color'),
              initialValue: block.color.toString(),
              onChanged: (value) {
                block.color = Color(int.parse(value));
              },
            ),
            //Button to save changes
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, block);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
