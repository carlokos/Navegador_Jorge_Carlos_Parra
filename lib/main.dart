import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Navegador());
}
class Navegador extends StatefulWidget {
  const Navegador({ Key? key }) : super(key: key);

  @override
  _NavegadorState createState() => _NavegadorState();
}

class _NavegadorState extends State<Navegador> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebviewScaffold(
        url: urlInicial,
        withJavascript: true,
        withLocalStorage: true,
        withZoom: false,
        enableAppScheme: true,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black,),
          actions:<Widget>[
            IconButton(onPressed: ()=>navegador.goBack(),
             icon: Icon(Icons.arrow_back)
            ),
            IconButton(onPressed: ()=>webviewProcess(),
             icon: Icon(Icons.search),
            ),
            IconButton(onPressed: ()=>navegador.goForward(),
            icon: Icon(Icons.arrow_forward)
            ),
          ],

           title: Padding(
             padding: const EdgeInsets.all(3.0),
             child: Container(
               height: 30,
              decoration: 
              BoxDecoration (
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(3.0),
              child: TextField(
                textInputAction: TextInputAction.go,
                controller: buscador,
                onSubmitted: (url)=>webviewProcess(),
                decoration: 
                  InputDecoration(
                    border: InputBorder.none,
                    hintText: "Hoy voy a tener suerte",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
              ),
          ),
          ),  
        ),
      ),
      
    );
  }
  
  FlutterWebviewPlugin navegador = new FlutterWebviewPlugin();
  var buscador = TextEditingController();
  var urlInicial="https://google.es/";
  void webviewProcess(){
    setState(() {
      if (buscador.text.contains('.')){
        urlInicial="https://"+buscador.text;
        FocusScope.of(context).unfocus();
      }
      else{
        urlInicial="https://google.es/search?q="+buscador.text;
        FocusScope.of(context).unfocus();
      }
      navegador.reloadUrl(urlInicial);
    });
  }

}