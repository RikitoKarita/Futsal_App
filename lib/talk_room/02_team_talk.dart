import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsal_develop/common/01_team_talk_room.dart';
import 'package:futsal_develop/setting/02_my_account.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../00_admob_baner.dart';
import '../utils/firestore.dart';
import '02_talk_room.dart';

class TeamTalkList extends StatefulWidget {
  @override
  _TeamTalkListState createState() => _TeamTalkListState();
}

class _TeamTalkListState extends State<TeamTalkList> {
  List<TeamTalkRoomModel> talkTeamList = [];

  Future<void> createRooms() async{
    talkTeamList = await Firestore.getTeamRooms(Firestore.auth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2FFE4),
        appBar: AppBar(
          backgroundColor: const Color(0xFF3CB371),
          title: Text('トーク履歴'),
          actions: [
            IconButton(onPressed:(){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyAccount(),
                ),
              );
            }, icon: Icon(Icons.settings))
          ],
        ),
        drawer: Drawer(
            child: ListView(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10.0)),
                AdBanner(size: AdSize.banner),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                Container(
                  height: 60.0,
                  child: DrawerHeader(
                    child: Text("メニュー"),
                    decoration: BoxDecoration(),
                  ),
                ),
                ListTile(
                  title: Text('利用規約同意書', style: TextStyle(color: Colors.black54)),
                  // onTap: _manualURL,
                ),
                ListTile(
                  title: Text('アプリ操作手順書', style: TextStyle(color: Colors.black54)),
                  // onTap: _FAQURL,
                )
              ],
            )),
        body:
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.roomSnapshot,
            builder: (context, snapshot) {
              return FutureBuilder(
                future: createRooms(),
                builder:(context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    return  ListView.builder(
                        itemCount: talkTeamList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TeamTalkRoom(talkTeamList[index])));
                            },
                            child: Container(
                              height: 70,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: CircleAvatar(backgroundImage: NetworkImage(talkTeamList[index].talkTeam.IMAGE_PASS),
                                      radius: 30,),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(talkTeamList[index].talkTeam.TEAM_NAME,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                      Text(talkTeamList[index].lastMessage,style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
        ));
  }
}

