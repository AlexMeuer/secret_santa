import 'package:auto_route/auto_route.dart';
import 'package:secretsanta/presentation/routes/auto_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NameEntryRoute.page, initial: true),
        AutoRoute(page: DrawRoute.page),
        AutoRoute(page: RemoteDrawRoute.page),
        AutoRoute(page: EndRoute.page),
      ];
}
