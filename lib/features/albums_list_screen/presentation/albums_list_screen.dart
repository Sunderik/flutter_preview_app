import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'albums_list_screen_bloc.dart';
import 'albums_list_screen_view.dart';

///
class AlbumsListScreen extends StatelessWidget {
  final int userId;

  const AlbumsListScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext ctx) => AlbumsListScreenBloc(userId)..init(),
      dispose: (BuildContext ctx, AlbumsListScreenBloc bloc) => bloc.dispose(),
      child: const AlbumsListScreenView(),
    );
  }
}
