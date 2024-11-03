import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secretsanta/presentation/pages/name_entry/app_bar_sliver.dart';
import 'package:secretsanta/presentation/routes/auto_router.gr.dart';
import 'package:secretsanta/presentation/widgets/basic_made_by.dart';

@RoutePage()
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

  static bool haveEnoughNamesAndEmails(
    bool isRemote,
    BuiltList<String> names,
    BuiltList<String> emails,
  ) {
    final nonEmptyNames =
        names.map((name) => name.trim()).where((name) => name != "");
    final namesOk = nonEmptyNames.length > 2;

    if (!isRemote || !namesOk) {
      return namesOk;
    }

    // There's a bug here where the emails entered don't need to match the rows with the names.
    final emailsOk = emails
            .map((email) => email.trim())
            .where((email) => email != "")
            .length ==
        nonEmptyNames.length;

    return emailsOk;
  }

  @override
  Widget build(BuildContext context) {
    final scroller = useScrollController();
    final isRemote = useState(false);
    final names = useState(BuiltList<String>(["", "", "", "", ""]));
    final emails = useState(BuiltList<String>(["", "", "", "", ""]));
    final canProgress =
        haveEnoughNamesAndEmails(isRemote.value, names.value, emails.value);
    final latestInputNode = useFocusNode(debugLabel: "latest_input_node");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton.extended(
        focusNode: FocusNode(
          skipTraversal: true,
          canRequestFocus: false,
          descendantsAreFocusable: false,
        ),
        backgroundColor: canProgress ? null : Colors.grey,
        tooltip: canProgress ? null : "Enter at least 3 names.",
        onPressed: canProgress
            ? () {
                final n = names.value
                    .map((name) => name.trim())
                    .where((name) => name != "")
                    .toBuiltList();
                if (!isRemote.value) {
                  AutoRouter.of(context).push(
                    DrawRoute(
                      index: 0,
                      names: n,
                      drawNames: generateSecretSantas(n),
                    ),
                  );
                } else {
                  final e = emails.value
                      .map((email) => email.trim())
                      .where((email) => email != "")
                      .toBuiltList();
                  AutoRouter.of(context).push(
                    RemoteDrawRoute(names: n, emails: e),
                  );
                }
              }
            : null,
        icon: const Icon(Icons.chevron_right_rounded),
        label: const Text("START DRAW"),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        child: CustomScrollView(
          controller: scroller,
          slivers: [
            const AppBarSliver(),
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
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Draw all names on this device",
                      style: TextStyle(
                        color: isRemote.value ? Colors.grey : null,
                      ),
                    ),
                    Switch(
                      value: isRemote.value,
                      onChanged: (v) => isRemote.value = v,
                    ),
                    Text(
                      "Send emails with draw results",
                      style: TextStyle(
                        color: isRemote.value ? null : Colors.grey,
                      ),
                    ),
                  ],
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
                        title: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                focusNode: i == names.value.length - 1
                                    ? latestInputNode
                                    : null,
                                autocorrect: false,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Name",
                                ),
                                textInputAction: TextInputAction.next,
                                onChanged: (v) {
                                  names.value = names.value.rebuild(
                                    (b) => b
                                      ..removeAt(i)
                                      ..insert(i, v),
                                  );
                                },
                              ),
                            ),
                            if (isRemote.value)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateEmail,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Email",
                                    ),
                                    onChanged: (v) {
                                      emails.value = emails.value.rebuild(
                                        (b) => b
                                          ..removeAt(i)
                                          ..insert(i, v),
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
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
                    emails.value = emails.value.rebuild((b) => b..add(""));
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
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: BasicMadeBy(),
              ),
            ),
          ],
        ),
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

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}
