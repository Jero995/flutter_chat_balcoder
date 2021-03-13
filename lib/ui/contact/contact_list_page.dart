import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_chat_balcoder/ui/contact/contact_form_page.dart';
import 'package:flutter_chat_balcoder/ui/contact/model/contact_model.dart';
import 'package:flutter_chat_balcoder/ui/contact/contact_services.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  ContactService _contactService = new ContactService(); //usar metodo
  List<ContactModel> _contactList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Agregar a BD
    // _contactService.addContact(new ContactModel(contactName: "Nombre del contacto", phoneNumber: "320"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffe9fbfc),
      child: StreamBuilder(
        stream: _contactService.contactCollection
            .where('isDeleted', isEqualTo: false)
            .snapshots(), //Hacer que la ref bd nos traiga la info
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: new CircularProgressIndicator(),
              );
            // break;
            default:
              _contactList = [];
              //Recorrer informacion de los documentos
              snapshot.data.docs.forEach((doc) {
                _contactList.add(new ContactModel.fromSnapshot(doc));
              });

              return ListView.builder(
                itemCount: _contactList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return ContactFormPage(
                                contactModel: _contactList[index]);
                          }));
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.amberAccent,
                          child: Text(
                            _contactList[index].contactName[0].toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(_contactList[index].contactName),
                        subtitle: Text(_contactList[index].phoneNumber),
                        trailing: GestureDetector(
                            onTap: () {
                              return showAlertDialog(
                                  context, _contactList[index]);
                              //_contactService.deleteContact(_contactList[index]);
                            },
                            child: Icon(Icons.delete)),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context, ContactModel x) {
  List<ContactModel> _contactList = [];
  ContactService _contactService = new ContactService();
  // set up the button
  Widget okButton = FlatButton(
    child: Text("Aceptar"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget alerta() {
    return Center(
      child: Container(
        color: Colors.white,
        width: 220,
        height: 100,
        child: Column(
          children: [
            Title(color: Colors.black, child: Text("¿Seguro?")),
            Spacer(),
            Text(
              "Se eliminara a ${x.contactName} de tu lista de contactos.",
              style: TextStyle(color: Colors.black),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                print("hggc");
                _contactService.deleteContact(x);
                Navigator.of(context).pop();
              },
              child: Text(
                "Aceptar",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta();
    },
  );
}
