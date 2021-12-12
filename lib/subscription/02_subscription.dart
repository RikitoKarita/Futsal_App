import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../00_admob_baner.dart';
import '../02_home.dart';
import '../../common/01_will_pop_scope.dart';
import 'package:provider/provider.dart';
import '01_subscription_model.dart';

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  String batolDateTime = "選択してください";
  String dropdownLevelValue = '選択してください';
  var freeSpaceCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopCallback,
      child: ChangeNotifierProvider<SubscriptionModel>(
        create: (_) => SubscriptionModel()..init(),
        child: Scaffold(
          backgroundColor: const Color(0xFFF2FFE4),
          appBar: AppBar(
            title: Text('対戦チケットを発行'),
            backgroundColor: const Color(0xFF3CB371),
          ),
          drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 60.0,
                    child: DrawerHeader(
                      child: Text("メニュー"),
                      decoration: BoxDecoration(),
                    ),
                  ),
                  ListTile(
                    title: Text('利用規約同意書', style: TextStyle(color: Colors.black54)),
                    // onTap: _manualURL,
                  ),
                  ListTile(
                    title:
                    Text('アプリ操作手順書', style: TextStyle(color: Colors.black54)),
                    // onTap: _FAQURL,
                  )
                ],
              )),
          body: Consumer<SubscriptionModel>(
            builder: (context, model, child) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      AdBanner(size: AdSize.banner),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0x8D99D472)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding:
                                EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          1.0, 10.0, 1.0, 10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: Color(0x9E3CB371)),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                  Icons.face,
                                                                  size: 16,
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                            TextSpan(
                                                              text: 'チーム名',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Container(
                                                    child: Text(
                                                      model.teamName,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15.0, 20.0, 70.0, 5.0)),
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                  Icons
                                                                      .star_rate_outlined,
                                                                  color: Colors
                                                                      .white70,
                                                                  size: 16),
                                                            ),
                                                            TextSpan(
                                                              text: 'ランク',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Container(
                                                    child: Text(
                                                      model.level,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          15.0, 5.0, 15.0, 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: Color(0x9E3CB371)),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                  Icons
                                                                      .calendar_today_sharp,
                                                                  color: Colors
                                                                      .white70,
                                                                  size: 14),
                                                            ),
                                                            TextSpan(
                                                              text: '希望日時を選択',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: <Widget>[
                                                        TextButton(
                                                          child: Text(
                                                            batolDateTime,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .blueAccent),
                                                          ),
                                                          onPressed: () {
                                                            showDatePicker(
                                                                context:
                                                                context,
                                                                locale:
                                                                const Locale(
                                                                    "ja"),
                                                                initialDate:
                                                                DateTime
                                                                    .now(),
                                                                firstDate:
                                                                DateTime(
                                                                    2021),
                                                                lastDate:
                                                                DateTime(
                                                                    2023))
                                                                .then((date) {
                                                              setState(() {
                                                                DateFormat
                                                                outoutFormat =
                                                                DateFormat(
                                                                    'yyyy年M月d日');
                                                                batolDateTime =
                                                                    outoutFormat
                                                                        .format(
                                                                        date!);
                                                              });
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5.0, 5.0, 25.0, 5.0)),
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color: Colors
                                                                      .white70,
                                                                  size: 16),
                                                            ),
                                                            TextSpan(
                                                              text: '希望する開催場所',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Container(
                                                    child: TextButton(
                                                      onPressed: () {
                                                        _showModalPicker(
                                                            context);
                                                      },
                                                      child: Text(
                                                        _selectedItem,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .blueAccent),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          15.0, 20.0, 15.0, 20.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: Color(0x9E3CB371)),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                  Icons
                                                                      .star_rate_outlined,
                                                                  size: 16,
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                            TextSpan(
                                                              text: '希望する相手レベル',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Container(
                                                    child: DropdownButton<String>(
                                                      value: dropdownLevelValue,
                                                      icon: const Icon(
                                                        Icons.arrow_drop_down_circle_outlined,
                                                        color: Colors.white,
                                                      ),
                                                      iconSize: 24,
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.black),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors.white,
                                                      ),
                                                      onChanged: (String? newValue) {
                                                        setState(() {
                                                          dropdownLevelValue = newValue!;
                                                        });
                                                      },
                                                      items: <String>['選択してください', 'lev.1', 'lev.2', 'lev.3', 'lev.4', 'lev.5']
                                                          .map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5.0, 5.0, 5.0, 5.0)),
                                              Column(
                                                children: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (_) =>
                                                              AlertDialog(
                                                                content:
                                                                SingleChildScrollView(
                                                                  child:
                                                                  ListBody(
                                                                    children: const <
                                                                        Widget>[
                                                                      Text(
                                                                          'Lev.1： 初心者のみ'),
                                                                      Text(
                                                                          'Lev.2： 初心者(多)＆経験者(少)'),
                                                                      Text(
                                                                          'Lev.3： 初心者(少)＆経験者(多)'),
                                                                      Text(
                                                                          'Lev.4： 経験者のみ'),
                                                                      Text(
                                                                          'Lev.5： 経験者のみ（上級）'),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    child: const Text(
                                                                        '閉じる'),
                                                                    onPressed:
                                                                        () {
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
                                                          color: Colors
                                                              .blueAccent),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          15.0, 20.0, 15.0, 20.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: Color(0x9E3CB371)),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                  Icons
                                                                      .paste_outlined,
                                                                  size: 16,
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                            TextSpan(
                                                              text: 'その他伝えたいこと',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Container(
                                                      alignment:
                                                      Alignment.center,
                                                      child: Container(
                                                        width: 280,
                                                        height: 100,
                                                        child: TextField(
                                                          controller:
                                                          freeSpaceCtl,
                                                          enabled: true,
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white),
                                                          obscureText: false,
                                                          maxLines: 4,
                                                          decoration:
                                                          const InputDecoration(
                                                            hintText:
                                                            'ex）全員初心者です。\n'
                                                                'ex）平均年齢30歳を超えです。\n'
                                                                'ex）お台場駅周辺で対戦希望です。\n',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FloatingActionButton.extended(
                          icon: Icon(Icons.sports_kabaddi_sharp),
                          label: Text('チケットを発行'),
                          backgroundColor: const Color(0xFFFF9426),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text('チケットを発行しますがよろしいでしょうか'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FloatingActionButton(
                                      child: const Text('はい'),
                                      onPressed: () async {
                                        model.batolDate = batolDateTime;
                                        model.desiredLevel = dropdownLevelValue;
                                        model.freespace = freeSpaceCtl.text;
                                        model.location = _selectedItem;
                                        await model.batol();

                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              content:
                                              SingleChildScrollView(
                                                child: ListBody(
                                                  children: const <
                                                      Widget>[
                                                    Text(
                                                        'チケットを発行しました。\n'
                                                            '対戦相手から連絡が来るまで少々お待ちください。'),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FloatingActionButton(
                                                  child:
                                                  const Text('閉じる'),
                                                  onPressed: () {
                                                    Navigator.of(
                                                        context)
                                                        .pop();
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
              );
            },
          ),
        ),
      ),
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
              children: _items.map(_pickerItem).toList(),
              onSelectedItemChanged: _onSelectedItemChanged,
            ),
          ),
        );
      },
    );
  }

  String _selectedItem = '選択してください';

  final List<String> _items = [
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

  void _onSelectedItemChanged(int index) {
    setState(() {
      _selectedItem = _items[index];
    });
  }
}

