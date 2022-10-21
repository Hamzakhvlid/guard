class GuardModel {
  final String firstName;
  final String profilePicUrl;
  final String summary;
  final String workExperience;
  dynamic job;
  final String lastName;
  final String uid;
  final String token;
  final String city;

  GuardModel({
    required this.city,
    required this.token,
    required this.firstName,
    required this.profilePicUrl,
    required this.summary,
    required this.job,
    required this.lastName,
    required this.workExperience,
    required this.uid,
  });

  factory GuardModel.fromMap(Map<String, dynamic> map, String id) {
    return GuardModel(
       city: map['city']??'',
        token: map['token'] ?? '',
        uid: id,
        firstName: map['firstName'] ?? '',
        lastName: map['secondName'] ?? '',
        profilePicUrl: map['profilePicUrl'] ?? '',
        summary: map['summary'] ?? '',
        workExperience: map['workExperience'] ?? '',
        job: map['job'] ?? '');
  }
}
