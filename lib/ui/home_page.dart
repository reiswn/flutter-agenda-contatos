import 'dart:io';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:agenda_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';

// Atalho st

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override
  void initState() {
    // TODO: implement an action for null return of getAll
    super.initState();

    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){_showContactPage();},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            //Contact contact = contacts[index];
            //return ListTile(title: Text(contact.toString()));
            return _contactCard(context, index);
          }
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      onTap: (){_showContactPage(contact: contacts[index]);},
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ?
                    FileImage(File(contacts[index].img)) :
                    AssetImage("images/default-user.jpg")
                  ),
                ),
              ),
             Padding(
               padding: EdgeInsets.only(left: 10.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(contacts[index].name ?? "",
                     style: TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.bold
                     ),
                   ),
                   Text(contacts[index].email ?? "",
                     style: TextStyle(
                         fontSize: 18.0,
                     ),
                   ),
                   Text(contacts[index].phone ?? "",
                     style: TextStyle(
                         fontSize: 18.0,
                     ),
                   ),
                 ],
               ),
             )
            ],
          ),
        ),
      ),
    );
  }

  void _showContactPage({Contact contact}) async {
     final returnedContact = await Navigator.push(context, MaterialPageRoute(
      builder: (context) => ContactPage(contact: contact),
    ));

    if(returnedContact != null){
      if(contact != null){
        await helper.updateContact(returnedContact);
        _getAllContacts();
      } else {
        await helper.saveContact(returnedContact);
      }
    }
  }

  void _getAllContacts(){
    helper.getAllContacts().then((list){
      setState(() {
        contacts = list;
      });
    });
  }

}
