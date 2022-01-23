import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsal_develop/common/batol_tbl.dart';
import 'package:futsal_develop/common/talk_room_model.dart';
import 'package:futsal_develop/settings_profile/setting_profile.dart';
import 'package:futsal_develop/talk_room/talk_room.dart';
import 'package:futsal_develop/utils/shared_prefs.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import './../00_admob_baner.dart';
import './../02_home.dart';
import './../common/01_user.dart';
import './../utils/firestore.dart';

class myBatol_Serch extends StatefulWidget {
  @override
  _myBatol_SerchState createState() => _myBatol_SerchState();
}

class _myBatol_SerchState extends State<myBatol_Serch> {
  List<Batol_TBL> Batol_Tbl_List = [];

  Future<void> myBatol_Serch() async {
    Batol_Tbl_List = await Firestore.myBatol();
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
                future: myBatol_Serch(),
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
                                      style: TextStyle(fontSize: 16,color: Colors.white)),
                                  Padding(padding: const EdgeInsets.only(
                                      left: 5.0),),
                                  Text("(開催日：",
                                      style: TextStyle(fontSize: 16,color: Colors.white)
                                  ),
                                  Text(Batol_Tbl_List[index].BATOL_DATE,
                                      style: TextStyle(fontSize: 16,color: Colors.white)),
                                  Text(")",
                                      style: TextStyle(fontSize: 16,color: Colors.white)
                                  ),
                                  Padding(padding: const EdgeInsets.only(
                                      left: 15.0),),
                                  Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                          color:Colors.white
                                    ),
                                      child: Batol_Tbl_List[index].RESERVED_FLG == "0" ? Center(child: Text("予約\n受付中",style:TextStyle(fontSize: 12,color: Colors.red))):Center(child: Text("予約\n受付終了",style:TextStyle(fontSize: 12,color: Colors.white)))
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

