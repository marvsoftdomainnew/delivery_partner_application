import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const FishPartnerApp());
}

class FishPartnerApp extends StatelessWidget {
  const FishPartnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.getRoutes(),
        );
      },
    );
  }
}
