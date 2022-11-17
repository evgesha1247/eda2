import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../api/ali_client.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstansts.POPULAR_PRODUCT_URL);
  }
}
