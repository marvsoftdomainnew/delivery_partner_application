import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../view models/dashboard_controller.dart';
import '../home/home_screen.dart';
import '../orders/order_list_screen.dart';
import '../profile/profile_screen.dart';

class NeonSpotlightNav extends StatelessWidget {
  NeonSpotlightNav({super.key});

  final DashboardController controller = Get.put(DashboardController());
  final List<Widget> pages = [HomeScreen(), OrderListScreen(), DeliveryPartnerProfile()];

  final List<IconData> icons = const [
    Icons.home_outlined,
    Icons.list_alt_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    final double navWidth = MediaQuery.of(context).size.width;
    final double itemWidth = navWidth / icons.length;
    return Obx(() {
      final index = controller.selectedIndex.value;

      return Scaffold(
        body: IndexedStack(index: index, children: pages),

        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: Container(
            height: 9.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.black38,
                  offset: Offset(0, 15),
                ),
              ],
            ),
            child: Stack(
              children: [
                /// 🔦 TOP NEON INDICATOR
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  top: 0,
                  left: (index * itemWidth) + (itemWidth / 2) - 20,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
          
                /// 🔥 LIGHT BEAM (PERFECT CENTERED)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  top: 4, // indicator ke thoda neeche
                  left: (index * itemWidth) + (itemWidth / 2) - 35,
                  child: CustomPaint(
                    size: const Size(70, 80),
                    painter: _LightBeamPainter(AppColors.primary),
                  ),
                ),
          
                /// ICONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    icons.length,
                    (i) => GestureDetector(
                      onTap: () => controller.changeTab(i),
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Icon(
                          icons[i],
                          size: 28,
                          color: index == i
                              ? AppColors.primary
                              : AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

/// 🎨 LIGHT BEAM PAINTER
class _LightBeamPainter extends CustomPainter {
  final Color color;
  _LightBeamPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(.35),
          color.withOpacity(.15),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path()
      ..moveTo(size.width * 0.35, 0)
      ..lineTo(size.width * 0.65, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
