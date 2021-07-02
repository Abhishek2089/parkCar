import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkster/Model/postdetails.dart';
import 'package:parkster/Model/user.dart';
import 'package:parkster/frontend/login.dart';
import 'package:parkster/hosting/Addparkingdetails.dart';

class ParkingDetails extends StatefulWidget {

  final User currentUser;

  ParkingDetails({this.currentUser});

  @override
  _ParkingDetailsState createState() => _ParkingDetailsState();
}

class _ParkingDetailsState extends State<ParkingDetails> {
  PostDetails postDetails;
  // GoogleMapController mapController;

  // final LatLng _center = const LatLng(45.521563, -122.677433);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }


  getPosts() async {
    // setState(() {
    //   isLoading = true;
    // });
    QuerySnapshot snapshot = await timlineRef.document("timeline").collection("userPosts").getDocuments();
    setState(() {
     final List postDetails = snapshot.documents;
    });
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(postDetails.mediaUrl);
      // print(doc.documentID);
      // print(doc.exists);
    });
    // setState(() {
    //   isLoading = false;
    //   posts = snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    // });
  }


  buildheader() {
    return FutureBuilder(
      future: timlineRef.document("timeline").collection("userPosts").document(ids).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } 
        PostDetails postDetails = PostDetails.fromDocument(snapshot.data);
         
        print(postDetails.mediaUrl);
        // Size size = MediaQuery.of(context).size;
        // return Stack(
        //         children: <Widget>[
        //           Image.network(postDetails.mediaUrl, fit: BoxFit.cover ,),
        //           Positioned(
        //             child: Icon(
        //               Icons.favorite_border,
        //               color: Colors.white,
        //             ),
        //             top: size.height / 5,
        //             left: size.width - 40.0,
        //           ),
        //           Positioned(
        //             child: Icon(
        //               Icons.comment,
        //               color: Colors.white,
        //             ),
        //             top: size.height / 4,
        //             left: size.width - 40.0,
        //           ),
        //         ],
        //       );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back)),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              child: buildheader()
            )),
            // Extruding edge from the sliver appbar, may need to fix expanded height
            expandedHeight: MediaQuery.of(context).size.height /3.8,
            backgroundColor: const Color(0xFFF8A19B),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Text(
                "Adorable Garden Blending Gingerbread House",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                              AssetImage('assets/images/rosius.jpeg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Entire House",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Hosted By",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Text(
                                        "Rosius",
                                        style:
                                            TextStyle(color: Color(0xFFFB7592)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "See Ratings",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "*****",
                                      style:
                                          TextStyle(color: Color(0xFFFB7592)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Color(0xFFFB7592),
                            ),
                            Text(
                              "San Francisco",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.group,
                        color: Color(0xFFFB7592),
                        size: 30.0,
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Color(0xFFFB7592),
                        size: 30.0,
                      ),
                      Icon(
                        Icons.cake,
                        color: Color(0xFFFB7592),
                        size: 30.0,
                      ),
                      Icon(
                        Icons.event_note,
                        color: Color(0xFFFB7592),
                        size: 30.0,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "About this Home",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "There are not many cities that have experience such social and political"
                                " extrmes in recent history as Amsterdam.In the 20th century alone, Amsterdam"
                                "faced the atrocities of war for the first tune in 400years, became radical...",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "Read More....",
                            style: TextStyle(color: Color(0xFFFB7592)),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "Check in: After 3pm",
                            style: TextStyle(color: Colors.black54,fontSize: 16.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0,right: 10.0),
                        child: Text(
                          "Check Out:11am",
                          style: TextStyle(color:Colors.black54,fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 400.0,
                  //   child: GoogleMap(
                  //     onMapCreated: _onMapCreated,
                  //     options: GoogleMapOptions(
                  //       cameraPosition: CameraPosition(
                  //         target: _center,
                  //         zoom: 11.0,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
        bottomNavigationBar:new Container(
          decoration: new BoxDecoration(
            //   shape: BoxShape.circle,
              gradient: new LinearGradient(colors: [
                const Color(0xFFFB7592),
                const Color(0xFFF8A19B),
              ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.9, 0.0),
                  stops: [0.0, 0.9],
                  tileMode: TileMode.clamp

              )
          ),
          child: new MaterialButton(
            onPressed: () {
              //  saveMoist();
            },

            child: new Padding(
              padding: const EdgeInsets.all(24.0),
              child:new Text("Book Now",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600)),
            ),
          ),
        )
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
// import 'package:parkster/Constantswidgets/Constants.dart';
// import 'package:parkster/Model/Property.dart';
// import 'package:parkster/Widgets/commentsWidget.dart';
// import 'package:parkster/frontend/payers.dart';

// class PropertyDetails extends StatefulWidget {
//   final Property _property;

//   PropertyDetails(this._property);
//   @override
//   _PropertyDetailsState createState() => _PropertyDetailsState();
// }

// class _PropertyDetailsState extends State<PropertyDetails> {
//   var _pageController=PageController();
//   var _currentIndex=0;
//   var _maxlines =3;
//   bool _liked=false;
//   @override
//   Widget build(BuildContext context) {
//     _pageController.addListener(() {
//       setState(() {
//         _currentIndex=_pageController.page.round();
//       });
//     });
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Stack(
//                 children: <Widget>[
//                   buildImageSlider(context),
//                   buildWidgetImageIndicator(context),
//                   buildCloseWidget(context),
//                   buildHeartWidget(context),
//                   buildContainerPrice(),
//                 ],
//               ),
//               buildDescreption(context),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(13,2,25,10),
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                         margin:EdgeInsets.only(right: 5),
//                         child: Icon(Icons.star,color: Constants.redAirbnb,size: 18,)),
//                     Container(
//                       margin:EdgeInsets.only(right: 5),
//                       child: Align(
//                         alignment: Alignment.topLeft,

//                         child:  Text("5,0",style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
//                       ),
//                     ) ,
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child:  Text("(25)",style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.w400,letterSpacing: 0.2),overflow: TextOverflow.ellipsis,),
//                     ) ,
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(13,2,25,10),
//                 child:
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child:  Text("sector3 Rohini",style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.w400,letterSpacing: 0.2),overflow: TextOverflow.ellipsis,),
//                 ) ,
//               ),
//               separateurHorizontal(),
//               Row(
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(25,2,25,0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text("Entire Space",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600,letterSpacing: 0.2),overflow: TextOverflow.ellipsis,),
//                         Text("Host : Rohan",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600,letterSpacing: 0.2),overflow: TextOverflow.ellipsis,),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                             image: AssetImage("assets/images/logo2.png"),
//                             fit: BoxFit.cover)
//                     ),
//                     height: 50,
//                     width: 50,
//                   ),
//                 ],
//               ),
//               separateurHorizontal(),
//               buildDescText(),
//               separateurHorizontal(),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(25,2,25,0),
//                   child: Text("equipments".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.2),overflow: TextOverflow.ellipsis,),
//                 ),
//               ),
//               buildEquipement(Commodite(false,true,false,false,true,false,false,false,true)),
//               separateurHorizontal(),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(13,2,25,5),
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                         margin:EdgeInsets.only(right: 5),
//                         child: Icon(Icons.star,color: Constants.redAirbnb,size: 25,)),
//                     Container(
//                       margin:EdgeInsets.only(right: 5),
//                       child: Align(
//                         alignment: Alignment.topLeft,

//                         child:  Text("4,38",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
//                       ),
//                     ) ,
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(13,0,25,10),
//                 child: Align(
//                   alignment: Alignment.topLeft,
//                   child:  Text("(45)",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.2),overflow: TextOverflow.ellipsis,),
//                 ),
//               ) ,
//               SizedBox(height: 25,),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(13,2,25,10),
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                               image: AssetImage("assets/images/profilePicture.png"),
//                               fit: BoxFit.cover)
//                       ),
//                       height: 45,
//                       width: 45,
//                     ),
//                     SizedBox(width: 15,),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text("Jatin",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500,letterSpacing: 0.2),overflow: TextOverflow.ellipsis,),
//                         Text("novembre 2019",style: TextStyle(color: Colors.black45,fontSize: 14,fontWeight: FontWeight.w500,letterSpacing: 0.2),overflow: TextOverflow.ellipsis,)
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               commentsWidget(),
//             ],
//           ),

//         ),
//       ),
//       bottomNavigationBar: Material(
//         elevation: 5,
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10)
//           ),
//           padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
//           margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
//           child: MaterialButton(
//               color:  Constants.greenAirbnb,
//               onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Payer()));
//               },
//               child: new Text("Verify your identity",style: TextStyle(color: Colors.white),)
//           ),
//         ),
//       ),
//     );
//   }



//   Column buildEquipement(Commodite commodite)
//   {
//     TextStyle bare= TextStyle(color:Colors.grey,decoration: TextDecoration.lineThrough);
//     TextStyle active= TextStyle(color:Colors.black);
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 25),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Wi-Fi",style: commodite.wifi? active: bare),
//               Icon(Icons.wifi,color: commodite.wifi?Constants.redAirbnb:Colors.grey,)
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 25),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Services",style: commodite.serviceDeChambre? active: bare),
//               Icon(Icons.local_laundry_service,color: commodite.serviceDeChambre?Constants.redAirbnb:Colors.grey,)
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 25),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("shade",style: commodite.piscine? active: bare),
//               Icon(Icons.pool,color: commodite.piscine?Constants.redAirbnb:Colors.grey,)
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 25),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("park",style: commodite.gym? active: bare),
//               Icon(Icons.fitness_center,color: commodite.gym?Constants.redAirbnb:Colors.grey,)
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 25),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("cover",style: commodite.repasInclus? active: bare),
//               Icon(Icons.room_service,color: commodite.repasInclus?Constants.redAirbnb:Colors.grey,)
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 25),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("kuch bhi ",style: commodite.enfantAutorise? active: bare),
//               Icon(Icons.child_care,color: commodite.enfantAutorise?Constants.redAirbnb:Colors.grey,)
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 25),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Parking",style: commodite.Parking? active: bare),
//               Icon(Icons.local_parking,color: commodite.Parking?Constants.redAirbnb:Colors.grey,)
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 25),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("lode",style: commodite.equipe? active: bare),
//               Icon(Icons.widgets,color: commodite.equipe?Constants.redAirbnb:Colors.grey,)
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//   Container separateurHorizontal() {
//     return Container(
//       margin: EdgeInsets.all(15),
//       width: 200,
//       height: 1,
//       color: Colors.black38,
//     );
//   }
//   Column buildDescText() {
//     int _maxLines1=3;
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.fromLTRB(18,5,25,10),
//           child:
//           Align(
//             alignment: Alignment.topLeft,
//             child:  Text("A modern  parking, in a quiet area, but very close to the busy street.\n-parquet floor/ central ",style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 0.2),overflow: TextOverflow.ellipsis,maxLines: _maxLines1,),
//           ) ,
//         ),
//         Padding(
//           padding: EdgeInsets.fromLTRB(18,10,25,10),
//           child: GestureDetector(
//             onTap: (){},
//             child: Row(
//               children: <Widget>[
//                 Text("yha bhi kuch dalna h",style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.w500,fontSize: 16),),
//                 Icon(Icons.arrow_right)
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }


//   Container buildImageSlider(BuildContext context) {
//     return Container(
//         height: 250,
//         child: PageView.builder(
//             controller: _pageController,
//             itemCount: widget._property.images.length,
//             itemBuilder: (
//                 context,index){
//               return Image.asset(widget._property.images[_currentIndex],fit: BoxFit.cover,);
//             }
//         )
//     );
//   }

//   Align buildWidgetImageIndicator(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 225),
//         child: SliderIndicator(
//           length: widget._property.images.length,
//           activeIndex: _currentIndex,
//           indicator: Icon(Icons.radio_button_unchecked,color: Colors.white,size: 10,),
//           activeIndicator: Icon(Icons.fiber_manual_record,color: Colors.white,size: 12,),
//         ),
//       ),
//     );
//   }

//   Align buildCloseWidget(BuildContext context) {
//     return Align(
//       alignment: Alignment.topLeft,

//       child: Container(
//         padding: EdgeInsets.all(0),
//         height: 45,
//         decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white
//         ),
//         margin: EdgeInsets.only(left: 13,top: 40),
//         child: IconButton(icon: Icon(Icons.arrow_back,size: 18,),
//           color: Colors.black,
//           onPressed: (){Navigator.of(context).pop();},
//         ),
//       ),
//     );
//   }

//   Widget buildContainerPrice() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         margin: EdgeInsets.only(left: 10,top: 10),
//         padding: EdgeInsets.symmetric(vertical: 6,horizontal:12 ),
//         decoration: BoxDecoration(
//           color: Colors.grey,
//           borderRadius: BorderRadius.all(Radius.circular(25)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Icon(Icons.attach_money,size: 16,color: Colors.white,),
//             Text("${widget._property.prix}",style: TextStyle(color: Colors.white),),
//             Text("/ nuit",style: TextStyle(color: Colors.white,fontSize: 16),),
//           ],
//         ),
//       ),
//     );
//   }
//   buildHeartWidget(BuildContext context) {


//     return Container(
//         margin: EdgeInsets.only(right: 13,top: 40),
//         alignment: Alignment.topRight,
//         child:GestureDetector(
//           child:Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               //  borderRadius: BorderRadius.circular(25)
//             ),
//             child: Icon(!_liked?Icons.favorite_border:Icons.favorite,color:!_liked? Colors.black:Constants.redAirbnb,size: 20,),
//           ),
//           onTap: (){
//             setState(() {
//               _liked=!_liked;
//             });
//           },
//         )
//     );
//   }

//   buildDescreption(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Text("Quiet, carefully designed & furnished.",style: TextStyle(fontSize: 20,color: Colors.black,),overflow: TextOverflow.ellipsis,maxLines: 2,),
//     );
//   }
// }
