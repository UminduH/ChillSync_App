import 'package:chillsync/routes/auth_routes.dart';
import 'package:chillsync/routes/static_routes.dart';
import 'package:chillsync/routes/user_routes.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    ...StaticRoutes.routes,
    ...AuthRoutes.routes,
    ...UserRoutes.routes
  };
}