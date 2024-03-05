import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'activity_block.dart';
import 'activity_screen.dart';
import 'bottom_button_bar.dart';

const String version = 'v0.1';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time 2 Focus',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Time 2 Focus $version'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<ActivityBlock> activitiesPlan = [
    ActivityBlock('Run', DateTime(2024, 01, 22, 7, 30), DateTime(2024, 01, 22, 8, 0), Colors.blue),
    ActivityBlock('Lift weights', DateTime(2024, 01, 22, 8, 15), DateTime(2024, 01, 22, 9, 0), Colors.red),
    ActivityBlock('Eat breakfast', DateTime(2024, 01, 22, 9, 0), DateTime(2024, 01, 22, 9, 30), Colors.yellow),
    ActivityBlock('Shower', DateTime(2024, 01, 22, 9, 30), DateTime(2024, 01, 22, 10, 0), Colors.green),
    // ActivityBlock('Activity 5', DateTime(2024, 01, 22, 12, 0), DateTime(2024, 01, 22, 13, 0), Colors.purple),
    // ActivityBlock('Activity 6', DateTime(2024, 01, 22, 13, 0), DateTime(2024, 01, 22, 14, 0), Colors.orange),
    // ActivityBlock('Activity 7', DateTime(2024, 01, 22, 14, 0), DateTime(2024, 01, 22, 15, 0), Colors.pink),
    // ActivityBlock('Activity 8', DateTime(2024, 01, 22, 15, 0), DateTime(2024, 01, 22, 16, 0), Colors.teal),
    // ActivityBlock('Activity 9', DateTime(2024, 01, 22, 16, 0), DateTime(2024, 01, 22, 17, 0), Colors.brown),
    // ActivityBlock('Activity 10', DateTime(2024, 01, 22, 17, 0), DateTime(2024, 01, 22, 18, 0), Colors.grey),
    // ActivityBlock('Activity 11', DateTime(2024, 01, 22, 18, 0), DateTime(2024, 01, 22, 19, 0), Colors.blue)
  ];

  List<ActivityBlock> activitiesActual = [];

  bool isDayLocked = false;

  addActivity() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityScreen(null),
      ),
    ).then((value) => setState(() {
      if(value != null) {
        activitiesPlan.add(ActivityBlock(value.title,
            value.startTime as DateTime,
            value.endTime as DateTime,
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
        ));
      }
    }));
  }

  lockDay() {
    //Copy plan activities to actual activities
    setState(() {
      activitiesActual = List.from(activitiesPlan);
      isDayLocked = true;
    });
  }

  favorActivity() {
  }

  @override
  Widget build(BuildContext context) {

    //Sort each time in case of additions and edits
    activitiesPlan.sort((a, b) => a.startTime.compareTo(b.startTime));
    activitiesActual.sort((a, b) => a.startTime.compareTo(b.startTime));
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.all(0),
        child: BottomButtonBar(addActivity, lockDay, favorActivity, isDayLocked),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Your Plan',
                    ),
                    const SizedBox(height: 20),
                    //Loop through activities and separate with a SizedBox
                    for (var activity in activitiesPlan) ...[
                      const SizedBox(height: 10),
                      activity,
                      // Text(activity),
                    ],
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Actual',
                    ),
                    const SizedBox(height: 20),
                    //Loop through activities and separate with a SizedBox
                    for (var activity in activitiesActual) ...[
                      const SizedBox(height: 10),
                      activity,
                      // Text(activity),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
