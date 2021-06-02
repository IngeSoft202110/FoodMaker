import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/ChatMessage.dart';
import 'package:foodmakera/Pantallas/ChatDetallado.dart';
import 'PChat.dart';


class PExtra extends StatefulWidget {
  @override
  _PExtraState createState() => _PExtraState();
}

class _PExtraState extends State<PExtra> {
  @override
  final mensaje = TextEditingController();
  Widget build(BuildContext context) {
    print(messages.length);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/nico.PNG"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Nico",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "Nico"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "Nico"
                          ? Colors.grey.shade200
                          : Colors.lightGreen[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: mensaje,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                          hintText: "Escriba su mensaje",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      guardar();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.lightGreen,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void guardar() {
    messages.add(
      ChatMessage(messageContent: mensaje.text, messageType: "JoseReus"),
    );
    print("entre");
    print(messages.length);
  }

  void recivedtosender() {
    int cantidad = messages.length - 1;
    messages[cantidad].messageType = "receiver";
    messages[cantidad - 1].messageType = "sender";
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }
}
