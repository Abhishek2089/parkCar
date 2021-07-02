import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkster/Model/user.dart';
import 'package:parkster/frontend/login.dart';
import 'package:parkster/hosting/Addparkingdetails.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;
import 'morequestions.dart';

class AddPhoto extends StatefulWidget {
  final User currentUser;

  AddPhoto({this.currentUser,});

  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File file;
  String postId = Uuid().v4();
  bool isUploading = false;


  // @override
  // void initState() {
  //   super.initState();
  //   //getStream();
  //   //getUserInfo();
  //   getPosts();
  //  // getpostpic();
  // }

  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.camera,
    maxHeight: 675,
    maxWidth: 960,
    );
    setState(() {
      this.file = file;
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  clearImage() {
    setState(() {
      file = null;
    });
  }

  // getPosts() async {
  //   // setState(() {
  //   //   isLoading = true;
  //   // });
  //   QuerySnapshot snapshot = await postsRef.document(
  //     widget.currentUser.id
  //   ).collection('userPosts')
  //   .getDocuments();
  //   // setState(() {
  //   //   posts = snapshot.documents;
  //   // });
  //   snapshot.documents.forEach((DocumentSnapshot doc) {
  //     print(doc.data);
  //     print(doc.documentID);
  //     print(doc.exists);
  //   });
  // }


  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Create Ad for Parking"),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Photo with camera"),
              onPressed: handleTakePhoto,
            ),
            SimpleDialogOption(
              child: Text("Image from gallery"),
              onPressed: handleChooseFromGallery,
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      }
    );
  }


Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask = storageRef.child("post_$postId.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  // createPostPicsInFirestore({ String mediaUrl, String location, String description, }) {
  //   postsRef
  //      .document(widget.currentUser.id)
  //      .collection("userPosts")
  //      .document(widget.currentUser.id)
  //      .updateData({
  //        "ownerId": widget.currentUser.id,
  //        "username": widget.currentUser.username,
  //        "mediaUrl": mediaUrl,
  //       // "description": description,
  //       // "location": location,
  //      });
  // }

  Future<void> upDateinTimeline({DocumentSnapshot doc, String mediaUrl, String postId}) async {
    await timlineRef
    .document("timeline")
    .collection('userPosts')
    .document(ids).updateData({
      "ownerId": widget.currentUser.id,
      "username": widget.currentUser.username,
      "mediaUrl": mediaUrl,
    });
  }

  Future<void> upDate({DocumentSnapshot doc, String mediaUrl, String postId}) async {
    await postsRef
    .document(widget.currentUser.id)
    .collection('userPosts')
    .document(ids).updateData({
      "ownerId": widget.currentUser.id,
      "username": widget.currentUser.username,
      "mediaUrl": mediaUrl,
    });
  }

  // Future<void> upDate({DocumentSnapshot doc, String mediaUrl, String postId}) async {
  //   QuerySnapshot postsfeednamesnapshot = await postsRef
  //   .document(widget.currentUser.id)
  //   .collection('userPosts')
  //   .where('postId', isEqualTo: postId)
  //   .getDocuments();
  //   postsfeednamesnapshot.documents.forEach((doc) {
  //     if(doc.exists){
  //       doc.reference.updateData({
  //     "ownerId": widget.currentUser.id,
  //     "username": widget.currentUser.username,
  //     "mediaUrl": mediaUrl,
  //   });
  //     }
  //   });
  // }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file);
    upDate(
      mediaUrl: mediaUrl,
    );
    upDateinTimeline(
      mediaUrl: mediaUrl,
    );
    setState(() {
      file = null;
     // isUploading = false;
      //postId = Uuid().v4();
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Nom(currentUser: currentUser,)));
  }



  buildUploadPage() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: clearImage, color: Colors.black,),
        title: Text('Caption Ad'),
      ),
      body: ListView(
        children: [
          isUploading ? LinearProgressIndicator() : Text(""),
          Container(
            height: 220,
            width: MediaQuery.of(context).size
            .width*0.8,
            child: Center(
              child: AspectRatio(aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(file)
                  )
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 350)),
          InkWell(
            onTap: handleSubmit,
            child: ListTile(
              title: Container(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
              child: Center(child: Text("Submit",style: TextStyle(color: Colors.white),))),
            ),
          )
        ],
      ),
    );
  }

  Scaffold buildAddPhotoScreen() {
    return Scaffold(
        body: SingleChildScrollView(
        child: Padding(
           padding: EdgeInsets.symmetric(vertical:25,horizontal: 25 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back,color: Colors.black87,size: 23,),
                onPressed: () {
                  Navigator.pop(context);
                },
            ),
               SizedBox(height: 30,),
               Text("Add Photos to your ad",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
               SizedBox(height: 20,),
                Text("Photos help travelers see themselves in your accommodation. You can start with a photo and add more after posting",style: TextStyle(fontSize: 18,color:Colors.black87,fontWeight: FontWeight.w400),),
               SizedBox(height: 30,),
                MaterialButton(
                  onPressed: (){
                    // I have to put some function here....
                    selectImage(context);
                  },
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                  ),
                  child: Text("Add Pictures",style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
                SizedBox(height: 25,),
                Align(
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Nom()),
                      );
                    },
                    elevation: 3,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red)
                        ),
                        child: Text("Later",style: TextStyle(color: Colors.red),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    return file == null ? buildAddPhotoScreen() : buildUploadPage();
  }
}
