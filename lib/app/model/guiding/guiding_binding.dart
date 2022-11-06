import 'package:get/get.dart';
import 'package:text/app/model/guiding/guiding_model.dart';

class GuidingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<GuidingScreenModel>(GuidingScreenModel());
  }
}
