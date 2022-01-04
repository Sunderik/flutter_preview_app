import 'package:azorin_test/core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

///
class MapView extends StatelessWidget {
  ///
  final Geolocation geolocation;

  const MapView({Key? key, required this.geolocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).backgroundColor, //change your color here
          ),
          title: const Text(
            'Координаты',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(double.parse(geolocation.lat!), double.parse(geolocation.lng!)),
                  zoom: 17.0,
                ),
                children: <Widget>[
                  TileLayerWidget(
                      options: TileLayerOptions(
                          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'])),
                  MarkerLayerWidget(
                    options: MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(double.parse(geolocation.lat!), double.parse(geolocation.lng!)),
                          builder: (ctx) => const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.grey[850],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                geolocation.lat! + '"N ' + geolocation.lat! + '"E',
                                style: TextStyle(color: Colors.grey[850], fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
