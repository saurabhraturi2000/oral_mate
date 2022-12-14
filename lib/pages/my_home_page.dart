import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oral_mate/controller/auth_controller.dart';
import 'package:oral_mate/controller/profile_controller.dart';
import 'package:oral_mate/pages/data.dart';
import 'package:oral_mate/pages/history_page.dart';
import 'package:oral_mate/widgets/activity_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/history_controller.dart';

class HomePage extends StatefulWidget {
  final String uid;
  final BluetoothDevice? device;
  final bool isConnected;
  const HomePage(
      {Key? key, required this.uid, this.device, this.isConnected = false})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProfileController profileController = Get.put(ProfileController());
  HistoryController historyController = Get.put(HistoryController());

  Map<String, dynamic>? mySelectedEvents = {};
  var today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  bool isTodayEvent = false;

  @override
  void initState() {
    profileController.updateUserId(widget.uid);
    historyController.updateUserId(widget.uid);
    super.initState();
    loadPreviousEvents();
  }

  loadPreviousEvents() async {
    var myEvents = await historyController.getActivity();
    setState(() {
      mySelectedEvents = myEvents;
    });

    if (mySelectedEvents![today] != null) {
      isTodayEvent = true;
      setState(() {});
    } else {
      isTodayEvent = false;
    }
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents?[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents![DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  @override
  void dispose() {
    mySelectedEvents?.clear();
    profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Oral",
                    style: TextStyle(
                      color: Color(0xFF47ABE0),
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Mate",
                    style: TextStyle(
                      color: Color(0xFF4643D3),
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              actions: [
                Center(
                  child: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.chartSimple,
                    ),
                    onPressed: () => Get.to(() => const HistoryPage()),
                    iconSize: 30,
                    tooltip: 'History',
                    splashColor: Colors.amber,
                  ),
                ),
              ],
              actionsIconTheme:
                  const IconThemeData(color: Colors.black, size: 40),
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 350,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: controller.user['profilePhoto'],
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.user['name'],
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.all(10),
                            //   width: 200,
                            //   height: 35,
                            //   alignment: Alignment.center,
                            //   decoration: const BoxDecoration(
                            //     color: Colors.red,
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(20)),
                            //   ),
                            //   child: const Text(
                            //     "saurabhraturi@gmail.com",
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),
                            (widget.isConnected)
                                ? Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 110,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.bluetooth_connected),
                                          Text(
                                            "Connected",
                                            textAlign: TextAlign.center,
                                          ),
                                        ]),
                                  )
                                : Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 130,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.bluetooth_disabled),
                                          Text(
                                            "Disconnected",
                                            textAlign: TextAlign.center,
                                          ),
                                        ]),
                                  )
                            // Container(
                            //   margin: const EdgeInsets.all(10),
                            //   width: 100,
                            //   height: 35,
                            //   alignment: Alignment.center,
                            //   decoration: const BoxDecoration(
                            //     color: Colors.red,
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(20)),
                            //   ),
                            //   child: const Text(
                            //     "signout",
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: TableCalendar(
                        focusedDay: DateTime.now(),
                        firstDay: DateTime(2020),
                        lastDay: DateTime(2023),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarFormat: CalendarFormat.month,
                        eventLoader: _listOfDayEvents,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          tableBorder: TableBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    isTodayEvent
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "TODAY ACTIVITY",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ..._listOfDayEvents(DateTime.now()).map(
                                (myEvents) => ActivityWidget(
                                  strokes: myEvents['strokes'],
                                  pressure: myEvents['pressure'],
                                  time: myEvents['time'],
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Start Brushing"),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black)),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                      () => (DataPage(device: widget.device!)));
                                },
                                child: const Text("Start Brushing"),
                              ),
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        AuthController.instance.logOut();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: const [
                            Icon(Icons.logout),
                            SizedBox(width: 30),
                            Text(
                              "Logout(just for now)",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
}
