import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapView({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

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
            // print("Ngobe");
          },
        ),
        Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: const MarkerId("Seguku"),
          position: LatLng(widget.latitude, widget.longitude),
          draggable: true,
          onTap: () {
            // print("Ngobe");
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
