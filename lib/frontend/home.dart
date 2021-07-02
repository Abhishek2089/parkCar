import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkster/Model/category.dart';
import 'package:parkster/Model/user.dart';
import 'package:parkster/Widgets/wavyHeader.dart';
import 'package:parkster/frontend/login.dart';
import 'search.dart';


class HomeScreen extends StatefulWidget {
  final User currentUser;

  HomeScreen({this.currentUser});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List posts = [];



 Widget _buildPopularList(context,index, List<Popular>listImages) {
    return
      Container(
        width: 200.0,
        padding: const EdgeInsets.only(left:10.0,top: 10.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  listImages[index].image,
                  width: 220.0,
                  height: 100.0,
                  fit: BoxFit.cover,)),
            Text(listImages[index].name,style: TextStyle(color: Colors.grey),),
            Text(listImages[index].desc,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
            Text(listImages[index].price,style: TextStyle(fontSize: 12.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.star,color: Colors.red,size: 15.0,),
                Icon(Icons.star,color: Colors.red,size: 15.0,),
                Icon(Icons.star,color: Colors.red,size: 15.0,),
                Icon(Icons.star,color: Colors.red,size: 15.0,),
                Icon(Icons.star,color: Colors.red,size: 15.0,),

                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text(listImages[index].rating),
                ),
              ],
            )
          ],
        ),
      );
  }

  buildPosts() {
    return FutureBuilder<QuerySnapshot>(
      future: timlineRef.document("timeline").collection('userPosts').getDocuments(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
      final List postName = snapshot.data.documents.map((doc) => 
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
                  width: 220.0,
                  height: 100.0,
                  fit: BoxFit.cover,)),
            Text(doc['category'],style: TextStyle(color: Colors.grey),),
            Text(doc['ad-name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
            Text(doc['price'],style: TextStyle(fontSize: 12.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.star,color: Colors.red,size: 15.0,),
                Icon(Icons.star,color: Colors.red,size: 15.0,),
                Icon(Icons.star,color: Colors.red,size: 15.0,),
                Icon(Icons.star,color: Colors.red,size: 15.0,),
                Icon(Icons.star,color: Colors.red,size: 15.0,),
              ],
            )
          ],
        ),
      )).toList(); 
        return Container(
              padding: EdgeInsets.only(left: 10.0),
              height: 220.0,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: postName,
            ),
          );
      },
    );
  }

  Widget _buildFruitCategoryList(context,index, List<FruitsCategory>listImages) {
    return
      Padding(
        padding: const EdgeInsets.only(left:10.0,top: 10.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  listImages[index].image,
                  width: 180.0,
                  height: 90.0,
                  fit: BoxFit.cover,)),
            Text(listImages[index].name)
          ],
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                WavyHeader(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: new BoxDecoration(
                      color: Color(0xFFFCFCFC).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                      },
                      child: Row(
                        children: [
                          Expanded(child: Text('Try  "New Delhi', style: TextStyle(color: Color(0xFFFCFCFC)))),
                          IconButton(icon: Icon(Icons.search), onPressed: () {},
                          color: Color(0xFFFCFCFC), iconSize: 30.0,)
                        ],
                      ),
                    ),
                  ),),
                  
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 40, left: 10),
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: Image.asset('assets/images/name.png', height: 40, color: Colors.white,),
                //   ),
                // ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Categories", style: TextStyle(fontSize: 30, color: Colors.black54,fontWeight: FontWeight.bold),),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              height: 120.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return _buildFruitCategoryList(context,index,fruitsCategoryList.fruitsCategory);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 10.0,),
              child: Text("Most Popular",style: TextStyle(fontSize: 30.0,color: Colors.black54,fontWeight: FontWeight.bold),),
            ),
            buildPosts(),
          ],
        ),
      ),
    );
  }
}


       




// class HomeScreen extends StatefulWidget {

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
//   }

//   class _HomeScreenState extends State<HomeScreen> {
//     final controller = PageController(
//       initialPage: 1,
//     );

//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         body:  SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 50,),
//                   InkWell(
//                    borderRadius: BorderRadius.circular(20),
//                     onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => SearchScreen()),
//                      );
//                    },
//                     splashColor: Colors.white,
//                     hoverColor: Constants.greenAirbnb,
//                      child: Container(
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(20),
//                          border: Border.all(color: Colors.black87),),
//                        child: Padding(
//                          padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//                          child: Stack(
//                            children: [
//                             WavyHeader(), 
//                            ],
//                          ),






//                         //     child: Row(
//                         //      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         //      children: <Widget>[
//                         //        Align(
//                         //          child: Icon(Icons.search),
//                         //          alignment: Alignment.topLeft,),
//                         //        Center(
//                         //          child: Text("Search, Parking space",style:TextStyle(fontSize: 13,color: Colors.black54),
                                     
//                         //             ),
//                         //       ),
//                         //   ],
//                         // ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 80,),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Stack(
//                       children: <Widget>[
//                         Container(
//                           decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                             ),
//                            child: Image.asset("assets/images/landing_page_img.png",fit: BoxFit.scaleDown,),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             SizedBox(height: 20,),
//                             Center(child: Text("Explore",style:TextStyle(fontSize: 25,fontWeight:FontWeight.bold,color: Colors.white))),
//                             Center(child: Text("I agree",style:TextStyle(fontSize: 20,color: Colors.white))),
//                           ],
//                         ),
//                         Positioned(
//                           top: 0,
//                           bottom: 0,
//                           left: 0,
//                           right: 0,

//                           child: MaterialButton(
//                             onPressed: (){
//                             /*  Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => Photo()),
//                               );*/
//                             },
//                             elevation: 3,
//                             child: Container(
//                                 padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
//                                 margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Colors.white,
//                                 ),
//                                 child: Text("Explore",style: TextStyle(color: Colors.red),)),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.black,
//                     height: 400,
//                     child: Column(
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Align(
//                               alignment: Alignment.topLeft,
//                               child: Text("Parkster",style: TextStyle(color:Color(0xfff35e0b)),)),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 10,right: 10,left: 10),
//                           child: Text("Park your vehicle before time..",style: TextStyle(fontSize: 13,color:Color(0xffd3d3d3)),),
//                         ),
//                         Expanded(
//                           child: Container(
//                             color: Colors.white,
//                             child: PageView(
//                               scrollDirection: Axis.horizontal,
//                               controller: controller,
//                               children: <Widget>[
//                                 buildScrollActivities("the best vacation", "assets/images/3.jpg"),
//                                 buildScrollActivities("the best vacation", "assets/images/4.jpg"),
//                                 buildScrollActivities("the best vacation", "assets/images/1.jpg"),
//                                 buildScrollActivities("the best vacation", "assets/images/2.jpg"),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//         ),
//       );
//     }
//     Padding buildScrollActivities(String text,String imgUri){
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Column(
//           children: <Widget>[
//             Container(
//               color: Colors.white,
//               height: 250,
//                 width: 350,
//                 child: Image.asset(imgUri,fit: BoxFit.fill,)
//             ),
//             Container(
//               width: double.infinity,
//               color: Colors.black,
//                 child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
//           ],
//         ),
//       );
//     }
//   }