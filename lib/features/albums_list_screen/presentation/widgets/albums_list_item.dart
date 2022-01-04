import 'package:azorin_test/core/core.dart';
import 'package:flutter/material.dart';

///
class AlbumsListItem extends StatelessWidget {
  /// Объект альбома пользователя.
  final Album album;

  /// Действие по нажатию.
  final Function() onTap;

  const AlbumsListItem({Key? key, required this.album, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          album.title != null ? album.title! : '',
          style: const TextStyle(color: Color.fromRGBO(59, 59, 59, 1.0), fontWeight: FontWeight.bold, fontSize: 16),
        ),
        dense: true,
        onTap: onTap,
      ),
    );
  }
}
