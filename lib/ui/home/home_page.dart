import 'package:flutter/material.dart';
import 'package:flutter_chat_balcoder/ui/contact/model/contact_list_page.dart';

class HomePage extends StatefulWidget {
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
          bottom: TabBar(controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.messenger_outline_rounded)),
          ],
          ),
          title: Text("CHAT"),
        ),
        body: Center(child: TabBarView(

          children: [
            ContactListPage(),
            Container(),

          ],
          controller: _tabController,
        ),));
      
  }
}
