import 'package:auto_route/auto_route.dart';
import 'package:secretsanta/presentation/pages/draw/page.dart';
import 'package:secretsanta/presentation/pages/end/page.dart';
import 'package:secretsanta/presentation/pages/name_entry/page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: NameEntryPage, initial: true),
    AutoRoute(page: DrawPage),
    AutoRoute(page: EndPage),
  ],
)
class $AppRouter {}
