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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../notes/notes_overview/notes_overview_page.dart' as _i3;
import '../sign_in/sign_in_page.dart' as _i2;
import '../splash/spalash_page.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SpalshRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SpalshPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignInPage(),
      );
    },
    NotesOverviewRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.NotesOverviewPage(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          SpalshRoute.name,
          path: '/',
        ),
        _i4.RouteConfig(
          SignInRoute.name,
          path: '/sign-in-page',
        ),
        _i4.RouteConfig(
          NotesOverviewRoute.name,
          path: '/notes-overview-page',
        ),
      ];
}

/// generated route for
/// [_i1.SpalshPage]
class SpalshRoute extends _i4.PageRouteInfo<void> {
  const SpalshRoute()
      : super(
          SpalshRoute.name,
          path: '/',
        );

  static const String name = 'SpalshRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i4.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in-page',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.NotesOverviewPage]
class NotesOverviewRoute extends _i4.PageRouteInfo<void> {
  const NotesOverviewRoute()
      : super(
          NotesOverviewRoute.name,
          path: '/notes-overview-page',
        );

  static const String name = 'NotesOverviewRoute';
}
