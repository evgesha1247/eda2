import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name;
  final String? phone;
  final String? imgURL;
  UserModel({
    this.name,
    this.phone,
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
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (phone != null) "phone": phone,
      if (imgURL != null) "imgURL": imgURL,
    };
  }
}
