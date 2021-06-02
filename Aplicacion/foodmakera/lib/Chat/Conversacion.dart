import 'package:flutter/material.dart';
import 'package:foodmakera/PExtra.dart';
import 'package:foodmakera/Pantallas/ChatDetallado.dart';
import 'package:foodmakera/PChat.dart';
class Conversacion extends StatefulWidget{
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  Conversacion({@required this.name,@required this.messageText,@required this.imageUrl,@required this.time,@required this.isMessageRead});
  @override
  _ConversacionState createState() => _ConversacionState();

}
class _ConversacionState extends State<Conversacion> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => PExtra()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:AssetImage(widget.imageUrl) ,
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }

  void recivedtosender() {
    int cantidad = messages.length - 1;
    messages[cantidad].messageType = "receiver";
    messages[cantidad - 1].messageType = "sender";
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }
}