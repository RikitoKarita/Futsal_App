import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futsal_develop/common/talk_room_model.dart';
import 'package:futsal_develop/settings_profile/setting_profile.dart';
import 'package:futsal_develop/talk_room/talk_room.dart';
import 'package:futsal_develop/utils/shared_prefs.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '00_admob_baner.dart';
import 'utils/firestore.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
List<TalkRoomModel> talkUserList = [];

Future<void> createRooms() async{
  String? myUid = SharedPrefs.getUid();
  talkUserList = await Firestore.getRooms(myUid!);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2FFE4),
        appBar: AppBar(
          title: Text('トーク履歴'),
          actions: [
            IconButton(onPressed:(){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingProfilePage(),
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
                      itemCount: talkUserList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            print(talkUserList[index].roomId);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TalkRoom(talkUserList[index])));
                          },
                          child: Container(
                            height: 70,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CircleAvatar(backgroundImage: NetworkImage(talkUserList[index].talkUser.imagePath),
                                    radius: 30,),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(talkUserList[index].talkUser.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                    Text(talkUserList[index].lastMessage,style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis)
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

