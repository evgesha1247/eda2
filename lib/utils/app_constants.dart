// ignore_for_file: constant_identifier_names

class AppConstansts {
  static const String APP_NAME = "FlutterApp";
  static const int APP_VERSION = 1;

  // http://mvs.bslmeiyu.com/api/v1/products/popular/
  // https://fir-app-7be70-default-rtdb.firebaseio.com/products/popular.json

  // static const String BASE_URL = "http://mvs.bslmeiyu.com";
  // static const String POPULAR_PRODUCT_URL = "/api/v1/products/popular/";
  // static const String RECOMMENDED_PRODUCT_URL = "/api/v1/products/recommended/";

  static const String BASE_URL =
      "https://fir-app-7be70-default-rtdb.firebaseio.com/";
  static const String POPULAR_PRODUCT_URL = "products/popular.json";
  static const String RECOMMENDED_PRODUCT_URL = "products/recommended.json";
  static const String PRODUCT_URL = "products/products.json";
  static const String TOKEN = "DBtoken";

  static const String LOCOL_KEY_RESTORAN = 'Rest';
  static const String LOCOL_KEY_INFO_DATA_RESTORAN = 'infoRestorans';


  static const String CART_LIST = "Cart_List";
  static const String FAVORITE_LIST = "favorite_list";
  static const String CART_HISTORY_LIST = "Cart_History_List";
}
