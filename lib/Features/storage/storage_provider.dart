import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grab_guard/Models/job_model.dart';
import 'package:grab_guard/Views/Screens/main_screen.dart';

import 'package:riverpod/riverpod.dart';

final storageProvider = Provider((ref) => StorageMethods(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance));

class StorageMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StorageMethods(
      {required this.auth, required this.firestore, required this.storage});

  Future<String> uploadImageToStorage(String childName, File file) async {
    String downloadUrl = "";
    // creating location to our firebase storage

    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);

    // putting in uint8list format -> Upload task like a future but not future

    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snapshot = await uploadTask;
    try {
      downloadUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      EasyLoading.showError(e.toString().split(']').last);
    }
    return downloadUrl;
  }

  Future<void> updateUserData({
    required String firstName,
    required String lastName,
    required String address,
    required String profilePicUrl,
  }) async {
    await firestore
        .collection('Hirer')
        .doc(auth.currentUser?.uid)
        .collection('Basic')
        .doc('info')
        .update(
      {
        'firstName': firstName,
        'lastName': lastName,
        ' profilePicUrl': profilePicUrl,
        'address': address,
        'profilePicUrl': profilePicUrl,
      },
    ).then((value) {
      EasyLoading.showSuccess("Data Updated successfully");
    }).catchError((error) {
      EasyLoading.showError("Failed to update try again");
    });
  }

  Future<void> saveUser(
      {required String city,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String email,
      required String address,
      required String profilePicUrl,
      required BuildContext context}) async {
    await firestore
        .collection('Hirer')
        .doc(auth.currentUser?.uid)

        .set({'uid':auth.currentUser?.uid,'deleted':false});

    await firestore
        .collection('Hirer')
        .doc(auth.currentUser?.uid)
        .collection('Basic')
        .doc('info')
        .set(
      {
        'city': city,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address,
        'profilePicUrl': profilePicUrl,
      },
    ).then((value) {
      EasyLoading.showSuccess("Data added successfully");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }).catchError((error) {
      EasyLoading.showError(error.toString());
    });
  }

  Future<void> postJob({JobModel? job}) async {
    String date = DateTime.now().toString();
    var newJob = JobModel.toMap(job);

    await firestore
        .collection('Hirer')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('bookings')
        .doc(date)
        .set({...newJob}, SetOptions(merge: true)).then((value) {
      EasyLoading.showSuccess("Job posted");
    });

    await firestore
        .collection('Guard')
        .doc(job?.guardId)
        .collection('jobs')
        .doc(date)
        .set({...newJob}, SetOptions(merge: true));
  }
}
