class UserModel {
  final String firstName;
  final String lastName;
  final String uid;
  final String profilePic;
  final String phoneNumber;
  final String email;
  final String address;
  final String city;

  UserModel({
    required this.city,
    required this.firstName,
    required this.lastName,
    required this.uid,
    required this.profilePic,
    required this.address,
    required this.phoneNumber,
    required this.email,
  });

  Map<String, String> toMap(
      {required String city,
        required String firstName,
      required String uid,
      required String profilePic,
      required String address,
      required String email,
      required String phoneNumber}) {
    return {
      'city':city,
      'name': firstName,
      'uid': uid,
      'profilePic': profilePic,
      'address': address,
      'phoneNumber': phoneNumber,
      'groupId': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      city: map['city'],
      lastName: map['lastName'],
      firstName: map['firstName'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePicUrl'] ?? '',
      address: map['address'] ?? "",
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
