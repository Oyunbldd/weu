import 'package:get/get.dart';
import 'package:weu/screens/login_screen.dart';
import 'package:weu/screens/main_screen.dart';
import 'package:weu/screens/emergency_screen.dart';
import 'package:weu/screens/otp_screen.dart';
import 'package:weu/screens/permission_screen.dart';
import 'package:weu/screens/required_screen.dart';
import 'package:weu/screens/splash_screen.dart';

appRoutes() => [
      GetPage(
        name: '/mainScreen',
        page: () => const MainScreen(),
        transition: Transition.rightToLeft,
        // transitionDuration: const Duration(milliseconds: 800),
      ),
      GetPage(
        name: '/emergencyScreen',
        page: () => const EmergencyScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/splashScreen',
        page: () => const SplashScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.rightToLeft,
        // transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/permissionScreen',
        page: () => const PermissionScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/loginScreen',
        page: () => const LoginScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.native,
        // transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/otpScreen',
        page: () => const OtpScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.native,
        // transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/requiredScreen',
        page: () => const RequiredScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.native,
        // transitionDuration: const Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    // print(page?.name);
    return super.onPageCalled(page);
  }
}
