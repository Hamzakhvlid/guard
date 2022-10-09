import 'package:flutter/material.dart';
import 'package:grab_guard/Views/main_screen.dart';
import 'package:grab_guard/Views/profile.dart';

import 'active_jobs.dart';
import 'my_bookings.dart';

class CenterScreen extends StatefulWidget {
  const CenterScreen({Key? key}) : super(key: key);

  @override
  State<CenterScreen> createState() => _CenterScreenState();
}

class _CenterScreenState extends State<CenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: AssetImage("images/maps.png"),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 00, top: 40),
                  child: Container(
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()));
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
                  // onPressed: () {
                  //
                  //
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Sixthscreen()));},
                  icon: Icon(Icons.admin_panel_settings), onPressed: () {},
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
    );
  }
}
