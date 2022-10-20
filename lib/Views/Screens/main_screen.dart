import 'package:flutter/material.dart';
import 'package:grab_guard/Features/storage/data_provider.dart';
import 'package:grab_guard/Models/guard_model.dart';
import 'package:grab_guard/Views/Widgets/admin_screen.dart';
import 'package:grab_guard/Views/Widgets/main_widget.dart';

import '../Widgets/my_bookings.dart';

import '../Widgets/profile.dart';

import '../Widgets/active_jobs.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {


  
  int pageIndex = 0;

  static const List<Widget> pages=[MainScreenWidget(),Bookings(),AdminScreen(),ActiveJobs(),ProfileScreen()];

  

  @override
  void initState() {
    // TODO: implement initState

   

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: Icon(Icons.home),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                  
                 
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
                    setState(() {
                      pageIndex = 2;
                    });
                  
                     
                  },
                  icon: Icon(Icons.admin_panel_settings),
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: Icon(Icons.local_activity_outlined),
              ),
              label: "Active Jobs"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    pageIndex = 4;
                  });
                 
                },
                icon: Icon(Icons.person_outline),
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
