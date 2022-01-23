import 'package:flutter/material.dart';
import 'package:futsal_develop/utils/firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/cupertino.dart';
import '../00_admob_baner.dart';

class BatolTicketDetail extends StatefulWidget {
  late String BATOL_ID;
  late String TEAM_ID;
  late String TEAM_NAME;
  late String TEAM_LEVEL;
  late String BATOL_DATE;
  late String DESIRED_LEVEL;
  late String FREESPACE;
  late String LOCATION;
  late String RESERVED_FLG;
  late String IMAGE_PASS;
  late String UPDATE_AT;

  BatolTicketDetail.make(
      this.BATOL_ID,
      this.TEAM_ID,
      this.TEAM_NAME,
      this.TEAM_LEVEL,
      this.BATOL_DATE,
      this.DESIRED_LEVEL,
      this.FREESPACE,
      this.LOCATION,
      this.RESERVED_FLG,
      this.IMAGE_PASS,
      this.UPDATE_AT);

  @override
  _BatolTicketDetailState createState() => _BatolTicketDetailState();
}

class _BatolTicketDetailState extends State<BatolTicketDetail> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF2FFE4),
      appBar: AppBar(
          title: Text('対戦チケットを参照'),
          backgroundColor: const Color(0xFF3CB371),
          // leading:
          //   IconButton(
          //       icon: Icon(Icons.arrow_back, color: Colors.black),
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) =>
          //                     Search()));
          //       })
          ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 10.0)),
              AdBanner(size: AdSize.banner),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  Container(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child:
                              Icon(Icons.face, size: 16, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'チーム名:',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  )),
                  Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  Container(
                    child: Text(
                      widget.TEAM_NAME,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  Container(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.star_rate_outlined,
                              color: Colors.black, size: 16),
                        ),
                        TextSpan(
                          text: 'ランク:',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  )),
                  Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  Container(
                    child: Text(
                      widget.TEAM_LEVEL,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0)),
              Container(
                  width: deviceWidth * 0.95,
                  height: deviceHeight * 0.35,
                  child: Image.network(widget.IMAGE_PASS)),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0)),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  Container(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.calendar_today_sharp,
                              color: Colors.black, size: 14),
                        ),
                        TextSpan(
                          text: '希望日時:',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    child: Text(
                      widget.BATOL_DATE,
                      style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  Container(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.location_on_outlined,
                              color: Colors.black, size: 16),
                        ),
                        TextSpan(
                          text: '希望開催場所:',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    child: Text(
                      widget.LOCATION,
                      style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0)),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  Container(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.star_rate_outlined,
                              size: 16, color: Colors.black),
                        ),
                        TextSpan(
                          text: '希望対戦相手ランク:',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  )),
                  Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  Container(
                    child: Text(
                      widget.DESIRED_LEVEL,
                      style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Lev.1： 初心者のみ'),
                                  Text('Lev.2： 初心者(多)＆経験者(少)'),
                                  Text('Lev.3： 初心者(少)＆経験者(多)'),
                                  Text('Lev.4： 経験者のみ'),
                                  Text('Lev.5： 経験者のみ（上級）'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('閉じる'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ));
                    },
                    child: Text(
                      '詳細',
                      style: TextStyle(
                          fontSize: 14, color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0)),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0)),
                  Container(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.paste_outlined,
                              size: 16, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'その他伝えたいこと',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green,width: 2),
                ),
                width: deviceWidth * 0.95,
                height: deviceHeight * 0.05,
                child: Text(
                  widget.FREESPACE,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0)),
              Align(
                alignment: Alignment.center,
                child: FloatingActionButton.extended(
                  icon: Icon(Icons.sports_kabaddi_sharp),
                  label: Text('開催者へ連絡する'),
                  backgroundColor: const Color(0xFFFF9426),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: const <Widget>[
                                    Text('開催者とトークルームを作成しますか'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FloatingActionButton(
                                  child: const Text('はい'),
                                  onPressed: () async {
                                    await Firestore.checkTeamRoom(Firestore.auth.currentUser!.uid,widget.TEAM_ID);
                                    if(Firestore.teamCheck) {
                                      print("既に作成されています");
                                    }else{
                                      await Firestore.addTeamRoom(
                                          Firestore.auth.currentUser!.uid,
                                          widget.TEAM_ID);
                                    }

                                    Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: const <Widget>[
                                                    Text('トークルームを作成しました\n'
                                                        '対戦相手から連絡が来るまで少々お待ちください。'),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FloatingActionButton(
                                                  child: const Text('閉じる'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ));
                                  },
                                ),
                                FloatingActionButton(
                                  child: const Text('いいえ'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
