import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => __MapViewState();
}

class __MapViewState extends State<MapView> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(0.347596, 32.582520);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: {
        Marker(
          markerId: const MarkerId("Ngobe"),
          position: const LatLng(0.347596, 32.582520),
          draggable: true,
          onTap: () {
            print("Ngobe");
          },
        ),
        Marker(
          markerId: const MarkerId("Seguku"),
          position: const LatLng(0.349596, 32.782520),
          draggable: true,
          onTap: () {
            print("Ngobe");
          },
        )
      },
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 9.0,
      ),
    );
  }
}
