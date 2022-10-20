import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:grab_guard/Features/storage/data_provider.dart';
import 'package:grab_guard/Models/job_model.dart';
import 'package:table_calendar/table_calendar.dart';

class Bookings extends ConsumerStatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  ConsumerState<Bookings> createState() => _BookingsState();
}

class _BookingsState extends ConsumerState<Bookings> {
  List<JobModel> bookings = [];
  bool loading = true;
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  bool isNobookings = false;
  Future<void> getBookings() async {
    var data = await ref.read(dataProvier).getBookings();

    setState(() {
      if (data.isEmpty) {
        isNobookings = true;
      }
      bookings = data;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getBookings();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //rgba(255,255,254,255)
              color: Color.fromRGBO(255, 255, 254, 1),

              height: size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bookings",
                        style: TextStyle(
                            fontSize: size.width * 0.06,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.notifications_none_outlined,
                        size: size.width * 0.08,
                      )
                    ],
                  ),
                  TableCalendar(
                    focusedDay: focusedDay,
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2050),
                    calendarFormat: format,
                    onFormatChanged: (CalendarFormat _format) {},
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                      });
                      print(focusedDay);
                    },
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: false,
                      selectedDecoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            loading
                ? Center(
                    child:  isNobookings?Text("No Bookings Yet"): CircularProgressIndicator(),
                  )
                : Container(
                    width: size.width,
                    height: size.height * .45,
                    child: ListView.builder(
                        itemCount: bookings.length,
                        itemBuilder: ((context, index) {
                          return ListItem(
                              bookings[index].weekDay,
                              bookings[index].date,
                              bookings[index].duration,
                              size);
                        })),
                  )
          ],
        ),
      ),
    );
  }

  Widget ListItem(String weekDay, String date, String timing, var size) {
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.height * 0.07),
      padding: EdgeInsets.only(
          left: size.width * 0.02,
          right: size.width * 0.02,
          top: size.height * 0.01),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 254, 1),
          borderRadius: BorderRadius.circular(10.0)),
      height: size.height * 0.08,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$weekDay  $date",
            style: TextStyle(
                fontSize: size.width * 0.04,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Icon(
                Icons.watch_later_outlined,
                color: Colors.grey,
                size: 20.0,
              ),
              Text(
                timing,
                style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customCol(day, date, size) {
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$day",
            style: TextStyle(
                fontSize: size.width * 0.05,
                color: Color.fromRGBO(198, 198, 201, 1)),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            "$date",
            style: TextStyle(fontSize: size.width * 0.05, color: Colors.black),
          )
        ],
      ),
    );
  }
}
