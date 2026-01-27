
enum OrderStatus { pending, accepted, delivered }
class OrderModel {
  final String shop;
  final String pickup;
  final String drop;
  final int earning;
  final String address;
  OrderStatus status;

  OrderModel({
    required this.shop,
    required this.pickup,
    required this.drop,
    required this.earning,
    required this.address,
    this.status = OrderStatus.pending,
  });

  Map<String, dynamic> toMap() {
    return {
      "shop": shop,
      "pickup": pickup,
      "drop": drop,
      "earning": earning,
      "address": address,
      "status": status.toString(),
    };
  }
}
