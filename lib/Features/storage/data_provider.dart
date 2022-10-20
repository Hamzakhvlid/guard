import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grab_guard/Models/guard_model.dart';
import 'package:grab_guard/Models/job_model.dart';
import 'package:grab_guard/Models/user_model.dart';

final dataProvier = Provider(((ref) => DataProvider()));

class DataProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<String> listData = ['no user', 'hello user'];
  // ignore: prefer_final_fields
  static List<GuardModel> _guardList = [];

  List<GuardModel> get getGuardList {
    return _guardList;
  }

  Future<GuardModel> getGuardsDetails(String uid) async {
    var obj = await firestore
        .collection('Guard')
        .doc(uid)
        .collection('Basic')
        .doc('info')
        .get();
    GuardModel user =
        GuardModel.fromMap(obj.data() as Map<String, dynamic>, uid);

    return user;
  }

  Future<List<JobModel>> getActiveBookings() async {
    List<JobModel> _jobList = [];
    var data = await firestore
        .collection('Hirer')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('bookings')
        .where('pending', isEqualTo: true)
        .get();

    var iter = data.docs.iterator;

    while (iter.moveNext()) {
      var booking = iter.current.data();
      var item = JobModel.fromMap(booking);

      _jobList.add(item);

      //_jobList.add(job);
    }
    return _jobList;
  }

  Future<List<JobModel>> getBookings() async {
    List<JobModel> _jobList = [];
    var data = await firestore
        .collection('Hirer')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('bookings')
        .get();

    var iter = data.docs.iterator;

    while (iter.moveNext()) {
      var booking = iter.current.data();
      var item = JobModel.fromMap(booking);

      _jobList.add(item);

      //_jobList.add(job);
    }
    return _jobList;
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData = await firestore
        .collection('Hirer')
        .doc(auth.currentUser?.uid)
        .collection('Basic')
        .doc('info')
        .get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<void> getGuard() async {
    var data = await firestore.collection('Guard').get();

    var iter = data.docs.iterator;
    _guardList.clear();

    while (iter.moveNext()) {
      var uid = iter.current.id;

      var obj = await firestore
          .collection('Guard')
          .doc(uid)
          .collection('Basic')
          .doc('info')
          .get();

      GuardModel user =
          GuardModel.fromMap(obj.data() as Map<String, dynamic>, uid);
      _guardList.add(user);
      print(user.firstName);
    }
  }
}
