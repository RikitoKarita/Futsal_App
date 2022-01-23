import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../00_admob_baner.dart';
import '../02_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './01_my_account_model.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyAccountModel>(
      create: (_) => MyAccountModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2FFE4),
        appBar: AppBar(
          title: Text('設定を変更'),
          backgroundColor: const Color(0xFF3CB371),
        ),
        body: Consumer<MyAccountModel>(builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Align(
                  alignment: Alignment.center,
                  child: TextField(
                     controller: model.teamNameCtl,
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'チーム名',
                     ),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: model.memberNameCtl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '所属メンバ',
                    ),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: model.levelCtl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'チームレベル', //プルダウン＆補足説明
                    ),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: model.activeLocationCtl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '主な活動場所',
                    ),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: model.missionCtl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'チーム目標',
                    ),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: model.addressCtl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '連絡先',
                    ),
                  )),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    child: Text('更新'),
                    onPressed: () {
                      model.updateTeamInfo();
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (context) => HomePage()));
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
