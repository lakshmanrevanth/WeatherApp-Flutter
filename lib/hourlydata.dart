import 'package:flutter/material.dart';

class HourlyData extends StatelessWidget {
  const HourlyData();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Card(
        child: Column(children: [
          SizedBox(
            height: 5,
          ),
          Text("8:00"),
          Icon(Icons.cloud),
          Text("Cloud"),
        ]),
      ),
    );
  }
}
