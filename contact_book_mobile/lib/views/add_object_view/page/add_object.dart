import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/helpers/screen_arguments.dart';
import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/shared/widgets/default_text.dart';
import 'package:contact_book_mobile/views/add_object_view/data/add_object_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AddObjectView extends StatefulWidget {
  static const routeName = '/third';

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

  // Variables that turn the text fields enabled or not
  // according to the use of the zip code API
  bool isStreetEnable = true;
  bool isDistrictEnable = true;
  bool isCityEnable = true;
  bool isUfEnable = true;

  // The controllers to change the text fields values after a zip code search
  TextEditingController streetInitialValue = TextEditingController();
  TextEditingController districtInitialValue = TextEditingController();
  TextEditingController cityInitialValue = TextEditingController();
  TextEditingController ufInitialValue = TextEditingController();

  // How all text fields has almost the same style,
  // part of this is created here to avoid code repeat
  InputDecoration getInputDecoration(String hintText, IconData iconData) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(top: 7.0),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: defaultWhite),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: defaultWhite),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: lightBlue),
      ),
      prefixIcon: Icon(
        iconData,
        color: defaultWhite,
        size: 16.0,
      ),
      hintText: hintText,
      hintStyle: TextStyle(color: defaultWhite, fontSize: 13.0),
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.isAddingContact ? 'Add a new Contact' : 'Add an new Address',
          textAlign: TextAlign.end,
          style: GoogleFonts.pacifico(
            color: defaultWhite,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: darkBlue,
        elevation: 1.0,
      ),
      body: Center(
        child: Container(
          color: darkBlue,
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(8.0)),
                  args.isAddingContact
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 40.0,
                          child: TextFormField(
                              decoration:
                                  getInputDecoration('Name', Icons.person),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Enter with some name';
                              },
                              onSaved: (value) => setState(() => name = value!),
                              style: TextStyle(color: defaultWhite)))
                      : Container(),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 40.0,
                      child: TextFormField(
                          decoration: getInputDecoration('Phone', Icons.phone),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            // Simple phone validator (Brazil only)
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
                          style: TextStyle(color: defaultWhite))),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 40.0,
                      child: TextFormField(
                          decoration: getInputDecoration('Email', Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            // Simple email validator
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
                          style: TextStyle(color: defaultWhite))),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50.0,
                    child: Row(
                      children: [
                        Container(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: TextFormField(
                              decoration: getInputDecoration(
                                  'Zip code', Icons.post_add),
                              keyboardType: TextInputType.phone,
                              controller: zipCodeController,
                              onSaved: (value) =>
                                  setState(() => zipCode = value!),
                              style: TextStyle(color: defaultWhite)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: 100.0,
                            height: 30.0,
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.search,
                                color: darkBlue,
                                size: 18.0,
                              ),
                              label: DefaultText(
                                'Search',
                                fontSize: 13.0,
                                fontColor: darkBlue,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: defaultWhite,
                              ),
                              onPressed: () {
                                onSearchZipCode();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                                decoration: getInputDecoration(
                                    'Street', Icons.add_road_sharp),
                                onSaved: (value) =>
                                    setState(() => street = value!),
                                style: TextStyle(color: defaultWhite)),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          Container(
                            height: 40.0,
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: TextFormField(
                                decoration: getInputDecoration(
                                    'N°', Icons.confirmation_number),
                                onSaved: (value) =>
                                    setState(() => number = value!),
                                style: TextStyle(color: defaultWhite)),
                          )
                        ],
                      )),
                  Padding(padding: EdgeInsets.all(8.0)),
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
                                decoration: getInputDecoration(
                                    'City', Icons.location_city),
                                onSaved: (value) =>
                                    setState(() => city = value!),
                                style: TextStyle(color: defaultWhite))),
                        Padding(padding: EdgeInsets.only(left: 10.0)),
                        Container(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                            enabled: isUfEnable ? true : false,
                            controller: ufInitialValue,
                            decoration:
                                getInputDecoration('UF', Icons.account_balance),
                            onSaved: (value) => setState(() => uf = value!),
                            style: TextStyle(color: defaultWhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                          enabled: isDistrictEnable ? true : false,
                          controller: districtInitialValue,
                          decoration:
                              getInputDecoration('District', Icons.home_filled),
                          onSaved: (value) => setState(() => district = value!),
                          style: TextStyle(color: defaultWhite))),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () async {
                        final isValid = formKey.currentState!.validate();

                        if (isValid) {
                          formKey.currentState!.save();
                          onSubmit(args);
                        }
                      },
                      child: Text(
                        'Create!',
                        style: GoogleFonts.pacifico(
                          color: defaultWhite,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSearchZipCode() async {
    // Get the response from zipCode API and repass for the variables
    var resp =
        await AddObjectServices().getAddressByZipCode(zipCodeController.text);

    if (resp != null) {
      setState(
        () {
          // The controllers receive the values
          streetInitialValue.text = resp["logradouro"];
          districtInitialValue.text = resp["bairro"];
          cityInitialValue.text = resp["localidade"];
          ufInitialValue.text = resp["uf"];

          // If any value is found by the API the user can't modify it
          isStreetEnable = streetInitialValue.text == "" ? true : false;
          isDistrictEnable = districtInitialValue.text == "" ? true : false;
          isCityEnable = cityInitialValue.text == "" ? true : false;
          isUfEnable = ufInitialValue.text == "" ? true : false;
        },
      );
    }
  }

  void onSubmit(args) async {
    String body = '{"name":"$name",' +
        '"phone":"$phone",' +
        '"email":"$email",' +
        '"zip_code":"$zipCode",' +
        '"street":"$street",' +
        '"number":"$number",' +
        '"district":"$district",' +
        '"city":"$city",' +
        '"uf":"$uf"}';

    var resp;
    int? userId = UserController.instance.user.id;
    String token = AuthController.instance.token;

    try {
      if (args.isAddingContact) {
        resp = await AddObjectServices().createContact(userId, body, token);
      } else {
        resp = await AddObjectServices()
            .createAddress(args.contactId, body, token);
      }

      Fluttertoast.showToast(
          msg: resp['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: resp['status'] ? Colors.green : Colors.red,
          textColor: defaultWhite,
          fontSize: 10.0);

      if (resp['status']) Navigator.pop(context);
    } catch (error) {
      print(error);
    }
  }
}
