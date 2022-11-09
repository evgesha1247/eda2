part of 'main_screens.dart';

abstract class MainRoutes {
  MainRoutes._();
  static const splash = _Paths.splash;
  static const load = _Paths.load;
  static const appHome = _Paths.appHome;
  static const auth = _Paths.auth;
  static const details = _Paths.details;
  static const detailsCart = _Paths.detailsCart;
  static const homeCart = _Paths.homeCart;
}

abstract class _Paths {
  _Paths._();
  static const splash = '/splash';
  static const load = '/load';
  static const appHome = '/appHome';
  static const auth = '/auth';
  static const details = '/appHome/details';

  static const detailsCart = '/appHome/details/cart';
  static const homeCart = '/appHome/cart';
}
