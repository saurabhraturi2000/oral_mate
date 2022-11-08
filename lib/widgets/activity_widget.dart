import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityWidget extends StatelessWidget {
  final String? strokes;
  final String? pressure;
  final String? time;
  const ActivityWidget({Key? key, this.strokes, this.pressure, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.leftRight),
            title: const Text(
              'Strokes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            trailing: Text(
              '$strokes',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.tooth),
            title: const Text(
              'Pressure',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            trailing: Text(
              '$pressure',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.clock),
            title: const Text(
              'Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            trailing: Text(
              '$time',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
