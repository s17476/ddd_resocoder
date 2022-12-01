import 'package:auto_route/annotations.dart';
import 'package:ddd_resocoder/presentation/sign_in/sign_in_page.dart';
import 'package:ddd_resocoder/presentation/splash/spalash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SpalshPage, initial: true),
    AutoRoute(page: SignInPage),
  ],
)
class $AppRouter {}
