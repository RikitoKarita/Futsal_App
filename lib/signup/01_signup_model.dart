import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import './../common/01_convert_error_message.dart';

class SignUpModel extends ChangeNotifier {
  SignUpModel() {
    this.agreeGuideline = false;
    this.showingDialog = false;
    this.mail = '';
    this.password = '';
    this.confirm = '';
    this.errorMail = '';
    this.errorPassword = '';
    this.errorConfirm = '';
    this.errorTeamName = '';
    this.errorMission = '';
    this.errorAddress = '';
    this.isLoading = false;
    this.isMailValid = false;
    this.isPasswordValid = false;
    this.isConfirmValid = false;
    this.isTeamNameValid = false;
    this.isMissionValid = false;
    // this.userCredential = null;
    this.isGuestAllowed = false;
    // this.teamPass = '';
    this.teamName = '';
    // this.memberName = '';
    this.level = '';
    this.activeLocation = '';
    this.mission = '';
    this.image_path = '';
    this.date = '';
  }

  late bool agreeGuideline;
  late bool showingDialog;
  late String mail;
  late String password;
  late String confirm;
  late String errorMail;
  late String errorPassword;
  late String errorConfirm;
  late String errorTeamName;
  late String errorMission;
  late String errorAddress;
  late bool isLoading;
  late bool isMailValid;
  late bool isPasswordValid;
  late bool isConfirmValid;
  late bool isTeamNameValid;
  late bool isMissionValid;
  late UserCredential userCredential;
  late bool isGuestAllowed;
  // late String teamPass;
  late String teamName;
  // late String memberName;
  late String level;
  late String activeLocation;
  late String mission;
  XFile ? imageFile;
  ImagePicker picker = ImagePicker();
  String ? image_path;
  late String date;
  
  Future<void> init() async {
    notifyListeners();
  }

  Future signUp(
      ) async {
    if (this.password != this.confirm) {
      throw ('パスワードが一致しません。');
    }

    /// 入力されたメール, パスワードで UserCredential を作成
    try {
      this.userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: this.mail,
        password: this.password,
      );
    } on FirebaseAuthException catch (e) {
      print('エラーコード：${e.code}\nエラー：$e');
      throw (convertErrorMessage(e.code));
    }

    /// UserCredential の null チェック
    if (this.userCredential == null) {
      print('UserCredential が見つからないエラー');
      throw ('エラーが発生しました。');
    }

    /// users コレクションにユーザーデータを保存
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      WriteBatch _batch = _firestore.batch();

      // user ドキュメント
      DocumentReference _teamDoc =
          _firestore.collection('TEAM_TBL').doc(this.userCredential.user!.uid);

      // user ドキュメントのフィールド
      Map<String, dynamic> _teamFields = {
        'TEAM_ID': this.userCredential.user!.uid,
        'TEAM_PASS': this.password,
        'TEAM_NAME': this.teamName,
        'LEVEL' : this.level,
        'ACTIVE_LOCATION': this.activeLocation,
        'MISSION': this.mission,
        'IMAGE_PASS': this.image_path,
      };

      _batch.set(_teamDoc, _teamFields);
      await _batch.commit();
      uploadImage();
      
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
    final ref = FirebaseStorage.instance.ref('/myTeamProfile/${this.userCredential.user!.uid}/${this.date}.png');
    final storedImage = await ref.putFile(imageFileHenkan);
    image_path = await loadImage(storedImage);
    return image_path;
  }
  
  Future<String> loadImage(TaskSnapshot storedImage) async{
    String downloadUrl = await storedImage.ref.getDownloadURL();
    return downloadUrl;
  }
  
  

  void changeMail(text) {
    this.mail = text.trim();
    if (text.length == 0) {
      this.isMailValid = false;
      this.errorMail = 'メールアドレスを入力して下さい。';
    } else {
      this.isMailValid = true;
      this.errorMail = '';
    }
    notifyListeners();
  }

  void changePassword(text) {
    this.password = text;
    if (text.length == 0) {
      isPasswordValid = false;
      this.errorPassword = 'パスワードを入力して下さい。';
    } else if (text.length < 8 || text.length > 20) {
      isPasswordValid = false;
      this.errorPassword = 'パスワードは8文字以上20文字以内です。';
    } else {
      isPasswordValid = true;
      this.errorPassword = '';
    }
    notifyListeners();
  }

  void changeConfirm(text) {
    this.confirm = text;
    if (text.length == 0) {
      isConfirmValid = false;
      this.errorConfirm = 'パスワードを再入力して下さい。';
    } else if (text.length < 8 || text.length > 20) {
      isConfirmValid = false;
      this.errorConfirm = 'パスワードは8文字以上20文字以内です。';
    } else {
      isConfirmValid = true;
      this.errorConfirm = '';
    }
    notifyListeners();
  }

  void changeTeamName(text) {
    this.teamName = text.trim();
    if (text.length == 0) {
      this.isTeamNameValid = false;
      this.errorTeamName = 'チーム名称を入力して下さい。';
    } else {
      this.isTeamNameValid = true;
      this.errorTeamName = '';
    }
    notifyListeners();
  }

  void changeMission(text) {
    this.mission = text.trim();
    if (text.length == 0) {
      this.isMissionValid = false;
      this.errorMission = 'チーム目標を入力して下さい。';
    } else {
      this.isMissionValid = true;
      this.errorMission = '';
    }
    notifyListeners();
  }

  // void changeAddress(text) {
  //   this.image_path = text.trim();
  //   if (text.length == 0) {
  //     this.isAddressValid = false;
  //     this.errorAddress = '連絡先を入力して下さい。';
  //   } else {
  //     this.isAddressValid = true;
  //     this.errorAddress = '';
  //   }
  //   notifyListeners();
  // }


  void tapAgreeCheckBox(val) {
    this.agreeGuideline = val;
    notifyListeners();
  }

  void showDialog() {
    this.showingDialog = true;
    notifyListeners();
  }

  void hideDialog() {
    this.showingDialog = false;
    notifyListeners();
  }

  void startLoading() {
    this.isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    this.isLoading = false;
    notifyListeners();
  }
  Future passWordCheck(
      ) async {
    if (this.password != this.confirm) {
      throw ('パスワードが一致しません。');
    }
  }

}
