import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase_Auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:futsal_develop/common/01_message.dart';
import 'package:futsal_develop/common/01_team.dart';
import 'package:futsal_develop/common/01_team_talk_room.dart';
import 'package:futsal_develop/common/01_user.dart';
import 'package:futsal_develop/common/batol_tbl.dart';
import 'package:futsal_develop/common/talk_room_model.dart';
import 'package:futsal_develop/utils/shared_prefs.dart';

class Firestore {
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final userRef = _firestoreInstance.collection('user');
  static final roomRef = _firestoreInstance.collection('room');
  static final roomSnapshot = roomRef.snapshots();
  FirebaseStorage storage = FirebaseStorage.instance;

  static final teamRef = _firestoreInstance.collection('TEAM_TBL');
  static final roomTeamRef = _firestoreInstance.collection('TEAM_TALK_ROOM_TBL');
  static final batolRef = _firestoreInstance.collection('BATOL_TBL');
  static final batolSnapshot = batolRef.snapshots();
  static final Firebase_Auth.FirebaseAuth auth =
      Firebase_Auth.FirebaseAuth.instance;
  static bool teamCheck = false;

  static Future<void> addUser() async {
    try {
      final newDoc = await userRef.add({
        'name': '名無し',
        'image_path':
            'https://1.bp.blogspot.com/-XeLDe3ylSIY/XWS5pVa7TjI/AAAAAAABUVI/VpLH_IIPkA8PaiGVCRr7sYOnJmuIp-2qQCLcBGAs/s1600/kakedasu_suit1.png'
      });
      print('アカウント作成完了');
      await SharedPrefs.setUid(newDoc.id);

      List<String>? userIds = await getUser();
      userIds!.forEach((user) async {
        if (user != newDoc.id) {
          await roomRef.add({
            'joined_user_ids': [user, newDoc.id],
            'updated_time': Timestamp.now()
          });
        }
      });
      print('ルーム作成完了');
    } catch (e) {
      print('アカウント作成に失敗しました --- $e');
    }
  }

  static Future<List<String>?> getUser() async {
    try {
      final snapshot = await userRef.get();
      List<String> userIds = [];
      snapshot.docs.forEach((user) {
        userIds.add(user.id);
        print('ドキュメントID: ${user.id} --- 名前: ${user.data()['name']}');
      });
      return userIds;
    } catch (e) {
      print('取得失敗 --- $e');
      return null;
    }
  }

  static Future<User> getProfile(String uid) async {
    final profile = await userRef.doc(uid).get();
    User myProfile = User(
      name: profile.data()!['name'],
      imagePath: profile.data()!['image_path'],
      uid: uid,
    );
    return myProfile;
  }

  static Future<List<TalkRoomModel>> getRooms(String myUid) async {
    print(myUid);
    final snapshot = await roomRef.get();
    List<TalkRoomModel> roomList = [];
    await Future.forEach<dynamic>(snapshot.docs, (doc) async {
      if (doc.data()['joined_user_ids'].contains(myUid)) {
        late String yourUid;
        doc.data()['joined_user_ids'].forEach((id) {
          if (id != myUid) {
            yourUid = id;
            return;
          }
        });
        User yourProfile = await getProfile(yourUid);
        TalkRoomModel room = TalkRoomModel(
            roomId: doc.id,
            talkUser: yourProfile,
            lastMessage: doc.data()['last_message'] ?? '');
        roomList.add(room);
      }
    });
    print(roomList.length);
    return roomList;
  }

  // static Future<List<Message>> getMessages(String roomId) async {
  //   final messageRef = roomRef
  //       .doc(roomId)
  //       .collection('message')
  //       .orderBy('send_time', descending: true);
  //   List<Message> messageList = [];
  //   final snapshot = await messageRef.get();
  //   Future.forEach<dynamic>(snapshot.docs, (doc) async {
  //     bool isMe;
  //     String? myUid = SharedPrefs.getUid();
  //     if (doc.data()['sender_id'] == myUid) {
  //       isMe = true;
  //     } else {
  //       isMe = false;
  //     }
  //     Message message = Message(
  //         message: doc.data()['message'],
  //         isMe: isMe,
  //         sendTime: doc.data()['send_time']);
  //     messageList.add(message);
  //   });
  //   messageList.sort((a, b) => b.sendTime.compareTo(a.sendTime));
  //   return messageList;
  // }
  //
  // static Future<void> sendMessage(String roomId, String message) async {
  //   final messageRef = roomRef.doc(roomId).collection('message');
  //   String? myUid = SharedPrefs.getUid();
  //   await messageRef.add(
  //       {'message': message, 'sender_id': myUid, 'send_time': Timestamp.now()});
  //   roomRef.doc(roomId).update({'last_message': message});
  // }
  //
  // static Stream<QuerySnapshot> messageSnapshot(String roomId) {
  //   return roomRef.doc(roomId).collection('message').snapshots();
  // }

  static Future<void> updateProfile(User newProfile) async {
    String? myUid = SharedPrefs.getUid();
    userRef
        .doc(myUid)
        .update({'name': newProfile.name, 'image_path': newProfile.imagePath});
  }



  static Future<List<Batol_TBL>> myBatol() async {
    final snapshot =
        await batolRef.orderBy('UPDATE_AT', descending: true).get();
    List<Batol_TBL> myBatolList = [];

    Future.forEach<dynamic>(snapshot.docs, (doc) async {
      String? myUid = '${auth.currentUser!.uid}';
      if (doc.data()['TEAM_ID'] == myUid) {
        Batol_TBL batol_tbl = Batol_TBL(
            BATOL_ID: batolRef.doc().id,
            TEAM_ID: doc.data()['TEAM_ID'],
            TEAM_NAME: doc.data()['TEAM_NAME'],
            TEAM_LEVEL: doc.data()['TEAM_LEVEL'],
            BATOL_DATE: doc.data()['BATOL_DATE'],
            DESIRED_LEVEL: doc.data()['DESIRED_LEVEL'],
            FREESPACE: doc.data()['FREESPACE'],
            LOCATION: doc.data()['LOCATION'],
            RESERVED_FLG: doc.data()['RESERVED_FLG'],
            IMAGE_PASS: doc.data()['IMAGE_PASS'],
            UPDATE_AT: doc.data()['UPDATE_AT']);
        myBatolList.add(batol_tbl);
      }
    });
    return myBatolList;
  }

  static Future<List<Batol_TBL>> othersBatol() async {
    final snapshot =
        await batolRef.orderBy('UPDATE_AT', descending: true).get();
    List<Batol_TBL> othersBatolList = [];

    Future.forEach<dynamic>(snapshot.docs, (doc) async {
      String? myUid = '${auth.currentUser!.uid}';
      if (doc.data()['TEAM_ID'] != myUid && doc.data()['RESERVED_FLG'] == "0") {
        Batol_TBL batol_tbl = Batol_TBL(
          BATOL_ID: batolRef.doc().id,
          TEAM_ID: doc.data()['TEAM_ID'],
          TEAM_NAME: doc.data()['TEAM_NAME'],
          TEAM_LEVEL: doc.data()['TEAM_LEVEL'],
          BATOL_DATE: doc.data()['BATOL_DATE'],
          DESIRED_LEVEL: doc.data()['DESIRED_LEVEL'],
          FREESPACE: doc.data()['FREESPACE'],
          LOCATION: doc.data()['LOCATION'],
          RESERVED_FLG: doc.data()['RESERVED_FLG'],
          IMAGE_PASS: doc.data()['IMAGE_PASS'],
          UPDATE_AT: doc.data()['UPDATE_AT'],
        );
        othersBatolList.add(batol_tbl);
      }
    });
    return othersBatolList;
  }

  static Future<Team> getTeamProfile(String teamId) async {
    final profile = await teamRef.doc(teamId).get();
    Team teamProfile = Team(
        TEAM_ID: profile.data()!['TEAM_ID'],
        TEAM_PASS: profile.data()!['TEAM_PASS'],
        TEAM_NAME: profile.data()!['TEAM_NAME'],
        LEVEL: profile.data()!['LEVEL'],
        ACTIVE_LOCATION: profile.data()!['ACTIVE_LOCATION'],
        MISSION: profile.data()!['MISSION'],
        IMAGE_PASS: profile.data()!['IMAGE_PASS']);
    return teamProfile;
  }

  static Future<void> addTeamRoom(String myTeamId , String yourTeamID) async {
    try {
          await roomTeamRef.add({
            'joined_team_ids': [myTeamId, yourTeamID],
            'updated_time': Timestamp.now()
          });
        }
    catch (e) {
      print('トークルーム作成に失敗しました --- $e');
    }
  }

  static Future<void> checkTeamRoom(String myTeamId , String yourTeamID) async {
    final snapshot = await roomTeamRef.get();

    await Future.forEach<dynamic>(snapshot.docs, (doc) async {
      if (doc.data()['joined_team_ids'].contains(myTeamId)) {
        doc.data()['joined_team_ids'].forEach((id) {
          if (id == yourTeamID) {
            teamCheck = true;
            print(teamCheck);
          }
          return;
        });
      }
    });
  }

  static Future<List<TeamTalkRoomModel>> getTeamRooms(String myTeamId) async {
    final snapshot = await roomTeamRef.get();
    List<TeamTalkRoomModel> roomList = [];
    await Future.forEach<dynamic>(snapshot.docs, (doc) async {
      if (doc.data()['joined_team_ids'].contains(myTeamId)) {
        late String yourTeamId;
        doc.data()['joined_team_ids'].forEach((id) {
          if (id != myTeamId) {
            yourTeamId = id;
            return;
          }
        });
        Team yourTeamProfile = await getTeamProfile(yourTeamId);
        TeamTalkRoomModel room = TeamTalkRoomModel(
            roomId: doc.id,
            talkTeam: yourTeamProfile,
            lastMessage: doc.data()['last_message'] ?? '');
        roomList.add(room);
      }
    });
    return roomList;
  }

  static Future<List<Message>> getMessages(String roomId) async {
    final messageRef = roomTeamRef
        .doc(roomId)
        .collection('message')
        .orderBy('send_time', descending: true);
    List<Message> messageList = [];
    final snapshot = await messageRef.get();
    Future.forEach<dynamic>(snapshot.docs, (doc) async {
      bool isMe;
      String? myUid = SharedPrefs.getUid();
      if (doc.data()['sender_id'] == auth.currentUser!.uid) {
        isMe = true;
      } else {
        isMe = false;
      }
      Message message = Message(
          message: doc.data()['message'],
          isMe: isMe,
          sendTime: doc.data()['send_time']);
      messageList.add(message);
    });
    messageList.sort((a, b) => b.sendTime.compareTo(a.sendTime));
    return messageList;
  }

  static Future<void> sendMessage(String roomId, String message) async {
    final messageRef = roomTeamRef.doc(roomId).collection('message');
    String? myUid = auth.currentUser!.uid;
    await messageRef.add(
        {'message': message, 'sender_id': myUid, 'send_time': Timestamp.now()});
    roomTeamRef.doc(roomId).update({'last_message': message});
  }

  static Stream<QuerySnapshot> messageSnapshot(String roomId) {
    return roomTeamRef.doc(roomId).collection('message').snapshots();
  }

  Future<String> downloadImage(String storedImagePath) async{
    Reference imageRef = storage.ref(storedImagePath);
    String imageUrl = await imageRef.getDownloadURL();
    return imageUrl;
  }


}
