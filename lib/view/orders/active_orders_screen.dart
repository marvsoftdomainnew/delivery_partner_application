import 'package:fish_delivery_partner_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class ActiveOrderScreen extends StatefulWidget {
  const ActiveOrderScreen({super.key});

  @override
  State<ActiveOrderScreen> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> order;
  int currentStep = 0;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    order = Get.arguments as Map<String, dynamic>;
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMapCard(),
            SizedBox(height: 2.h),
            _buildOrderDetails(),
            SizedBox(height: 2.h),
            // _buildTrackingTimeline(),
            // SizedBox(height: 10.h), // extra space for bottom button
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xff1E40AF),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      centerTitle: true,
      title: Text(
        'Order in Progress',
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMapCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      height: 20.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [AppColors.primary, const Color(0xff2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Positioned.fill(
          //   child: Icon(
          //     Icons.route_outlined,
          //     size: 80,
          //     color: Colors.white.withOpacity(0.1),
          //   ),
          // ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delivery_dining,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Live Tracking',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Details',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff1E293B),
            ),
          ),
          SizedBox(height: 2.h),
          _buildDetailRow(
            Icons.store_outlined,
            'Shop',
            order['shop'],
            const Color(0xffF59E0B),
          ),
          _buildDetailRow(
            Icons.location_on_outlined,
            'Pickup',
            order['pickup'],
            const Color(0xff3B82F6),
          ),
          _buildDetailRow(
            Icons.flag_outlined,
            'Drop',
            order['drop'],
            const Color(0xffEF4444),
          ),
          SizedBox(height: 1.5.h),
          Divider(color: Colors.grey.shade200, thickness: 1),
          SizedBox(height: 1.5.h),
          _buildEarningCard(),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xff64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.3.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xff0F172A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningCard() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff10B981).withOpacity(0.1),
            const Color(0xff059669).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xff10B981).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: const Color(0xff10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                'Your Earning',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xff047857),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            '₹${order['earning']}',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              color: const Color(0xff047857),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildTrackingTimeline() {
  //   final steps = [
  //     {'label': 'Reached Shop', 'icon': Icons.store},
  //     {'label': 'Picked Up', 'icon': Icons.shopping_bag},
  //     {'label': 'Delivered', 'icon': Icons.check_circle},
  //   ];

  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 4.w),
  //     padding: EdgeInsets.all(5.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.04),
  //           blurRadius: 20,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Order Status',
  //           style: GoogleFonts.inter(
  //             fontSize: 16.sp,
  //             fontWeight: FontWeight.w700,
  //             color: const Color(0xff1E293B),
  //           ),
  //         ),
  //         SizedBox(height: 2.h),
  //         ...List.generate(steps.length, (index) {
  //           final isActive = index <= currentStep;
  //           final isCompleted = index < currentStep;
  //           return _buildTimelineStep(
  //             steps[index]['label'] as String,
  //             steps[index]['icon'] as IconData,
  //             isActive,
  //             isCompleted,
  //             index != steps.length - 1,
  //           );
  //         }),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildTimelineStep(
  //   String label,
  //   IconData icon,
  //   bool isActive,
  //   bool isCompleted,
  //   bool showLine,
  // ) {
  //   return Row(
  //     children: [
  //       Column(
  //         children: [
  //           AnimatedContainer(
  //             duration: const Duration(milliseconds: 300),
  //             height: 44,
  //             width: 44,
  //             decoration: BoxDecoration(
  //               color: isActive
  //                   ? const Color(0xff2563EB)
  //                   : const Color(0xffE2E8F0),
  //               shape: BoxShape.circle,
  //               boxShadow: isActive
  //                   ? [
  //                       BoxShadow(
  //                         color: const Color(0xff2563EB).withOpacity(0.3),
  //                         blurRadius: 12,
  //                         offset: const Offset(0, 4),
  //                       ),
  //                     ]
  //                   : [],
  //             ),
  //             child: Icon(
  //               isCompleted ? Icons.check : icon,
  //               color: isActive ? Colors.white : const Color(0xff94A3B8),
  //               size: 22,
  //             ),
  //           ),
  //           if (showLine)
  //             Container(
  //               height: 5.h,
  //               width: 2,
  //               margin: EdgeInsets.symmetric(vertical: 0.5.h),
  //               decoration: BoxDecoration(
  //                 gradient: LinearGradient(
  //                   begin: Alignment.topCenter,
  //                   end: Alignment.bottomCenter,
  //                   colors: isActive
  //                       ? [
  //                           const Color(0xff2563EB),
  //                           const Color(0xff2563EB).withOpacity(0.3),
  //                         ]
  //                       : [const Color(0xffE2E8F0), const Color(0xffE2E8F0)],
  //                 ),
  //               ),
  //             ),
  //         ],
  //       ),
  //       SizedBox(width: 4.w),
  //       Expanded(
  //         child: Text(
  //           label,
  //           style: GoogleFonts.inter(
  //             fontSize: 15.sp,
  //             fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
  //             color: isActive
  //                 ? const Color(0xff0F172A)
  //                 : const Color(0xff94A3B8),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }




  Widget _buildActionButton() {
    final padding = MediaQuery.of(context).padding;
    final labels = ['Mark Reached', 'Mark Picked Up', 'Complete Delivery'];

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: padding.bottom),
        child: ElevatedButton(
          onPressed: () {
            if (currentStep < 2) {
              setState(() => currentStep++);
              _animController.forward(from: 0);
            } else {
              Get.back();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                labels[currentStep],
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 2.w),
              const Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
