import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import 'widgets/menu_item_data.dart';

class DeliveryPartnerProfile extends StatefulWidget {
  const DeliveryPartnerProfile({super.key});

  @override
  State<DeliveryPartnerProfile> createState() => _DeliveryPartnerProfileState();
}

class _DeliveryPartnerProfileState extends State<DeliveryPartnerProfile>
    with TickerProviderStateMixin {
  bool isOnline = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            "Profile",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF64748B),
            ),
            onPressed: () {},
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: _cardDecoration(),
                    child: Row(
                      children: [
                        _buildAvatar(),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aman Kumar",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "Partner ID: DP102345",
                                style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  color: const Color(0xFF64748B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // SizedBox(height: 1.h),
                              // _buildRatingBadge(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isOnline
                            ? [const Color(0xFF10B981), const Color(0xFF059669)]
                            : [
                                const Color(0xFF6B7280),
                                const Color(0xFF4B5563),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color:
                              (isOnline
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFF6B7280))
                                  .withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isOnline
                                ? Icons.wifi_rounded
                                : Icons.wifi_off_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isOnline ? "You're Online" : "You're Offline",
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                isOnline
                                    ? "Ready to accept orders"
                                    : "Tap to go online",
                                style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isOnline,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.white.withOpacity(0.3),
                          inactiveThumbColor: Colors.white70,
                          inactiveTrackColor: Colors.white.withOpacity(0.2),
                          onChanged: (v) => setState(() => isOnline = v),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Earnings",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Row(
                        children: [
                          Expanded(
                            child: earningCardGlass(
                              amount: "₹2,450",
                              label: "This Week",
                              icon: Icons.calendar_today_rounded,
                              color: const Color(0xFF3B82F6),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: earningCardGlass(
                              amount: "₹540",
                              label: "Today",
                              icon: Icons.access_time_rounded,
                              color: const Color(0xFF8B5CF6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  MenuSection(
                    title: "Work",
                    icon: Icons.work_outline_rounded,
                    items: const [
                      MenuItemData(
                        icon: Icons.receipt_long_rounded,
                        title: "Order History",
                      ),
                      MenuItemData(
                        icon: Icons.two_wheeler_rounded,
                        title: "Vehicle Details",
                      ),
                      MenuItemData(
                        icon: Icons.description_outlined,
                        title: "Documents",
                      ),
                      MenuItemData(
                        icon: Icons.attach_money_rounded,
                        title: "Earnings Report",
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  MenuSection(
                    title: "Account",
                    icon: Icons.person_outline_rounded,
                    items: const [
                      MenuItemData(
                        icon: Icons.edit_outlined,
                        title: "Edit Profile",
                      ),
                      MenuItemData(
                        icon: Icons.account_balance_outlined,
                        title: "Bank Details",
                      ),
                    ],
                  ),
                  // SizedBox(height: 2.h),
                  // const MenuSection(
                  //   title: "Support",
                  //   icon: Icons.support_agent_outlined,
                  //   items: const [
                  //     MenuItemData(
                  //       icon: Icons.help_outline_rounded,
                  //       title: "Help Center",
                  //     ),
                  //     MenuItemData(
                  //       icon: Icons.privacy_tip_outlined,
                  //       title: "Privacy Policy",
                  //     ),
                  //     MenuItemData(
                  //       icon: Icons.info_outline_rounded,
                  //       title: "About",
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 2.h),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon:  Icon(Icons.logout_rounded, size: 6.w),
                    label: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.alertRed,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      minimumSize: Size(double.infinity, 6.h),
                      elevation: 4,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.person_rounded, color: Colors.white, size: 36),
    );
  }

  // Widget _buildRatingBadge() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //         colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
  //       ),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         const Icon(Icons.star_rounded, color: Colors.white, size: 16),
  //         SizedBox(width: 1.w),
  //         Text(
  //           "4.6 Rating",
  //           style: GoogleFonts.poppins(
  //             fontSize: 12.sp,
  //             fontWeight: FontWeight.w600,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
