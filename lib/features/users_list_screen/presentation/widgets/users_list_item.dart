import 'package:azorin_test/core/core.dart';
import 'package:flutter/material.dart';
///
class UsersListItem extends StatelessWidget {
  /// Объект исполнителя.
  final User user;

  /// Действие по нажатию.
  final Function() onTap;

  const UsersListItem({Key? key, required this.user, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 28, height: 28),
          child: Icon(
            Icons.person,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          user.userName != null ? user.userName! : '',
          style: const TextStyle(color: Color.fromRGBO(59, 59, 59, 1.0), fontWeight: FontWeight.w400, fontSize: 14),
        ),
        subtitle: Text(
          user.name != null ? user.name! : '',
          style: const TextStyle(color: Color.fromRGBO(59, 59, 59, 1.0), fontWeight: FontWeight.w400, fontSize: 14),
        ),
        dense: true,
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[700],
          size: 23,
        ),
        onTap: onTap,
      ),
    );
  }
}
