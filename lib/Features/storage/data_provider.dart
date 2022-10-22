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

  Future<GuardModel> getGuardsDetails(String uid) async {
    var obj = await firestore
        .collection('Guard')
        .doc(uid)
        .collection('Basic')
        .doc('info')
        .get();
    GuardModel user = GuardModel.fromMap(obj.data() as Map<String, dynamic>);

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

  Future<String?> getCurrentUserCity() async {
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
    return user?.city;
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

  Future<List<GuardModel>> getGuardWithCity(String? city) async {
    print(city);
    var data = await firestore
        .collection('Guard')
        .where("city", isEqualTo: city)
        .get();
    List<GuardModel> _guardList = [];

    var iter = data.docs.iterator;

    while (iter.moveNext()) {
      var obj = iter.current.data();

      GuardModel user = GuardModel.fromMap(obj as Map<String, dynamic>);

      _guardList.add(user);
    }

    return _guardList;
  }

  Future<List<GuardModel>> getGuardWithService(
      String? city, String serviceType) async {
    print(city);
    
    var data = await firestore
        .collection('Guard')
        .where('city', isEqualTo: city)
        .where('service', isEqualTo: serviceType)
        .get();
    List<GuardModel> _guardList = [];

    var iter = data.docs.iterator;

    while (iter.moveNext()) {
      var obj = iter.current.data();

      GuardModel user = GuardModel.fromMap(obj as Map<String, dynamic>);
    }

    return _guardList;
  }
}
