import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grab_guard/Features/notification/local_notification_service.dart';
import 'package:grab_guard/Features/storage/create_job.dart';
import 'package:grab_guard/Features/storage/data_provider.dart';
import 'package:grab_guard/Features/storage/storage_provider.dart';
import 'package:grab_guard/Models/job_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class reviewBooking extends ConsumerStatefulWidget {
  @override
  ConsumerState<reviewBooking> createState() => _reviewBookingState();
}

class _reviewBookingState extends ConsumerState<reviewBooking> {
  JobModel job = JobData.currentJob;
  bool isChecked = false;
  bool tick = false;

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios)),
                Container(
                  margin: EdgeInsets.only(left: size.width * 0.27),
                  child: Text(
                    'Review Booking',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: size.height * 0.05),
              child: Text(
                "Selected Guard",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
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
                  border: Border.all(color: Colors.black),
                  color: Color.fromRGBO(255, 255, 254, 1),
                  borderRadius: BorderRadius.circular(10.0)),
              height: size.height * 0.08,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${job.guardName} -${job.description.split(',').first}",
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${job.date} | ${job.duration}",
                        style: TextStyle(
                            fontSize: size.width * 0.03,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: size.width * 0.03,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${job.fee}",
                        style: TextStyle(
                            fontSize: size.width * 0.03,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    thickness: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 10.0,),
                      // Text("5.3",style: TextStyle(fontSize: size.width*0.024,color: Colors.black,fontWeight: FontWeight.w300),),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5, top: size.height * 0.05),
                  child: Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * .05, top: size.height * 0.05),
                  child: Text(
                    "${job.fee}£",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              // margin: EdgeInsets.only(
              //     left: size.width * 0.01,
              //     right: size.width * 0.01,
              //     top: size.height * 0.01),
              // padding: EdgeInsets.only(
              //     left: size.width * 0.02,
              //     right: size.width * 0.02,
              //     top: size.height * 0.01),
              height: size.height * 0.07,
              width: size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text('Selected Method')),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Cancellation Policy:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                'Lorem ipsum dolor sit aet, consectetur sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Lorem ipsum dolor sit aet, consectetur sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                tick
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            tick = !tick;
                          });
                        },
                        child: const Icon(
                          Icons.check_box,
                          size: 30,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            tick = true;
                          });
                        },
                        child: Icon(
                          Icons.check_box_outline_blank,
                          size: 25,
                        ),
                      ),
                Text(
                  "I agree to Grab Guard's",
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
                Text(
                  "Terms and Privacy Policy",
                  style: TextStyle(fontSize: 11, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            InkWell(
              onTap: () {
                if (tick) {
                  ref.read(storageProvider).postJob(job: job);
                  
                  LocalNotificationService.sendPushMessage(
                      "${job.hirerName} hired you",
                      "Congratulation!!",
                      job.mtoken);
                  Navigator.pop(context);
                } else {
                  EasyLoading.showError("Please select our terms to continue");
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    color: !tick ? Colors.grey : Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Confirm",
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
    );
  }
}
