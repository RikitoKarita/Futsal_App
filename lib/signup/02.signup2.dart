import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import './../common/01_text_dialog.dart';
import './../common/01_will_pop_scope.dart';
import './../signin/02_signin.dart';
import './01_signup_model.dart';
import './02.signup1.dart';
import './02.signup3.dart';
import './../02_subscription.dart';
import './../02_subscription.dart';

class SignUpPage2 extends StatefulWidget {
  // final mailController = TextEditingController();
  // final passwordController = TextEditingController();
  // final confirmController = TextEditingController();
  // var teamNameCtl = TextEditingController();
  // var memberNameCtl = TextEditingController();
  // var levelCtl = TextEditingController();
  // var activeLocationCtl = TextEditingController();
  // var missionCtl = TextEditingController();
  // var addressCtl = TextEditingController();
  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  String batolDateTime = "選択してください";

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
                                      TextFormField(
                                        // controller: teamNameCtl,
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
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black45, //色
                                          ),
                                        ),
                                        height: 60,
                                        width: 400,
                                        child: Row(
                                          children: [
                                            Container(padding: EdgeInsets.all(5),),
                                            TeamLeavelWidget(),
                                            Container(padding: EdgeInsets.all(10),),
                                            TextButton(
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
                                                    fontSize: 14,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(padding: EdgeInsets.all(10),),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black45, //色
                                          ),
                                        ),
                                        height: 60,
                                        width: 400,
                                        child: Row(
                                          children: [
                                            Container(padding: EdgeInsets.all(5),),
                                            Container(
                                              child: TextButton(
                                                onPressed: () {
                                                  _showModalPicker(context);
                                                },
                                                child: Text(
                                                  _selectedLocation,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        // controller: missionCtl,
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
  void _showModalPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 40,
              children: _Location.map(_pickerItem).toList(),
              onSelectedItemChanged: _onSelectedLocationChanged,
            ),
          ),
        );
      },
    );
  }

  String _selectedLocation = '主な活動場所を選択してください';

  final List<String> _Location = [
    "北海道",
    "青森県",
    "岩手県",
    "宮城県",
    "秋田県",
    "山形県",
    "福島県",
    "茨城県",
    "栃木県",
    "群馬県",
    "埼玉県",
    "千葉県",
    "東京都",
    "神奈川県",
    "新潟県",
    "富山県",
    "石川県",
    "福井県",
    "山梨県",
    "長野県",
    "岐阜県",
    "静岡県",
    "愛知県",
    "三重県",
    "滋賀県",
    "京都府",
    "大阪府",
    "兵庫県",
    "奈良県",
    "和歌山県",
    "鳥取県",
    "島根県",
    "岡山県",
    "広島県",
    "山口県",
    "徳島県",
    "香川県",
    "愛媛県",
    "高知県",
    "福岡県",
    "佐賀県",
    "長崎県",
    "熊本県",
    "大分県",
    "宮崎県",
    "鹿児島県",
    "沖縄県",
  ];

  Widget _pickerItem(String str) {
    return Text(
      str,
      style: const TextStyle(fontSize: 32),
    );
  }

  void _onSelectedLocationChanged(int index) {
    setState(() {
      _selectedLocation = _Location[index];
    });
  }
}

class TeamLeavelWidget extends StatefulWidget {
  const TeamLeavelWidget({Key? key}) : super(key: key);

  @override
  State<TeamLeavelWidget> createState() => _TeamLeavelWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _TeamLeavelWidgetState extends State<TeamLeavelWidget> {
  String dropdownValue = 'チームを選択してください';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['チームを選択してください', 'lev.1', 'lev.2', 'lev.3', 'lev.4', 'lev.5']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: 16,color: Colors.black54),),
        );
      }).toList(),
    );
  }
}


