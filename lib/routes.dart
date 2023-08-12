import 'package:get/get.dart';
import 'package:weu/screens/main_screen.dart';

appRoutes() => [
      GetPage(
        name: '/mainScreen',
        page: () => const MainScreen(),
        transition: Transition.leftToRightWithFade,
        // transitionDuration: Duration(milliseconds: 500),
      ),
      // GetPage(
      //   name: '/emergency',
      //   page: () => EmergencyScreen(),
      //   middlewares: [MyMiddelware()],
      //   transition: Transition.leftToRightWithFade,
      //   transitionDuration: Duration(milliseconds: 500),
      // ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    // print(page?.name);
    return super.onPageCalled(page);
  }
}
