import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/albums_list_screen/presentation/albums_list_screen_bloc.dart';
import 'package:azorin_test/features/albums_list_screen/presentation/widgets/albums_list_item.dart';
///
class AlbumsListContent extends StatefulWidget {
  const AlbumsListContent({Key? key}) : super(key: key);

  @override
  _AlbumsListContentState createState() => _AlbumsListContentState();
}
///
class _AlbumsListContentState extends State<AlbumsListContent> {
  ///
  AlbumsListScreenBloc get bloc => Provider.of<AlbumsListScreenBloc>(context, listen: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BuiltList<Album>>(
        stream: bloc.albumsController.stream,
        builder: (context, snapshot) {
          final _albums = bloc.albums;
          return ListView.builder(
              itemCount: _albums?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return AlbumsListItem(album: _albums![index], onTap: () => {bloc.openAlbumInfo(_albums[index])});
              });
        });
  }
}
