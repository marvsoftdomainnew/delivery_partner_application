// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class HomeController extends GetxController {
//   RxBool isOnline = false.obs;
//   RxInt currentOrderIndex = 0.obs;

//   Timer? _orderTimer;

//   final List<Map<String, dynamic>> orders = [
//     {
//       "earning": 85,
//       "shop": "Machli Bazar - Sector 4",
//       "pickup": "Fish Market",
//       "drop": "Gomti Nagar",
//       "address": "Shop 12, Fish Market, Gomti Nagar",
//     },
//     {
//       "earning": 70,
//       "shop": "Fresh Fish Point",
//       "pickup": "Alambagh",
//       "drop": "Charbagh",
//       "address": "Shop 5, Alambagh, Lucknow",
//     },
//     {
//       "earning": 95,
//       "shop": "Sea Food Hub",
//       "pickup": "Indira Nagar",
//       "drop": "Hazratganj",
//       "address": "Shop 9, Indira Nagar, Lucknow",
//     },
//   ];

//   void toggleOnline() {
//     isOnline.value = !isOnline.value;

//     if (!isOnline.value) {
//       _orderTimer?.cancel();
//       currentOrderIndex.value = 0;
//     }
//   }

//   void startFindingOrders(VoidCallback onOrderFound) {
//     _orderTimer?.cancel();

//     _orderTimer = Timer(const Duration(seconds: 2), () {
//       if (!isOnline.value) return;
//       HapticFeedback.mediumImpact();
//       onOrderFound();
//     });
//   }

//   void ignoreOrder(VoidCallback showNext) {
//     currentOrderIndex.value =
//         (currentOrderIndex.value + 1) % orders.length;

//     _orderTimer = Timer(const Duration(seconds: 2), () {
//       if (!isOnline.value) return;
//       showNext();
//     });
//   }

//   @override
//   void onClose() {
//     _orderTimer?.cancel();
//     super.onClose();
//   }
// }





import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isOnline = false.obs;
  RxInt currentOrderIndex = 0.obs;
  RxBool isAcceptingOrder = false.obs; 
  final List<Map<String, dynamic>> orders = [
    {
      "earning": 85,
      "shop": "Machli Bazar - Sector 4",
      "pickup": "Fish Market",
      "drop": "Gomti Nagar",
      "address": "Shop 12, Fish Market, Gomti Nagar",
    },
    {
      "earning": 70,
      "shop": "Fresh Fish Point",
      "pickup": "Alambagh",
      "drop": "Charbagh",
      "address": "Shop 5, Alambagh, Lucknow",
    },
    {
      "earning": 95,
      "shop": "Sea Food Hub",
      "pickup": "Indira Nagar",
      "drop": "Hazratganj",
      "address": "Shop 9, Indira Nagar, Lucknow",
    },
  ];

  void toggleOnline() {
    isOnline.value = !isOnline.value;
    if (!isOnline.value) {
      currentOrderIndex.value = 0;
    }
  }

  void ignoreOrder(VoidCallback showNextOrder) {
    Future.delayed(const Duration(seconds: 3), () {
      if (!isOnline.value) return;

      currentOrderIndex.value = (currentOrderIndex.value + 1) % orders.length;

      if (currentOrderIndex.value < orders.length) {
        showNextOrder(); // Next order show
      } else {
        currentOrderIndex.value = 0;
        isOnline.value = true; 
      }
    });
  }
}
