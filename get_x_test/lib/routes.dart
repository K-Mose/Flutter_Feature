import 'package:get/get.dart';
import 'package:get_x_test/screens/screens.dart';

class Routes {
  static final routes = [
    GetPage(
      name: PageA.routeName,
      page: () => const PageA(),
      children: [
        GetPage(
            name: PageAA.routeName,
            page: () => const PageAA(),
            children: [
              GetPage(
                  name: PageAAA.routeName,
                  page: () => const PageAAA(),
              ),
            ]
        ),
      ]
    ),
    GetPage(
        name: PageB.routeName,
        page: () => const PageB(),
    ),
    GetPage(
        name: PageC.routeName,
        page: () => const PageC(),
    ),
  ];
}