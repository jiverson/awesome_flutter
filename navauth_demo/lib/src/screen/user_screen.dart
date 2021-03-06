import 'package:flutter/material.dart';
import 'package:jiverson_navauth_demo/src/core/authentication/authentication_manager.dart';

import 'package:jiverson_navauth_demo/src/screen/base_screen.dart';

class UserScreen extends StatefulWidget {
  final ValueChanged refresh;

  UserScreen({Key? key, required this.refresh}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends BaseScreenState<UserScreen> {
  List<Widget> buildColumn(BuildContext context) {
    var column = <Widget>[];
    column.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'User page',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
    if (AuthenticationManager.instance.isLoggedIn) {
      column.add(Text('You are connected'));
    } else {
      column.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Enter email address'),
        ),
      );
      column.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Enter password'),
      ));
      column.add(
        ElevatedButton(
          onPressed: () {
            doLogin();
          },
          child: Text('Login'),
        ),
      );
    }
    return column;
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Center(
      child: Column(children: buildColumn(context)),
    );
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return (AuthenticationManager.instance.isLoggedIn)
        ? AppBar(
            title: Text('User Screen'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.logout,
                  ),
                  onPressed: () {
                    doLogout();
                  })
            ],
          )
        : AppBar(title: Text('User Screen'));
  }

  @override
  void onLoggedIn() {
    widget.refresh(null);
  }

  @override
  void onLoggedOut() {
    widget.refresh(null);
  }
}
