import 'package:azorin_test/core/domain/models/album.dart';
import 'package:azorin_test/features/user_details_screen/presentation/user_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
class AlbumsPreviewList extends StatelessWidget {
  const AlbumsPreviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsBloc bloc = Provider.of<UserDetailsBloc>(context, listen: false);

    return StreamBuilder<List<Album>?>(
        stream: bloc.albumsStream,
        initialData: null,
        builder: (context, snapshot) {
          var albums = snapshot.data;
          if (albums == null) {
            bloc.loadUserAlbums();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (albums.isEmpty) {
            return const Center(
              child: Text('Альбомы отсутствуют.'),
            );
          } else if (albums.isNotEmpty) {
            albums = albums.getRange(0, 3).toList();
            return Card(
              child: Column(
                children: [
                  _getCardHeader(bloc),
                  const Divider(indent: 8, endIndent: 8),
                  _getCardContent(albums),
                ],
              ),
            );
          }
          return Container();
        });
  }

  ///
  Widget _getCardHeader(UserDetailsBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Albums',
            style: TextStyle(fontSize: 16),
          ),
          GestureDetector(
            onTap: () => bloc.openAlbumsList(),
            child: const Chip(
              label: Text('ALL'),
              labelStyle: TextStyle(fontSize: 12),
              useDeleteButtonTooltip: false,
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget _getCardContent(List<Album> albums) {
    List<Widget> widgets = albums.map((album) {
      return Builder(
        builder: (BuildContext context) {
          return ListTile(
            onTap: () => {},
            leading: Image.asset(
              'assets/images/album_miniature.png',
              fit: BoxFit.cover,
            ),
            title: Text(album.title!),
          );
        },
      );
    }).toList();
    return Column(
      children: [...widgets],
    );
  }
}
