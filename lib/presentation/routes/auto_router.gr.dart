// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:built_collection/built_collection.dart' as _i7;
import 'package:flutter/material.dart' as _i6;
import 'package:secretsanta/presentation/pages/draw/page.dart' as _i1;
import 'package:secretsanta/presentation/pages/end/page.dart' as _i2;
import 'package:secretsanta/presentation/pages/name_entry/page.dart' as _i3;
import 'package:secretsanta/presentation/pages/remote_draw/page.dart' as _i4;

/// generated route for
/// [_i1.DrawPage]
class DrawRoute extends _i5.PageRouteInfo<DrawRouteArgs> {
  DrawRoute({
    _i6.Key? key,
    required int index,
    required _i7.BuiltList<String> names,
    required _i7.BuiltList<int> drawNames,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          DrawRoute.name,
          args: DrawRouteArgs(
            key: key,
            index: index,
            names: names,
            drawNames: drawNames,
          ),
          initialChildren: children,
        );

  static const String name = 'DrawRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DrawRouteArgs>();
      return _i1.DrawPage(
        key: args.key,
        index: args.index,
        names: args.names,
        drawNames: args.drawNames,
      );
    },
  );
}

class DrawRouteArgs {
  const DrawRouteArgs({
    this.key,
    required this.index,
    required this.names,
    required this.drawNames,
  });

  final _i6.Key? key;

  final int index;

  final _i7.BuiltList<String> names;

  final _i7.BuiltList<int> drawNames;

  @override
  String toString() {
    return 'DrawRouteArgs{key: $key, index: $index, names: $names, drawNames: $drawNames}';
  }
}

/// generated route for
/// [_i2.EndPage]
class EndRoute extends _i5.PageRouteInfo<void> {
  const EndRoute({List<_i5.PageRouteInfo>? children})
      : super(
          EndRoute.name,
          initialChildren: children,
        );

  static const String name = 'EndRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.EndPage();
    },
  );
}

/// generated route for
/// [_i3.NameEntryPage]
class NameEntryRoute extends _i5.PageRouteInfo<void> {
  const NameEntryRoute({List<_i5.PageRouteInfo>? children})
      : super(
          NameEntryRoute.name,
          initialChildren: children,
        );

  static const String name = 'NameEntryRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.NameEntryPage();
    },
  );
}

/// generated route for
/// [_i4.RemoteDrawPage]
class RemoteDrawRoute extends _i5.PageRouteInfo<RemoteDrawRouteArgs> {
  RemoteDrawRoute({
    _i6.Key? key,
    required _i7.BuiltList<String> names,
    required _i7.BuiltList<String> emails,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          RemoteDrawRoute.name,
          args: RemoteDrawRouteArgs(
            key: key,
            names: names,
            emails: emails,
          ),
          initialChildren: children,
        );

  static const String name = 'RemoteDrawRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RemoteDrawRouteArgs>();
      return _i4.RemoteDrawPage(
        key: args.key,
        names: args.names,
        emails: args.emails,
      );
    },
  );
}

class RemoteDrawRouteArgs {
  const RemoteDrawRouteArgs({
    this.key,
    required this.names,
    required this.emails,
  });

  final _i6.Key? key;

  final _i7.BuiltList<String> names;

  final _i7.BuiltList<String> emails;

  @override
  String toString() {
    return 'RemoteDrawRouteArgs{key: $key, names: $names, emails: $emails}';
  }
}
