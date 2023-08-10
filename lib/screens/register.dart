import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/dto/registerDto.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/services/authservice.dart';

import '../main.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool load = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyApp.menu,
      appBar: AppBar(
        title: Text('Kayıt Ol'),
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
                        labelText: 'Soyadınız '),
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
                onPressed: () {
                  addUser();
                },
                child: Text("Kaydet"),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }

  addUser() async {
    RegisterDto model = RegisterDto(
        email: "_mailController.text",
        password: "_passwordController.text",
        firstName: "_nameController.text",
        lastname: "_lastnameController.text");
    print(model.toString() + "model");
    await AuthService.register(model).then((value) async {
      if (value != null) {
        setState(() {
          load = true;
          showAlertDialog();
        });
      } else {
        setState(() {
          load = false;
          showAlertDialog();
        });
      }
    });
  }

  showAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: Text("tamamla"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => LoginPage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
          load == true ? "Ekleme işlemi başarılı" : "Ekleme işlemi başarısız"),
      content: load == true
          ? Text("Giriş sayfasına yönlendiriliyorsunuz")
          : Text("Eklenemedi"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
