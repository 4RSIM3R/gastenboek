import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:next_starter/presentation/pages/guest/guest_form_page.dart';
import 'package:next_starter/presentation/pages/scan/scan_page.dart';
import 'package:nik_validator/nik_validator.dart';

import '../pages/pages.dart';

part 'app_router.gr.dart';

@LazySingleton()
@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: FormRoute.page),
    AutoRoute(page: PostRoute.page),
    // auth
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: ChangePasswordRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: SuccessRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: ScanRoute.page),
    AutoRoute(page: GuestFormRoute.page),
  ];
}
