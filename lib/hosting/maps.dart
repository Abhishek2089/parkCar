import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsFlutter extends StatefulWidget {
  @override
  _MapsFlutterState createState() => _MapsFlutterState();
}

class _MapsFlutterState extends State<MapsFlutter> {
  
  final MapController mapController = MapController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Maps'),
      ),
      body: Center(
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            plugins: <MapPlugin>[

              LocationPlugin(),
            ],
            interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          ),
          layers: [
      MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(51.5, -0.09),
            builder: (ctx) =>
            Container(
              child: FlutterLogo(),
            ),
          ),
        ],
      ),
    ],
    children: <Widget>[
      TileLayerWidget(options: TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c']
      )),
      MarkerLayerWidget(options: MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(51.5, -0.09),
            builder: (ctx) =>
            Container(
              child: FlutterLogo(),
            ),
          ),
        ],
      )),
    ],
        ),
      ),
    );
  }
}