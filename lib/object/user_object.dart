class User {
  String id;
  final String name;
  final int age;
  final String address;
  final String telephone;
  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.address,
    required this.telephone,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'address': address,
        'telephone': telephone,
      };
}
