import 'package:flutter/material.dart';

class BottomButtonBar extends StatelessWidget {

  //Constructor that takes 3 functions as parameters
  BottomButtonBar(this.onAdd, this.onLockDay, this.onFavorite, this.isDayLocked, {super.key});

  //Function to call when the add button is pressed
  final VoidCallback onAdd;
  //Function to call when the search button is pressed
  final VoidCallback onLockDay;
  //Function to call when the favorite button is pressed
  final VoidCallback onFavorite;

  bool isDayLocked = false;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.lightBlueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            tooltip: 'Open navigation menu',
            icon: const Icon(Icons.add, size: 30),
            color: Colors.white,
            onPressed: this.onAdd,
          ),
          IconButton(
            tooltip: 'Lock day',
            icon: Icon(isDayLocked ? Icons.lock: Icons.lock_open, size: 30),
            color: Colors.white,
            onPressed: this.onLockDay,
          ),
          IconButton(
            tooltip: 'Favorite',
            icon: const Icon(Icons.favorite, size: 30),
            color: Colors.white,
            onPressed: this.onFavorite,
          ),
        ],
      ),
    );
  }
}
