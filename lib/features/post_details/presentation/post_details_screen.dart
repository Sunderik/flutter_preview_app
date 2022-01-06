import 'package:azorin_test/core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation.dart';
///
class PostDetails extends StatelessWidget {
 ///
  final int postId;

  const PostDetails({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => PostDetailsBloc(postId)..init(),
      dispose: (BuildContext context, BaseBloc bloc) => bloc.dispose(),
      child: const PostDetailsView(),
    );
  }
}
