import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkster/Model/user.dart';
import 'package:parkster/frontend/login.dart';
import 'package:uuid/uuid.dart';
import 'package:geocoder/geocoder.dart' as geo;
import 'Addparkingdetails.dart';

class GoogleLocation extends StatefulWidget {
  final User currentUser;

  GoogleLocation({
    this.currentUser,
  });
  @override
  _GoogleLocationState createState() => _GoogleLocationState();
}

class _GoogleLocationState extends State<GoogleLocation> with AutomaticKeepAliveClientMixin {
  GoogleMapController googleMapController;
  Position position;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String postId = Uuid().v4();

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    super.initState();
  }

  void getmarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(snippet: 'Address'));
    setState(() {
      markers[markerId] = _marker;
    });
  }

  void getCurrentLocation() async {
    Position currentPosition =
      await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: GoogleMap(
                onTap: (tapped) async {
                  final coordinated = new geo.Coordinates(tapped.latitude, tapped.longitude);
                  var _address = await geo.Geocoder.local.findAddressesFromCoordinates(
                      coordinated
                  );
                  var firstAddress = _address.first;
                  getmarkers(tapped.latitude, tapped.longitude);
                  await postsRef.document(widget.currentUser.id)
                      .collection('userPosts').document(ids).updateData({
                    'latitude': tapped.latitude,
                    'longitude': tapped.longitude,
                    'address': firstAddress.addressLine,
                    'country': firstAddress.countryCode,
                    'zip': firstAddress.postalCode,
                  });
                },
                mapType: MapType.hybrid,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    googleMapController = controller;
                  });
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        position.latitude.toDouble(), position.longitude.toDouble()), //current position dalana hai yha
                    zoom: 15),
                markers: Set<Marker>.of(markers.values),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}