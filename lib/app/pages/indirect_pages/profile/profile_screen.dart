import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/repository/auth_repo.dart';
import '../../../theme/theme_app.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  @override
  void initState() {
    try {
      user = FirebaseAuth.instance.currentUser as User;
    } catch (e) {
      user = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: user != null ? _ProfileBody(user: user!) : const _Example(),
    );
  }
}

// class _ErrorWidget extends StatelessWidget {
//   const _ErrorWidget();
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('// попробуйти зайти с другова устройсва'),
//     );
//   }
// }

class _ProfileBody extends StatelessWidget {
  _ProfileBody({required this.user});
  final User user;
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
  const _Example();
  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example> {
  final pageController = PageController(viewportFraction: .8, initialPage: 1);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {});
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
            children: const [
              Text('data'),
              Text('data'),
            ],
          ),
        ),
      ],
    );
  }
}
