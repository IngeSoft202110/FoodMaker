import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Clases/Chatusers.dart';
import 'Clases/ListaDeConversacion.dart';
import 'package:foodmakera/Clases/ChatMessage.dart';

List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hola nico", messageType: "JoseReus")
];
class PChat extends StatefulWidget {

  _PChatState createState() => _PChatState();
}

class _PChatState extends State<PChat> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jose Arias",
        messageText: messages.last.messageContent,
        imageURL: "assets/perfil1.jpeg",
        time: "Now"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Chats',
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
          ListView.builder(
            itemCount: chatUsers.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return ListaDeConversacion(
                name: chatUsers[index].name,
                messageText: chatUsers[index].messageText,
                imageUrl: chatUsers[index].imageURL,
                time: chatUsers[index].time,
                isMessageRead: (index == 0 || index == 3)?true:false,
              );
            },
          ),
        ],
      ),
    );
  }

  void cambioenvio(){
    int cantidad = messages.length;
    for(int i=0; i<cantidad-1 ;i++)
    {
      if(messages[i].messageType=="sender"){
        messages[i].messageType="receiver";
      }
      if(messages[i].messageType=="receiver"){
        messages[i].messageType="sender";
      }

    }
  }
}
