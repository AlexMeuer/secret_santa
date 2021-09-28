import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secretsanta/presentation/routes/auto_router.gr.dart';

class NameEntryPage extends HookWidget {
  static const icons = [
    FontAwesomeIcons.gifts,
    FontAwesomeIcons.candyCane,
    FontAwesomeIcons.hollyBerry,
    FontAwesomeIcons.gift,
    FontAwesomeIcons.sleigh,
    FontAwesomeIcons.snowman,
  ];
  const NameEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final names = useState(<String>["", "", "", "", ""]);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final n = names.value.toBuiltList();
          AutoRouter.of(context).push(
            DrawPageRoute(
              index: 0,
              names: n,
              drawNames: generateSecretSantas(n),
            ),
          );
        },
        icon: const Icon(Icons.chevron_right_rounded),
        label: const Text("START DRAW"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: CachedNetworkImage(
              imageUrl: "https://source.unsplash.com/SUTfFCAHV_A/800x600",
              fit: BoxFit.cover,
            ),
            collapsedHeight: 64,
            expandedHeight: 400,
            title: const Text("Name Entry"),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => ListTile(
                leading: FaIcon(icons[i % icons.length]),
                title: TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => names.value[i] = v,
                ),
              ),
              childCount: names.value.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverToBoxAdapter(
              child: IconButton(
                onPressed: () => names.value = names.value + [""],
                icon: const Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }

  static BuiltList<int> generateSecretSantas(BuiltList<String> names) {
    final list = Iterable<int>.generate(names.length).toList();
    bool hasSelfDraw() {
      for (var i = 0; i < list.length; ++i) {
        if (list[i] == i) {
          return true;
        }
      }
      return false;
    }

    do {
      list.shuffle();
    } while (hasSelfDraw());
    return list.build();
  }
}
