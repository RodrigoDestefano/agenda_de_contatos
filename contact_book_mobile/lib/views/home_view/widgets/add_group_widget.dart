import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/views/home_view/data/home_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddGroupWidget extends StatefulWidget {
  const AddGroupWidget({Key? key}) : super(key: key);

  @override
  _AddGroupWidgetState createState() => _AddGroupWidgetState();
}

class _AddGroupWidgetState extends State<AddGroupWidget> {
  final formKey = GlobalKey<FormState>();

  String? name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a group'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Color(0xff181818),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60.0,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Enter with a name for the group';
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'Name'),
                    onSaved: (value) => setState(() => name = value!),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          final isValid = formKey.currentState!.validate();

                          if (isValid) {
                            formKey.currentState!.save();

                            String body = '{"name":"$name"}';

                            var resp;
                            int? userId = UserController.instance.user.id;
                            String token = AuthController.instance.token;

                            try {
                              resp = await HomePageServices()
                                  .createGroup(userId, token, body);

                              Fluttertoast.showToast(
                                  msg: resp['message'],
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: resp['status']
                                      ? Colors.green
                                      : Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 10.0);

                              if (resp['status']) Navigator.pop(context);
                            } catch (error) {
                              print(error);
                            }
                          }
                        },
                        child: Text('Create'),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff282828)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
