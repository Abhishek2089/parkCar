// import 'package:flutter/material.dart';
// import 'package:parkster/frontend/login.dart';

// import 'Addparkingdetails.dart';

// class CategorieType extends StatefulWidget {
//   @override
//   _CategorieTypeState createState() => _CategorieTypeState();
// }

// class _CategorieTypeState extends State<CategorieType> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical:25,horizontal: 15 ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//              IconButton(
//                icon: Icon(Icons.arrow_back,color: Colors.black87,size: 23,),
//              onPressed: (){
//                Navigator.pop(context);
//              },),
//               SizedBox(height: 30,),
//               Text("Tell us about your accommodation",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),maxLines: 2,textAlign: TextAlign.center,),
//               SizedBox(height: 30,),
//               InkWell(
//                 onTap: (){
//                   _buildCategory();
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding:  EdgeInsets.fromLTRB(10,8,10,0),
//                       child: Text("Choose a category of parking",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
//                     ),
//                     Padding(
//                       padding:  EdgeInsets.fromLTRB(10,12,10,3),
//                       child: Text("Select one o the options",style: TextStyle(color:Colors.grey,fontSize: 13,fontWeight: FontWeight.w300),),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 15,),
//               Center(
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20),
//                   alignment: Alignment.center,
//                   height: 1,
//                   color: Colors.grey,
//                 ),
//               ),
//               SizedBox(height: 20,),
//               InkWell(
//                 onTap: (){
//                   SousCategorieDialog();
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding:  EdgeInsets.fromLTRB(10,8,10,0),
//                       child: Text("Choose the Time of parking",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
//                     ),
//                     Padding(
//                       padding:  EdgeInsets.fromLTRB(10,12,10,3),
//                       child: Text("Select one option",style: TextStyle(color:Colors.grey,fontSize: 13,fontWeight: FontWeight.w300),),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 15,),
//               Center(
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20),
//                   alignment: Alignment.center,
//                   height: 1,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: MaterialButton(
//         onPressed: (){
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Emplacement(currentUser: currentUser,)),
//           );
//         },
//         elevation: 3,
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: Colors.red,
//           ),
//             child: Text("Submit",style: TextStyle(color: Colors.white),)),
//       ),
//     );
//   }

//   Widget _buildCategory() {
//     return DropDownFormField(
//       titleText: 'Select Category of Work',
//       hintText: _category,
//       onSaved: (value) {
//         _category = value;
//       },
//       onChanged: (value) {
//         setState(() {
//           _category = value;
//         });
//       },
//       dataSource: [
//         {"display": "Painter", "value": "Painter"},
//         {"display": "Labour", "value": "Labour"},
//         {"display": "Mistri", "value": "Mistri"},
//         {"display": "Electrician", "value": "Electrician"},
//         {"display": "Carpenter", "value": "Carpenter"},
//         {"display": "Others", "value": "Others"},
//       ],
//       textField: 'display',
//       valueField: 'value',
//     );
//   }

//   Future<void> SousCategorieDialog() async {
//     switch (await showDialog<String>(
//         context: context,
//         builder: (BuildContext context) {
//           return SimpleDialog(
//             children: <Widget>[
//               SimpleDialogOption(
//                 onPressed: () { Navigator.pop(context, "Whole Day"); },
//                 child: const Text('Whole Day'),
//               ),
//               SimpleDialogOption(
//                 onPressed: () { Navigator.pop(context, "Hour by Hour"); },
//                 child: const Text('Hour by Hour'),
//               ),
//             ],
//           );
//         }
//     )) {
//       case "Homme":
//       // Let's go.
//       // ...
//         break;
//       case "Femme":
//       // ...
//         break;
//     }
//   }
// }
