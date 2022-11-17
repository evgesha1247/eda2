import 'package:get/get.dart';

import '../app/controllers/popular_product_controller.dart';
import '../app/data/api/ali_client.dart';
import '../app/data/repository/popular_product_pero.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstansts.BASE_URL));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}
