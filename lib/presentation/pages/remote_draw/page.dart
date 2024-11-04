import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:secretsanta/presentation/routes/auto_router.gr.dart';
import 'package:secretsanta/presentation/widgets/glitch.dart';

@RoutePage()
class RemoteDrawPage extends HookWidget {
  const RemoteDrawPage({
    Key? key,
    required this.names,
    required this.emails,
  }) : super(key: key);

  final BuiltList<String> names;
  final BuiltList<String> emails;

  @override
  Widget build(BuildContext context) {
    final future =
        useMemoized(() => sendPostRequest(names, emails), [names, emails]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Remote Draw"),
      ),
      body: Center(
        child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  GlitchEffect(
                    child: Text("Assigning santas..."),
                  ),
                ],
              );
            }

            if (snapshot.hasError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text("Failed to assign santas"),
                  const SizedBox(height: 16),
                  Text(snapshot.error.toString()),
                ],
              );
            } else {
              AutoRouter.of(context).push(const EndRoute());
              return const Text("Santas have been assigned!");
            }
          },
        ),
      ),
    );
  }
}

Future<void> sendPostRequest(
  BuiltList<String> names,
  BuiltList<String> emails,
) async {
  final response = await http.post(
    Uri.parse("/doSecretSantaDraw"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "participants": List.generate(
        names.length,
        (i) => {
          "name": names[i],
          "email": emails[i],
        },
      ),
    }),
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to assign santas: ${response.body}");
  }
}
