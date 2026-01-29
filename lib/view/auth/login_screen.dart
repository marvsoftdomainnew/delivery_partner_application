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
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bgimages/loginbg.png', fit: BoxFit.cover),
          Container(color: Colors.white.withOpacity(0.85)),

          Padding(
            padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [                                                 
                SizedBox(height: 6.h),
            
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
                      ),
                    ),
                  ),
                ),
            
                SizedBox(height: 10.h),
            
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
            
                _buildInputLabel('Mobile Number'),
                SizedBox(height: 1.h),
                _buildPhoneInputField(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
            
                SizedBox(height: 2.5.h),
            
                _buildInputLabel('Password'),
                SizedBox(height: 1.h),
                _buildPasswordInputField(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
            
                SizedBox(height: 1.5.h),
                SizedBox(height: 4.h),
                _buildLoginButton(
                  MediaQuery.of(context).size.height,
                  MediaQuery.of(context).size.width,
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ],
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
