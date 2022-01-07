import 'package:azorin_test/features/album_details/presentation/widgets/album_photos_list.dart';
import 'package:azorin_test/features/post_details/presentation/post_details_bloc.dart';
import 'package:azorin_test/features/post_details/presentation/widgets/comments_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:azorin_test/core/core.dart';

import 'album_details_bloc.dart';

///
class AlbumDetailsView extends StatefulWidget {
  const AlbumDetailsView({Key? key}) : super(key: key);

  @override
  _AlbumDetailsViewState createState() => _AlbumDetailsViewState();
}

///
class _AlbumDetailsViewState extends State<AlbumDetailsView> {
  ///
  AlbumDetailsBloc get bloc => Provider.of<AlbumDetailsBloc>(context, listen: false);

  ///
  static const String _loadingError = 'Ошибка загрузки';

  String _titleImage = '';

  void updateTitle(String newTitle) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _titleImage = newTitle;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _getScaffold(
        body: StreamBuilder<ScreenStatusEnum?>(
            stream: bloc.albumDetailsScreenStatusStream,
            initialData: ScreenStatusEnum.init,
            builder: (context, snapshot) {
              final screenStatus = snapshot.data;

              if (screenStatus == null) {
                return _getErrorScreenView();
              }

              switch (screenStatus) {
                case ScreenStatusEnum.init:
                  bloc.loadAlbumInfo();
                  return _getLoadingScreenView();
                case ScreenStatusEnum.loading:
                  return _getLoadingScreenView();
                case ScreenStatusEnum.wait:
                  return _getWaitScreenView();
                case ScreenStatusEnum.fail:
                default:
                  return _getErrorScreenView();
              }
            }),
      ),
    );
  }

  /// Возвращает Scaffold.
  ///
  /// [body] - поле body у виджета Scaffold.
  Widget _getScaffold({required Widget body}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Альбом'),
      ),
      body: body,
    );
  }

  /// Возвращает окно загрузки.
  Widget _getLoadingScreenView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Container(height: 10.0),
          const Text('Загружаем фотографии'),
        ],
      ),
    );
  }

  /// Возвращает окно ошибки.
  Widget _getErrorScreenView() {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: const Center(child: Text(_loadingError)),
          )
        ],
      ),
    );
  }

  /// Возвращает основные виджеты.
  ///
  /// [album] - .
  Widget _getWaitScreenView() {
    return StreamBuilder<List<AlbumPhoto>?>(
        stream: bloc.photosStream,
        initialData: null,
        builder: (context, snapshot) {
          var photos = snapshot.data;
          if (photos == null) {
            bloc.loadAlbumPhotos();
          } else if (photos.isEmpty) {
            return const Center(
              child: Text('Фотографии отсутствуют.'),
            );
          } else if (photos.isNotEmpty) {
            return Column(
              children: [
                AlbumPhotosList(photos: photos, callback: (String newTitle) => updateTitle(newTitle)),
                Center(child: Container(width: MediaQuery.of(context).size.width * 0.8, child: Text(_titleImage,textAlign: TextAlign.center,)))
              ],
            );
          }
          return Container();
        });
  }
}

typedef StringCallback = void Function(String val);
