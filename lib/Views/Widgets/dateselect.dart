import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grab_guard/Features/storage/create_job.dart';
import 'package:grab_guard/Models/job_model.dart';

import 'bookingsummary.dart';
import 'customduration.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_range/time_range.dart';

class DateFormat extends StatefulWidget {
  @override
  State<DateFormat> createState() => _DateFormatState();
}

class _DateFormatState extends State<DateFormat> {
  JobModel? job;
  String dateSelected = "";
  String durationSelected = "";
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.twoWeeks;
  List<bool> select = [false, false, false, false, false, false];
  Color selectbox = Colors.black;
  DateTime selectedDay = DateTime.now();
  Color selectedtext = Colors.white;
  Color unSelectbox = Color.fromARGB(255, 209, 207, 207);
  Color unSelectedtext = Colors.black;
  double workingHours = 0;
  bool disabled = true;
  bool isPeriodSelected = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      job = JobData.currentJob;
    });
  }

  @override
  tapped(int index) {
    setState(() {
      if (select[index] == true) {
        select[index] = false;
      } else if (select[index] == false) {
        select[index] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return ListView(children: [
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios)),
            Divider(
              thickness: 2.0,
            ),
            TableCalendar(
              focusedDay: focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
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
            Divider(
              thickness: 2.0,
            ),
            Text('Duration',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            SizedBox(
              height: 2,
            ),
            SizedBox(
                height: screenHeight * .06,
                width: screenWidth,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      decoration: BoxDecoration(
                        // ignore: dead_code
                        color: select[0] ? selectbox : unSelectbox,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            //

                            workingHours = 24;

                            select[0] = true;
                            select[4] = false;
                            select[2] = false;
                            select[1] = false;
                            select[5] = false;
                          });
                        },
                        child: Center(
                            child: Text(
                          '1 Day',
                          style: TextStyle(
                              color: select[0] ? selectedtext : unSelectedtext),
                        )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      decoration: BoxDecoration(
                        color: select[1] ? selectbox : unSelectbox,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            workingHours = 6;

                            select[1] = true;
                            select[4] = false;
                            select[2] = false;
                            select[3] = false;
                            select[0] = false;
                            select[5] = false;
                          });
                        },
                        child: Center(
                            child: Text(
                          '6 Hrs',
                          style: TextStyle(
                              color: select[1] ? selectedtext : unSelectedtext),
                        )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      decoration: BoxDecoration(
                        color: select[2] ? selectbox : unSelectbox,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            workingHours = 4;

                            select[2] = true;
                            select[4] = false;
                            select[3] = false;
                            select[1] = false;
                            select[0] = false;
                            select[5] = false;
                          });
                        },
                        child: Center(
                            child: Text(
                          '4 Hrs',
                          style: TextStyle(
                              color: select[2] ? selectedtext : unSelectedtext),
                        )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      decoration: BoxDecoration(
                        color: select[3] ? selectbox : unSelectbox,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            workingHours = 2;

                            select[3] = true;
                            select[4] = false;
                            select[2] = false;
                            select[1] = false;
                            select[0] = false;
                            select[5] = false;
                          });
                        },
                        child: Center(
                            child: Text(
                          '2 Hrs',
                          style: TextStyle(
                              color: select[3] ? selectedtext : unSelectedtext),
                        )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      decoration: BoxDecoration(
                        color: select[4] ? selectbox : unSelectbox,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            workingHours = 1;

                            select[4] = true;

                            select[3] = false;
                            select[2] = false;
                            select[1] = false;
                            select[0] = false;
                            select[5] = false;
                          });
                        },
                        child: Center(
                            child: Text(
                          '1 Hrs',
                          style: TextStyle(
                              color: select[4] ? selectedtext : unSelectedtext),
                        )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 15),
                      decoration: BoxDecoration(
                        color: select[5] ? selectbox : unSelectbox,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            workingHours = .5;

                            select[5] = true;

                            select[4] = false;
                            select[2] = false;
                            select[1] = false;
                            select[0] = false;
                            select[3] = false;
                          });
                        },
                        child: Center(
                            child: Text(
                          '0.5 Hrs',
                          style: TextStyle(
                              color: select[5] ? selectedtext : unSelectedtext),
                        )),
                      ),
                    ),
                  ],
                )),
            TimeRange(
                fromTitle: Text(
                  'From',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                toTitle: Text(
                  'To',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                titlePadding: 20,
                textStyle: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black87),
                activeTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                borderColor: Colors.black,
                backgroundColor: Colors.transparent,
                activeBackgroundColor: Colors.amber,
                firstTime: TimeOfDay(hour: 00, minute: 00),
                lastTime: TimeOfDay(hour: 23, minute: 59),
                timeStep: 10,
                timeBlock: 30,
                onRangeCompleted: (range) => setState(() {
                      if (range == null) {
                        isPeriodSelected = false;
                        durationSelected = "";
                      } else {
                        isPeriodSelected = true;
                        durationSelected =
                            "${range.start.hour} : ${range.start.minute}  ${range.start.period.name} - ${range.end.hour} : ${range.end.minute}  ${range.end.period.name}";
                      }
                      print(disabled);
                      if (workingHours != 0 && isPeriodSelected) {
                        disabled = false;
                      } else {
                        disabled = true;
                      }
                    })),
            SizedBox(
              height: 14,
            ),
            InkWell(
              onTap: () {
                if (workingHours != 0 && isPeriodSelected) {
                  job?.date =
                      "${focusedDay.day}/${focusedDay.month}/${focusedDay.year}";
                  focusedDay.weekday;
                  switch (focusedDay.weekday) {
                                                            case 1:
                                                              job?.weekDay =
                                                                  'Monday';
                                                              break;
                                                            case 2:
                                                              job?.weekDay =
                                                                  'Tuesday';
                                                              break;
                                                            case 3:
                                                              job ?.weekDay =
                                                                  'Wednesday';
                                                              break;
                                                            case 4:
                                                              job?.weekDay =
                                                                  'Thursday';
                                                              break;
                                                            case 5:
                                                              job ?.weekDay =
                                                                  'Friday';
                                                              break;
                                                            case 6:
                                                          job  ?.weekDay =
                                                                  'Saturday';
                                                              break;
                                                            case 7:
                                                              job?.weekDay =
                                                                  'Monday';
                                                                  break;}
                  job?.duration = durationSelected;

                  job?.hours = workingHours;
                  job?.fee = workingHours * 6.5;

                  JobData.setJobModel(job!);

                  disabled = false;
                  Navigator.pop(context);

                  showModalBottomSheet(
                    isDismissible: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                    enableDrag: true,
                    context: context,
                    builder: (context) => buildSummarySheet(context),
                  );
                } else {
                  EasyLoading.showError("All the field must be selected ");
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    color: disabled
                        ? Color.fromARGB(255, 72, 72, 72)
                        : Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
