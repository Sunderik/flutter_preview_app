import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/albums_list_screen/presentation/albums_list_screen_bloc.dart';
import 'package:azorin_test/features/albums_list_screen/presentation/widgets/albums_list_content.dart';

///
class AlbumsListScreenView extends StatefulWidget {
  const AlbumsListScreenView({Key? key}) : super(key: key);

  @override
  _AlbumsListScreenViewState createState() => _AlbumsListScreenViewState();
}

///
class _AlbumsListScreenViewState extends State<AlbumsListScreenView> {
  ///
  AlbumsListScreenBloc get bloc => Provider.of<AlbumsListScreenBloc>(context, listen: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Альбомы'),
        ),
        body: StreamBuilder<ScreenStatusEnum>(
            stream: bloc.albumsListScreenStatusController.stream,
            initialData: ScreenStatusEnum.init,
            builder: (context, snapshot) {
              final status = snapshot.data;
              return StreamBuilder<BuiltList<Album>?>(
                stream: bloc.albumsController.stream,
                builder: (context, snapshot) {
                  final albums = bloc.albums;
                  switch (status) {
                    case ScreenStatusEnum.loading:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            Container(height: 10.0),
                            const Text('Загружаем альбомы пользователя'),
                          ],
                        ),
                      );
                    case ScreenStatusEnum.wait:
                      {
                        if (albums == null || albums.isEmpty) {
                          return Center(
                            child: Text(
                              'Альбомов нет',
                              style: TextStyle(color: Theme.of(context).backgroundColor),
                            ),
                          );
                        } else {
                          return const AlbumsListContent();
                        }
                      }
                    case ScreenStatusEnum.init:
                    default:
                      return Container();
                  }
                },
              );
            }),
      ),
    );
  }
}
