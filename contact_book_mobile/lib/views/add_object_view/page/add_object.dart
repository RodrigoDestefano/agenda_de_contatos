import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/services/api_correios_services.dart';
import 'package:contact_book_mobile/views/add_object_view/data/add_object_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class AddObjectView extends StatefulWidget {
  @override
  _AddObjectViewState createState() => _AddObjectViewState();
}

class _AddObjectViewState extends State<AddObjectView> {
  TextEditingController zipCodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String name = '';
  String phone = '';
  String email = '';
  String zipCode = '';
  String street = '';
  String number = '';
  String district = '';
  String city = '';
  String uf = '';

  bool isStreetEnable = true;
  bool isDistrictEnable = true;
  bool isCityEnable = true;
  bool isUfEnable = true;

  TextEditingController streetInitialValue = TextEditingController();
  TextEditingController districtInitialValue = TextEditingController();
  TextEditingController cityInitialValue = TextEditingController();
  TextEditingController ufInitialValue = TextEditingController();

  InputDecoration getInputDecoration(String hintText) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(top: 7.0),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      prefixIcon: Icon(
        Icons.person,
        color: Colors.white,
        size: 16.0,
      ),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white, fontSize: 13.0),
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar',
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: Color(0xff181818),
      ),
      body: Container(
        color: Color(0xff181818),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40.0,
                    child: TextFormField(
                        decoration: getInputDecoration('Name'),
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter with some name';
                        },
                        onSaved: (value) => setState(() => name = value!),
                        style: TextStyle(color: Colors.white))),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40.0,
                    child: TextFormField(
                        decoration: getInputDecoration('Phone'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          final pattern = r'(^[0-9]{2}-[0-9]{4}-[0-9]{4}$)';
                          final regExp = RegExp(pattern);

                          if (value!.isEmpty) {
                            return 'Enter a phone';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Enter a valid phone';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => setState(() => phone = value!),
                        style: TextStyle(color: Colors.white))),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40.0,
                    child: TextFormField(
                        decoration: getInputDecoration('Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final pattern =
                              r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                          final regExp = RegExp(pattern);

                          if (value != '') {
                            if (!regExp.hasMatch(value!)) {
                              return 'Enter a valid email';
                            } else {
                              return null;
                            }
                          }
                        },
                        onSaved: (value) => setState(() => email = value!),
                        style: TextStyle(color: Colors.white))),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50.0,
                    child: Row(
                      children: [
                        Container(
                          height: 40.0,
                          width:
                              MediaQuery.of(context).size.width * 0.85 - 20.0,
                          child: TextFormField(
                              decoration: getInputDecoration('Zip code'),
                              keyboardType: TextInputType.phone,
                              controller: zipCodeController,
                              validator: (value) {
                                // final pattern = r'(^\d{5}-\d{3}$)';
                                // final regExp = RegExp(pattern);

                                // if (value!.isEmpty) {
                                //   return 'Enter a zip code';
                                //   // } else if (!regExp.hasMatch(value)) {
                                //   //   return 'Enter a valid zip code';
                                // } else {
                                //   return null;
                                // }
                              },
                              onSaved: (value) =>
                                  setState(() => zipCode = value!),
                              style: TextStyle(color: Colors.white)),
                        ),
                        Container(
                            width: 20.0,
                            height: 20.0,
                            child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                onPressed: () async {
                                  print(zipCodeController.text);

                                  var resp = await ApiCorreiosServices()
                                      .getAddressByZipCode(
                                          zipCodeController.text);

                                  if (resp != null) {
                                    setState(() {
                                      streetInitialValue.text =
                                          resp["logradouro"];
                                      districtInitialValue.text =
                                          resp["bairro"];
                                      cityInitialValue.text =
                                          resp["localidade"];
                                      ufInitialValue.text = resp["uf"];

                                      isStreetEnable =
                                          streetInitialValue.text == ""
                                              ? true
                                              : false;
                                      isDistrictEnable =
                                          districtInitialValue.text == ""
                                              ? true
                                              : false;
                                      isCityEnable = cityInitialValue.text == ""
                                          ? true
                                          : false;
                                      isUfEnable = ufInitialValue.text == ""
                                          ? true
                                          : false;
                                    });
                                  }
                                }))
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50.0,
                    child: Row(
                      children: [
                        Container(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: TextFormField(
                              enabled: isStreetEnable ? true : false,
                              controller: streetInitialValue,
                              decoration: getInputDecoration('Street'),
                              onSaved: (value) =>
                                  setState(() => street = value!),
                              style: TextStyle(color: Colors.white)),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10.0)),
                        Container(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: TextFormField(
                              decoration: getInputDecoration('N°'),
                              onSaved: (value) =>
                                  setState(() => number = value!),
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    )),
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Container(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: TextFormField(
                              enabled: isCityEnable ? true : false,
                              controller: cityInitialValue,
                              decoration: getInputDecoration('City'),
                              onSaved: (value) => setState(() => city = value!),
                              style: TextStyle(color: Colors.white))),
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Container(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                              enabled: isUfEnable ? true : false,
                              controller: ufInitialValue,
                              decoration: getInputDecoration('UF'),
                              onSaved: (value) => setState(() => uf = value!),
                              style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
                Container(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                        enabled: isDistrictEnable ? true : false,
                        controller: districtInitialValue,
                        decoration: getInputDecoration('District'),
                        onSaved: (value) => setState(() => district = value!),
                        style: TextStyle(color: Colors.white))),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final isValid = formKey.currentState!.validate();

                      if (isValid) {
                        formKey.currentState!.save();

                        String body =
                            '{"name":"$name", "phone":"$phone", "email":"$email", "zip_code":"$zipCode", "street":"$street", "number":"$number", "district":"$district", "city":"$city", "uf":"$uf"}';

                        var resp;
                        int userId = UserController.instance.user.id;
                        String token = AuthController.instance.token;

                        try {
                          resp = await AddObjectServices()
                              .createContact(userId, token, body);

                          Fluttertoast.showToast(
                              msg: resp['message'],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:
                                  resp['status'] ? Colors.green : Colors.red,
                              textColor: Colors.white,
                              fontSize: 10.0);

                          if (resp['status']) Navigator.pop(context);
                        } catch (error) {
                          print(error);
                        }
                      }
                    },
                    child: Text('Create Contact!'),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff3fa1ff),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
