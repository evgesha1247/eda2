import 'package:get/get.dart';

class ProfileController extends GetxController {
  bool isVisibility = true;
  togVisibility() {
    isVisibility = !isVisibility;
    update();
  }
}
