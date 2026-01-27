import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../view models/order_list_controller.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
    final OrdersController orderlistcontroller = Get.put(OrdersController());


@override
void initState() {
  super.initState();

  _tabController = TabController(length: 3, vsync: this);

  _tabController.animation!.addListener(() {
    final newIndex = _tabController.animation!.value.round();

    if (orderlistcontroller.tabIndex.value != newIndex) {
      orderlistcontroller.tabIndex.value = newIndex;
    }
  });
}



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xffF8FAFC),
    appBar: _buildAppBar(),
    body: Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOrderListByStatus(['accepted', 'pending']),
              _buildOrderListByStatus(['completed']),
              _buildOrderListByStatus(['cancelled']),
            ],
          ),
        ),
      ],
    ),
  );
}

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
    
      backgroundColor: const Color(0xff1E40AF),
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'My Orders',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
 
Widget _tabOption(String label, int index) {
  return Obx(() {
    final isSelected = orderlistcontroller.tabIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          orderlistcontroller.tabIndex.value = index;
          _tabController.animateTo(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary, width: 1.6),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  });
}

Widget _buildTabBar() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
    padding: EdgeInsets.all(1.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        _tabOption('Pending', 0),
        SizedBox(width: 2.w),
        _tabOption('Completed', 1),
        SizedBox(width: 2.w),
        _tabOption('Cancelled', 2),
      ],
    ),
  );
}

Widget _buildOrderListByStatus(List<String> statuses) {
  return Obx(() {
    final orders = orderlistcontroller.filteredOrders;

    if (orders.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.all(4.w),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final isActive =
            order['status'] == 'accepted' ||
            order['status'] == 'pending';

        return Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: _buildOrderCard(order, index, isActive: isActive),
        );
      },
    );
  });
}
  Widget _buildOrderCard(Map order, int index, {required bool isActive}) {
    return GestureDetector(
      onTap: isActive
          ? () {
              // orderlistcontroller.orders.value = orderlistcontroller.orders;
              Get.toNamed(AppRoutes.activeorders, arguments: order);
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isActive
                ? const Color(0xff2563EB).withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? const Color(0xff2563EB).withOpacity(0.08)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  _buildOrderIcon(order['status']),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                order['shop'],
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff0F172A),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            _buildStatusBadge(order['status']),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        _buildLocationRow(order),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xffF0F9FF)
                    : const Color(0xffF8FAFC),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 18,
                        color: const Color(0xff10B981),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Earning',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: const Color(0xff64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹${order['earning']}',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff10B981),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildOrderIcon(String status) {
  return Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      gradient: _getOrderGradient(status),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Icon(
      _getOrderIcon(status),
      color: Colors.white,
      size: 28,
    ),
  );
}


  Widget _buildStatusBadge(String status) {
    final statusConfig = _getStatusConfig(status);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: statusConfig['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: statusConfig['color'].withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        statusConfig['label'],
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: statusConfig['color'],
        ),
      ),
    );
  }

IconData _getOrderIcon(String status) {
  switch (status) {
    case 'pending':
      return Icons.hourglass_bottom;
    case 'accepted':
      return Icons.delivery_dining;
    case 'completed':
      return Icons.check_circle;
    case 'cancelled':
      return Icons.cancel;
    default:
      return Icons.inventory_2;
  }
}
LinearGradient _getOrderGradient(String status) {
  switch (status) {
    case 'accepted':
      return const LinearGradient(
        colors: [Color(0xff3B82F6), Color(0xff2563EB)],
      );
      case 'pending':
      return const LinearGradient(
        colors: [Color(0xff3B82F6), Color(0xff2563EB)],
      );
    case 'completed':
      return const LinearGradient(
        colors: [Color(0xff34D399), Color(0xff10B981)],
      );
    case 'cancelled':
      return const LinearGradient(
        colors: [Color(0xffF87171), Color(0xffEF4444)],
      );
    default:
      return LinearGradient(
        colors: [Colors.grey.shade300, Colors.grey.shade400],
      );
  }
}

  Map<String, dynamic> _getStatusConfig(String status) {
    switch (status) {
      case 'pending':
        return {
          'label': 'Pending',
          'color': const Color(0xffF59E0B),
        };
      case 'accepted':
        return {
          'label': 'Active',
          'color': const Color(0xff2563EB),
        };
      case 'completed':
        return {
          'label': 'Completed',
          'color': const Color(0xff10B981),
        };
      default:
        return {
          'label': status.capitalize ?? status,
          'color': const Color(0xff64748B),
        };
    }
  }

  Widget _buildLocationRow(Map order) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 16,
          color: const Color(0xff3B82F6),
        ),
        SizedBox(width: 1.w),
        Expanded(
          child: Text(
            order['pickup'],
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xff64748B),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Icon(
            Icons.arrow_forward,
            size: 16,
            color: const Color(0xff94A3B8),
          ),
        ),
        Icon(
          Icons.flag_outlined,
          size: 16,
          color: const Color(0xffEF4444),
        ),
        SizedBox(width: 1.w),
        Expanded(
          child: Text(
            order['drop'],
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xff64748B),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState({String? message}) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: const Color(0xffF0F9FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              size: 60,
              color: const Color(0xff2563EB),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            message ?? 'No orders yet',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff64748B),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Your orders will appear here',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xff94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}