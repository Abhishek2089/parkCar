import 'package:flutter/material.dart';
import 'package:parkster/Model/user.dart';
import 'package:parkster/frontend/personalinfo.dart';
import 'Addproperty.dart';
import 'login.dart';

  class Profile extends StatefulWidget {
    final String profileId;

    Profile({ this.profileId });

  @override
  _ProfileState createState() => _ProfileState();
  }

  class _ProfileState extends State<Profile> {
    User user;
    bool isLoading = false;
    final String currentUserId = currentUser?.id;
    String profilepic;
    String username;

    final textStyleState = TextStyle(
        fontSize: 11.0,
        color: Colors.white
    );

    final textStyleTop = TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
    );

    final textStyle2 = TextStyle(
        color: Colors.white

    );

  @override
  void initState() {
    super.initState();
  }

  

  logout() async {
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
  }

  buildProfile() {
    return FutureBuilder(
      future: usersRef.document(widget.profileId).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        User user = User.fromDocument(snapshot.data);
        return ListView(
          children: <Widget>[
        Container(
          child: Padding(
          padding: EdgeInsets.all(25),
          child: Row(
            children: <Widget>[
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(user.photoUrl),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.displayName, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black87
                  ),),
                ],
              )
            ],
          ),
      ),
      ),
      ClipRRect(
        child: Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                    color: Colors.black12,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                width: 50,
                height: 1,
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(15),
              child: Text("Account Settings".toUpperCase(),style: TextStyle(color: Colors.grey,fontSize: 15,),),
            ),
            FlatButton(
                    splashColor: Colors.grey,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InfoPersonnel(currentUserId: currentUserId,)),
                      );
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                         Expanded(
                           child: Text("Personal Information",
                            style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,),
                         ),
                          Icon(
                            Icons.person_outline,
                          ),],
                      ),
                    ),
                ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              width: 50,
              height: 1,
            ),
            FlatButton(
              splashColor: Colors.grey,
              onPressed: (){},
              child: Padding(
                padding:  EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Text("Notifications",
                        style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),
                        overflow: TextOverflow.ellipsis,),
                    ),
                    Icon(
                      Icons.notifications_none,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              width: 50,
              height: 1,
            ),
            FlatButton(
              splashColor: Colors.grey,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProperty(currentUserId: currentUser.id,)),
                );
              },
              child: Padding(
                padding:  EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Text("Add Parking",
                        style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),
                        overflow: TextOverflow.ellipsis,),
                    ),
                    Icon(
                      Icons.add_circle_outline,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              width: 50,
              height: 1,
            ),
            FlatButton(
              splashColor: Colors.grey,
              onPressed: logout,
              child: Padding(
                padding:  EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Text("Log Out",
                        style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),
                        overflow: TextOverflow.ellipsis,),
                    ),
                    Icon(
                      Icons.exit_to_app,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
  );
}


  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: buildProfile(),
      );
    }
  }

 