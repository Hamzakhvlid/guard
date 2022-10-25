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
  final double latitude;
  final double longitude;
  final String cvUrl;

  GuardModel({
    required this.cvUrl,
    required this.latitude,
    required this.longitude,
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
        cvUrl: map['cvUrl'],
        latitude: map['latitude'],
        longitude: map['longitude'],
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
