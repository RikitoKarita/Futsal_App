import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../common/01_text_dialog.dart';
import './../common/01_will_pop_scope.dart';
import './../signin/02_signin.dart';
import './01_signup_model.dart';
import './02.signup1.dart';
import './02.signup3.dart';
import './../02_home.dart';
import './../02_subscription.dart';
import './../user_policy/01_user_policy_page.dart';

class SignUpPage2 extends StatelessWidget {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  var teamNameCtl = TextEditingController();
  var memberNameCtl = TextEditingController();
  var levelCtl = TextEditingController();
  var activeLocationCtl = TextEditingController();
  var missionCtl = TextEditingController();
  var addressCtl = TextEditingController();

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
                title: Text('アカウントを作成する',style: TextStyle(fontSize: 18,),),
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
                                Icon(Icons.check_circle,color: Colors.grey,),
                                Text('ステップ1',style: TextStyle(fontSize: 16,),)
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10,20,10,40),
                            ),
                            Row(
                              children: [
                                Icon(Icons.check_circle,color: Colors.green,),
                                Text('ステップ2',style: TextStyle(fontSize: 16,),)
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10,20,10,40),
                            ),
                            Row(
                              children: [
                                Icon(Icons.check_circle,color: Colors.grey,),
                                Text('ステップ3',style: TextStyle(fontSize: 16,),)
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
                                      // TextFormField(
                                      //   controller: mailController,
                                      //   onChanged: (text) {
                                      //     model.changeMail(text);
                                      //   },
                                      //   maxLines: 1,
                                      //   style: TextStyle(fontSize: 16),
                                      //   decoration: InputDecoration(
                                      //     errorText: model.errorMail == ''
                                      //         ? null
                                      //         : model.errorMail,
                                      //     labelText: 'メールアドレス',
                                      //     border: OutlineInputBorder(),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 16,
                                      // ),
                                      // TextFormField(
                                      //   controller: passwordController,
                                      //   onChanged: (text) {
                                      //     model.changePassword(text);
                                      //   },
                                      //   obscureText: true,
                                      //   maxLines: 1,
                                      //   style: TextStyle(fontSize: 16),
                                      //   decoration: InputDecoration(
                                      //     errorText: model.errorPassword == ''
                                      //         ? null
                                      //         : model.errorPassword,
                                      //     labelText: 'パスワード',
                                      //     border: OutlineInputBorder(),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 16,
                                      // ),
                                      // TextFormField(
                                      //   controller: confirmController,
                                      //   onChanged: (text) {
                                      //     model.changeConfirm(text);
                                      //   },
                                      //   obscureText: true,
                                      //   maxLines: 1,
                                      //   style: TextStyle(fontSize: 16),
                                      //   decoration: InputDecoration(
                                      //     labelText: 'パスワード（確認用）',
                                      //     errorText: model.errorConfirm == ''
                                      //         ? null
                                      //         : model.errorConfirm,
                                      //     border: OutlineInputBorder(),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 16,
                                      // ),
                                      TextFormField(
                                        controller: teamNameCtl,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          labelText: 'チーム名',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        controller: memberNameCtl,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          labelText: '所属メンバ',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Text('チームレベル', style: TextStyle(fontSize: 16,color: Colors.black54),),
                                          Container(padding: EdgeInsets.fromLTRB(20,10,10,10),),
                                          Container(child: TeamLeavelWidget(),),
                                          TextButton(
                                            // controller: levelCtl,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    content:
                                                    SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const <
                                                            Widget>[
                                                          Text('Lev.1： 初心者のみ'),
                                                          Text(
                                                              'Lev.2： 初心者(多)＆経験者(少)'),
                                                          Text(
                                                              'Lev.3： 初心者(少)＆経験者(多)'),
                                                          Text('Lev.4： 経験者のみ'),
                                                          Text(
                                                              'Lev.5： 経験者のみ（上級）'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                        const Text('閉じる'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                            },
                                            child: Text(
                                              '詳細',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        controller: activeLocationCtl,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          labelText: '主な活動場所',
                                          hintText: '台場周辺で活動してます',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        controller: missionCtl,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          labelText: 'チーム目標',
                                          hintText: 'とにかく楽しくやることがモットーです',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          FloatingActionButton.extended(
                                            label: Text('戻る'),
                                            backgroundColor: const Color(0xFF9E9E9E),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => SignUpPage(),
                                                ),
                                              );
                                            },
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(10,20,40,40),
                                          ),
                                          FloatingActionButton.extended(
                                            label: Text('次へ'),
                                            backgroundColor: const Color(0xFF4CAF50),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => SignUpPage3(),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 16,
                                      // ),
                                      // TextFormField(
                                      //   controller: addressCtl,
                                      //   maxLines: 1,
                                      //   decoration: InputDecoration(
                                      //     labelText: '連絡先',
                                      //     border: OutlineInputBorder(),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 16,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                      //   children: [
                                      //     SizedBox(
                                      //       width: 24,
                                      //       child: Checkbox(
                                      //         activeColor: Color(0xFF4CAF50),
                                      //         checkColor: Colors.white,
                                      //         onChanged: (val) {
                                      //           model.tapAgreeCheckBox(val);
                                      //         },
                                      //         value: model.agreeGuideline,
                                      //       ),
                                      //     ),
                                      //     SizedBox(
                                      //       width: 8,
                                      //     ),
                                      //     Flexible(
                                      //       child: RichText(
                                      //         text: TextSpan(
                                      //           style: TextStyle(
                                      //             color: Colors.grey,
                                      //             fontSize: 12.0,
                                      //             fontWeight: FontWeight.bold,
                                      //           ),
                                      //           children: [
                                      //             TextSpan(
                                      //               text: '利用規約',
                                      //               style: TextStyle(
                                      //                 color: Color(0xFF4CAF50),
                                      //                 decoration:
                                      //                 TextDecoration.underline,
                                      //                 decorationThickness: 2.00,
                                      //               ),
                                      //               recognizer: TapGestureRecognizer()
                                      //                 ..onTap = () {
                                      //                   Navigator.push(
                                      //                     context,
                                      //                     MaterialPageRoute(
                                      //                       builder: (context) =>
                                      //                           UserPolicyPage(),
                                      //                       fullscreenDialog: true,
                                      //                     ),
                                      //                   );
                                      //                 },
                                      //             ),
                                      //             TextSpan(text: ' を読んで同意しました。'),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 16,
                                      // ),
                                      // SizedBox(
                                      //   width: double.infinity,
                                      //   height: 50,
                                      //   child: RaisedButton(
                                      //     child: Text('新規登録'),
                                      //     color: Color(0xFF4CAF50),
                                      //     textColor: Colors.white,
                                      //     onPressed: model.agreeGuideline &&
                                      //         model.isMailValid &&
                                      //         model.isPasswordValid &&
                                      //         model.isConfirmValid
                                      //         ? () async {
                                      //       model.startLoading();
                                      //       try {
                                      //         model.teamPass =
                                      //             passwordController.text;
                                      //         model.teamName = teamNameCtl.text;
                                      //         model.memberName =
                                      //             memberNameCtl.text;
                                      //         model.level = levelCtl.text;
                                      //         model.activeLocation =
                                      //             activeLocationCtl.text;
                                      //         model.mission = missionCtl.text;
                                      //         model.address = addressCtl.text;
                                      //
                                      //         await model.signUp();
                                      //
                                      //         await Navigator.pushReplacement(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //             builder: (context) => HomePage(
                                      //                 user_id: model.userCredential.user!.uid),
                                      //           ),
                                      //         );
                                      //         model.endLoading();
                                      //       } catch (e) {
                                      //         showTextDialog(context, e);
                                      //         model.endLoading();
                                      //       }
                                      //     }
                                      //         : null,
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 16,
                                      // ),
                                      // FlatButton(
                                      //   child: Text(
                                      //     'ログインはこちら',
                                      //   ),
                                      //   textColor: Color(0xFF4CAF50),
                                      //   onPressed: () {
                                      //     Navigator.pushReplacement(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder: (context) => SignInPage(),
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // model.showingDialog
                    // ? Container(
                    //                         //     color: Colors.black.withOpacity(0.5),
                    //                         //     child: Center(
                    //                         //       child: Container(
                    //                         //         padding: const EdgeInsets.all(16.0),
                    //                         //         width: 300,
                    //                         //         height: 250,
                    //                         //         color: Colors.white,
                    //                         //         child: Column(
                    //                         //           mainAxisAlignment: MainAxisAlignment.center,
                    //                         //           crossAxisAlignment: CrossAxisAlignment.center,
                    //                         //           children: [
                    //                         //             Row(
                    //                         //               mainAxisAlignment:
                    //                         //                   MainAxisAlignment.start,
                    //                         //               children: [
                    //                         //                 SizedBox(
                    //                         //                   width: 24,
                    //                         //                   child: Checkbox(
                    //                         //                     activeColor: Color(0xFF4CAF50),
                    //                         //                     checkColor: Colors.white,
                    //                         //                     onChanged: (val) {
                    //                         //                       model.tapAgreeCheckBox(val);
                    //                         //                     },
                    //                         //                     value: model.agreeGuideline,
                    //                         //                   ),
                    //                         //                 ),
                    //                         //                 SizedBox(
                    //                         //                   width: 8,
                    //                         //                 ),
                    //                         //                 Flexible(
                    //                         //                   child: RichText(
                    //                         //                     text: TextSpan(
                    //                         //                       style: TextStyle(
                    //                         //                         color: Colors.grey,
                    //                         //                         fontSize: 12.0,
                    //                         //                         fontWeight: FontWeight.bold,
                    //                         //                       ),
                    //                         //                       children: [
                    //                         //                         TextSpan(
                    //                         //                           text: '利用規約',
                    //                         //                           style: TextStyle(
                    //                         //                             color: Color(0xFF4CAF50),
                    //                         //                             decoration: TextDecoration
                    //                         //                                 .underline,
                    //                         //                             decorationThickness: 2.00,
                    //                         //                           ),
                    //                         //                           recognizer:
                    //                         //                               TapGestureRecognizer()
                    //                         //                                 ..onTap = () {
                    //                         //                                   Navigator.push(
                    //                         //                                     context,
                    //                         //                                     MaterialPageRoute(
                    //                         //                                       builder: (context) =>
                    //                         //                                           UserPolicyPage(),
                    //                         //                                       fullscreenDialog:
                    //                         //                                           true,
                    //                         //                                     ),
                    //                         //                                   );
                    //                         //                                 },
                    //                         //                         ),
                    //                         //                         TextSpan(text: ' を読んで同意しました。'),
                    //                         //                       ],
                    //                         //                     ),
                    //                         //                   ),
                    //                         //                 ),
                    //                         //               ],
                    //                         //             ),
                    //                         //             SizedBox(
                    //                         //               height: 16.0,
                    //                         //             ),
                    //                         //           ],
                    //                         //         ),
                    //                         //       ),
                    //                         //     ),
                    // // // //                         //   )
                    // // //     : SizedBox(),
                    // // // model.isLoading
                    // // //     ? Container(
                    // // //         color: Colors.black.withOpacity(0.3),
                    // // //         child: Center(
                    // // //           child: CircularProgressIndicator(),
                    // // //         ),
                    // //       )
                    //     : SizedBox(),
                  ],
                );
              },
            ),
          )),
    );
  }
}

class TeamLeavelWidget extends StatefulWidget {
  const TeamLeavelWidget({Key? key}) : super(key: key);

  @override
  State<TeamLeavelWidget> createState() => _TeamLeavelWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _TeamLeavelWidgetState extends State<TeamLeavelWidget> {
  String dropdownValue = '選択してください';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Colors.black54,
      ),
      iconSize: 24,
      elevation: 18,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.black54,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['選択してください', 'lev.1', 'lev.2', 'lev.3', 'lev.4', 'lev.5']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
