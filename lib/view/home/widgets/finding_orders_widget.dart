import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';

class FindingOrdersWidget extends StatefulWidget {
  const FindingOrdersWidget({super.key});

  @override
  State<FindingOrdersWidget> createState() => _FindingOrdersWidgetState();
}

class _FindingOrdersWidgetState extends State<FindingOrdersWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int _dotCount = 1;
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _startDotsAnimation();
  }

  void _startDotsAnimation() {
    Future.doWhile(() async {
      if (!_isMounted) return false;

      await Future.delayed(const Duration(milliseconds: 500));
      
      if (!mounted) {
        _isMounted = false;
        return false;
      }

      setState(() {
        _dotCount = (_dotCount % 3) + 1;
      });
      
      return true;
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAnimatedSearchIcon(),
        SizedBox(height: 3.h),
        _buildLoadingText(),
        SizedBox(height: 1.5.h),
        // _buildSubtitle(),
        SizedBox(height: 3.h),
        // _buildPulsingIndicators(),
      ],
    );
  }

  Widget _buildAnimatedSearchIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: 36.h * (0.9 + (_pulseController.value * 0.1)),
              height: 36.h * (0.9 + (_pulseController.value * 0.1)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1 * _pulseController.value),
                    AppColors.primary.withOpacity(0.02 * _pulseController.value),
                    Colors.transparent,
                  ],
                ),
              ),
            );
          },
        ),
        Lottie.asset(
          'assets/lottie/Searching Animation.json',
          width: 32.h,
          height: 32.h,
          repeat: true,
          fit: BoxFit.contain,
          frameRate: FrameRate(24),
        ),

        // Center Package Icon
        Padding(
          padding: EdgeInsets.only(bottom: 1.8.h),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Lottie.asset(
              'assets/lottie/Order packed.json',
              width: 14.h,
              height: 14.h,
              repeat: true,
              fit: BoxFit.contain,
              frameRate: FrameRate(24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            "Finding Orders",
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              "." * _dotCount,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildSubtitle() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         width: 6,
  //         height: 6,
  //         decoration: BoxDecoration(
  //           color: AppColors.primary,
  //           shape: BoxShape.circle,
  //         ),
  //       ),
  //       SizedBox(width: 8),
  //       Text(
  //         "Scanning nearby fish markets",
  //         style: GoogleFonts.poppins(
  //           fontSize: 13.sp,
  //           fontWeight: FontWeight.w500,
  //           color: AppColors.darkGrey,
  //           letterSpacing: 0.2,
  //         ),
  //       ),
  //       SizedBox(width: 8),
  //       Container(
  //         width: 6,
  //         height: 6,
  //         decoration: BoxDecoration(
  //           color: AppColors.primary,
  //           shape: BoxShape.circle,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildPulsingIndicators() {
  //   return AnimatedBuilder(
  //     animation: _pulseController,
  //     builder: (context, child) {
  //       return Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: List.generate(3, (index) {
  //           final delay = index * 0.3;
  //           final animValue = (_pulseController.value + delay) % 1.0;
            
  //           return Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 4),
  //             child: Container(
  //               width: 8 + (animValue * 4),
  //               height: 8 + (animValue * 4),
  //               decoration: BoxDecoration(
  //                 color: AppColors.primary.withOpacity(1 - animValue * 0.5),
  //                 shape: BoxShape.circle,
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: AppColors.primary.withOpacity(0.3),
  //                     blurRadius: 8 * animValue,
  //                     spreadRadius: 2 * animValue,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         }),
  //       );
  //     },
  //   );
  // }
}