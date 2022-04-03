import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:producthunt/view/home/home_page.dart';
import 'package:producthunt/view/product_details/product_details_page.dart';
import 'package:producthunt/view/spalsh/splash.dart';

class Routes {
  Routes._();

  static List<GetPage> get() {
    final moduleRoutes = <GetPage>[
      GetPage(
        name: SplashPage.routeName,
        page: () => SplashPage(),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: HomePage.routeName,
        page: () => HomePage(),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: ProductDetailsPage.routeName,
        page: () => ProductDetailsPage(),
        transition: Transition.fadeIn,
      ),
    ];
    return moduleRoutes;
  }
}