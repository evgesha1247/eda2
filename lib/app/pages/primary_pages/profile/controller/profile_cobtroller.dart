import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isVisibility = true.obs;
  RxBool isEditName = true.obs;
  togEditName() {
    isEditName.value = !isEditName.value;
  }
  togVisibility() {
    isVisibility.value = !isVisibility.value;

  }


}
