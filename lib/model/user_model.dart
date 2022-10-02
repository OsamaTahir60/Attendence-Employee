class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  int? qr_code;
  int? freeMeal;

  UserModel({this.uid, this.email, this.firstName, this.secondName,this.qr_code,this.freeMeal});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      qr_code: map['qr_code'],
      freeMeal: map['freeMeal'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'qr_code':qr_code,
      'freeMeal': freeMeal,
    };
  }
}
