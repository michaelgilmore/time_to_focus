import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'activity_screen.dart';

class ActivityBlock extends StatefulWidget {
  ActivityBlock(this.title, this.startTime, this.endTime, this.color, {super.key});

  String title;
  DateTime startTime;
  DateTime endTime;
  Color color;

  @override
  State<ActivityBlock> createState() => _ActivityBlockState();
}

class _ActivityBlockState extends State<ActivityBlock> {

  double getHeightFromTime() {
    //Calculate the number of minutes between start and end times
    int minutes = widget.endTime.difference(widget.startTime).inMinutes;
    return minutes * 2.0;
  }

  String getTimeFromDateTime(DateTime dt) {
    return DateFormat('h:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    //Create a container that is clickable and displays the activity title and start and end times
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityScreen(widget),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 40,
        height: getHeightFromTime(),
        color: widget.color,
        padding: const EdgeInsets.all(10),
        child: Text('${widget.title}\n${getTimeFromDateTime(widget.startTime)}-${getTimeFromDateTime(widget.endTime)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
