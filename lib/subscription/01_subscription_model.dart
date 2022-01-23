import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    this.image_path = '';
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
  XFile ? imageFile;
  ImagePicker picker = ImagePicker();
  String ? image_path;
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final batolRef = _firestoreInstance.collection('BATOL_TBL');

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
    await uploadImage();
    try {
      await FirebaseFirestore.instance.collection('BATOL_TBL').add(
          {
            'BATOL_ID': batolRef.doc().id,
            'TEAM_ID': this.auth.currentUser!.uid,
            'TEAM_NAME': this.teamName,
            'TEAM_LEVEL': this.level,
            'BATOL_DATE': this.batolDate,
            'DESIRED_LEVEL': this.desiredLevel,
            'FREESPACE': this.freespace,
            'LOCATION': this.location,
            'RESERVED_FLG': this.reservedFlg,
            'IMAGE_PASS': this.image_path,
            'UPDATE_AT': this.date,
          }
      );
    } catch (e) {
      print('ユーザードキュメントの作成中にエラー');
      print(e.toString());
      throw ('エラーが発生しました。');
    }
  }

  Future<void>getImageFromGallery() async{
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = (pickedImage != null ? XFile(pickedImage.path): null)!;
    notifyListeners();
  }

  Future<String ?> uploadImage() async{
    DateTime now = DateTime.now();
    DateFormat outputFormat =
    DateFormat('yyyy-MM-dd-HH:mm:ss');
    this.date = outputFormat.format(now);

    File imageFileHenkan = File(imageFile!.path);
    final ref = FirebaseStorage.instance.ref('/batol_ticket/${this.auth.currentUser!.uid}/${this.date}.png');
    final storedImage = await ref.putFile(imageFileHenkan);
    image_path = await loadImage(storedImage);
    return image_path;
  }

  Future<String> loadImage(TaskSnapshot storedImage) async{
    String downloadUrl = await storedImage.ref.getDownloadURL();
    return downloadUrl;
  }

}
