import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:text/utils/app_constants.dart';

import '../model/restoran_model.dart';

class AboutController extends GetxController {
  int selectedIndexPickupAdress = -1;
  List<RestoranModel?> listInfoRestorans = [];
  void togSelectPickup(index) {
    selectedIndexPickupAdress == index
        ? selectedIndexPickupAdress = -1
        : selectedIndexPickupAdress = index;
    update();
  }

  Future<void> initLocalData() async {
    listInfoRestorans = [];
    final db = FirebaseFirestore.instance;
    CollectionReference collectionRef =
        db.collection(AppConstansts.LOCOL_KEY_INFO_DATA_RESTORAN);
    QuerySnapshot querySnapshot = await collectionRef.get();
    querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList()
        .forEach((element) {

      final nowTime = double.parse(DateFormat("HH.mm").format(DateTime.now()));
      final timePeriod = element['dataTime']['time'];
      final restTimeOpen = double.parse(timePeriod.substring(0, 5));
      final restTimeClose = double.parse(timePeriod.substring(8));
      bool isOpen = nowTime > restTimeOpen && nowTime < restTimeClose;
      listInfoRestorans.add(
        RestoranModel(
          adres: element['adres'],
          dataTime: element['dataTime'],
          status: isOpen,
        ),
      );
    });

    update();
  }
}
