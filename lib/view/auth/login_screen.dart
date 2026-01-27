// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import '../../constants/app_colors.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [

//           SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 4.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 0.8.h),

//                   // Logo
//                   Center(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.asset(
//                         'assets/images/applogo.png',
//                         width: 80,
//                         height: 80,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),

//                   SizedBox(height: screenHeight * 0.045),

//                   Text(
//                     'Login with your mobile number',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.045,
//                       color: AppColors.black,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),

//                   SizedBox(height: screenHeight * 0.04),

//                   Container(
//                     height: screenHeight * 0.065,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.black.withOpacity(0.2),
//                           blurRadius: 6,
//                           spreadRadius: 0.5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: screenWidth * 0.04,
//                           ),
//                           child: Text(
//                             '+91',
//                             style: TextStyle(
//                               fontSize: screenWidth * 0.043,
//                               color: AppColors.black,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: 1,
//                           height: screenHeight * 0.03,
//                           color: AppColors.hintTextGrey,
//                         ),
//                         Expanded(
//                           child: TextField(
//                             keyboardType: TextInputType.phone,
//                             maxLength: 10,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             decoration: InputDecoration(
//                               counterText: "",
//                               hintText: 'Enter Mobile Number',
//                               hintStyle: TextStyle(
//                                 color: AppColors.hintTextGrey,
//                                 fontSize: screenWidth * 0.043,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.symmetric(
//                                 horizontal: screenWidth * 0.04,
//                                 vertical: screenHeight * 0.015,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: screenHeight * 0.025),

//                  Container(
//                       height: screenHeight * 0.065,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.black.withOpacity(0.2),
//                             blurRadius: 6,
//                             spreadRadius: 0.5,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.lock_outline,
//                             color: Colors.grey,
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                                   Icons.visibility,
//                               color: AppColors.hintTextGrey,
//                             ),
//                             onPressed: () {},
//                           ),
//                           hintText: 'Enter Password',
//                           hintStyle: TextStyle(
//                             color: AppColors.hintTextGrey,
//                             fontSize: screenWidth * 0.043,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: screenWidth * 0.04,
//                             vertical: screenHeight * 0.015,
//                           ),
//                         ),
//                       ),
//                     ),

//                   SizedBox(height: 6.h),
//                  Container(
//                       width: double.infinity,
//                       height: screenHeight * 0.065,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.grey.withOpacity(0.5),
//                             blurRadius: 3,
//                             spreadRadius: 1,
//                             offset: const Offset(0, 1),
//                           ),
//                         ],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primary,
//                             // : AppColors.alertRed,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: Text(
//                             'Login',
//                             style: TextStyle(
//                               color: AppColors.white,
//                               fontSize: screenWidth * 0.042,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                   SizedBox(height: screenHeight * 0.015),
//                   Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         // Get.toNamed(AppRoutes.signup);
//                       },
//                       child: RichText(
//                         text: TextSpan(
//                           style: GoogleFonts.poppins(
//                             fontSize: screenWidth * 0.035,
//                             color: AppColors.darkGrey,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           children: [
//                             TextSpan(text: "Don't have an account? "),
//                             TextSpan(
//                               text: "Sign Up",
//                               style: GoogleFonts.poppins(
//                                 fontSize: screenWidth * 0.038,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.primary,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.015),
//                    Spacer(),
//                   Center(
//                     child: RichText(
//                       textAlign: TextAlign.center,
//                       text: TextSpan(
//                         style: GoogleFonts.poppins(
//                           fontSize: screenWidth * 0.028,
//                           color: AppColors.darkGrey,
//                           height: 1,
//                         ),
//                         children: [
//                            TextSpan(
//                             text: 'By continuing, you accept our ',
//                           ),
//                           TextSpan(
//                             text: 'Terms & Conditions',
//                             style: GoogleFonts.poppins(
//                               fontSize: screenWidth * 0.030,
//                               color: AppColors.black,
//                               fontWeight: FontWeight.w600,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {

  bool _obscurePassword = true;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // _fadeController.dispose();
    // _slideController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),

                  // Logo with elevated card
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1976D2).withOpacity(0.15),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/applogo.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 1.h),

                  Text(
                    'Login to continue your journey',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Phone number input
                  _buildInputLabel('Mobile Number'),
                  SizedBox(height: 1.h),
                  _buildPhoneInputField(screenWidth, screenHeight),

                  SizedBox(height: 2.5.h),

                  // Password input
                  _buildInputLabel('Password'),
                  SizedBox(height: 1.h),
                  _buildPasswordInputField(screenWidth, screenHeight),

                  SizedBox(height: 1.5.h),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Login button
                  _buildLoginButton(screenHeight, screenWidth),

                  SizedBox(height: 4.h),

                  // Sign up prompt
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to signup
                      },
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkGrey,
                              ),
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 15.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPhoneInputField(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.065,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 0.5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Text(
              '+91',
              style: TextStyle(
                fontSize: screenWidth * 0.043,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 1,
            height: screenHeight * 0.03,
            color: AppColors.hintTextGrey,
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],

              decoration: InputDecoration(
                counterText: "",
                hintText: 'Enter Mobile Number',
                hintStyle: TextStyle(
                  color: AppColors.hintTextGrey,
                  fontSize: screenWidth * 0.043,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordInputField(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.065,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 0.5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.hintTextGrey,
              size: 22,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          hintText: 'Enter Password',
          hintStyle: TextStyle(
            color: AppColors.hintTextGrey,
            fontSize: screenWidth * 0.043,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.015,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(double screenHeight, double screenWidth) {
    return Container(
      width: double.infinity,
      height: 6.5.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.offAllNamed(AppRoutes.dashBoard);
          },
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}







// return Container(
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(16),
    //     border: Border.all(
    //       color: AppColors.primary.withOpacity(0.1),
    //       width: 1.5,
    //     ),
    //     boxShadow: [
    //       BoxShadow(
    //         color: AppColors.primary.withOpacity(0.08),
    //         blurRadius: 12,
    //         spreadRadius: 0,
    //         offset: const Offset(0, 4),
    //       ),
    //     ],
    //   ),
    //   child: TextField(
    //     controller: _passwordController,
    //     obscureText: _obscurePassword,
    //     style: GoogleFonts.poppins(
    //       fontSize: 14.sp,
    //       color: AppColors.black,
    //       fontWeight: FontWeight.w600,
    //     ),
    //     decoration: InputDecoration(
    //       prefixIcon: Icon(
    //         Icons.lock_outline_rounded,
    //         color: AppColors.darkGrey,
    //         size: 22,
    //       ),
    //       suffixIcon: IconButton(
    //         icon: Icon(
    //           _obscurePassword
    //               ? Icons.visibility_off_outlined
    //               : Icons.visibility_outlined,
    //           color: AppColors.hintTextGrey,
    //           size: 22,
    //         ),
    //         onPressed: () {
    //           setState(() {
    //             _obscurePassword = !_obscurePassword;
    //           });
    //         },
    //       ),
    //       hintText: 'Enter Password',
    //       hintStyle: GoogleFonts.poppins(
    //         color: AppColors.hintTextGrey,
    //         fontSize: 14.sp,
    //         fontWeight: FontWeight.w500,
    //       ),
    //       border: InputBorder.none,
    //       contentPadding: EdgeInsets.symmetric(
    //         horizontal: 4.w,
    //         vertical: 1.8.h,
    //       ),
    //     ),
    //   ),
    // );

    
  // @override
  // void initState() {
  //   super.initState();

  //   _fadeController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 800),
  //   );

  //   _slideController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 900),
  //   );

  //   _fadeAnimation = Tween<double>(
  //     begin: 0.0,
  //     end: 1.0,
  //   ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

  //   _slideAnimation =
  //       Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
  //         CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
  //       );

  //   _fadeController.forward();
  //   _slideController.forward();
  // }