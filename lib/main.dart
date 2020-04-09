import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.deepPurpleAccent
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.lightGreenAccent,
        ),
      ),
      title: "Todo_app",
      debugShowCheckedModeBanner: false,
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyPage createState() => _MyPage();

}
  class _MyPage extends State<MyHomePage>{

    List<String> todoList = List<String>();
    List<bool> boolList = List<bool>();
    List<String> doneList = List<String>();

  Widget _MyWidget(List lt){
    for(int i = 0; i < lt.length; i++ ){
      boolList.add(false);
    }
    if (lt.length <= 0){
      return Text("");
    }else{
      return Center(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5.0,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                children: <Widget>[
                  Checkbox(
                    value: boolList[index],
                    onChanged: (bool value){
                      setState(() {
                        if(value){
                        boolList[index] = value;
                        doneList.add(todoList[index]);
                        }else{
                          boolList[index] = value;
                          doneList.remove(todoList[index]);
                        }
                      });
                    },
                  ),
                Text(lt[index]),

                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 30.0,
                    onPressed: (){

                      String inputText = "";
                      return showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Add some : "),
                              content: TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: lt[index],
                                ),
                                onChanged: (text){
                                  inputText = text;
                                },
                              ),
                              actions: <Widget>[ FlatButton(
                                child: Text("OK"),
                                onPressed: (){
                                  setState(() {
                                    todoList[index] = inputText;
                                    doneList[index] = inputText;
                                  });
                                  Navigator.of(context).pop();
                                },
                              )
                              ],
                            );
                          }
                      );

                    },
                  ),

                  IconButton(
                    alignment: Alignment.centerLeft,
                      icon: Icon(Icons.cancel),
                      onPressed: (){
                        setState(() {
                          todoList.removeAt(index);
                          boolList.removeAt(index);
                          print(todoList);
                          print(index);
                        });
                      }
                  ),
                ]
                ),
              )
            );
          }
        )
      );
    }
  }

@override
  Widget build(BuildContext context){

    _addTODO(){
      String inputText = "";
      return showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Add some : "),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Write here..."
                ),
                onChanged: (text){
                  inputText = text;
                },
              ),
               actions: <Widget>[ FlatButton(
                  child: Text("OK"),
                  onPressed: (){
                    setState(() {
                      todoList.add(inputText);
                    });
                    Navigator.of(context).pop();
                  },
                )
            ],
            );
          }
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: Text("ToDo List", textAlign: TextAlign.center),
        actions: <Widget>[
         IconButton(
           icon: Icon(Icons.assignment_turned_in),
           onPressed: (){
             setState(() {
             });
             Navigator.push(context, MaterialPageRoute(builder: (context) => Done(doneList)));
           },
         ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/deer.png"),
            fit: BoxFit.cover
          )
        ),
      child: Center(
          child: Column(
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.deepPurpleAccent,
              splashColor: Colors.yellow[200],
              child: Text("Add", style: TextStyle(color: Colors.white),),
              onPressed: (){
                setState(() {
                  _addTODO();
                });
              },
            ),
            _MyWidget(todoList)
          ]
          )
        ),
      ),
    );
  }
}

class Done extends StatefulWidget {
  List<String> doneList;
  Done(this.doneList);
  _Done createState() => _Done(doneList);

}
class _Done extends State<Done>{

  //_MyPage hm = new _MyPage();
  List<String> doneList;
  _Done(this.doneList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You have DONE: "),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/check2.png"),
                fit: BoxFit.cover
            )
        ),
        child: Column(
        children: <Widget>[
        Center(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
            //itemCount: hm.doneList.length,
            itemCount: doneList.length,
            itemBuilder: (BuildContext context, int index) {
                    return Card(
                elevation: 5.0,
          color: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Text(doneList[index], style: TextStyle(color: Colors.white, fontSize: 25.0)),
          )
      );
    }
        ),
      ),]
      ),
      ),
    );
  }
}