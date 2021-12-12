import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    this.isLoading = false;
    this.isMailValid = false;
    this.isPasswordValid = false;
    this.isConfirmValid = false;
    // this.userCredential = null;
    this.isGuestAllowed = false;
    // this.teamPass = '';
    this.teamName = '';
    // this.memberName = '';
    this.level = '';
    this.activeLocation = '';
    this.mission = '';
    this.address = '';
  }

  late bool agreeGuideline;
  late bool showingDialog;
  late String mail;
  late String password;
  late String confirm;
  late String errorMail;
  late String errorPassword;
  late String errorConfirm;
  late bool isLoading;
  late bool isMailValid;
  late bool isPasswordValid;
  late bool isConfirmValid;
  late UserCredential userCredential;
  late bool isGuestAllowed;
  // late String teamPass;
  late String teamName;
  // late String memberName;
  late String level;
  late String activeLocation;
  late String mission;
  late String address;

  Future<void> init() async {
    // DocumentSnapshot _doc = await FirebaseFirestore.instance
    //     .collection('settings')
    //     .doc('guest_mode')
    //     .get();
    // this.isGuestAllowed = _doc.data()['guest_allowed'];
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
      DocumentReference _userDoc =
          _firestore.collection('TEAM_TBL').doc(this.userCredential.user!.uid);

      // user ドキュメントのフィールド
      Map<String, dynamic> _userFields = {
        'TEAM_ID': this.userCredential.user!.uid,
        'TEAM_PASS': this.password,
        'TEAM_NAME': this.teamName,
        // 'MEMBER_NAME': this.memberName,
        'LEVEL' : this.level,
        'ACTIVE_LOCATION': this.activeLocation,
        'MISSION': this.mission,
        'ADDRESS': this.address,
      };

      _batch.set(_userDoc, _userFields);
      await _batch.commit();
    } catch (e) {
      print('ユーザードキュメントの作成中にエラー');
      print(e.toString());
      throw ('エラーが発生しました。');
    }
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
