import 'package:flutter/material.dart';
import '02_home.dart';
import '01_firebase.dart';

class TeamR extends StatefulWidget {
  @override
  _TeamRState createState() => _TeamRState();
}

class _TeamRState extends State<TeamR> {
  var teamIdCtl = TextEditingController();
  var teamPassWord = TextEditingController();
  var teamNameCtl = TextEditingController();
  var memberNameCtl = TextEditingController();
  var levelCtl = TextEditingController();
  var activeLocationCtl = TextEditingController();
  var missionCtl = TextEditingController();
  var addressCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: TextField(
                controller: teamIdCtl,
                decoration: const InputDecoration(
                  icon: Icon(Icons.face),
                  hintText: 'チームIDを入力してください',
                  labelText: 'チームID',
                  border: OutlineInputBorder(),
                ),
              )
          ),
          Align(
              alignment: Alignment.center,
              child: TextField(
                controller: teamPassWord,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'パスワード(8文字以上)',
                ),
              )
          ),
          Align(
              alignment: Alignment.center,
              child: TextField(
                controller: teamNameCtl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'チーム名',
                ),
              )
          ),
          Align(
              alignment: Alignment.center,
              child: TextField(
                controller: memberNameCtl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '所属メンバ',
                ),
              )
          ),
          Align(
              alignment: Alignment.center,
              child: TextField(
                controller: levelCtl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'チームレベル',//プルダウン＆補足説明
                ),
              )
          ),
          Align(
              alignment: Alignment.center,
              child: TextField(
                controller: activeLocationCtl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '主な活動場所',
                ),
              )
          ),
          Align(
              alignment: Alignment.center,
              child: TextField(
                controller: missionCtl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'チーム目標',
                ),
              )
          ),
          Align(
              alignment: Alignment.center,
              child: TextField(
                controller: addressCtl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '連絡先',
                ),
              )
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                child: Text('登録'),
                onPressed: () async {
                  String teamId = teamIdCtl.text;
                  String teamPass = teamPassWord.text;
                  String teamName = teamNameCtl.text;
                  String memberName = memberNameCtl.text;
                  String level = levelCtl.text;
                  String activeLocation = activeLocationCtl.text;
                  String mission = missionCtl.text;
                  String address = addressCtl.text;
                  await firebaseMethod().createTeamInfo(teamId: teamId, teamPass: teamPass, teamName: teamName, memberName: memberName, level: level, activeLocation: activeLocation, mission: mission, address: address);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => HomePage(user_id: "")));
                }
            ),
          ),
        ],
      ),
    );
  }
}