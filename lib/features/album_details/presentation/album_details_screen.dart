import 'package:azorin_test/core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation.dart';
///
class AlbumDetails extends StatelessWidget {
 ///
  final int albumId;

  const AlbumDetails({
    Key? key,
    required this.albumId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => AlbumDetailsBloc(albumId)..init(),
      dispose: (BuildContext context, BaseBloc bloc) => bloc.dispose(),
      child: const AlbumDetailsView(),
    );
  }
}
