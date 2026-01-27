import 'package:fish_delivery_partner_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _scaleAnimation;
  // late Animation<double> _logoFadeAnimation;
  // late Animation<double> _textFadeAnimation;
  // late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoController.forward();
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textController.forward();
      }
    });

    Future.delayed(const Duration(seconds: 5), () {
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0D47A1), // Deep blue
              const Color(0xFF1976D2), // Medium blue
              const Color(0xFF42A5F5), // Light blue
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background circles
            Positioned(
              top: -10.h,
              right: -10.w,
              child: Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -15.h,
              left: -15.w,
              child: Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with scale animation
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/images/splashlogo.png',
                          width: 15.h,
                          height: 15.h,
                        ),
                      ),
                    ),
                  ),

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
