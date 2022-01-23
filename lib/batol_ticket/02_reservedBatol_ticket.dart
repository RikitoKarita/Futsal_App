import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsal_develop/common/batol_tbl.dart';
import './../utils/firestore.dart';

class reservedBatolTicket extends StatefulWidget {
  @override
  _reservedBatolTicketState createState() => _reservedBatolTicketState();
}

class _reservedBatolTicketState extends State<reservedBatolTicket> {
  List<Batol_TBL> Batol_Tbl_List = [];

  Future<void> othersBatol_Serch() async {
    Batol_Tbl_List = await Firestore.othersBatol();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2FFE4),
        body:
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.roomSnapshot,
            builder: (context, snapshot) {
              return FutureBuilder(
                future: othersBatol_Serch(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: Batol_Tbl_List.length,
                        itemBuilder: (context, index) {
                          return
                            //トークルームチェックして、なかったら作成する処理を追加し遷移
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => TalkRoom(talkUserList[index])));
                            Card(
                              color: Color(0xFF27E28F),
                              child:
                              ListTile(title:
                              Row(
                                children: [
                                  Text(Batol_Tbl_List[index].TEAM_NAME,
                                      style: TextStyle(fontSize: 18,color: Colors.white)),
                                  Padding(padding: const EdgeInsets.only(
                                      left: 5.0),),
                                  Text("(開催日：",
                                      style: TextStyle(fontSize: 18,color: Colors.white)
                                  ),
                                  Text(Batol_Tbl_List[index].BATOL_DATE,
                                      style: TextStyle(fontSize: 18,color: Colors.white)),
                                  Text(")",
                                      style: TextStyle(fontSize: 18,color: Colors.white)
                                  ),
                                ],
                              ),
                                  subtitle:
                                  Row(children: [
                                    Text("希望ランク：",
                                        style: TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis),
                                    Text(Batol_Tbl_List[index].DESIRED_LEVEL,
                                        style: TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis),
                                    Padding(padding: const EdgeInsets.only(
                                        left: 5.0),),
                                    Text("開催場所：",
                                        style: TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis),
                                    Text(Batol_Tbl_List[index].LOCATION,
                                        style: TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                  )
                              ),
                            );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
        ));
  }
}

