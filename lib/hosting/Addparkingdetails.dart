// import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:parkster/Model/user.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:parkster/frontend/login.dart';
import 'package:uuid/uuid.dart';
import 'Addphotos.dart';
// import 'package:google_maps_webservice/places.dart';

String ids;
// const kGoogleApiKey = "AIzaSyDHpVko_EqCnzi9zDjOMLppizREwYH-BwY";
// GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class Emplacement extends StatefulWidget {
  final User currentUser;
  Emplacement({
    this.currentUser,
  });

  @override
  _EmplacementState createState() => _EmplacementState();
}

class _EmplacementState extends State<Emplacement> {
  bool isSave = false;
  String postId = Uuid().v4();
  String _category = "others";
  // List locations = [];
  //  String lat = "";
  //  String lng = "";
  // GoogleMapController googleMapController;
  // Position position;
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  TextEditingController regionController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController zipController = TextEditingController();


  Future<void> addParkinginTimeline({
    String mediaUrl,
    String region,
    String district,
    String address,
    String mobile,
    String zip,
    String price,
    String adname,
    String category,
    String country,
    String latitude,
    String longitude,
  }) async {
    timlineRef
        .document("timeline")
        .collection("userPosts")
        .document(ids = postId)
        .setData({
      "postId": postId,
      "ownerId": widget.currentUser.id,
      "mediaUrl": mediaUrl,
      "ad-name": adname,
      "category": _category,
      "username": widget.currentUser.username,
      "region": region,
      "district": district,
      "mobile no.": mobile,
      "price": price,
      "address": address,
      "zip-code": zip,
      "country": country,
      "longitude": longitude,
      "latitude": latitude,
      //  "location": locations,
    });
  }


  Future<void> addParking({
    String mediaUrl,
    String region,
    String district,
    String address,
    String mobile,
    String zip,
    String price,
    String adname,
    String category,
    String country,
    String latitude,
    String longitude,
  }) async {
    postsRef
        .document(widget.currentUser.id)
        .collection("userPosts")
        .document(ids = postId)
        .setData({
      "postId": postId,
      "ownerId": widget.currentUser.id,
      "mediaUrl": mediaUrl,
      "ad-name": adname,
      "category": _category,
      "username": widget.currentUser.username,
      "region": region,
      "district": district,
      "mobile no.": mobile,
      "price": price,
      "address": address,
      "zip-code": zip,
      "country": country,
      "longitude": longitude,
      "latitude": latitude,
      //  "location": locations,
    });
  }

  handleSubmitLocation() async {
    setState(() {
      isSave = true;
    });
    // await getCoordinate();
    //String mediaUrl = await uploadImage(file);
    addParking(
      mediaUrl: null,
      category: _category,
      region: regionController.text,
      district: districtController.text,
      address: addressController.text,
      mobile: mobileController.text,
      zip: zipController.text,
      price: priceController.text,
      country: null,
      latitude: null,
      longitude: null,
      //locations: locations
    );
    addParkinginTimeline(
      mediaUrl: null,
      category: _category,
      region: regionController.text,
      district: districtController.text,
      address: addressController.text,
      mobile: mobileController.text,
      zip: zipController.text,
      price: priceController.text,
      country: null,
      latitude: null,
      longitude: null,
      //locations: locations
    );
    regionController.clear();
    districtController.clear();
    addressController.clear();
    mobileController.clear();
    zipController.clear();
    priceController.clear();
    setState(() {
      isSave = false;
      postId = Uuid().v4();
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddPhoto(
              currentUser: currentUser,
        )
      )
    );
  }

  

  Widget _buildCategory() {
    return DropDownFormField(
      titleText: 'Select Category of Work',
      hintText: _category,
      onSaved: (value) {
        _category = value;
      },
      onChanged: (value) {
        setState(() {
          _category = value;
        });
      },
      dataSource: [
        {"display": "Garage", "value": "Garage"},
        {"display": "Government Parking", "value": "Government Parking"},
        {"display": "Private space", "value": "Private space"},
        {"display": "Others", "value": "Others"},
      ],
      textField: 'display',
      valueField: 'value',
    );
  }


  Scaffold buildFormForParking() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                  size: 23,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Where is your Parking located?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "This is the position that users see",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: MaterialButton(
                  elevation: 5,
                  onPressed: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black87),
                    ),
                    child: Center(
                        child: Text(
                      "Current Location",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildCategory(),
                    SizedBox(height: 10),
                    Text(
                      "Region/State",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      controller: regionController,
                      decoration:
                          InputDecoration(labelText: 'Enter your region'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "District",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      controller: districtController,
                      decoration: InputDecoration(
                          //labelText: 'Enter your District',
                          hintText: "enter_you_house_number",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal)),
                      // onTap: () async {
                      //   Prediction p = await PlacesAutocomplete.show(
                      //     context: context,
                      //     apiKey: kGoogleApiKey,
                      //     mode: Mode.overlay,
                      //     language: "en",
                      //     components: [
                      //       new Component(
                      //         Component.country, "en"
                      //       )
                      //     ]
                      //   );
                      //   displayPrediction(p);
                      // },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Address",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      controller: addressController,
                      decoration:
                          InputDecoration(labelText: 'Enter Your Address'),
                      // onTap: () {
                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleLocation(currentUser: currentUser,)));
                      // },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Price per hour",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      controller: priceController,
                      decoration: InputDecoration(labelText: 'Price per hour'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Mobile Number",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      controller: mobileController,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Mobile Number',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    //separateurHorizontal(),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "postal code",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      controller: zipController,
                      decoration:
                          InputDecoration(labelText: 'Enter Your Zip Code'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MaterialButton(
        onPressed: handleSubmitLocation,
        elevation: 3,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.red,
            ),
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  // Future<Null> displayPrediction(Prediction p) async {
  //   if (p != null) {
  //     PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

  //     final lat = detail.result.geometry.location.lat;
  //     final lng = detail.result.geometry.location.lng;

  //     var address  =detail.result.formattedAddress;

  //     print(lat);
  //     print(lng);
  //     print(address);

  //     setState(() {
  //       districtController.text = address;
  //     });
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return buildFormForParking();
  }
}
