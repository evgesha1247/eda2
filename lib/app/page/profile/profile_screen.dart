import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/repository/auth_repo.dart';
import '../../theme/theme_app.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  @override
  void initState() {
    try {
      user = FirebaseAuth.instance.currentUser as User;
    } catch (e) {
      print('user is null !!!');
      user = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user != null ? _ProfileBody(user: user!) : _Example(),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('// попробуйти зайти с другова устройсва'),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  _ProfileBody({required this.user});
  User user;
  final auth = AuthRepo.instance;
  @override
  Widget build(BuildContext context) {
    // user.updatePhotoURL(
    //     "https://xakep.ru/wp-content/uploads/2020/09/320274/pivoting-h-850x491.jpg");
    return Center(
      child: Column(
        children: [
          Text('id : ${user.uid}'),
          Text('name : ${user.displayName}'),
          Text('photo : ${user.photoURL}'),
          Text('email : ${user.email}'),
          ElevatedButton(
              onPressed: () => auth.logout(), child: const Text('logout')),
        ],
      ),
    );
  }
}

class _Example extends StatefulWidget {
  _Example({super.key});
  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example> {
  var _currPageValue = 1.0;
  final double _scaleFactore = 0.8;
  final double _height = ThemeAppSize.kPageViewContainer;
  final pageController = PageController(viewportFraction: .8, initialPage: 1);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: ThemeAppSize.kPageView,
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: pageController,
            children: [
              Text('data'),
              Text('data'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemHotPromo(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactore + (_currPageValue - index + 1) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactore) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(onTap: () => {}, child: Center()),
    );
  }
}
