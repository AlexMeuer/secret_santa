import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:secretsanta/presentation/routes/auto_router.gr.dart';

class DrawPage extends HookWidget {
  const DrawPage({
    Key? key,
    required this.index,
    required this.names,
    required this.drawNames,
  }) : super(key: key);

  final int index;
  final BuiltList<String> names;
  final BuiltList<int> drawNames;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final show = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Don't let anyone else see!"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: show.value
            ? () => index + 1 >= names.length
                ? AutoRouter.of(context).push(const EndPageRoute())
                : AutoRouter.of(context).push(
                    DrawPageRoute(
                      index: index + 1,
                      names: names,
                      drawNames: drawNames,
                    ),
                  )
            : null,
        icon: const Icon(Icons.chevron_right_rounded),
        label: const Text("NEXT"),
        backgroundColor: show.value ? null : Colors.grey,
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: CachedNetworkImage(
              imageUrl: "https://source.unsplash.com/SUTfFCAHV_A/1000x000",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        names[index],
                        style: theme.textTheme.headline1,
                      ),
                      ElevatedButton(
                        onPressed: show.value ? null : () => show.value = true,
                        child: Text(
                          show.value ? names[drawNames[index]] : "DRAW",
                          style: theme.textTheme.headline2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
