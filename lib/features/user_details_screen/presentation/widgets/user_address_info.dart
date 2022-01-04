import 'package:azorin_test/app_starter.dart';
import 'package:azorin_test/core/core.dart';
import 'package:flutter/material.dart';

import 'info_row.dart';

///
class UserAddressInfo extends StatelessWidget {
  ///
  final Address address;

  const UserAddressInfo({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: const Text('Address'),
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(children: <Widget>[
                  if (address.city != null)
                    InfoRow(
                      name: 'City',
                      widget: Text(address.city!),
                    ),
                  if (address.street != null)
                    InfoRow(
                      name: 'Street',
                      widget: Text(address.street!),
                    ),
                  if (address.suite != null)
                    InfoRow(
                      name: 'Suite',
                      widget: Text(address.suite!),
                    ),
                  if (address.zipCode != null)
                    InfoRow(
                      name: 'ZipCode',
                      widget: Text(address.zipCode!),
                    ),
                ]),
              ),
              if (address.geolocation != null)
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => _openMap(address.geolocation),
                      child: const Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        primary: Colors.white, // <-- Button color
                        onPrimary: Colors.white60, // <-- Splash color
                      ),
                    ),
                  ),
                ),
            ]),
          ],
        ),
      ),
    );
  }

  /// Открыват карту.
  _openMap(Geolocation? geolocation) {
    final bundle = {
      'geolocation': geolocation,
    };
    store!.actions.navigation.routeTo(AppRoute((builder) => builder
      ..route = Routes.showMap
      ..navigationType = NavigationType.push
      ..transitionType = TransitionType.fade
      ..bundle = bundle));
  }
}
