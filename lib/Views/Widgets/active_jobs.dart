import 'package:flutter/material.dart';
import 'package:grab_guard/Features/storage/data_provider.dart';
import 'package:grab_guard/Models/job_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveJobs extends ConsumerStatefulWidget {
  const ActiveJobs({Key? key}) : super(key: key);

  @override
  ConsumerState<ActiveJobs> createState() => _ActiveJobsState();
}

class _ActiveJobsState extends ConsumerState<ActiveJobs> {
  List<JobModel> bookings = [];
  bool loading = true;
  bool isNobookings = false;
  Future<void> getBookings() async {
    var data = await ref.read(dataProvier).getActiveBookings();

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
    // TODO: implement initState
    super.initState();
    getBookings();
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
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: size.width,
                    height: size.height * .75,
                    child: bookings.isEmpty?Center(child: Text("No jobs posted yet"),):ListView.builder(
                        itemCount: bookings.length,
                        itemBuilder: ((context, index) => Listitem(
                            bookings[index].guardName +
                                "-" +
                                bookings[index].description.split(',').first,
                            bookings[index].date,
                            bookings[index].weekDay,
                            bookings[index].duration,
                            bookings[index].fee,
                            size))),
                  )
          ],
        ),
      ),
    );
  }

  Widget Listitem(String header, String date, String day, String duration,
      double fee, var size) {
    return Container(
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
                header,
                style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "${day} | ${date}",
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
                fee.toString(),
                style: TextStyle(
                    fontSize: size.width * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
