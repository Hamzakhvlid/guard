import 'package:grab_guard/Features/storage/create_job.dart';
import 'package:grab_guard/Models/job_model.dart';
import 'package:grab_guard/Views/Widgets/addnewcard.dart';

import 'reviewbooking.dart';
import 'package:flutter/material.dart';

Widget selectPaymentMethod(BuildContext context) {
  var size = MediaQuery.of(context).size;
  var job=JobData.currentJob;
  return Container(
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
              margin: EdgeInsets.only(left: size.width * 0.2),
              child: Text(
                'Select Payment Method',
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
        Container(
          margin: EdgeInsets.only(top: size.height * 0.03),
          height: size.height * 0.08,
          width: size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Container(
                width: size.width * 0.7,
                child: RadioListTile(
                  value: 0,
                  groupValue: 1,
                  onChanged: (val) {},
                  title: Row(
                    children: [
                      Icon(Icons.payment),
                      Text("***** 1234"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: size.height * 0.03),
          height: size.height * 0.08,
          width: size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Container(
                width: size.width * 0.7,
                child: RadioListTile(
                  value: 0,
                  groupValue: 1,
                  onChanged: (val) {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        )),
                        enableDrag: true,
                        context: context,
                        builder: (context) => addnewCardd(context));
                  },
                  title: Row(
                    children: [
                      Icon(Icons.payment),
                      Text("Add new card"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
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
              enableDrag: true,
              context: context,
              builder: (context) => reviewBooking(),
            );
          },
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(10)),
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
  );
}
