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
    final model = _model;
    if (model != null) {
      return ChangeNotifierProvider(
        create: (context) => model,
        child: DishDetaild(model: model),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class DishDetaild extends StatelessWidget {
  const DishDetaild({Key? key, this.model}) : super(key: key);
  final model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(ThemeApp.kInterval),
            child: Stack(
              children: [
                //////////картинка///////////////

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/imgs/food5.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),

                //////////кнопка назад ///////////////

                GestureDetector(
                  onTap: () => model.showMenu(context),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ThemeApp.kFrontColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(ThemeApp.kRadius),
                      ),
                    ),
                    padding: const EdgeInsets.all(ThemeApp.kInterval),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: ThemeApp.kAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ThemeApp.kFrontColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(ThemeApp.kRadius),
                ),
              ),
              child: Text('qweqwe'),
            ),
          ),
        ],
      ),
    );
  }
}
