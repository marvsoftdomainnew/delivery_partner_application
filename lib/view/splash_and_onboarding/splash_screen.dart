import 'dart:ui';
import 'package:fish_delivery_partner_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _logoScale = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutExpo),
    );

    _logoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _logoController.forward();
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textController.forward();
      }
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bgimages/splashbg.png', fit: BoxFit.cover),

          Container(color: Colors.white.withOpacity(0.35)),

          // Positioned.fill(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 1, sigmaY: 0),
          //     child: Container(color: Colors.transparent),
          //   ),
          // ),
          Transform.translate(
            offset: Offset(0, 8.h), // 👈 yahan value adjust karo
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/splashlogo.png',
                        width: 16.h,
                        height: 16.h,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                SlideTransition(
                  position: _textSlide,
                  child: FadeTransition(
                    opacity: _textController,
                    child: Column(
                      children: [
                        Text(
                          "Fish Delivery Partner".toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Fresh • Fast • Reliable",
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



















                  // SizedBox(height: 5.h),

                  // // App name with fade animation
                  // FadeTransition(
                  //   opacity: _fadeAnimation,
                  //   child: Text(
                  //     'Fish Delivery',
                  //     style: TextStyle(
                  //       fontSize: 32.sp,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //       letterSpacing: 1.5,
                  //       shadows: [
                  //         Shadow(
                  //           color: Colors.black.withOpacity(0.3),
                  //           offset: const Offset(0, 2),
                  //           blurRadius: 4,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // SizedBox(height: 1.5.h),

                  // // Tagline with slide animation
                  // SlideTransition(
                  //   position: _slideAnimation,
                  //   child: FadeTransition(
                  //     opacity: _fadeAnimation,
                  //     child: Text(
                  //       'Partner App',
                  //       style: TextStyle(
                  //         fontSize: 16.sp,
                  //         fontWeight: FontWeight.w400,
                  //         color: Colors.white.withOpacity(0.9),
                  //         letterSpacing: 2,
                  //       ),
                  //     ),
                  //   ),
                  // ),