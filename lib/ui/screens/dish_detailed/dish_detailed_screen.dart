import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'dish_detailed_model.dart';

class DishDetailedScreen extends StatefulWidget {
  const DishDetailedScreen({Key? key}) : super(key: key);
  @override
  State<DishDetailedScreen> createState() => _DishDetailedScreenState();
}

class _DishDetailedScreenState extends State<DishDetailedScreen> {
  DishDetailedModel? _model;
  @override
  void didChangeDependencies() {
    if (_model == null) {
      final dishKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = DishDetailedModel(dishKey: dishKey);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    DishDetailedModel? model = _model;
    if (model != null) {
      return ChangeNotifierProvider(
        create: (context) => model,
        child: const DishDetaild(),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class DishDetaild extends StatelessWidget {
  const DishDetaild({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ThemeApp.kInterval),
          child: Column(
            children: [
              Stack(
                children: const [
                  _DishDetailedContainer(),
                  _DishDetailedImg(),
                  _DishDetailedButtonBack(),
                ],
              ),
              //   _DishDetailedDescriptions(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DishDetailedImg extends StatelessWidget {
  const _DishDetailedImg({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    final imgUrl = model.dish?.imgUrl ?? 'assets/imgs/food2.png';
    return Center(
      child: Image.asset(
        imgUrl,
        height: 200,
        width: MediaQuery.of(context).size.width * 0.6,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

class _DishDetailedContainer extends StatelessWidget {
  const _DishDetailedContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ThemeApp.kFrontColor,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeApp.kRadius),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.all(ThemeApp.kInterval),
      child: const _DishDetailedText(),
    );
  }
}

class _DishDetailedText extends StatelessWidget {
  const _DishDetailedText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Align(
          alignment: Alignment.topRight,
          child: Icon(Icons.bookmark_border, color: ThemeApp.kWhite),
        ),
        SizedBox(height: 60),
        Text(
          'Описание',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeApp.kWhite,
            letterSpacing: 3,
            fontSize: 24,
          ),
        ),
        SizedBox(height: ThemeApp.kInterval),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing  Lorem ipsum dolor sit amet, consectetur adipiscing s',
          style: TextStyle(
            color: ThemeApp.kWhite,
            fontSize: 18,
            fontWeight: FontWeight.normal,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}

class _DishDetailedButtonBack extends StatelessWidget {
  const _DishDetailedButtonBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<DishDetailedModel>();
    return GestureDetector(
      onTap: () => model.showMenu(context),
      child: Container(
        decoration: const BoxDecoration(
          color: ThemeApp.kFrontColor,
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeApp.kRadius),
          ),
        ),
        padding: const EdgeInsets.only(
          top: ThemeApp.kInterval,
          bottom: ThemeApp.kInterval,
          left: ThemeApp.kInterval + 10,
          right: ThemeApp.kInterval,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: ThemeApp.kAccent,
        ),
      ),
    );
  }
}
