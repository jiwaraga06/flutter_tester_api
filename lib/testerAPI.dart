import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TesterAPI extends StatefulWidget {
  TesterAPI({Key? key}) : super(key: key);

  @override
  State<TesterAPI> createState() => _TesterAPIState();
}

class _TesterAPIState extends State<TesterAPI> {
  bool loading = false;
  var list = {};
  void fetchData() async {
    setState(() {
      loading = true;
    });
    var uri = "https://covid19.mathdro.id/api";
    var response = await http.get(Uri.parse(uri));
    var json = jsonDecode(response.body);
    setState(() {
      loading = false;
      list = json;
    });
    print(json);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tester API"),
      ),
      body: loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Image.network(list['image'], fit: BoxFit.contain, height: 350,),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[600],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 1.4,
                              spreadRadius: 1.4,
                              offset: Offset(1,4),
                            )
                          ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("CONFIRMED", style: TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10),
                            // VALUE .toString() karena isinya integer ,widget text cuma nerima data string
                            Text(list['confirmed']['value'].toString(),style: TextStyle(color: Colors.white, fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 1.4,
                              spreadRadius: 1.4,
                              offset: Offset(1,4),
                            )
                          ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("RECOVERED", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10),
                            // VALUE .toString() karena isinya integer ,widget text cuma nerima data string
                            Text(list['recovered']['value'].toString(),style: TextStyle(color: Colors.white, fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 1.4,
                              spreadRadius: 1.4,
                              offset: Offset(1,4),
                            )
                          ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("DEATH", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10),
                            // VALUE .toString() karena isinya integer ,widget text cuma nerima data string
                            Text(list['deaths']['value'].toString(),style: TextStyle(color: Colors.white, fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                 
              ],
            ),
              ],
            ),
    );
  }
}
