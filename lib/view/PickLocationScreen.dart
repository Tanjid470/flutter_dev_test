
import 'package:flutter/material.dart';
import 'package:flutter_dev_test/controller/MapController.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationScreen extends StatefulWidget {
  final String appBarTitle;

  const PickLocationScreen({super.key, required this.appBarTitle});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  MapController mapController = MapController();
  CameraPosition? currentCameraPosition;
  late GoogleMapController googleMapController;
  Position? userCurrentLocation;
  LatLng? pickedPosition;
  List<Marker> marker = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            title: Text(
              widget.appBarTitle,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: pickedPosition == null
            ? null
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
              child: Text("Submit"),
              onPressed: () {
                Navigator.pop(context, Position(
                    latitude: pickedPosition!.latitude,
                    longitude: pickedPosition!.longitude,
                    timestamp: DateTime.now(),
                    accuracy: 1,
                    altitude: 1,
                    altitudeAccuracy: 1,
                    heading: 1,
                    headingAccuracy: 1,
                    speed: 1,
                    speedAccuracy: 1,
                    floor: 1));
              }),
        ),
        body: currentCameraPosition == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : SafeArea(
          child: googleMap(),
        ));
  }

  getData() async {
    Position? currentPosition = await mapController.getCurrentLocation();

    if (currentPosition != null) {
      userCurrentLocation = currentPosition;
      currentCameraPosition = CameraPosition(
          zoom: 6,
          target: LatLng(currentPosition.latitude, currentPosition.longitude));
      if (mounted) {
        setState(() {});
      }
    }
  }

  void handleOnTapEvent(LatLng position) {
    marker = [];
    setState(() {
      marker.add(Marker(
          markerId: MarkerId(position.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: position));
      pickedPosition = position;
    });
  }

  Widget googleMap() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: currentCameraPosition!,
          onTap: (LatLng position) {
            handleOnTapEvent(position);
          },
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              googleMapController = controller;
            });
          },
          onCameraMove: (CameraPosition newPosition) {
            currentCameraPosition = newPosition;
          },
          markers: Set.from(marker),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: false,
          zoomGesturesEnabled: true,
          padding: const EdgeInsets.all(0),
          buildingsEnabled: true,
          cameraTargetBounds: CameraTargetBounds.unbounded,
          compassEnabled: true,
          indoorViewEnabled: false,
          mapToolbarEnabled: true,
          minMaxZoomPreference: MinMaxZoomPreference.unbounded,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          trafficEnabled: false,
        ),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            right: 10,
            child: IconButton(
                onPressed: () {
                  if (userCurrentLocation != null) {
                    googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(userCurrentLocation!.latitude,
                                userCurrentLocation!.longitude),
                            zoom: currentCameraPosition!.zoom)));
                  }
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Colors.white.withOpacity(0.7))),
                icon: const Icon(Icons.my_location_outlined,
                    color: Colors.red, size: 30)))
      ],
    );
  }
}
