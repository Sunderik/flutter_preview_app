import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/users_list_screen/presentation/users_list_screen_bloc.dart';
import 'package:azorin_test/features/users_list_screen/presentation/widgets/users_list_content.dart';

///
class UsersListScreenView extends StatefulWidget {
  const UsersListScreenView({Key? key}) : super(key: key);

  @override
  _UsersListScreenViewState createState() => _UsersListScreenViewState();
}

///
class _UsersListScreenViewState extends State<UsersListScreenView> {
  ///
  UsersListScreenBloc get bloc => Provider.of<UsersListScreenBloc>(context, listen: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Пользователи'),
        ),
        body: RefreshIndicator(
          color: Theme.of(context).backgroundColor,
          onRefresh: () async {
            bloc.refreshUsersList();
          },
          child: StreamBuilder<ScreenStatusEnum>(
              stream: bloc.usersListScreenStatusController.stream,
              initialData: ScreenStatusEnum.init,
              builder: (context, snapshot) {
                final status = snapshot.data;
                return Container(
                  child: StreamBuilder<BuiltList<User>>(
                    stream: bloc.usersController.stream,
                    builder: (context, snapshot) {
                      final team = bloc.users;
                      if (team != null && team.isNotEmpty && status != ScreenStatusEnum.loading) {
                        return const UsersListContent();
                      } else if (team != null && team.isEmpty && status != ScreenStatusEnum.wait) {
                        return Center(
                          child: Text(
                            'Пользователей нет',
                            style: TextStyle(color: Theme.of(context).backgroundColor),
                          ),
                        );
                      }
                      return const Text('Загружаем команду проекта');
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }
}
