import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './../common/01_convert_error_message.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SubscriptionModel extends ChangeNotifier {
  SubscriptionModel() {
    this.batolDate = '';
    this.desiredLevel = '';
    this.freespace = '';
    this.location = '';
    this.reservedFlg = '0';
    this.teamName = '';
    this.auth = FirebaseAuth.instance;
    this.date = '';
    this.level ='';
  }

  late String batolDate;
  late String desiredLevel;
  late String freespace;
  late String location;
  late String reservedFlg;
  late String teamName;
  late FirebaseAuth auth;
  late String date;
  late String level;

  Future<void> init() async {
    DocumentSnapshot _userDoc = await FirebaseFirestore.instance
        .collection('TEAM_TBL')
        .doc('${this.auth.currentUser!.uid}')
        .get();
    this.teamName = _userDoc.get('TEAM_NAME');
    this.level = _userDoc.get('LEVEL');
    notifyListeners();
  }

  Future batol() async {
    /// BATOL_TBL コレクションにデータを保存
    DateTime now = DateTime.now();
    DateFormat outputFormat =
    DateFormat('yyyy/MM/dd HH:mm');
    this.date = outputFormat.format(now);
    try {
      await FirebaseFirestore.instance.collection('BATOL_TBL').add(
          {
            'TEAM_ID': this.auth.currentUser!.uid,
            'TEAM_NAME': this.teamName,
            'BATOL_DATE': this.batolDate,
            'DESIRED_LEVEL': this.desiredLevel,
            'FREESPACE': this.freespace,
            'LOCATION': this.location,
            'RESERVED_FLG': this.reservedFlg,
            'UPDATE_AT': this.date,
          }
      );
    } catch (e) {
      print('ユーザードキュメントの作成中にエラー');
      print(e.toString());
      throw ('エラーが発生しました。');
    }
  }
}
