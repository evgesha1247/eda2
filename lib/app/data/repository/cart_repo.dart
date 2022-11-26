import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedStore;
  CartRepo({required this.sharedStore});
}
