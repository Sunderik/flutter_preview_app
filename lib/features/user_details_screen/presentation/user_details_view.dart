import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/user_details_screen/presentation/presentation.dart';
import 'package:azorin_test/features/user_details_screen/presentation/widgets/_widgets.dart';

///
class UserDetailsView extends StatefulWidget {
  const UserDetailsView({Key? key}) : super(key: key);

  @override
  _UserDetailsViewState createState() => _UserDetailsViewState();
}

///
class _UserDetailsViewState extends State<UserDetailsView> {
  ///
  UserDetailsBloc get bloc => Provider.of<UserDetailsBloc>(context, listen: false);

  ///
  static const String _loadingError = 'Ошибка загрузки';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _getScaffold(
        body: StreamBuilder<ScreenStatusEnum?>(
            stream: bloc.userDetailsScreenStatusStream,
            initialData: ScreenStatusEnum.init,
            builder: (context, snapshot) {
              final screenStatus = snapshot.data;

              if (screenStatus == null) {
                return _getErrorScreenView();
              }

              switch (screenStatus) {
                case ScreenStatusEnum.init:
                  bloc.loadUserInfo();
                  return _getLoadingScreenView();
                case ScreenStatusEnum.loading:
                  return _getLoadingScreenView();
                case ScreenStatusEnum.wait:
                  final data = bloc.user;
                  if (data == null) {
                    return _getErrorScreenView();
                  }
                  return _getWaitScreenView(user: data);
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
        title: StreamBuilder<String>(
            stream: bloc.appBarNameStream,
            initialData: 'Пользователь',
            builder: (context, snapshot) {
              return Text(snapshot.data!);
            }),
      ),
      body: body,
    );
  }

  /// Возвращает окно загрузки.
  Widget _getLoadingScreenView() {
    return Container();
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
  /// [user] - объект пользователя.
  Widget _getWaitScreenView({required User user}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: UserMainInfo(
              name: user.name!,
              phone: user.phone,
              email: user.email,
              site: user.website,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: UserAddressInfo(
              address: user.address!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: UserCompanyInfo(
              company: user.company,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: PostPreviewList(),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: AlbumsPreviewList(),
          ),
        ],
      ),
    );
  }
}
