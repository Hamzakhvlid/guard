class GuardModel {
  final String firstName;
  final String profilePicUrl;
  final String summary;
  final String workExperience;
  final String lastName;
  final String token;
  final String city;
  final String guardId;
  final String service;

  GuardModel({
    required this.service,
    required this.guardId,
    required this.city,
    required this.token,
    required this.firstName,
    required this.profilePicUrl,
    required this.summary,
    required this.lastName,
    required this.workExperience,
  });

  factory GuardModel.fromMap(Map<String, dynamic> map) {
    return GuardModel(
        service: map['service'] ?? '',
        guardId: map['uid'] ?? "",
        city: map['city'] ?? '',
        token: map['token'] ?? '',
        firstName: map['firstName'] ?? '',
        lastName: map['secondName'] ?? '',
        profilePicUrl: map['profilePicUrl'] ?? '',
        summary: map['summary'] ?? '',
        workExperience: map['workExperience'] ?? '');
  }
}
