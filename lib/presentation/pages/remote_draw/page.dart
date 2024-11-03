import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RemoteDrawPage extends StatelessWidget {
  const RemoteDrawPage({
    Key? key,
    required this.names,
    required this.emails,
  }) : super(key: key);

  final BuiltList<String> names;
  final BuiltList<String> emails;

  @override
  Widget build(BuildContext context) {
    return const Text("placeholder text");
  }
}
