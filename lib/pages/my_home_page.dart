import 'package:flutter/material.dart';
import 'package:oral_mate/controller/auth_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(children: const [
          Text(
            "Oral",
            style: TextStyle(
              color: Color(0xFF47ABE0),
            ),
          ),
          Text(
            "Mate",
            style: TextStyle(
              color: Color(0xFF4643D3),
            ),
          ),
        ]),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    backgroundImage:
                        NetworkImage("http://www.gravatar.com/avatar/?d=mp"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Saurabh Raturi",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Container(
                  //   margin: const EdgeInsets.all(10),
                  //   width: 100,
                  //   height: 35,
                  //   alignment: Alignment.center,
                  //   decoration: const BoxDecoration(
                  //     color: Colors.red,
                  //     borderRadius: BorderRadius.all(Radius.circular(20)),
                  //   ),
                  //   child: const Text(
                  //     "Connected",
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
              calendarFormat: CalendarFormat.week,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              calendarStyle: CalendarStyle(
                  tableBorder:
                      TableBorder(borderRadius: BorderRadius.circular(10))),
              // rangeStartDay: DateTime(2022, 8, 24),
              // rangeEndDay: DateTime(2022, 8, 30),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "TODAY ACTIVITY",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(Icons.ac_unit_outlined),
                    SizedBox(width: 30),
                    Text(
                      "Brush Time",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "2min 30sec",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(Icons.ac_unit_outlined),
                    SizedBox(width: 30),
                    Text(
                      "Pressure",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "9.2 KOhm",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(Icons.ac_unit_outlined),
                    SizedBox(width: 30),
                    Text(
                      "Brush Strokes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "110",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: const [
                Icon(Icons.ac_unit_outlined),
                SizedBox(width: 30),
                Text(
                  "History",
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
                  Icon(Icons.ac_unit_outlined),
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
  }
}
