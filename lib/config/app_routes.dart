import 'package:dog_translator_demo_flutter/config/routes.dart';
import 'package:dog_translator_demo_flutter/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoute = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomePage.builder,
  ),
  GoRoute(
    path: RouteLocation.request,
    parentNavigatorKey: navigationKey,
    builder: ProfileRequestPage.builder,
  ),
  GoRoute(
    path: RouteLocation.register,
    parentNavigatorKey: navigationKey,
    builder: ProfileRegisterPage.builder,
  ),
  GoRoute(
    path: RouteLocation.result,
    parentNavigatorKey: navigationKey,
    builder: ProfileRegisterPage.builder,
  ),
];
