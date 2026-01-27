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
  late AnimationController _controller;
  // late Animation<double> _scaleAnimation;

  int _dotCount = 1;

  @override
  void initState() {
    super.initState();

    /// pulse animation (same as before)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // _scaleAnimation = Tween<double>(
    //   begin: 0.8,
    //   end: 1.2,
    // ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    /// dots animation
    _startDotsAnimation();
  }

  void _startDotsAnimation() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return false;

      setState(() {
        _dotCount++;
        if (_dotCount > 4) _dotCount = 1;
      });
      return true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 🔵 PULSE CIRCLE
        Stack(
          alignment: Alignment.center,
          children: [
            // 🔵 Ripple / Scale background
            // ScaleTransition(
            //   scale: _scaleAnimation,
            //   child: Container(
            //     width: 160,
            //     height: 160,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.blue.withOpacity(0.08),
            //     ),
            //   ),
            // ),

            // 🟦 Main circle
            // Container(
            //   width: 24.h,
            //   height: 24.h,
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Color(0xffE3EEFF),
            //   ),
            // ),

            // 🎬 First Lottie (background animation)
            Lottie.asset(
              'assets/lottie/Searching Animation.json',
              width: 34.h,
              height: 34.h,
              repeat: true,
              fit: BoxFit.contain,
              frameRate: FrameRate(24),
            ),

            // ⭐ Second Lottie (exact center)
            Padding(
              padding:  EdgeInsets.only(bottom: 1.8.h),
              child: Lottie.asset(
                'assets/lottie/Order packed.json',
                width: 14.h, // chhota rakho
                height: 14.h,
                repeat: true,
                fit: BoxFit.contain,
                frameRate: FrameRate(24),
              ),
            ),
          ],
        ),

        SizedBox(height: 4.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Finding Orders",
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),

            SizedBox(
              width: 11.w,
              child: Text(
                "." * _dotCount,
                style: GoogleFonts.poppins(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 2.h),

        Text(
          "Scanning nearby fish markets",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class FindingOrdersWidget extends StatefulWidget {
//   const FindingOrdersWidget({super.key});

//   @override
//   State<FindingOrdersWidget> createState() => _FindingOrdersWidgetState();
// }

// class _FindingOrdersWidgetState extends State<FindingOrdersWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   @override
//   void initState() {
//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ScaleTransition(
//           scale: Tween(begin: 0.8, end: 1.2).animate(controller),
//           child: CircleAvatar(
//             radius: 45,
//             backgroundColor: Colors.blue.withOpacity(0.1),
//             child: const Icon(Icons.store, size: 40, color: Colors.blue),
//           ),
//         ),
//         SizedBox(height: 3.h),
//         const Text("Finding Orders...",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         const Text("Scanning nearby fish markets",
//             style: TextStyle(color: Colors.grey)),
//       ],
//     );
//   }
// }
