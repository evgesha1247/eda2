import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../api/api_client.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    print('get Recommended');
    return await apiClient.getData(AppConstansts.RECOMMENDED_PRODUCT_URL);
  }
  Future<Response> getPopularProductList() async {
    print('get Popular');
    return await apiClient.getData(AppConstansts.POPULAR_PRODUCT_URL);
  }
}
