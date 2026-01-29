import 'package:fish_delivery_partner_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';


class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
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
 void _callCustomer() async {
  try {
    final uri = Uri(scheme: 'tel', path: order['customer_phone']);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    Get.snackbar('Error', 'Unable to make call');
  }
}


void _whatsAppCustomer() async {
  try {
    final uri = Uri.parse(
      'https://wa.me/${order['customer_phone']}?text=${Uri.encodeComponent(
        'Hi, I am your delivery partner for order ${order['order_id']}',
      )}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    Get.snackbar('Error', 'WhatsApp not available');
  }
}


// void _whatsAppCustomer() async {
//   final uri = Uri.parse(
//     'https://wa.me/${order['customer_phone']}?text=${Uri.encodeComponent(
//       'Hi, I am your delivery partner for order ${order['order_id']}',
//     )}',
//   );

//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     Get.snackbar('Error', 'WhatsApp not installed');
//   }
// }


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
          _buildCommunicationRow(),
          SizedBox(height: 2.h),
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
  Widget _buildCommunicationRow() {
  return Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: _callCustomer,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            decoration: BoxDecoration(
              color: const Color(0xff3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.call, color: Color(0xff2563EB), size: 18),
                SizedBox(width: 2.w),
                Text(
                  'Call',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2563EB),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(width: 3.w),
      Expanded(
        child: InkWell(
          onTap: _whatsAppCustomer,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            decoration: BoxDecoration(
              color: const Color(0xff22C55E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chat, color: Color(0xff16A34A), size: 18),
                SizedBox(width: 2.w),
                Text(
                  'Chat',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff16A34A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

}
