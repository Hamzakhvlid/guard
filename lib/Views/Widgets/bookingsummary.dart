import 'package:grab_guard/Features/storage/create_job.dart';
import 'package:grab_guard/Models/job_model.dart';

import 'selectPaymentMethod.dart';
import 'package:flutter/material.dart';

Widget buildSummarySheet(BuildContext context) {
  JobModel job = JobData.currentJob;
  var size = MediaQuery.of(context).size;

  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
    child: SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      "Your Booking Summary",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: size.height * 0.05),
              child: Text(
                "Selected guard",
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
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${job.guardName} -  ${job.description}",
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${job.date} |  ${job.duration}",
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
                      Icon(
                        Icons.card_travel_rounded,
                        size: 20.0,
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            Divider(
              thickness: 2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "${job.fee}",
                      style: TextStyle(
                          fontSize: size.width * 0.05,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${job.fee}",
                      style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    
                    Navigator.pop(context);

                    showModalBottomSheet(
                        isDismissible: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        )),
                        context: context,
                        builder: (context) =>
                            selectPaymentMethod(context));
                  },
                  child: Container(
                    height: size.height * 0.07,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.black),
                    child: Center(
                        child: Text(
                      "Book",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
