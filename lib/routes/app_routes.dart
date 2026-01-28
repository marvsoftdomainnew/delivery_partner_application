import 'package:get/get.dart';
import '../view/auth/login_screen.dart';
import '../view/dashboard/bottom_nav.dart';
import '../view/notifications_screen.dart';
import '../view/orders/active_orders_screen.dart';
import '../view/orders/order_list_screen.dart';
import '../view/profile/menu pages/bank_details_screen.dart';
import '../view/profile/menu pages/earning_report_screen.dart';
import '../view/splash_and_onboarding/splash_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const dashBoard = '/dashBoard';
  static const activeorders = '/activeOrders';
  static const orderHistory = '/orderHistory';
  static const earningReport = '/earningReport';
  static const bankDetails = '/bankDetails';
  static const notificationScreen = '/notificationScreen';

  static const _defaultTransition = Transition.cupertino;
  // static const _transitionDuration = Duration(milliseconds: 500);

  static GetPage _buildPage({
    required String name,
    required GetPageBuilder page,
  }) {
    return GetPage(
      name: name,
      page: page,
      transition: _defaultTransition,
      // transitionDuration: _transitionDuration,
    );
  }

  static List<GetPage> getRoutes() {
    return [
      _buildPage(name: splash, page: () => SplashScreen()),
      _buildPage(name: login, page: () => LoginScreen()),
      _buildPage(name: dashBoard, page: () => NeonSpotlightNav()),
      _buildPage(name: activeorders, page: () => ActiveOrderScreen()),
      _buildPage(name: orderHistory, page: () => OrderListScreen()),
      _buildPage(name: earningReport, page: () => EarningsReportScreen()),
      _buildPage(name: bankDetails, page: () => BankDetailsScreen()),
      _buildPage(name: notificationScreen, page: () => NotificationsScreen()),
    ];
  }
}
