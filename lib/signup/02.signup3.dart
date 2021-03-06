import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../common/01_text_dialog.dart';
import './../common/01_will_pop_scope.dart';
import './../signin/02_signin.dart';
import './01_signup_model.dart';
import './02.signup2.dart';
import './../02_home.dart';
import './../user_policy/01_user_policy_page.dart';

class SignUpPage3 extends StatelessWidget {
  late String image_path;

  //ページ1より取得
  late String mail;
  late String password;
  late String confirm;
  //ページ2より取得
  late String teamName;
  late String mission;
  late String teamLevel;
  late String activeLocation;

  SignUpPage3(this.mail, this.password, this.confirm, this.teamName,
      this.teamLevel, this.activeLocation, this.mission, this.image_path){
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopCallback,
      child: ChangeNotifierProvider<SignUpModel>(
          create: (_) => SignUpModel()..init(),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: AppBar(
                centerTitle: true,
                title: Text(
                  'アカウントを作成する',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            body: Consumer<SignUpModel>(
              builder: (context, model, child) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'ステップ1',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'ステップ2',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                Text(
                                  'ステップ3',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Center(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Container(width:100,child: Text('サムネイル')),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: 150,
                                                height: 40,
                                                child: ElevatedButton(onPressed:() {
                                                  model.getImageFromGallery();
                                                }, child: Text('画像を選択')),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 30,),
                                      model.imageFile == null ? Container() :
                                      Container(
                                          height: 200,
                                          width: 200,
                                          child: Image.asset(model.imageFile!.path)),
                                      SizedBox(height: 30,),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            child: Checkbox(
                                              activeColor: Color(0xFF4CAF50),
                                              checkColor: Colors.white,
                                              onChanged: (val) {
                                                model.tapAgreeCheckBox(val);
                                              },
                                              value: model.agreeGuideline,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: '利用規約',
                                                    style: TextStyle(
                                                      color: Color(0xFF4CAF50),
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationThickness: 2.00,
                                                    ),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        UserPolicyPage(),
                                                                fullscreenDialog:
                                                                    true,
                                                              ),
                                                            );
                                                          },
                                                  ),
                                                  TextSpan(
                                                      text: ' を読んで同意しました。'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: RaisedButton(
                                          child: Text('新規登録'),
                                          color: Color(0xFF4CAF50),
                                          textColor: Colors.white,
                                          onPressed: model.agreeGuideline
                                              ? () async {
                                                  model.startLoading();
                                                    try {
                                                      model.mail = mail;
                                                      model.password = password;
                                                      model.confirm = confirm;
                                                      model.teamName = teamName;
                                                      model.level = teamLevel;
                                                      model.activeLocation =
                                                          activeLocation;
                                                      model.mission = mission;

                                                      await model.signUp();

                                                      await Navigator
                                                          .pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage(
                                                                  user_id: model
                                                                      .userCredential
                                                                      .user!
                                                                      .uid),
                                                        ),
                                                      );
                                                      model.endLoading();
                                                    } catch (e) {
                                                      showTextDialog(
                                                          context, e);
                                                      model.endLoading();
                                                    }
                                                }
                                              : null,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child:
                                      FlatButton(
                                        child: Text(
                                          '戻る',
                                        ),
                                        color: Color(0xFF4CAF50),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpPage2(this.mail, this.password, this.confirm, this.teamName,
                                                      this.teamLevel, this.activeLocation, this.mission,this.image_path),
                                            ),
                                          );
                                        },
                                      ),),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'ログインはこちら',
                                        ),
                                        textColor: Color(0xFF4CAF50),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInPage(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    model.showingDialog
                        ? Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                width: 300,
                                height: 250,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          child: Checkbox(
                                            activeColor: Color(0xFF4CAF50),
                                            checkColor: Colors.white,
                                            onChanged: (val) {
                                              model.tapAgreeCheckBox(val);
                                            },
                                            value: model.agreeGuideline,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '利用規約',
                                                  style: TextStyle(
                                                    color: Color(0xFF4CAF50),
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationThickness: 2.00,
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UserPolicyPage(),
                                                              fullscreenDialog:
                                                                  true,
                                                            ),
                                                          );
                                                        },
                                                ),
                                                TextSpan(text: ' を読んで同意しました。'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    model.isLoading
                        ? Container(
                            color: Colors.black.withOpacity(0.3),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SizedBox(),
                  ],
                );
              },
            ),
          )),
    );
  }
}
