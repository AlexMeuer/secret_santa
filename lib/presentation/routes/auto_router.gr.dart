// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:built_collection/built_collection.dart' as _i6;
import 'package:flutter/material.dart' as _i5;
import 'package:secretsanta/presentation/pages/draw/page.dart' as _i1;
import 'package:secretsanta/presentation/pages/end/page.dart' as _i2;
import 'package:secretsanta/presentation/pages/name_entry/page.dart' as _i3;

/// generated route for
/// [_i1.DrawPage]
class DrawRoute extends _i4.PageRouteInfo<DrawRouteArgs> {
  DrawRoute({
    _i5.Key? key,
    required int index,
    required _i6.BuiltList<String> names,
    required _i6.BuiltList<int> drawNames,
    List<_i4.PageRouteInfo>? children,
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

  static _i4.PageInfo page = _i4.PageInfo(
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

  final _i5.Key? key;

  final int index;

  final _i6.BuiltList<String> names;

  final _i6.BuiltList<int> drawNames;

  @override
  String toString() {
    return 'DrawRouteArgs{key: $key, index: $index, names: $names, drawNames: $drawNames}';
  }
}

/// generated route for
/// [_i2.EndPage]
class EndRoute extends _i4.PageRouteInfo<void> {
  const EndRoute({List<_i4.PageRouteInfo>? children})
      : super(
          EndRoute.name,
          initialChildren: children,
        );

  static const String name = 'EndRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.EndPage();
    },
  );
}

/// generated route for
/// [_i3.NameEntryPage]
class NameEntryRoute extends _i4.PageRouteInfo<void> {
  const NameEntryRoute({List<_i4.PageRouteInfo>? children})
      : super(
          NameEntryRoute.name,
          initialChildren: children,
        );

  static const String name = 'NameEntryRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.NameEntryPage();
    },
  );
}
