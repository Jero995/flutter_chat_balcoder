import 'package:flutter/material.dart';
import 'package:flutter_chat_balcoder/ui/auth/model/user_model.dart';
import 'package:flutter_chat_balcoder/ui/chat/chat_form_page.dart';
import 'package:flutter_chat_balcoder/ui/contact/contact_form_page.dart';
import 'package:flutter_chat_balcoder/ui/contact/contact_list_page.dart';
import 'package:flutter_chat_balcoder/ui/contact/model/contact_model.dart';

class HomePage extends StatefulWidget {
  HomePage({this.onSignOut, this.userModel});
  final VoidCallback onSignOut;
  UserModel userModel;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = new TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0D5F64),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.messenger_outline_rounded)),
          ],
        ),
        title: Text(
          "SarApp",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
              color: Colors.white),
        ),
        actions: [
          GestureDetector(
              child: Icon(Icons.menu),
              onTap: () {
                widget.onSignOut();
              }),
        ],
      ),
      body: Center(
          child: TabBarView(
        children: [ContactListPage(), Container()],
        controller: _tabController,
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              if (_tabController.index == 0) {
                return ContactFormPage(
                  contactModel: new ContactModel(),
                );
              } else {
                return ChatFormPage();
              }
            }));
          },
          backgroundColor: Color(0xff094043),
          child: Icon(Icons.add)),
    );
  }
}
