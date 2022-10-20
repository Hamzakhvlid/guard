import 'package:grab_guard/Models/job_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobData {
  static JobModel job = JobModel(
    mtoken: "",
     weekDay: "",
      profileUrl: '',
      fee: 0.0,
      hours: 0.0,
      guardName: "",
      hirerId: '${FirebaseAuth.instance.currentUser?.uid}',
      hirerName: "",
      guardId: "",
      duration: "",
      date: "",
      description: "key-holding",
      pending: true);

  static void setJobModel(JobModel newJob) {
    job = newJob;
  }

  static get currentJob {
    return job;
  }
}
