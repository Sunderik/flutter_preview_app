import 'package:azorin_test/core/library/dialogs/connection_dialogs.dart';
import 'package:azorin_test/features/user_details_screen/presentation/widgets/info_row.dart';
import 'package:flutter/material.dart';

///
class UserMainInfo extends StatelessWidget {
  ///
  final String name;

  ///
  final String? phone;

  ///
  final String? email;

  ///
  final String? site;

  const UserMainInfo({Key? key, required this.name, this.phone, this.email, this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/user_avatar.png',
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  InfoRow(
                    name: 'Name',
                    widget: Text(
                      name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(),
                  if (phone != null)
                    InfoRow(
                      name: 'Phone',
                      widget: Text(phone!),
                      onTap: () => phoneCallDialog(context, phone!),
                    ),
                  const Divider(),
                  if (email != null)
                    InfoRow(
                      name: 'Email',
                      widget: Text(email!),
                      onTap: () => emailCallDialog(context, email!),
                    ),
                  const Divider(),
                  if (site != null)
                    InfoRow(
                      name: 'Site',
                      widget: Text(site!),
                      onTap: () => siteCallDialog(context, site!),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
