import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DataPage extends StatefulWidget {
  final BluetoothDevice device;
  const DataPage({Key? key, required this.device}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  var count;
  var force;
  BluetoothConnection? connection;
  @override
  void initState() {
    super.initState();
    getConnection();
  }

  Future<void> getConnection() async {
    try {
      connection = await BluetoothConnection.toAddress(widget.device.address);
      print('Connected to the device');

      connection!.input?.listen((data) {
        var values = ascii.decode(data);
        print(values);
        if (values.contains('Count') == true) {
          setState(() {
            count = values.substring(values.indexOf('count') + 1);
          });
        } else if (values.contains('force') == true) {
          setState(() {
            force = values.substring(values.indexOf('applied:') + 1);
          });
        }

        if (ascii.decode(data).contains('!')) {
          connection!.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      }).onDone(() {
        print('Disconnected by remote request');
      });
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

  @override
  void dispose() {
    connection!.finish();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text('$count'), Text('$force')],
      ))),
    );
  }
}
