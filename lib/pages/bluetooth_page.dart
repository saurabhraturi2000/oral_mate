import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:oral_mate/pages/discovery_page.dart';
import 'package:oral_mate/pages/my_home_page.dart';

// ignore: must_be_immutable
class BluetoothPage extends StatefulWidget {
  String userUid;
  BluetoothPage({Key? key, required this.userUid}) : super(key: key);

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothDevice? selectedDevice;
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  @override
  void initState() {
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bluetooth"),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => HomePage(uid: widget.userUid)),
            child: Container(
                margin: const EdgeInsets.only(top: 15, right: 10),
                child: const Text(
                  "SKIP",
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
      body: ListView(children: [
        SwitchListTile(
            title: const Text('Bluetooth status'),
            subtitle: Text(_bluetoothState.toString()),
            value: _bluetoothState.isEnabled,
            onChanged: (bool value) {
              // Do the request and update with the true value then
              future() async {
                // async lambda seems to not working
                if (value) {
                  await FlutterBluetoothSerial.instance.requestEnable();
                } else {
                  await FlutterBluetoothSerial.instance.requestDisable();
                }
              }

              future().then((_) {
                setState(() {});
              });
            }),
        ListTile(
          title: ElevatedButton(
              child: const Text('Scan for devices'),
              onPressed: () async {
                selectedDevice = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const DiscoveryPage();
                    },
                  ),
                );

                if (selectedDevice != null) {
                  print('Discovery -> selected ${selectedDevice!.address}');
                } else {
                  print('Discovery -> no device selected');
                }
                setState(() {});
              }),
        ),
        ListTile(
          title: const Text('Name'),
          subtitle: ((selectedDevice == null)
              ? const Text("not selected")
              : Text("${selectedDevice!.name}")),
        ),
        ListTile(
          title: const Text('Address'),
          subtitle: ((selectedDevice == null)
              ? const Text("not selected")
              : Text(selectedDevice!.address)),
        ),
        ElevatedButton(
          //HomePage(uid: widget.userUid)
          //DataPage(device: selectedDevice!
          onPressed: (selectedDevice != null)
              ? () {
                  Get.to(() => HomePage(
                        uid: widget.userUid,
                        device: selectedDevice,
                        isConnected: true,
                      ));
                  // Get.to(DataPage(
                  //   device: selectedDevice!,
                  // ));
                }
              : null,
          child: ((selectedDevice == null)
              ? const Text("Select Device")
              : const Text("Continue")),
        ),
      ]),
    );
  }
}
