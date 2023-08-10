import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/favorite.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/product-list.dart';
import 'package:flutter_application_1/screens/profile.dart';
import 'package:flutter_application_1/screens/winners.dart';
import 'package:flutter_application_1/services/shared_pref.dart';

// ignore: must_be_immutable
class DrawerMenu extends StatefulWidget {
  DrawerMenuState drawerMenuState;
  @override
  DrawerMenuState createState() {
    drawerMenuState = DrawerMenuState();
    return drawerMenuState;
  }
}

class DrawerMenuState extends State<DrawerMenu> {
  String email;

  @override
  void initState() {
    super.initState();
    SharedPref.getString("email").then((value) {
      setState(() {
        email = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          Navigator.pop(context);
        },
        child: getDrawer());
  }

  getDrawer() {
    return Drawer(
      child: Column(
        children: getMenuItem(),
      ),
    );
  }

  getMenuItem() {
    return <Widget>[
      UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          child: Icon(
            Icons.person,
            size: 50,
          ),
          backgroundColor: Colors.red,
          radius: 20,
        ),
        // ignore: deprecated_member_use
        accountName: null,
        accountEmail: email != null
            ? Text(email)
            // ignore: deprecated_member_use
            : RaisedButton(
                child: Text("Giriş Yap"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                  );
                },
              ),
      ),
      new ListTile(
        title: Text("Anasayfa"),
        leading: Icon(
          Icons.home,
          color: Colors.blueAccent,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Home()),
          );
        },
        //setPage(PageModel(Home(), "Anasayfa"))
      ),
      new ListTile(
          title: Text("Takip ettiklerim"),
          leading: Icon(
            Icons.favorite,
            color: Colors.blueAccent,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext buildContext) => Favorite()));
          }),
      new ListTile(
        title: Text("Kazandıklarım"),
        leading: Icon(
          Icons.check,
          color: Colors.blueAccent,
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext buildContext) => Winners()));
        },
      ),
      new ListTile(
        title: Text("Ürün İşlemleri"),
        leading: Icon(
          Icons.check,
          color: Colors.blueAccent,
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext buildContext) => ProductList()));
        },
      ),
      SizedBox(
        height: 5,
      ),
      Divider(
        color: Colors.blueAccent,
      ),
      SizedBox(
        height: 5,
      ),
      new ListTile(
        title: Text("Hesabım"),
        leading: Icon(
          Icons.person,
          color: Colors.blueAccent,
        ),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Profile()),
          );
        },
      ),
      new ListTile(
          title: Text("Çıkış"),
          leading: Icon(
            Icons.outbond,
            color: Colors.blueAccent,
          ),
          onTap: () {
            SharedPref.delete(email);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            );
          })
    ];
  }
}
