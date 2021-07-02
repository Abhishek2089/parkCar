import 'package:flutter/material.dart';
import 'package:parkster/Model/user.dart';
import 'package:parkster/frontend/Addproperty.dart';
import 'package:parkster/frontend/login.dart';
import 'package:parkster/hosting/Addparkingdetails.dart';
import 'package:uuid/uuid.dart';

class Nom extends StatefulWidget {
  final User currentUser;

  Nom({ this.currentUser, });

  @override
  _NomState createState() => _NomState();
}

class _NomState extends State<Nom> {
  
  String postId = Uuid().v4();

  bool isNameSave = false;
  TextEditingController adNameController = TextEditingController();

  createPostNameInFirestore({ String mediaUrl, String adname}) {
    postsRef
       .document(widget.currentUser.id)
       .collection("userPosts")
       .document(ids)
       .updateData({
         "ownerId": widget.currentUser.id,
         "username": widget.currentUser.username,
         "ad-name": adname,
    });
  }

  createPostNameInFirestoreTimeline({ String mediaUrl, String adname}) {
    timlineRef
       .document("timeline")
       .collection("userPosts")
       .document(ids)
       .updateData({
         "ownerId": widget.currentUser.id,
         "username": widget.currentUser.username,
         "ad-name": adname,
    });
  }

  // Future<void> upDateAdname({String adname}) async {
  //   await postsRef
  //   .document(widget.currentUser.id)
  //   .collection('userPosts')
  //   .document(ids).updateData({
  //        "ownerId": widget.currentUser.id,
  //        "username": widget.currentUser.username,
  //        "ad-name": adname,
  //   });
  // }

  // Future<void> upDateAdname({DocumentSnapshot doc, String adname, String postId}) async   {
  //   QuerySnapshot postsfeedsnapshot = await postsRef
  //   .document(widget.currentUser.id)
  //   .collection('userPosts')
  //   .where('postId', isEqualTo: postId)
  //   .getDocuments();
  //   postsfeedsnapshot.documents.forEach((doc) {
  //     if(doc.exists){
  //       doc.reference.updateData({
  //     "ownerId": widget.currentUser.id,
  //     "username": widget.currentUser.username,
  //     "ad-name": adname,
  //     });
  //     }
  //   });
  // }

  handleSaveAdName() {
    setState(() {
      isNameSave = true;
    });
    createPostNameInFirestore(
      adname: adNameController.text,
    );
    createPostNameInFirestoreTimeline(
      adname: adNameController.text,
    );
    adNameController.clear();
    setState(() {
      isNameSave = false;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddProperty(currentUserId: currentUser?.id,)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isNameSave ? LinearProgressIndicator() : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical:25,horizontal: 25 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.black87,size: 23,),
                  onPressed: (){
                  Navigator.pop(context);
                  },),
                SizedBox(height: 30,),
                Text("Give a Name to your ad",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                SizedBox(height: 20,),
                Text("Attract peoples with an ad titile which highlights what makes your parking special",style: TextStyle(fontSize: 18,color:Colors.black87,fontWeight: FontWeight.w400),),
                SizedBox(height: 30,),
                TextField(
                  controller: adNameController,
                  style: TextStyle(color: Colors.black87,fontSize: 18),
                  decoration: InputDecoration(
                    hintText: "Add an title",
                  ),
                ),
                SizedBox(height: 80,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                    onPressed: handleSaveAdName,
                    elevation: 3,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red,
                        ),
                        child: Text("Submit",style: TextStyle(color: Colors.white),)),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
