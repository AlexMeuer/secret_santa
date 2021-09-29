import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secretsanta/presentation/routes/auto_router.gr.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final scroller = useScrollController();
    final names = useState(BuiltList<String>(["", "", "", "", ""]));
    final canProgress = names.value
            .map((name) => name.trim())
            .where((name) => name != "")
            .length >
        2;
    final latestInputNode = useFocusNode(debugLabel: "latest_input_node");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: canProgress ? null : Colors.grey,
        tooltip: canProgress ? null : "Enter at least 3 names.",
        onPressed: canProgress
            ? () {
                final n = names.value
                    .map((name) => name.trim())
                    .where((name) => name != "")
                    .toBuiltList();
                AutoRouter.of(context).push(
                  DrawPageRoute(
                    index: 0,
                    names: n,
                    drawNames: generateSecretSantas(n),
                  ),
                );
              }
            : null,
        icon: const Icon(Icons.chevron_right_rounded),
        label: const Text("START DRAW"),
      ),
      body: CustomScrollView(
        controller: scroller,
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Secret Santa",
                style: GoogleFonts.mountainsOfChristmas(),
              ),
              background: CachedNetworkImage(
                imageUrl: "https://source.unsplash.com/SUTfFCAHV_A/800x600",
                fit: BoxFit.cover,
              ),
            ),
            collapsedHeight: 64,
            expandedHeight: 400,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: const ListTile(
                    leading: FaIcon(FontAwesomeIcons.info),
                    title: Text("Enter names for secret santa."),
                    subtitle: Text("Empty names will be ignored."),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: FadeInUp(
                    child: ListTile(
                      leading: FaIcon(icons[i % icons.length]),
                      title: TextField(
                        focusNode: i == names.value.length - 1
                            ? latestInputNode
                            : null,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (v) {
                          names.value = names.value.rebuild(
                            (b) => b
                              ..removeAt(i)
                              ..insert(i, v),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              childCount: names.value.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverToBoxAdapter(
              child: IconButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  names.value = names.value.rebuild((b) => b..add(""));
                  await Future.delayed(const Duration(milliseconds: 8));
                  latestInputNode.requestFocus();
                  await Future.delayed(const Duration(milliseconds: 8));
                  scroller.animateTo(
                    scroller.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutQuint,
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: DefaultTextStyle(
                style: GoogleFonts.majorMonoDisplay()
                    .copyWith(fontWeight: FontWeight.bold),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: "Made by "),
                        TextSpan(
                          text: "Alex Meuer",
                          style: const TextStyle(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launch("https://alexmeuer.com"),
                        ),
                        const TextSpan(text: " with "),
                        TextSpan(
                          text: "Flutter",
                          style: const TextStyle(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launch("https://flutter.dev/"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
