// This class is used to pass parameters to main pages
// To call these pages, a ScreenArguments object is required
class ScreenArguments {
  // This class is used to reuse the AddObjectsView main page,
  // to change between add a new contact or a new address

  // This parameter tells if will be add is a contact or an address
  final bool isAddingContact;
  // If an address will be add, the contact id is needed to request the service
  final int? contactId;

  ScreenArguments({required this.isAddingContact, required this.contactId});
}
