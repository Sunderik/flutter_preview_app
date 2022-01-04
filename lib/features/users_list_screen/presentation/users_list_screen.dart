import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'users_list_screen_bloc.dart';
import 'users_list_screen_view.dart';
///
class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext ctx) => UsersListScreenBloc()..init(),
      dispose: (BuildContext ctx, UsersListScreenBloc bloc) => bloc.dispose(),
      child: const UsersListScreenView(),
    );
  }
}
