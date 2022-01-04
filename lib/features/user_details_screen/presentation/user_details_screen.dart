import 'package:azorin_test/core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation.dart';
///
class UserDetails extends StatelessWidget {
 ///
  final int userId;

  const UserDetails({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => UserDetailsBloc(userId)..init(),
      dispose: (BuildContext context, BaseBloc bloc) => bloc.dispose(),
      child: const UserDetailsView(),
    );
  }
}
