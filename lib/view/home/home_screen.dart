import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../view models/home_controller.dart';
import 'widgets/order_request_bottomsheet.dart';
import 'widgets/finding_orders_widget.dart'; // jo order card banaya tha

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  void showOrderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => OrderRequestBottomsheet(
        order: controller.orders[controller.currentOrderIndex.value],
        onIgnore: () {
          Get.back(); // close sheet
          controller.ignoreOrder(() {
            showOrderBottomSheet(context);
          });
        },
        onAccept: () {
          Get.back();
          Get.toNamed(
            AppRoutes.activeorders,
            arguments: controller.orders[controller.currentOrderIndex.value],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.person),
                  ),
                  SizedBox(width: 3.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Amit",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F8EE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.circle, size: 8, color: Colors.green),
                            SizedBox(width: 4),
                            Text(
                              "Verified",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_none),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              /// 💳 STATS (same)
              Row(
                children: [
                  Expanded(
                    child: _stat(
                      title: "TODAY'S EARNINGS",
                      value: "₹450.00",
                      dark: true,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: _stat(title: "ORDERS DONE", value: "5", dark: false),
                  ),
                ],
              ),

              const Spacer(),

              /// 🔁 ONLINE / OFFLINE STATE
              Obx(() {
                return controller.isOnline.value
                    ? FindingOrdersWidget()
                    : _offlineState();
              }),

              const Spacer(),

              /// 🟢 BUTTON
              Obx(
                () => ElevatedButton(
                  onPressed: () {
                    controller.toggleOnline();

                    if (controller.isOnline.value) {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        showOrderBottomSheet(context);
                      });
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isOnline.value  
                        ? AppColors.alertRed    
                        : AppColors.primary,
                    minimumSize: Size(double.infinity, 6.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    controller.isOnline.value ? "GO OFFLINE" : "GO ONLINE",
                    style: GoogleFonts.nunito(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔴 OFFLINE UI
  Widget _offlineState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _statusIcon(),
        SizedBox(height: 3.h),
        const Text(
          "You are Offline",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 1.h),
        const Text(
          "Go online to start receiving fish delivery\norders near you.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: AppColors.darkGrey),
        ),
      ],
    );
  } 

  Widget _statusIcon() {
    return Center(
      child: Lottie.asset(
        'assets/lottie/No connection.json',
        width: 24.h,
        height: 24.h,
        repeat: true,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _stat({
    required String title,
    required String value,
    required bool dark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: dark ? Colors.white54 : Colors.blue,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: dark ? Colors.white : Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
