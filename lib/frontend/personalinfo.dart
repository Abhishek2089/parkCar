import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkster/Model/user.dart';
import 'package:parkster/frontend/login.dart';


class InfoPersonnel extends StatefulWidget {
  final String currentUserId;
  
  InfoPersonnel({ this.currentUserId});

  @override
  _infoPersonnelState createState() => _infoPersonnelState();
}

class _infoPersonnelState extends State<InfoPersonnel> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dateofbirthController = TextEditingController();
  User user;
  bool isLoading = false;
  bool _nameValid = true;
  bool _mobileValid = true;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.
    document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    namecontroller.text = user.displayName;
    mobileController.text = user.mobileno.toString();
    dateofbirthController.text = user.dateofbirth.toString();
  }

  updateProfileDate() {
    setState(() {
      namecontroller.text.trim().length < 3 || namecontroller.text.isEmpty ? 
      _nameValid = false : mobileController.text.trim().length > 13 ?
      _mobileValid = false : _mobileValid = true;
    });
    if(_nameValid && _mobileValid) {
      usersRef.document(widget.currentUserId).updateData({
        "displayName": namecontroller.text,
        "mobileno": mobileController.text
      });
      SnackBar snackBar = SnackBar(
        content: Text(
          "Profile Updated"
        ),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:13,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back,size: 19,color: Colors.black87,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                      child: Text("save",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                    onTap: updateProfileDate
                  )
                ],
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical:8.0,horizontal: 10),
                child: Text("Edit Your Personal Information",style: TextStyle(color:Colors.black,fontSize: 30,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.fromLTRB(10,8,10,0),
                    child: Text("Name",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                      hintText: "Update your Name",
                      errorText: _nameValid ? null : "Dispay Name too short",
                      hintStyle: TextStyle(color: Colors.black87),
                      suffixIcon: IconButton(
                      icon: Icon(Icons.cancel,size: 18,),
                      onPressed: (){
                        namecontroller.clear();
                      },
                    )
                  ),
                  controller: namecontroller,
                ),),
                ],
              ),
              SizedBox(height: 25,),
              GestureDetector(
                  onTap: (){
                    _askedToLead();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.fromLTRB(10,8,10,0),
                        child: Text("Gender",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                        child: Text("Male",style: TextStyle(color:Colors.black,fontSize: 17,fontWeight: FontWeight.w300),),
                        ),
                    ],
                  ),
                ),
              SizedBox(height: 25,),
              InkWell(
                onTap: (){
                  _selectDate(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.fromLTRB(10,8,10,0),
                      child: Text("Date of Birth",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                        child: Text("_selectedDate"),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.fromLTRB(10,8,10,0),
                    child: Text("Mobile Number",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "update your mobile number",
                        errorText: _mobileValid ? null : "mobile number is too short",
                          hintStyle: TextStyle(color: Colors.black87),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel,size: 18,),
                            onPressed: (){
                              mobileController.clear();
                            },
                          )
                      ),
                      controller: mobileController,
                    ),
                  ),
                ],
              ),
            ],
      ),
    ),),);
  }
  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(DateTime.now().year+1));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _askedToLead() async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Gender'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, "Male"); },
                child: const Text('Male'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, "Female"); },
                child: const Text('Female'),
              ),
            ],
          );
        }
    )) {
      case "Male":
      // Let's go.
      // ...
        break;
      case "Female":
      // ...
        break;
    }
  }
}
