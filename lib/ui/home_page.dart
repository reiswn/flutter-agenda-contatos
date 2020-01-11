import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

// Atalho st

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();

    *//*Contact c = Contact();

    c.name = "Name test";
    c.email = "email@test";
    c.phone = "123456789";
    c.img = "testeimg";

    helper.saveContact(c);*//*

    helper.getAllContacts().then((list){
      print(list);
    });

  }*/


}
