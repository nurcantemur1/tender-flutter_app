import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/screens/product-list.dart';
import 'package:flutter_application_1/services/photoservice.dart';
import 'package:flutter_application_1/services/productservice.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/services/userservice.dart';
import 'package:intl/intl.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key key}) : super(key: key);

  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  DateTime datetime1, datetime2;
  bool load = false;
  var userid;
  double _height1, _height2;
  double _width1, _width2;
  // ignore: unused_field
  String _setTime1, _setDate1, _setTime2, _setDate2;

  String _hour1, _minute1, _time1, _hour2, _minute2, _time2;

  String dateTime1, dateTime2;

  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  TimeOfDay selectedTime1 = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedTime2 = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _date1Controller = TextEditingController();
  TextEditingController _time1Controller = TextEditingController();
  TextEditingController _date2Controller = TextEditingController();
  TextEditingController _time2Controller = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  FilePickerResult pickerResult;

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate1 = picked;
        _date1Controller.text = DateFormat.yMd().format(selectedDate1);
        updatedate();
      });
  }

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked2 = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked2 != null)
      setState(() {
        selectedDate2 = picked2;
        _date2Controller.text = DateFormat.yMd().format(selectedDate2);
        updatedate();
      });
  }

  Future<Null> _selectTime1(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime1,
    );
    if (picked != null)
      setState(() {
        selectedTime1 = picked;
        _hour1 = selectedTime1.hour.toString();
        _minute1 = selectedTime1.minute.toString();
        _time1 = _hour1 + ' : ' + _minute1;
        _time1Controller.text = _time1;
        _time1Controller.text = formatDate(
            DateTime(2019, 08, 1, selectedTime1.hour, selectedTime1.minute),
            [HH, ':', nn, " "]).toString();
        updatedate();
      });
  }

  Future<Null> _selectTime2(BuildContext context) async {
    final TimeOfDay picked2 = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
    );
    if (picked2 != null)
      setState(() {
        selectedTime2 = picked2;
        _hour2 = selectedTime2.hour.toString();
        _minute2 = selectedTime2.minute.toString();
        _time2 = _hour2 + ' : ' + _minute2;
        _time2Controller.text = _time2;
        _time2Controller.text = formatDate(
            DateTime(2019, 08, 1, selectedTime2.hour, selectedTime2.minute),
            [HH, ':', nn, " "]).toString();
        updatedate();
      });
  }

  @override
  void initState() {
    _date1Controller.text = DateFormat.yMd().format(DateTime.now());

    _time1Controller.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [HH, ':', nn, " "]).toString();

    _date2Controller.text = DateFormat.yMd().format(DateTime.now());

    _time2Controller.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [HH, ':', nn, " "]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height1 = MediaQuery.of(context).size.height;
    _width1 = MediaQuery.of(context).size.width;
    _height2 = MediaQuery.of(context).size.height;
    _width2 = MediaQuery.of(context).size.width;
    dateTime1 = DateFormat.yMd().format(DateTime.now());
    dateTime2 = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      drawer: MyApp.menu,
      appBar: AppBar(
        title: Text('Ürün Ekle'),
      ),
      body: SingleChildScrollView(
        child: Card(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Container(
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Ürün Adı '),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Container(
                child: TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Ürün Fiyatı '),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Container(
                  // ignore: deprecated_member_use
                  child: CupertinoButton(
                color: Colors.blue,
                child: Text('UPLOAD FILE'),
                onPressed: () async {
                  var result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'jpeg', 'png'],
                  );
                  if (result != null) {
                    setState(() {
                      pickerResult = result;
                    });
                  }
                },
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Text("Yayın başlagıç tarihi: "),
                      Column(
                        children: <Widget>[
                          Text(
                            'Choose Date',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5),
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate1(context);
                            },
                            child: Container(
                              width: _width1 / 4,
                              height: _height1 / 16,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white),
                              child: TextFormField(
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _date1Controller,
                                onSaved: (String val) {
                                  _setDate1 = val;
                                },
                                decoration: InputDecoration(
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    // labelText: 'Time',
                                    contentPadding: EdgeInsets.only(top: 0.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Choose Time',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5),
                          ),
                          InkWell(
                            onTap: () {
                              _selectTime1(context);
                            },
                            child: Container(
                              width: _width1 / 4,
                              height: _height1 / 16,
                              decoration: BoxDecoration(color: Colors.white),
                              child: TextFormField(
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                                onSaved: (String val) {
                                  _setTime1 = val;
                                },
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _time1Controller,
                                decoration: InputDecoration(
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    // labelText: 'Time',
                                    contentPadding: EdgeInsets.all(5)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Text("Yayın bitiş tarihi: "),
                      Column(
                        children: <Widget>[
                          Text(
                            'Choose Date',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5),
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate2(context);
                            },
                            child: Container(
                              width: _width2 / 4,
                              height: _height2 / 16,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white),
                              child: TextFormField(
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _date2Controller,
                                onSaved: (String val) {
                                  _setDate2 = val;
                                },
                                decoration: InputDecoration(
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    // labelText: 'Time',
                                    contentPadding: EdgeInsets.only(top: 0.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Choose Time',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5),
                          ),
                          InkWell(
                            onTap: () {
                              _selectTime2(context);
                            },
                            child: Container(
                              width: _width2 / 4,
                              height: _height2 / 16,
                              decoration: BoxDecoration(color: Colors.white),
                              child: TextFormField(
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                                onSaved: (String val) {
                                  _setTime2 = val;
                                },
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _time2Controller,
                                decoration: InputDecoration(
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    // labelText: 'Time',
                                    contentPadding: EdgeInsets.all(5)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Text(datetime1 != null && dateTime2 != null
                  ? datetime2.difference(datetime1).toString().split(".")[0]
                  : "hesaplanamadı"),
            ),
            // ignore: deprecated_member_use
            CupertinoButton(
              onPressed: () async {
                await productadd();
                // load //apide msg bool ayarlamayı unutma!
                //     ? showAlertDialog(context, "Ekleme işlemi başarılı")
                //     : showAlertDialog(context, "Ekleme işlemi başarısız");
              },
              child: Text("ekle"),
              color: Colors.blue,
            )
          ],
        )),
      ),
    );
  }

  showAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: Text("tamamla"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => ProductList()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
          load == true ? "Ekleme işlemi başarılı" : "Ekleme işlemi başarısız"),
      content: load == true
          ? Text("Eklenen ürünün onaylanmasını bekleyiniz")
          : Text("Ürün Eklenemedi"),
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

  getuser() async {
    var value = await SharedPref.getString("email");
    if (value != null) {
      var user = await UserService.getbyMail(value);
      if (user != null) {
        setState(() {
          userid = user.id;
        });
      }
    }
  }

  productadd() async {
    await getuser();
    Product model = Product(
        id: 0,
        userId: userid,
        productName: _nameController.text,
        price: double.parse(_priceController.text),
        endprice: double.parse(_priceController.text),
        starttime: dateFormat(datetime1),
        endtime: dateFormat(datetime2),
        status: false);
    print(model);
    ProductService.add(model).then((value) async {
      if (value != null) {
        if (value.id > 0) {
          await PhotoService.add(value.id, pickerResult.files.first);
          setState(() {
            load = true;
            showAlertDialog();
          });
        }
      } else {
        setState(() {
          load = false;
          showAlertDialog();
        });
      }
    });
  }

  timeConvert(String zaman) {
    DateTime parseDate = new DateFormat('MM/dd/yyyy HH:mm ').parse(zaman);
    //print(parseDate.difference(DateTime.now()).toString());
    return DateFormat('dd.MM.yyyy HH:mm ').format(parseDate);
  }

  DateTime toDatetime(String date) {
    DateTime parseDate = new DateFormat('MM/dd/yyyy HH:mm ').parse(date);
    print(parseDate.toString());
    return parseDate;
  }

  dateFormat(DateTime date) {
    return DateFormat('dd.MM.yyyy HH:mm ').format(date);
  }

  updatedate() {
    var zaman1 = _date1Controller.text.toString() +
        " " +
        _time1Controller.text.toString();
    var zaman2 = _date2Controller.text.toString() +
        " " +
        _time2Controller.text.toString();

    setState(() {
      datetime1 = toDatetime(zaman1);
      print(datetime1.toString());
      datetime2 = toDatetime(zaman2);
      print(datetime2.toString());
    });
  }
}
