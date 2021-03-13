import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_balcoder/ui/chat/chat_services.dart';
import 'package:flutter_chat_balcoder/ui/chat/model/chat_model.dart';

class ChatFormPage extends StatefulWidget {
  @override
  _ChatFormPageState createState() => _ChatFormPageState();
}

class _ChatFormPageState extends State<ChatFormPage> {
  ChatServices _chatServices = new ChatServices();
  List<ChatModel> _chatList = [];
  final _listViewController = ScrollController();
  String myUID;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _widht = MediaQuery.of(context).size.width;
    TextEditingController _cMessage = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0D5F64),
        title: Text("ChatPage"),
      ),
      backgroundColor: Color(0xffe9fbfc),
      body: Column(
        children: [
          Container(
            width: _widht,
            height: _height*0.8, 
            child: StreamBuilder(
        stream: _chatServices.chatCollection.orderBy('createdDate', descending: false).snapshots(),
        //Hacer que la ref bd nos traiga la info
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator(),);
             // break;
            default:
            _chatList = [];
            //Recorrer informacion de los documentos
            snapshot.data.docs.forEach((doc){
            _chatList.add(new ChatModel.fromSnapshot(doc));
            });
              Future.delayed(const Duration(milliseconds: 1),(){
              _listViewController.animateTo(_listViewController.position.maxScrollExtent, 
              duration: Duration(milliseconds: 1), curve: Curves.fastOutSlowIn);
              });
            return ListView.builder(
              controller: _listViewController,
              itemCount: _chatList.length,
              itemBuilder: (BuildContext context, int index) { 
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: BoxDecoration(color: _chatList[index].sendToUID == myUID ? Color(0xff36797D) : Color(0xff17A8B0), 
                    borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_chatList[index].message, style: TextStyle(color: Colors.white),),
                    ),
                    
                  ),
                );
               },);
          }
         },),),
          Container(height: _height*0.1, color: Colors.transparent,
          child: Row(
            children: [
              Container(
                width: _widht*0.8,
                height: _height*0.2,
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: _cMessage,
                  decoration: InputDecoration(labelText: "Message",
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.blueGrey)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0), 
                    borderSide: BorderSide(color: Colors.blueGrey))
                  
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  child: FloatingActionButton(
                    mini: true,
                    
                    onPressed: (){

                      ChatModel _chatModel = new ChatModel();
                      _chatModel.message = _cMessage.text;
                      _chatModel.sendToUID = "a123";
                      _chatModel.uid = "de33";
                      _chatModel.createdDate = new Timestamp.now();

                      _chatServices.addChat(_chatModel);
                      _cMessage.text = "";
                    }, child: Icon(Icons.send),
                    ),
                    
                ),
              ),
            ],
          ),
          ),
        ],
      ),
      
    );
  }
}