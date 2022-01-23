import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsal_develop/batol_ticket_detail/batol_ticket_detail.dart';
import 'package:futsal_develop/common/batol_tbl.dart';
import 'package:futsal_develop/setting/02_my_account.dart';
import './../utils/firestore.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Batol_TBL> Batol_Tbl_List = [];

  Future<void> othersBatol_Serch() async {
    Batol_Tbl_List = await Firestore.othersBatol();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2FFE4),
        appBar: AppBar(
            title: Text("対戦相手を見つける",
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: 18,
                )),
            iconTheme: const IconThemeData(
              color: const Color(0xFFFFFFFF),
            ),
            backgroundColor: const Color(0xFF3CB371),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings, color: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyAccount()));
                  })
            ]),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            Container(
              height: 60.0,
              child: DrawerHeader(
                child: Text("メニュー"),
                decoration: BoxDecoration(),
              ),
            ),
            ListTile(
              title: Text('操作手順書',
                  style: TextStyle(
                    color: const Color(0xFF737373),
                  )),
              // onTap: _manualURL,
            ),
            ListTile(
              title: Text('問い合わせ',
                  style: TextStyle(
                    color: const Color(0xFF737373),
                  )),
              // onTap: _FAQURL,
            )
          ],
        )),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.batolSnapshot,
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
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(Batol_Tbl_List[index].TEAM_NAME,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                  ),
                                  Text("(開催日：",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  Text(Batol_Tbl_List[index].BATOL_DATE,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  Text(")",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text("希望ランク：",
                                      style: TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis),
                                  Text(Batol_Tbl_List[index].DESIRED_LEVEL,
                                      style: TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                  ),
                                  Text("開催場所：",
                                      style: TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis),
                                  Text(Batol_Tbl_List[index].LOCATION,
                                      style: TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BatolTicketDetail.make(
                                                Batol_Tbl_List[index].BATOL_ID,
                                                Batol_Tbl_List[index].TEAM_ID,
                                                Batol_Tbl_List[index].TEAM_NAME,
                                                Batol_Tbl_List[index]
                                                    .TEAM_LEVEL,
                                                Batol_Tbl_List[index]
                                                    .BATOL_DATE,
                                                Batol_Tbl_List[index]
                                                    .DESIRED_LEVEL,
                                                Batol_Tbl_List[index].FREESPACE,
                                                Batol_Tbl_List[index].LOCATION,
                                                Batol_Tbl_List[index]
                                                    .RESERVED_FLG,
                                                Batol_Tbl_List[index]
                                                    .IMAGE_PASS,
                                                Batol_Tbl_List[index]
                                                    .UPDATE_AT)));
                              },
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            }));
  }
}
