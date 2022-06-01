import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Carpediemデバッグフォーム'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? _pname = "カミヤ";
  String? _pgame = "KitPvP";
  String conts = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void connect() async{
    try{
      var conn = await MySqlConnection.connect(ConnectionSettings(
        host: "public.e54tz.tyo2.database-hosting.conoha.io",
        port: 3306,
        user: "e54tz_debugtool",
        password: "Eyeofthe4402car",
        db: "e54tz_carpediem_dbgs"
      ));
    }catch(e){
      print(e);
    }

    //await conn.query("INSERT INTO opinion VALUES (?,?)",[_pname,conts]);
    //await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child:TextField(
                enabled:true,
                onChanged: (value) {
                  setState(() {
                    conts = value;
                  });
                },
              ),
              height: 100,
              width: 500
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [      
                const Text("ユーザー："),      
                DropdownButton(
                  items: const[
                    DropdownMenuItem(
                      child: Text("カミヤ"),
                      value: "カミヤ"
                    ),
                    DropdownMenuItem(
                      child: Text("ルイ"),
                      value: "ルイ"
                    ),
                  ],
                  value: _pname,
                  onChanged: (String? value) {
                    setState(() {
                      _pname = value;
                    });
                  },
                ),
                const Text("対象ゲーム："),
                DropdownButton(
                  items: const[
                    DropdownMenuItem(
                      child: Text("KitPvP"),
                      value: "KitPvP"
                    ),
                    DropdownMenuItem(
                      child: Text("TableWars"),
                      value: "TableWars"
                    ),
                    DropdownMenuItem(
                      child: Text("鬼ごっこ倶楽部"),
                      value: "鬼ごっこ倶楽部"
                    ),
                  ],
                  value: _pgame,
                  onChanged: (String? value) {
                    setState(() {
                      _pgame = value;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    connect();
                  },
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
