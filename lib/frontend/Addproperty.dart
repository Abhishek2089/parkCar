import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkster/frontend/login.dart';
import 'package:parkster/hosting/Addparkingdetails.dart';
import 'login.dart';

class AddProperty extends StatefulWidget {
  final String currentUserId;

  AddProperty({ this.currentUserId});

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  List<dynamic> posts = [];
  bool isLoading = false;
  final String currentUserId = currentUser?.id;  


  @override
  void initState() {
    super.initState();
    getProfilePosts();
  }


  getProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postsRef.document(
      widget.currentUserId
    ).collection('userPosts')
    .getDocuments();
    setState(() {
      posts = snapshot.documents;
    });
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
      print(doc.documentID);
      print(doc.exists);
    });
    setState(() {
      isLoading = false;
    });
  }

  //   buildPosts() {
  //   return FutureBuilder(
  //     future: postsRef.document(widget.currentUserId).get(),
  //     builder: (context, snapshot) {
  //       if(!snapshot.hasData) {
  //         return CircularProgressIndicator();
  //       }
  //       //User user = User.fromDocument(snapshot.data);
  //       final List<Widget> posts = snapshot.data.documents.map((doc) => Scaffold(
  //           backgroundColor: Colors.white,
  //           body: Material(
  //             elevation: 3,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 // CircleAvatar(
  //                 //   backgroundImage: NetworkImage(doc['mediaUrl']),
  //                 //   backgroundColor: Colors.grey,
  //                 // ),
  //                 // SizedBox(width: 10,),
  //                 Container(
  //                   height:80,
  //                   width: MediaQuery.of(context).size.width/2,
  //                   child: Text(doc['district'],style: TextStyle(fontSize:15,fontWeight: FontWeight.w300),maxLines: 5,textAlign: TextAlign.center,)),
  //                     Container(
  //                       padding:EdgeInsets.all(8),
  //                       margin: EdgeInsets.only(left: 8),
  //                       height: 80,
  //                       child: Image.network(doc['mediaUrl'], fit: BoxFit.scaleDown,)),
  //                       SizedBox(height: 10)
  //             ],
  //           ),
  //         ),
  //       ));
  // //       return ListView(
  //         shrinkWrap: true,
  //         primary: false,
  //         children: posts,
  //       );
  //     },
  //   );
  // }

  buildPostPics() {
    return FutureBuilder<QuerySnapshot>(
      future: postsRef.document(widget.currentUserId).collection('userPosts').getDocuments(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        // User user = User.fromDocument(snapshot.data.documents.);
        final List postName = snapshot.data.documents.map((doc) => 
             Material(
              elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 20,),
                  CircleAvatar(
                    backgroundImage: NetworkImage(doc['mediaUrl']),
                    backgroundColor: Colors.grey,
                    radius: 30,
                  ),
                  Expanded(
                    child: Container(
                      height:80,
                      width: MediaQuery.of(context).size.width/2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Text(
                              doc['ad-name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                                maxLines: 5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                doc['region'],
                                style: TextStyle(
                                fontSize:15,
                                fontWeight: FontWeight.w400),
                                maxLines: 5,
                                textAlign: TextAlign.center,
                              )
                            ]
                        ), 
                    ),
                  ),
              ],
            ),
          ),
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
          //             child: const Text('Edit'),
          //           ),
          //           FlatButton(
          //             textColor: const Color(0xFF6200EE),
          //             onPressed: () {
          //               // Perform some action
          //             },
          //             child: Text('Delete'),
          //           ),
          //         ],
          //       ),
          //       Image.network(doc['mediaUrl'],)
          //       //Image.asset('assets/card-sample-image-2.jpg'),
          //     ],
          //   ),
          // ),
        ).toList(); 
        return Container(
          child: ListView(
            shrinkWrap: true,
            children: postName,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.white,
          child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: 
              ListView( 
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [ 
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical:15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 35,),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Emplacement(currentUser: currentUser,)),
                        );
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(icon:Icon(Icons.add,color: Colors.black87,),iconSize: 30,onPressed: null,),),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.popUntil(
                        context,
                        ModalRoute.withName('/'),
                      ),
                    )),
                    Text("2 Announcements",style: TextStyle(color:Colors.black87,fontSize: 22,fontWeight: FontWeight.bold),),
                    Text("In Progress",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    buildPostPics(),
                    SizedBox(height: 20,),  
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Emplacement(currentUser: currentUser,)),
                        );
                      },
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.add,color: Colors.red,size: 25,),
                            SizedBox(width: 15,),                     
                            Text("Add Your Own Parking space",style: TextStyle(fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
            ),
          ]),
        )
    ));
  }
}
