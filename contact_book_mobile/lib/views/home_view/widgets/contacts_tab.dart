import 'package:contact_book_mobile/core/controllers/auth_controller.dart';
import 'package:contact_book_mobile/core/controllers/contact_controller.dart';
import 'package:contact_book_mobile/core/controllers/user_controller.dart';
import 'package:contact_book_mobile/core/models/contact.dart';
import 'package:contact_book_mobile/shared/colors/colors.dart';
import 'package:contact_book_mobile/shared/widgets/default_text.dart';
import 'package:contact_book_mobile/views/home_view/data/home_services.dart';
import 'package:contact_book_mobile/views/home_view/widgets/people_api_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ContactsTab extends StatefulWidget {
  bool isGoogleLogin = false;
  ContactsTab({Key? key, required this.isGoogleLogin}) : super(key: key);

  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  TextEditingController searchInputController = TextEditingController();

  late List<Contact> contacts = [];
  late List<Contact> foudContacts = [];

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        automaticallyImplyLeading: false,
        title: Container(
          height: 33.0,
          child: TextField(
              controller: searchInputController,
              onChanged: onSearchTextChanged,
              style: GoogleFonts.lato(
                  color: darkBlue, fontSize: 13.0, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                filled: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      if (!isControllerEmpty()) {
                        searchInputController.clear();
                        foudContacts = contacts;
                      }
                    });
                  },
                  icon: isControllerEmpty()
                      ? Icon(Icons.search)
                      : Icon(Icons.search_off),
                  iconSize: 20.0,
                  padding: EdgeInsets.only(bottom: 2.0),
                  color: darkBlue,
                ),
                fillColor: defaultWhite,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: defaultWhite),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: defaultWhite),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                contentPadding: EdgeInsets.only(top: 5.0, left: 15.0),
                hintText: "Search for a contact",
              )),
        ),
      ),
      body: Container(
        child: widget.isGoogleLogin
            ? PeopleApiWidget()
            : FutureBuilder(
                future: HomePageServices().getAllContactsByUserId(
                    UserController.instance.user.id,
                    AuthController.instance.token),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    contacts = snapshot.data;

                    return RefreshIndicator(
                      backgroundColor: darkBlue,
                      color: defaultWhite,
                      strokeWidth: 2.0,
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: contacts.length == 0
                          ? Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 300.0,
                                  minHeight: 200.0,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/any_contact_img.svg',
                                        height: 150.0,
                                      ),
                                      Padding(padding: EdgeInsets.all(8.0)),
                                      DefaultText(
                                        "You don't have any contacts yet try to add someone!",
                                        fontSize: 23.0,
                                        textAlign: TextAlign.center,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.refresh_outlined,
                                          color: darkBlue,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ListView.builder(
                                itemCount: isControllerEmpty()
                                    ? contacts.length
                                    : foudContacts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              (1 / 7.7),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxHeight: 60.0,
                                                maxWidth: 60.0,
                                                minHeight: 40.0,
                                                minWidth: 40.0,
                                              ),
                                              child: Container(
                                                // Catch image from https://picsum.photos/
                                                child: ClipOval(
                                                  child: Image.network(
                                                      'https://picsum.photos/id/${contacts[index].id}/200'),
                                                ),
                                              ),
                                            ),
                                            title: DefaultText(
                                              isControllerEmpty()
                                                  ? "${contacts[index].name}"
                                                  : "${foudContacts[index].name}",
                                              fontColor: darkBlue,
                                              fontSize: 21.0,
                                            ),
                                            subtitle: DefaultText(
                                              isControllerEmpty()
                                                  ? "${contacts[index].phone}"
                                                  : "${foudContacts[index].phone}",
                                              fontColor: darkBlue,
                                              fontSize: 15.0,
                                            ),
                                            onTap: () => {
                                              ContactController.instance
                                                  .addContact(
                                                      isControllerEmpty()
                                                          ? contacts[index]
                                                          : foudContacts[
                                                              index]),
                                              Navigator.pushNamed(
                                                  context, '/fourth')
                                            },
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Divider(
                                              color: darkBlue,
                                              thickness: 1.1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: defaultWhite,
                      color: darkBlue,
                      strokeWidth: 2.0,
                    ));
                  }
                },
              ),
      ),
    );
  }

  void onSearchTextChanged(String text) async {
    setState(() {
      var iterable = contacts.where((element) =>
          (element.name!.toLowerCase().contains(searchInputController.text)));

      foudContacts = iterable.toList();
    });
  }

  bool isControllerEmpty() {
    return searchInputController.text == "" ? true : false;
  }
}
