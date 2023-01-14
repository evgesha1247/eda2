import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name;
  final String? phone;
  final String? imgURL;
  final String? email;
  UserModel({
    this.name,
    this.phone,
    this.email,
    this.imgURL,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      name: data?['name'],
      phone: data?['phone'],
      imgURL: data?['imgURL'],
      email: data?['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (phone != null) "phone": phone,
      if (imgURL != null) "imgURL": imgURL,
      if (email != null) "email": email,

    };
  }
}
