import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/services/userservice.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyApp.menu,
      appBar: AppBar(
        title: Text('Hesabım'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Container(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Adınız '),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Container(
                  child: TextFormField(
                    controller: _lastnameController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Soy adınız '),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Container(
                  child: TextFormField(
                    controller: _mailController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'E-mailiniz '),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Container(
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Şifreniz '),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {},
                child: Text("Kaydet"),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }

  getuser() async {
    var value = await SharedPref.getString("email");
    if (value != null) {
      var user = await UserService.getbyMail(value);
      if (user != null) {
        setState(() {
          _nameController.text = user.firstName;
          _lastnameController.text = user.lastName;
          _mailController.text = user.email;
        });
      }
    }
  }
}
