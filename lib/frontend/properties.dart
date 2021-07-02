import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkster/Constantswidgets/Constants.dart';
import 'package:parkster/Model/user.dart';
import 'package:parkster/frontend/propertiesdetatils.dart';

import 'login.dart';


class Properties extends StatefulWidget {
  final User currentUser;

  Properties({this.currentUser});
  @override
  _PropertiesState createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  bool isLoading = false;
  List posts = [];
  var _pageController=PageController();
  var _currentIndex=0;



  // Align buildWidgetImageIndicator(BuildContext context, int currentindex) {
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Padding(
  //       padding: EdgeInsets.all(10.0),
  //       child: SliderIndicator(
  //           length: property.images.length,
  //           activeIndex: currentindex,
  //           indicator:Padding( padding:EdgeInsets.all(3),child:Icon(Icons.fiber_manual_record,color: Colors.white70,size: 10,)),
  //           activeIndicator: Padding(padding:EdgeInsets.all(3),child:Icon(Icons.fiber_manual_record,color: Colors.white,size: 14,),)
  //       ),
  //     ),
  //   );
  // }

  // Container buildImageSlider(BuildContext context,PageController p,int index,) {
  //   return Container(
  //     // margin: EdgeInsets.all(20),
  //       child: PageView.builder(
  //           controller: p..addListener(() {
  //             setState(() {
  //               index=p.page.round();
  //             });
  //           }),
  //           //itemCount: property.images.length,
  //           itemBuilder: (
  //               context,index){
  //             return ClipRRect(
  //                 child:Image.network(doc["mediaUrl"],fit: BoxFit.cover,));
  //           }
  //       )
  //   );
  // }

  buildPosts() {
    return FutureBuilder<QuerySnapshot>(
      future: timlineRef.document("timeline").collection('userPosts').getDocuments(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
      final List postName = snapshot.data.documents.map((doc) => 
      Padding(
      padding: EdgeInsets.only(bottom: 5),
      child:  InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ParkingDetails(currentUser: currentUser,)));
        },
        child:Column(
          children: <Widget>[
            Container(
        width: 200.0,
        padding: const EdgeInsets.only(left:10.0,top: 10.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  doc['mediaUrl'],
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: 200.0,
                  fit: BoxFit.cover,)),
          ],
        ),
      ),
      SizedBox(height: 10),
      Padding(
              padding: const EdgeInsets.fromLTRB( 35,0,35, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child:  Text(doc['region'],style: TextStyle(color: Colors.grey),),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:  Text(doc['ad-name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:  Text(doc['price'],style: TextStyle(fontSize: 12.0)),
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     Icon(Icons.star,color: Constants.greenAirbnb,size: 12,),
                      //     Align(
                      //       alignment: Alignment.topLeft,
                      //       child:  Text("5,0",style: TextStyle(color: Colors.black87,fontSize: 13,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
                      //     ) ,
                      //     Align(
                      //       alignment: Alignment.topLeft,
                      //       child:  Text("(25)",style: TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
                      //     ) ,
                      //   ],
                      // ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Constants.greenAirbnb
                    ),
                    child: InkWell(
                      child: Text("Book now",style: TextStyle(color: Colors.white),),
                      onTap: (){
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Payer()),
                        // );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ), ),
      )
          // Card(
          //   clipBehavior: Clip.antiAlias,
          //   child: Column(
          //     children: [
          //       ListTile(
          //         leading: Icon(Icons.arrow_drop_down_circle),
          //         title:  Text(doc['ad-name']),
          //         subtitle: Text(
          //           doc['district'],
          //           style: TextStyle(color: Colors.black.withOpacity(0.6)),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Text(
          //           'This is a fresh clean Parking available in Delhi',
          //           style: TextStyle(color: Colors.black.withOpacity(0.6)),
          //         ),
          //       ),
          //       ButtonBar(
          //         alignment: MainAxisAlignment.start,
          //         children: [
          //           FlatButton(
          //             textColor: const Color(0xFF6200EE),
          //             onPressed: () {
          //               // Perform some action
          //             },
          //             child: const Text('Book Now'),
          //           ),
          //           FlatButton(
          //             textColor: const Color(0xFF6200EE),
          //             onPressed: () {
          //               // Perform some action
          //             },
          //             child: Text('Add To Favourites'),
          //           ),
          //         ],
          //       ),
          //       Image.network(doc['mediaUrl'])
          //       //Image.asset('assets/card-sample-image-2.jpg'),
          //     ],
          //   ),
          // ),
        ).toList(); 
        return Container(
          child: ListView(
            shrinkWrap: true,
            children: postName,
          )
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return buildPosts();
  }
}

// class Properties extends StatefulWidget {

//   @override
//   _PropertiesState createState() => _PropertiesState();
// }

// class _PropertiesState extends State<Properties> {
  // var _pageController=PageController();
  // var _currentIndex=0;

  // var _liked=false;


//   @override
//   Widget build(BuildContext context) {
//     _pageController.addListener(() {
//       setState(() {
//         _currentIndex=_pageController.page.round();
//       });
//     });

//     List<Widget> properties = [

//      new ImageProperty(true, Constants.properties[1]),
//      new ImageProperty(false, Constants.properties[0]),
//      //_buildPadding(),
//     ];
//     return Scaffold(

//       body: SafeArea(
//         child: ListView(
//           scrollDirection: Axis.vertical,
//           children: <Widget>[
//             for(Widget prop in properties)
//               prop,

//           ],
//         ),
//       ),
//     );

//   }
  // Container buildImageSlider(BuildContext context,PageController p,int index,Property property) {
  //   return Container(
  //     // margin: EdgeInsets.all(20),
  //       child: PageView.builder(
  //           controller: p..addListener(() {
  //             setState(() {
  //               index=p.page.round();
  //             });
  //           }),
  //           itemCount: property.images.length,
  //           itemBuilder: (
  //               context,index){
  //             return ClipRRect(
  //                 child:Image.asset(property.images[index],fit: BoxFit.cover,));
  //           }
  //       )
  //   );
  // }

  // Align buildWidgetImageIndicator(BuildContext context,Property property, int currentindex) {
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Padding(
  //       padding: EdgeInsets.all(10.0),
  //       child: SliderIndicator(
  //           length: property.images.length,
  //           activeIndex: currentindex,
  //           indicator:Padding( padding:EdgeInsets.all(3),child:Icon(Icons.fiber_manual_record,color: Colors.white70,size: 10,)),
  //           activeIndicator: Padding(padding:EdgeInsets.all(3),child:Icon(Icons.fiber_manual_record,color: Colors.white,size: 14,),)
  //       ),
  //     ),
  //   );
  // }

//   buildHeartWidget(BuildContext context) {

//     return Container(
//         margin: EdgeInsets.all(10),
//         alignment: Alignment.topRight,
//         child:GestureDetector(
//           child:Container(
//             padding: EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               //  borderRadius: BorderRadius.circular(25)
//             ),
//             child: Icon(!_liked?Icons.favorite_border:Icons.favorite,color:!_liked? Colors.black:Constants.redAirbnb,size: 25,),
//           ),
//           onTap: (){
//             setState(() {
//               _liked=!_liked;
//             });
//           },
//         )
//     );
//   }

//   _buildPadding(Property property) {
    // return   Padding(
    //   padding: EdgeInsets.only(bottom: 5),
    //   child:   InkWell(
    //     onTap: (){
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => PropertyDetails(property)),
    //       );
    //     },
    //     child:Column(
    //       children: <Widget>[
    //         Container(
    //           margin: EdgeInsets.fromLTRB(0,0,0,15),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(3),

    //           ),
    //           height: 200,
    //           child: Stack(
    //             children: <Widget>[
    //               buildImageSlider(context,PageController(),_currentIndex,property),
    //               buildWidgetImageIndicator(context,Constants.properties[1],_currentIndex),
    //               buildHeartWidget(context),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.fromLTRB( 35,0,35, 20),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Column(
    //                 children: [
    //                   Align(
    //                     alignment: Alignment.topLeft,
    //                     child:  Text("ORAN",style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
    //                   ),
    //                   Align(
    //                     alignment: Alignment.topLeft,
    //                     child:  Text("Maison entière",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
    //                   ),
    //                   Align(
    //                     alignment: Alignment.topLeft,
    //                     child:  Text("EL-BEY",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
    //                   ),
    //                   Align(
    //                     alignment: Alignment.topLeft,
    //                     child:  Text("4200 DZD/nuit",style: TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.w400),),
    //                   ),
    //                   Row(
    //                     children: <Widget>[
    //                       Icon(Icons.star,color: Constants.greenAirbnb,size: 12,),
    //                       Align(
    //                         alignment: Alignment.topLeft,
    //                         child:  Text("5,0",style: TextStyle(color: Colors.black87,fontSize: 13,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
    //                       ) ,
    //                       Align(
    //                         alignment: Alignment.topLeft,
    //                         child:  Text("(25)",style: TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
    //                       ) ,
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               Container(
    //                 padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(20),
    //                     color: Constants.greenAirbnb
    //                 ),
    //                 child: InkWell(
    //                   child: Text("Book now",style: TextStyle(color: Colors.white),),
    //                   onTap: (){
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(builder: (context) => Payer()),
    //                     );
    //                   },
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),


    //       ],
    //     ), ),
//     // );
//   }

// }