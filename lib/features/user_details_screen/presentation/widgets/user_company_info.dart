import 'package:azorin_test/core/core.dart';
import 'package:flutter/material.dart';

import 'info_row.dart';
///
class UserCompanyInfo extends StatelessWidget {
  ///
  final Company company;

  const UserCompanyInfo({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: const Text('Company'),
          children: <Widget>[
            if (company.name != null)
              InfoRow(
                name: 'Name',
                widget: Text(company.name!),
              ),
            if (company.bs != null)
              InfoRow(
                name: 'BS',
                widget: Text(company.bs!),
              ),
            if (company.catchPhrase != null)
              InfoRow(
                name: 'CatchPhrase',
                widget: Text('"' + company.catchPhrase! + '"',
                    style: const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400)),
              ),
          ],
        ),
      ),
    );
  }
}
