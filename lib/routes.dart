import 'package:get/get.dart';
import 'package:weu/screens/main_screen.dart';
import 'package:weu/screens/emergency_screen.dart';

appRoutes() => [
      GetPage(
        name: '/mainScreen',
        page: () => const MainScreen(),
        transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/emergency',
        page: () => const EmergencyScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      // GetPage(
      //   name: '/splash',
      //   page: () => const SplashScreen(),
      //   middlewares: [MyMiddelware()],
      //   transition: Transition.native,
      //   transitionDuration: const Duration(milliseconds: 500),
      // ),
      // GetPage(
      //   name: '/login',
      //   page: () => const LoginScreen(),
      //   middlewares: [MyMiddelware()],
      //   transition: Transition.native,
      //   transitionDuration: const Duration(milliseconds: 500),
      // ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    // print(page?.name);
    return super.onPageCalled(page);
  }
}
