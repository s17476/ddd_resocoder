// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../sign_in/sign_in_page.dart' as _i2;
import '../splash/spalash_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    SpalshRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SpalshPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignInPage(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          SpalshRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          SignInRoute.name,
          path: '/sign-in-page',
        ),
      ];
}

/// generated route for
/// [_i1.SpalshPage]
class SpalshRoute extends _i3.PageRouteInfo<void> {
  const SpalshRoute()
      : super(
          SpalshRoute.name,
          path: '/',
        );

  static const String name = 'SpalshRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i3.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in-page',
        );

  static const String name = 'SignInRoute';
}
