import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddCommentDialog extends StatefulWidget {
  final String email;
  final Function(String, String, String) onAddComment;

  AddCommentDialog({
    required this.email,
    required this.onAddComment,
  });

  @override
  _AddCommentDialogState createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _bodyFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _bodyEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextStyle btnStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).backgroundColor);

    _nameEditingController.text = '';
    _bodyEditingController.text = '';
    _emailEditingController.text = widget.email;

    return AlertDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: '',
                focusNode: _nameFocusNode,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Заголовок комментария",
                  hintText: "Залоговок",
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Заголовок не может быть пустым';
                  }
                  return null;
                },
                onChanged: (value) {
                  _nameEditingController.text = value;
                },
              ),
              TextFormField(
                initialValue: '',
                focusNode: _bodyFocusNode,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Комментарий",
                  hintText: "Комментарий",
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Комментарий не может быть пустым';
                  }
                  return null;
                },
                onChanged: (value) {
                  _bodyEditingController.text = value;
                },
              ),
              TextFormField(
                initialValue: widget.email,
                focusNode: _emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Почта отправителя",
                  hintText: "example@mail.ru",
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Почта должна быть указана';
                  }
                  return null;
                },
                onChanged: (value) {
                  _emailEditingController.text = value;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Отправить', style: btnStyle),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onAddComment(
                  _nameEditingController.text, _bodyEditingController.text, _emailEditingController.text);
            }
          },
        ),
        TextButton(
          child: Text('Отменить', style: btnStyle),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
