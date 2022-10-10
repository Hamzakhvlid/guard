import 'package:flutter/material.dart';
import 'package:grab_guard/Features/authentiction/auth_provider.dart';
import 'package:grab_guard/Views/password.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//make this widget consumerwidget rather than a stateful widget

class OtpVerify extends ConsumerWidget {
  //Adding a constructor to receive the verification id for calling the verification method
  String verificationId;
  OtpVerify({required this.verificationId});
  var val = TextEditingController();



  //a method is created to verify if the OTP is correct or not 
  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Security Code",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black45,
            )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Row(
                children: [
                  Text(
                    "Enter the code you recieve on mobile",
                    style: TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child:   SizedBox(
              
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
               controller: val,
              ),
            ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Row(
                children: [
                  Text(
                    "Didn't recieved code?",
                    style: TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {
                       //The trim method is called to remove any leading or ending whiteSpace 
                 verifyOTP(ref, context, val.text);
               // Navigator.push(context,
                  //  MaterialPageRoute(builder: (context) => Password()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
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
    );
  }
}
