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

class SignUpPage extends StatefulWidget {
  //ページ1より取得
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  late String mail;
  late String password;
  late String confirm;
  //ページ2より取得
  String teamName = '';
  String mission = '';
  String teamLevelValue = 'チームレベルを選択してください';
  String activeLocation = '主な活動場所を選択してください';
  //ページ3より取得
  String image_path = '';

  SignUpPage.make(){
    mail = "";
    password = "";
    confirm = "";
  }

  SignUpPage.modoru(this.mail, this.password, this.confirm, this.teamName, this.teamLevelValue, this.activeLocation, this.mission, this.image_path){
    this.mailController = TextEditingController(text: this.mail);
    this.passwordController = TextEditingController(text: this.password);
    this.confirmController = TextEditingController(text: this.confirm);
  }
    @override
    _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
  //ページ1より
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  late String mail;
  late String password;
  late String confirm;
  //ページ2より
  late String teamName;
  late String mission;
  late String teamLevelValue;
  late String activeLocation;

  //ページ3より
  late String image_path;

  void initState() {
    mailController = widget.mailController;
    passwordController = widget.passwordController;
    confirmController = widget.confirmController;
    mail = widget.mail;
    password = widget.password;
    confirm = widget.confirm;
    teamName = widget.teamName;
    mission = widget.mission;
    teamLevelValue = widget.teamLevelValue;
    activeLocation = widget.activeLocation;
    image_path = widget.image_path;
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
                                  color: Colors.green,
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
                                  color: Colors.grey,
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
                                      TextFormField(
                                        controller: mailController,
                                        onChanged: (text) {
                                          model.changeMail(text);
                                        },
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          errorText: model.errorMail == ''
                                              ? null
                                              : model.errorMail,
                                          labelText: 'メールアドレス',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        onChanged: (text) {
                                          model.changePassword(text);
                                        },
                                        obscureText: true,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          errorText: model.errorPassword == ''
                                              ? null
                                              : model.errorPassword,
                                          labelText: 'パスワード',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        controller: confirmController,
                                        onChanged: (text) {
                                          model.changeConfirm(text);
                                        },
                                        obscureText: true,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          labelText: 'パスワード（確認用）',
                                          errorText: model.errorConfirm == ''
                                              ? null
                                              : model.errorConfirm,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FloatingActionButton.extended(
                                            label: Text('戻る'),
                                            backgroundColor:
                                                const Color(0xFF9E9E9E),
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
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 20, 40, 40),
                                          ),
                                          FloatingActionButton.extended(
                                            label: Text('次へ'),
                                            backgroundColor:
                                                const Color(0xFF4CAF50),
                                            onPressed:
                                                 () async {
                                                    String mail =
                                                        mailController.text;
                                                    String password =
                                                        passwordController.text;
                                                    String confirm =
                                                        confirmController.text;
                                                    model.mail = mail;
                                                    model.password = password;
                                                    model.confirm = confirm;
                                                    model.changeMail(mail);
                                                    model.changePassword(password);
                                                    model.changeConfirm(confirm);
                                                    if(model.isMailValid && model.isPasswordValid && model.isConfirmValid) {
                                                      try {
                                                        await model
                                                            .passWordCheck();
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                SignUpPage2
                                                                    (
                                                                    mail,
                                                                    password,
                                                                    confirm,
                                                                    teamName,
                                                                    teamLevelValue,activeLocation,mission,image_path),
                                                          ),
                                                        );
                                                        model.endLoading();
                                                      } catch (e) {
                                                        showTextDialog(
                                                            context, e);
                                                        model.endLoading();
                                                      }
                                                    }else{
                                                      showTextDialog(
                                                          context, "メール又はパスワードを正しく入力してください");
                                                      model.endLoading();
                                                    }
                                                  }
                                          ),
                                        ],
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
                  ],
                );
              },
            ),
          )),
    );
  }
}
