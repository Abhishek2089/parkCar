// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:parkster/Model/user.dart';
// import 'package:parkster/frontend/login.dart';

// class Post extends StatefulWidget {
//   final String postId;
//   final String ownerId;
//   final String username;
//   final String district;
//   final String description;
//   final String mediaUrl;

//   Post({
//     this.postId,
//     this.ownerId,
//     this.username,
//     this.district,
//     this.description,
//     this.mediaUrl,
// });

// factory Post.fromDocument(DocumentSnapshot doc) {
//   return Post(
//     postId: doc['postId'],
//     ownerId: doc['ownerId'],
//     username: doc['username'],
//     district: doc['district'],
//     description: doc['description'],
//     mediaUrl: doc['mediaUrl'],
//   );
// }

//   @override
//   _PostState createState() => _PostState(
//     postId: this.postId,
//     ownerId: this.ownerId,
//     username: this.username,
//     district: this.district,
//     description: this.description,
//     mediaUrl: this.mediaUrl,
//   );
// }

// class _PostState extends State<Post> {

//   final String currentUserId = currentUser?.id;
//   final String postId;
//   final String ownerId;
//   final String username;
//   final String district;
//   final String description;
//   final String mediaUrl;
//   bool showHeart = false;

//   _PostState({
//     this.postId,
//     this.ownerId,
//     this.username,
//     this.district,
//     this.description,
//     this.mediaUrl,
//   });

//       buildPosts() {
//     return FutureBuilder(
//       future: usersRef.document(ownerId).get(),
//       builder: (context, snapshot) {
//         if(!snapshot.hasData) {
//           return CircularProgressIndicator();
//         }
//         User user = User.fromDocument(snapshot.data);
//         return Scaffold(
//             backgroundColor: Colors.white,
//             body: Material(
//               elevation: 3,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   CircleAvatar(
//                     backgroundImage: NetworkImage(user.photoUrl),
//                     backgroundColor: Colors.grey,
//                   ),
//                   SizedBox(width: 10,),
//                   Container(
//                     height:80,
//                     width: MediaQuery.of(context).size.width/2,
//                     child: Text(district,style: TextStyle(fontSize:15,fontWeight: FontWeight.w300),maxLines: 5,textAlign: TextAlign.center,)),
//                       Container(
//                         padding:EdgeInsets.all(8),
//                         margin: EdgeInsets.only(left: 8),
//                         height: 80,
//                         child: Image.network(mediaUrl, fit: BoxFit.scaleDown,)),
//                         SizedBox(height: 10)
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // buildPosts() {
//   //   return FutureBuilder(
//   //     future: usersRef.document(ownerId).get(),
//   //     builder: (context, snapshot) {
//   //       if(!snapshot.hasData) {
//   //         return CircularProgressIndicator();
//   //       }
//   //       User user = User.fromDocument(snapshot.data);
//   //       return Scaffold(
//   //           backgroundColor: Colors.white,
//   //           body: Material(
//   //             elevation: 3,
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //               children: <Widget>[
//   //                 CircleAvatar(
//   //                   backgroundImage: NetworkImage(user.photoUrl),
//   //                   backgroundColor: Colors.grey,
//   //                 ),
//   //                 SizedBox(width: 10,),
//   //                 Container(
//   //                   height:80,
//   //                   width: MediaQuery.of(context).size.width/2,
//   //                   child: Text(district, style: TextStyle(fontSize:15,fontWeight: FontWeight.w300),maxLines: 5,textAlign: TextAlign.center,)),
//   //                   buildPostImage(),
//   //                   SizedBox(height: 10)
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   // buildPostImage() {
//   //   return FutureBuilder(
//   //     future: postsRef.document(ownerId).get(),
//   //     builder: (context, snapshot) {
//   //       if(!snapshot.hasData) {
//   //         return CircularProgressIndicator();
//   //       }
//   //       return Container(
//   //         padding:EdgeInsets.all(8),
//   //         margin: EdgeInsets.only(left: 8),
//   //         height: 80,
//   //         child: Image.network(mediaUrl, fit: BoxFit.scaleDown,)
//   //       );
//   //     },
//   //   );
//   // }


//   @override
//   Widget build(BuildContext context) {
//     return 
//         buildPosts();
//   }
// }