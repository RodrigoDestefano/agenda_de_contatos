import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/shared/widgets/default_text.dart';
import 'package:contact_book_mobile/views/login_view/data/login_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final formKey = GlobalKey<FormState>();

  String? name = '';
  String? email = '';
  String? password = '';

  static bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
      body: SimpleDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: darkBlue),
            borderRadius: new BorderRadius.circular(10.0)),
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(0),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0)),
              color: darkBlue,
            ),
            child: Center(
                child: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: defaultWhite,
                      size: 20.0,
                    )),
                DefaultText(
                  "ContactsBook Sign In",
                  fontColor: defaultWhite,
                ),
              ],
            )),
          ),
          Container(
            height: 260.0,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 250,
                          height: 50.0,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) return 'Enter with a name';
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: defaultWhite,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: darkBlue),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: darkBlue),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                labelText: 'Name',
                                labelStyle: GoogleFonts.lato(
                                    color: darkBlue,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600)),
                            onSaved: (value) => setState(() => name = value!),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 250,
                          height: 50.0,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              // Validator to enter with a valid email
                              final pattern =
                                  r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                              final regExp = RegExp(pattern);

                              if (value!.isEmpty)
                                return 'Enter with an email';
                              else if (value != '') {
                                if (!regExp.hasMatch(value)) {
                                  return 'Enter with a valid email';
                                } else {
                                  return null;
                                }
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: defaultWhite,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: darkBlue),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: darkBlue),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                labelText: 'Email',
                                labelStyle: GoogleFonts.lato(
                                    color: darkBlue,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600)),
                            onSaved: (value) => setState(() => email = value!),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 250,
                          height: 50.0,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Enter with a password';
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: defaultWhite,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: darkBlue),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: darkBlue),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              labelText: 'Password',
                              labelStyle: GoogleFonts.lato(
                                  color: darkBlue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                              suffixIcon: IconButton(
                                iconSize: 16.0,
                                color: darkBlue,
                                icon: Icon(showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                            ),
                            onSaved: (value) =>
                                setState(() => password = value!),
                            obscureText: !showPassword,
                            obscuringCharacter: "*",
                          ),
                        ),
                      ),
                      Container(
                        height: 40.0,
                        width: 150.0,
                        child: ElevatedButton(
                          onPressed: () {
                            final isValid = formKey.currentState!.validate();

                            if (isValid) {
                              formKey.currentState!.save();

                              onSigInSubmit(name, email, password);
                            }
                          },
                          child: DefaultText(
                            'Sign In Now!',
                            fontColor: defaultWhite,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: darkBlue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onSigInSubmit(
      String? name, String? email, String? password) async {
    try {
      var resp = await LoginServices().createUser(name, email, password);

      Fluttertoast.showToast(
          msg: resp['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: resp['status'] ? Colors.green : Colors.red,
          textColor: Colors.white,
          fontSize: 10.0);

      if (resp['status']) Navigator.pop(context);
    } catch (error) {
      print(error);
    }
  }
}
