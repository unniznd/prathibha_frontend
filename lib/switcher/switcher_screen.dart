import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:table_calendar/table_calendar.dart';

class SwitcherScreen extends StatefulWidget {
  const SwitcherScreen({super.key});

  @override
  State<SwitcherScreen> createState() => _SwitcherScreenState();
}

final kToday = DateTime.now();

final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class _SwitcherScreenState extends State<SwitcherScreen> {
  int _selectedIndex = 0;

  final List<String> _tabs = [
    'Dashboard',
    'Attedance',
    'Finance',
  ];

  final CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 250.0,
            color: const Color.fromRGBO(245, 247, 249, 1),
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0
                          ? const Color.fromRGBO(68, 97, 242, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        HeroIcon(
                          HeroIcons.squares2x2,
                          color:
                              _selectedIndex == 0 ? Colors.white : Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _tabs[0],
                          style: TextStyle(
                            color: _selectedIndex == 0
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == 1
                          ? const Color.fromRGBO(68, 97, 242, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        HeroIcon(
                          HeroIcons.userPlus,
                          color:
                              _selectedIndex == 1 ? Colors.white : Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _tabs[1],
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == 2
                          ? const Color.fromRGBO(68, 97, 242, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        HeroIcon(
                          HeroIcons.currencyDollar,
                          color:
                              _selectedIndex == 2 ? Colors.white : Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _tabs[2],
                          style: TextStyle(
                            color: _selectedIndex == 2
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Content for Tab $_selectedIndex',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          //add right side as profile view
          SingleChildScrollView(
            child: Container(
              width: 300,
              padding: const EdgeInsets.only(
                top: 50,
                left: 5,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      HeroIcon(
                        HeroIcons.pencilSquare,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Maietry Prajapati",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "Main Adminstrator",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TableCalendar(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Events",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    content: Builder(
                                      builder: (context) {
                                        // Get available height and width of the build area of this widget. Make a choice depending on the size.

                                        return SizedBox(
                                          height: 250,
                                          width: 500,
                                          child: Column(
                                            children: [
                                              // add events
                                              const Text(
                                                "Add Event",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "Event Name",
                                                    filled: true,
                                                    fillColor: Color.fromRGBO(
                                                        234, 240, 247, 1),
                                                    border: InputBorder.none,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "Event Date",
                                                    filled: true,
                                                    fillColor: Color.fromRGBO(
                                                        234, 240, 247, 1),
                                                    border: InputBorder.none,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              SizedBox(
                                                width: 200,
                                                height: 50,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child:
                                                      const Text("Add Event"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ));
                        },
                        child: const HeroIcon(
                          HeroIcons.plus,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(245, 247, 249, 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Event Name",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
