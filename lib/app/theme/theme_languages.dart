import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ru_RU': {
          // menu guiding
          'home': 'Главное',
          'menu': 'Меню',
          'favorites': 'Избранные',
          'person': 'Профиль',

          // home  ,  1 page
          'welcom': 'Здравствуйте',
          'popular_product': 'полулярные позиции',
          'top_recommended': 'топ рекомендаций',

          // menu  ,  2 page
          'search': 'Поиск',
          'sort_by': 'сортировать по',
          'menu_list': 'список позиций',
          'filter': 'фильтр',
          'A_to_Z': 'по порядку',
          'Z_to_A': 'с конца',

          /// menu  ,  2 page , filter
          'price_range': 'Диапозон',
          'category': 'Категория',

          /// menu  ,  2 page , sort by
          'price': 'Цена',
          'name': 'Название',
          'low_to_high': 'по возрастанию',
          'high_to_low': 'по убыванию',

          // cart
          'cart': 'Корзина',
          'total': 'Цена',
          'discount': 'Скидка',
          'pay': 'Купить',
          // detailed
          'description': 'Описание',
          'more_images': 'Больше изображений',
          'show': 'раскрыть',
          'close': 'закрыть',
          'go_to_cart': 'К заказу',


          // User
          'buy': 'Покупок',
          'bought_on': 'Потраченно',
          'favorite': 'Избранных',
          'logout': 'Выйти',
          'email': 'Почта',

          // User setting
          'setting': 'Настройки',
          'photo': 'Фото',
          'phone': 'Телефон',
          'save': 'сохранить',
          'address': 'адрес',


          // auth page
          'login': 'Войти',
          'register': 'Регистрация',
          'no_accaount': 'нет аккаунта ?',
          'have_an_account': 'уже есть аккаунт ?',


          //
          'Dark mode': 'Темный режим',
          'Language': 'Язык',
          'preference': 'предпоченик',
          'are common': 'общие',
          'User_name': 'Имя',
        },



        'en_US': {
          'User_name': 'Name',

          'preference': 'preference',
          'are common': 'are common',
          'Language': 'Language',
          'Dark mode': 'Dark mode',

          // menu guiding
          'home': 'Home',
          'menu': 'Menu',
          'favorites': 'Favorites',
          'person': 'Person',


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


          // cart
          'cart': 'Cart',
          'total': 'Total',
          'discount': 'Discount',
          'pay': 'Pay',

          // detailed
          'description': 'Introduce',
          'more_images': 'More images',
          'show': 'show',
          'close': 'close',
          'go_to_cart': 'Go to cart',

          // User
          'buy': 'buy',
          'bought_on': 'bought on',
          'favorite': 'favorites',
          'logout': 'logout',
          'email': 'email',

          // User setting
          'setting': 'Setting',
          'photo': 'Photo',
          'phone': 'phone',
          'save': 'save',
          'address': 'address',

          // auth page
          'login': 'Login',
          'register': 'Register',
          'no_accaount': 'no accaount ?',
          'have_an_account': 'have an account ?',
        },
      };
}
