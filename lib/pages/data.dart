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
  @override
  Future<void> initState() async {
    // Some simplest connection :F
    try {
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(widget.device.address);
      print('Connected to the device');

      connection.input?.listen((data) {
        print(data);
        print('Data incoming: ${ascii.decode(data)}');

        if (ascii.decode(data).contains('!')) {
          connection.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      }).onDone(() {
        print('Disconnected by remote request');
      });
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Home page"),
        ),
      ),
    );
  }
}
