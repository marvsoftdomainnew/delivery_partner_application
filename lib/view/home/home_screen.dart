import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../view models/home_controller.dart';
import 'widgets/finding_orders_widget.dart';
import 'widgets/order_request_bottomsheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showOrderBottomSheet(BuildContext context) {
    final controller = Get.find<HomeController>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => OrderRequestBottomsheet(
        order: controller.orders[controller.currentOrderIndex.value],
        onIgnore: () {
          Get.back();
          controller.ignoreOrder(() {
            _showOrderBottomSheet(context);
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
    final controller = Get.put(HomeController());
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: padding.top,
          bottom: padding.bottom,
        ),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildHeader(),
            SizedBox(height: 3.h),
            _buildStatsCards(),
            const Spacer(),
            Obx(
              () => controller.isOnline.value
                  ? const FindingOrdersWidget()
                  : _buildOfflineState(),
            ),
            const Spacer(),
            _buildActionButton(context, controller),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Profile Avatar with Gradient Border
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey.shade100,
              child: Icon(Icons.person, color: AppColors.primary, size: 28),
            ),
          ),
        ),
        SizedBox(width: 12),

        // User Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, There!",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xffE7F8EE), const Color(0xffF0FDF4)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Verified",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xff059669),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Notification Icon
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.notificationScreen),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.alertRed,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "TODAY'S EARNINGS",
            value: "₹450.00",
            icon: Icons.account_balance_wallet_rounded,
            gradientColors: [const Color(0xff1E293B), const Color(0xff334155)],
            isLight: false,
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: _buildStatCard(
            title: "ORDERS DONE",
            value: "5",
            icon: Icons.shopping_bag_rounded,
            gradientColors: [Colors.white, Colors.grey.shade50],
            isLight: true,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required List<Color> gradientColors,
    required bool isLight,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isLight
                ? Colors.black.withOpacity(0.04)
                : Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: isLight
                      ? const Color(0xff64748B)
                      : Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isLight
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 16.sp,
                  color: isLight ? AppColors.primary : Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              color: isLight ? const Color(0xff1E293B) : Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineState() {
    return Column(
      children: [
        Lottie.asset(
          'assets/lottie/No connection.json',
          width: 24.h,
          height: 24.h,
          repeat: true,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 2.h),
        Text(
          "You are Offline",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          "Go online to start receiving fish delivery\norders near you.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: AppColors.darkGrey,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, HomeController controller) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.toggleOnline();
          if (controller.isOnline.value) {
            Future.delayed(const Duration(milliseconds: 300), () {
              _showOrderBottomSheet(context);
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: 6.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: controller.isOnline.value
                  ? [AppColors.alertRed, AppColors.alertRed.withOpacity(0.8)]
                  : [AppColors.primary, AppColors.primary.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color:
                    (controller.isOnline.value
                            ? AppColors.alertRed
                            : AppColors.primary)
                        .withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              controller.isOnline.value ? "GO OFFLINE" : "GO ONLINE",
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
