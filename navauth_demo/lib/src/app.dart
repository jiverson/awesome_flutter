import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jiverson_navauth_demo/src/bloc/authentication/authentication_bloc.dart';
import 'package:jiverson_navauth_demo/src/navigation/my_route_information_parser.dart';
import 'package:jiverson_navauth_demo/src/navigation/my_router_delegate.dart';
import 'package:jiverson_navauth_demo/src/resource/login_repository.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final MyRouterDelegate _routerDelegate = MyRouterDelegate();
  final MyRouteInformationParser _routeInformationParser =
      MyRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(LoginRepository()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Books App',
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
        ));
  }
}
