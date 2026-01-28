import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs;
DateTime? lastBackPressed;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
