import 'package:azorin_test/core/core.dart';
import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  final List<Comment> comments;

  const CommentsList({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: comments.map((Comment comment) {
        return Card(
          child: ListTile(
            title: Text(
              comment.name ?? '',
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (comment.body ?? ''),
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: ' + (comment.email ?? ''),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ));
  }
}