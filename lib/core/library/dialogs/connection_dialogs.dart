import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:url_launcher/url_launcher.dart';

/// Вызов диалога с возможностью звонка и копирования номера.
///
/// [context] - контекст экрана;
/// [phone] - номер телефона.
void phoneCallDialog(BuildContext context, String phone) {
  if (phone.isNotEmpty) {
    _showDialogConnection(
      context: context,
      onPressedConnection: () {
        _callPhoneApps(phone);
      },
      onPressedCopy: () {
        _copyPhone(phone);
      },
      connectionText: 'ПОЗВОНИТЬ',
      copyText: 'СКОПИРОВАТЬ НОМЕР ТЕЛЕФОНА',
      cancelText: 'ОТМЕНА',
    );
  }
}

/// Вызов диалога с возможностью отправки на почту и копирования почтового адреса.
///
/// [context] - контекст экрана;
/// [email] - почтовый адрес.
void emailCallDialog(BuildContext context, String email) {
  if (email.isNotEmpty) {
    _showDialogConnection(
      context: context,
      onPressedConnection: () {
        _callEmailApps(email);
      },
      onPressedCopy: () {
        _copyEmail(email);
      },
      connectionText: 'НАПИСАТЬ',
      copyText: 'СКОПИРОВАТЬ E-MAIL',
      cancelText: 'ОТМЕНА',
    );
  }
}

/// Вызов диалога с возможность открытия сайта и копирования его url адреса.
///
/// [context] - контекст экрана;
/// [site] - сайт.
void siteCallDialog(BuildContext context, String site) {
  if (site.isNotEmpty) {
    _showDialogConnection(
      context: context,
      onPressedConnection: () {
        _openSite(site);
      },
      onPressedCopy: () {
        _copySite(site);
      },
      connectionText: 'ОТКРЫТЬ',
      copyText: 'СКОПИРОВАТЬ URL',
      cancelText: 'ОТМЕНА',
    );
  }
}
// endregion

// region Private Methods
/// Выполнение звонка по номеру телефона [phone].
void _callPhoneApps(String phone) {
  launch("tel:$phone");
}

/// Копирование номера телефона [phone].
void _copyPhone(String phone) {
  Clipboard.setData(ClipboardData(text: phone));
  // ShowSnackBar.showInfoSnackBar(
  //   message: 'Телефон скопирован в буфер обмена',
  // );
}

/// Отправка на [email].
void _callEmailApps(String email) {
  launch("mailto:$email");
}

/// Копирование [email].
void _copyEmail(String email) {
  Clipboard.setData(ClipboardData(text: email));
  // ShowSnackBar.showInfoSnackBar(
  //   message: 'e-mail скопирован в буфер обмена',
  // );
}

/// Открытие сайта по [site].
void _openSite(String site) {
  launch("https://$site");
}

/// Копирование [site].
void _copySite(String site) {
  Clipboard.setData(ClipboardData(text: site));
  // ShowSnackBar.showInfoSnackBar(
  //   message: 'e-mail скопирован в буфер обмена',
  // );
}
/// Метод отображения диалога на экране.
void _showDialogConnection(
    {required BuildContext context,
    required Function() onPressedConnection,
    required Function() onPressedCopy,
    String connectionText = 'Соединиться',
    String copyText = 'Скопировать значение',
    String cancelText = 'Нет'}) {
  Widget connectionButton = TextButton(
    child: Text(connectionText, style: TextStyle(color: Theme.of(context).backgroundColor)),
    onPressed: () {
      Navigator.of(context).pop();
      onPressedConnection();
    },
  );

  Widget copyButton = TextButton(
    child: Text(copyText, style: TextStyle(color: Theme.of(context).backgroundColor)),
    onPressed: () {
      Navigator.of(context).pop();
      onPressedCopy();
    },
  );

  Widget cancelButton = TextButton(
    child: Text(cancelText, style: TextStyle(color: Theme.of(context).backgroundColor)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    actionsOverflowButtonSpacing: 4.0,
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          connectionButton,
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          copyButton,
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cancelButton,
        ],
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
// endregion
