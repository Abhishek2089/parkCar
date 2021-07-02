import 'package:flutter/material.dart';
import 'package:parkster/Model/bottomnavbar.dart';
import 'package:parkster/frontend/profile.dart';
import 'package:parkster/frontend/properties.dart';
import 'package:parkster/hosting/maps.dart';
import 'Addproperty.dart';
import 'home.dart';
import 'login.dart';


class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => HomePageState();
  }

// void main() => runApp(
//   MaterialApp(
//     debugShowCheckedModeBanner: false,

//     home: HomePage(),
//     theme: ThemeData(
//       // primaryColor: Constants.greenAirbnb,
//       // accentColor: Constants.redAirbnb,
//       // scaffoldBackgroundColor: Colors.orange[400]
//       )
//     ),
//   );


class HomePageState extends State<HomePage> {
  int _currentTab=0;
  
  List<Widget> _children=[HomeScreen(currentUser: currentUser,),Properties(currentUser: currentUser,), MapsFlutter(),//Messages(),
  Profile(profileId: currentUser?.id,)];



  void _selectedTab(int value) {
    setState(() {
      _currentTab = value;
    });
  }

  Widget _buildFab(BuildContext context) {
    final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProperty(currentUserId: currentUser.id,)),
          );
        },
       tooltip: 'parkster',
       backgroundColor: Colors.white,
        child: Image.asset('assets/images/logo2.jpg',width: 40.0,height: 40.0,),
        elevation: 2.0,

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0XFFE7EBEE),
      body: SafeArea(
        child: _children[_currentTab],
      ),
       bottomNavigationBar:  FABBottomAppBar(
          centerItemText: 'Start',
          color: Colors.grey,
          selectedColor: Color(0xFFFB7592),
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          items: [
            FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
            FABBottomAppBarItem(iconData: Icons.favorite, text: 'Parkings'),
            FABBottomAppBarItem(iconData: Icons.navigation, text: 'Nav'),
            FABBottomAppBarItem(iconData: Icons.account_circle, text: 'profile'),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFab(context),
    );
  }
}


