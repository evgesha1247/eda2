import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/data/repository/popular_product_pero.dart';

class PopularProductController extends GetxController {
  static final to = Get.find<PopularProductController>();
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print('gooooooooooooooooooooooooooood');
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      update();
    } else {
      print(response.statusCode);
      print('noooooooooooooooooooooooooooooooooon');
    }
  }
}
