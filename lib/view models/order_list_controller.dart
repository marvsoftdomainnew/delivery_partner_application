import 'package:get/get.dart';

class OrdersController extends GetxController {
  RxInt tabIndex = 0.obs;

  RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[
    {
      "earning": 85,
      "shop": "Machli Bazar - Sector 4",
      "pickup": "Fish Market",
      "customer_phone": "919454310605",
      "drop": "Gomti Nagar",
      "address": "Shop 12, Fish Market, Gomti Nagar",
      "status": "accepted",
    },
    {
      "earning": 70,
      "shop": "Fresh Fish Point",
      "pickup": "Alambagh",
      "customer_phone": "91120304050",

      "drop": "Charbagh",
      "address": "Shop 5, Alambagh, Lucknow",
      "status": "pending",
    },
    {
      "earning": 95,
      "shop": "Sea Food Hub",
      "pickup": "Indira Nagar",
      "customer_phone": "91120304050",

      "drop": "Hazratganj",
      "address": "Shop 9, Indira Nagar, Lucknow",
      "status": "completed",
    },
    {
      "earning": 95,
      "shop": "Sea Food Hub",
      "pickup": "Indira Nagar",
      "customer_phone": "91120304050",

      "drop": "Hazratganj",
      "address": "Shop 9, Indira Nagar, Lucknow",
      "status": "cancelled",
    },
  ].obs;

  List<Map<String, dynamic>> get filteredOrders {
    orders.toList();

    switch (tabIndex.value) {
      case 0:
        return orders
            .where((o) => o['status'] == 'accepted' || o['status'] == 'pending')
            .toList();
      case 1:
        return orders.where((o) => o['status'] == 'completed').toList();
      case 2:
        return orders.where((o) => o['status'] == 'cancelled').toList();
      default:
        return [];
    }
  }
}
