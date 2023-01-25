import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ru_RU': {
          // home  ,  1 page
          'welcom': 'добро пожаловать',
          'popular_product': 'полулярные позиции',
          'top_recommended': 'топ рекомендаций',

          // menu  ,  2 page
          'search': 'Поиск',
          'sort_by': 'сортировать по',
          'menu_list': 'список позиций',
          'filter': 'фильтер',
          'A_to_Z': 'по порядку',
          'Z_to_A': 'с конца',

          /// menu  ,  2 page , sort by
          'price': 'Цена',
          'name': 'Название',
          'low_to_high': 'по возрастанию',
          'high_to_low': 'по убыванию',

          /// menu  ,  2 page , filter
          'price_range': 'Диапозон',
          'category': 'Категория',

          // menu
          'home': 'Главное',
          'menu': 'Меню',
          'favorites': 'Избранные',
          'person': 'профель',
        },
        'en_US': {
          // home  ,  1 page
          'welcom': 'Welcom',
          'popular_product': 'Popular product',
          'top_recommended': 'Top recommended',

          // menu  ,  2 page
          'search': 'Search',
          'sort_by': 'Sort by',
          'menu_list': 'Menu list',
          'filter': 'Filter',
          'A_to_Z': 'A to Z',
          'Z_to_A': 'Z to A',

          /// menu  ,  2 page , sort by
          'price': 'Price',
          'name': 'Name',
          'low_to_high': 'Low to high',
          'high_to_low': 'High to low',

          /// menu  ,  2 page , filter
          'price_range': 'Price range',
          'category': 'Category',

          // menu
          'home': 'Home',
          'menu': 'Menu',
          'favorites': 'Favorites',
          'person': 'Person',
        },
      };
}
