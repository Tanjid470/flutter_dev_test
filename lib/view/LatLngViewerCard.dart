

import 'package:flutter/material.dart';
import 'package:flutter_dev_test/controller/MapController.dart';
import 'package:flutter_dev_test/view/PickLocationScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLngViewerCard extends StatefulWidget {
  final Position? currentPosition;
  final Function(Position) returnValue;

  LatLngViewerCard(
      {super.key, required this.currentPosition, required this.returnValue});

  @override
  State<LatLngViewerCard> createState() => _LatLngViewerCardState();
}

class _LatLngViewerCardState extends State<LatLngViewerCard> {
  MapController mapController = MapController();
  Position? position;
  CameraPosition? currentCameraPosition;
  List<Marker> marker = [];
  late GoogleMapController googleMapController;

  @override
  void initState() {
    position = widget.currentPosition;
    setCameraPosition();
    super.initState();
  }

  setCameraPosition() async {
    if (position == null) {
      Position? userPosition = await mapController.getCurrentLocation();
      if (userPosition != null) {
        currentCameraPosition = CameraPosition(
          target: LatLng(userPosition.latitude, userPosition.longitude),
          // Initial camera position
          zoom: 12, // Initial zoom level
        );
      }
    } else {
      currentCameraPosition = CameraPosition(
        target: LatLng(position!.latitude, position!.longitude),
        // Initial camera position
        zoom: 12, // Initial zoom level
      );
      setMarker(position!);
    }
    refresh();
  }

  setMarker(Position makerPosition) async {
    marker = [];
    marker.add(Marker(
        markerId: MarkerId(makerPosition.toString()),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(makerPosition.latitude, makerPosition.longitude)));
    refresh();
  }

  refresh() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (currentCameraPosition == null) {
          return;
        }

        Position? pos = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PickLocationScreen(appBarTitle: "Pick Location"),
          ),
        );

        if (pos != null) {
          position = pos;
          await setMarker(pos);

          widget.returnValue(pos);
          currentCameraPosition = CameraPosition(
            target: LatLng(pos.latitude, pos.longitude),
            zoom: 12,
          );

          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(currentCameraPosition!),
          );
          refresh();
        }
      },

      child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Container(
                height: MediaQuery.of(context).size.height - 300,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.cyan),
                child: currentCameraPosition == null
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : googleMap()),
            Container(
                height: MediaQuery.of(context).size.height - 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: position == null &&
                        currentCameraPosition != null
                        ? WidgetStateColor.transparent
                        : Colors.white.withOpacity(0.25)),
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.currentPosition != null &&
                          currentCameraPosition != null) ...[
                        const Icon(Icons.share_location_rounded,
                            color: Colors.cyan, size: 30),
                        const SizedBox(width: 10),
                        const Text("Pick Location",
                            style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ]
                      else...[

                      ]
                    ],
                  ),
                ))
          ],
        ));
  }

  Widget googleMap() {
    return GoogleMap(
      initialCameraPosition: currentCameraPosition!,
      onMapCreated: (GoogleMapController controller) {
        googleMapController = controller;
        refresh();
      },
      onCameraMove: (CameraPosition newPosition) {
        currentCameraPosition = newPosition;
      },
      markers: Set.from(marker),
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      padding: const EdgeInsets.all(0),
      buildingsEnabled: false,
      cameraTargetBounds: CameraTargetBounds.unbounded,
      compassEnabled: false,
      indoorViewEnabled: false,
      mapToolbarEnabled: false,
      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
      tiltGesturesEnabled: false,
      trafficEnabled: false,
    );
  }
}
