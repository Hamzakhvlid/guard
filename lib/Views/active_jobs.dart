import 'package:flutter/material.dart';
import 'package:grab_guard/Views/profile.dart';

import 'center_screen.dart';
import 'main_screen.dart';
import 'my_bookings.dart';

class ActiveJobs extends StatefulWidget {
  const ActiveJobs({Key? key}) : super(key: key);

  @override
  State<ActiveJobs> createState() => _ActiveJobsState();
}

class _ActiveJobsState extends State<ActiveJobs> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 254, 1),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                icon: Icon(Icons.home),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  //
                  //
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Bookings()));
                },
                icon: Icon(Icons.my_library_books),
              ),
              label: "MyBookings"),
          BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(100.0)),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CenterScreen()));
                  },
                  icon: Icon(Icons.admin_panel_settings),
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ActiveJobs()));
                },
                icon: Icon(Icons.local_activity_outlined),
              ),
              label: "Active Jobs"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                icon: Icon(Icons.person_outline),
              ),
              label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.03, right: size.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Active Jobs",
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
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "In Progress",
                style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.01,
                    right: size.width * 0.01,
                    top: size.height * 0.01),
                padding: EdgeInsets.only(
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                    top: size.height * 0.01),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(51, 72, 159, 1),
                    borderRadius: BorderRadius.circular(10.0)),
                height: size.height * 0.08,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Steve Smith - key holding",
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Monday, 16 June | 10:00am - 12:00am",
                          style: TextStyle(
                              fontSize: size.width * 0.03,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "123",
                          style: TextStyle(
                              fontSize: size.width * 0.03,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
