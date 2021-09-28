// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:built_collection/built_collection.dart' as _i6;
import 'package:flutter/material.dart' as _i5;

import '../pages/draw/page.dart' as _i2;
import '../pages/end/page.dart' as _i3;
import '../pages/name_entry/page.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    NameEntryPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.NameEntryPage());
    },
    DrawPageRoute.name: (routeData) {
      final args = routeData.argsAs<DrawPageRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.DrawPage(
              key: args.key,
              index: args.index,
              names: args.names,
              drawNames: args.drawNames));
    },
    EndPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EndPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(NameEntryPageRoute.name, path: '/'),
        _i4.RouteConfig(DrawPageRoute.name, path: '/draw-page'),
        _i4.RouteConfig(EndPageRoute.name, path: '/end-page')
      ];
}

/// generated route for [_i1.NameEntryPage]
class NameEntryPageRoute extends _i4.PageRouteInfo<void> {
  const NameEntryPageRoute() : super(name, path: '/');

  static const String name = 'NameEntryPageRoute';
}

/// generated route for [_i2.DrawPage]
class DrawPageRoute extends _i4.PageRouteInfo<DrawPageRouteArgs> {
  DrawPageRoute(
      {_i5.Key? key,
      required int index,
      required _i6.BuiltList<String> names,
      required _i6.BuiltList<int> drawNames})
      : super(name,
            path: '/draw-page',
            args: DrawPageRouteArgs(
                key: key, index: index, names: names, drawNames: drawNames));

  static const String name = 'DrawPageRoute';
}

class DrawPageRouteArgs {
  const DrawPageRouteArgs(
      {this.key,
      required this.index,
      required this.names,
      required this.drawNames});

  final _i5.Key? key;

  final int index;

  final _i6.BuiltList<String> names;

  final _i6.BuiltList<int> drawNames;
}

/// generated route for [_i3.EndPage]
class EndPageRoute extends _i4.PageRouteInfo<void> {
  const EndPageRoute() : super(name, path: '/end-page');

  static const String name = 'EndPageRoute';
}
