import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:foodmakera/PantallasCrearReceta/PCRContenido.dart';
import 'package:foodmakera/PantallasCrearReceta/PCRInfoGeneral.dart';
import 'package:foodmakera/PantallasCrearReceta/PCRIngredientes.dart';
import 'package:foodmakera/PantallasCrearReceta/PCRPasos.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

int posicionp=0;
double porcentaje=0.25;
Receta receta=Receta.vacia();
Verificar listaVerificar = Verificar(
  [false],
  [false],
  [false],
  [false]);

class PCRPrincipal extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => EstadoPCRPrincipal();
  }

class EstadoPCRPrincipal extends State<PCRPrincipal>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Crear Receta') ),
        body: Stack(
          children:<Widget> [
            devolverPantalla(posicionp),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed:() {
                  setState(() {
                    if(posicionp > 0){
                      posicionp--;
                      porcentaje=porcentaje-0.25;
                    }
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.chevron_right),
                    onPressed:() {
                      setState(() {
                        if(posicionp < 3){
                          posicionp++;
                          porcentaje=porcentaje+0.25;
                        }
                      });
                    }
                )
            )
          ],
        ),
        bottomSheet:
        Container(
            height: 50,
            child:Column(
              children:<Widget> [
                SizedBox(
                  height: 10,
                ),
                Row(
                    children:<Widget> [
                      SizedBox(width: 15,),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width-30,
                        lineHeight: 20.0,
                        animationDuration: 1000,
                        percent: porcentaje,
                        center: Text("${porcentaje*100} %"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                        backgroundColor: Colors.green.withOpacity(0.2),
                      )]
                )
              ],
            )
        )
    );
  }
}





 devolverPantalla(int i){
  switch(i){
    case 0:{
      return PCRInfoGeneral(receta, listaVerificar);
    }
    break;

    case 1:{
        validarNombre();
        print("xdddddd" + listaVerificar.infoGeneral[0].toString());
        if (listaVerificar.infoGeneral[0]) {
          return PCRIngredientes(receta, listaVerificar);
        }
        else {
          return Text("Nombre invalido");
        }
    }
    break;

    case 2:{
      return PCRContenido(receta, listaVerificar);
    }
    break;

    case 3:{
      return PCRPasos(receta, listaVerificar);
    }
    break;

    default:{
      return Center(child: Text('Error'),);
    }
    break;
  }

 }

 class Verificar {
  Verificar(
      this.infoGeneral,
      this.ingredientes,
      this.contenido,
      this.pasos);

  List<bool> infoGeneral;
  List<bool> ingredientes;
  List<bool> contenido;
  List<bool> pasos;
 }
