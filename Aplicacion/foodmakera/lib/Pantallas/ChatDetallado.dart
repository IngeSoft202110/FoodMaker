import 'package:flutter/material.dart';

class ChatDetallado extends StatefulWidget{

  @override
  _ChatDetalladoState createState() => _ChatDetalladoState();
}

class _ChatDetalladoState extends State<ChatDetallado> {
  @override
  Widget build(BuildContext context) {
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
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/perfil1.jpeg"),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Jose Arias",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.settings,color: Colors.black54,),
                ],
              ),
            ),
          ),
        ),
        body: Container()
    );

  }
}