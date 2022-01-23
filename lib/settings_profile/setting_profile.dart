// import 'dart:html';

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futsal_develop/common/01_user.dart';
import 'package:futsal_develop/utils/firestore.dart';
import 'package:futsal_develop/utils/shared_prefs.dart';
import 'package:image_picker/image_picker.dart';


class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({Key? key}) : super(key: key);

  @override
  _SettingProfilePageState createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  XFile ? imageFile;
  ImagePicker picker = ImagePicker();
  String ? imagePath;
  TextEditingController controller = TextEditingController();

  Future<void>getImageFromGallery() async{
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = (pickedImage != null ? XFile(pickedImage.path): null)!;
    uploadImage();
    setState(() {
    });
    }

    Future<String ?> uploadImage() async{
      File imageFileHenkan = File(imageFile!.path);
      final ref = FirebaseStorage.instance.ref('test.png');
      final storedImage = await ref.putFile(imageFileHenkan);
      imagePath = await loadImage(storedImage);
      return imagePath;
    }

    Future<String> loadImage(TaskSnapshot storedImage) async{
    String downloadUrl = await storedImage.ref.getDownloadURL();
    return downloadUrl;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("プロフィール編集"),
    ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(width:100,child: Text("名前")),
                Expanded(child: TextField(controller: controller,)),
              ],
            ),
            SizedBox(height:50),
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
                         getImageFromGallery();
                      }, child: Text('画像を選択')),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            imageFile == null ? Container() :
            Container(
              height: 200,
              width: 200,
              child: Image.asset(imageFile!.path)),
            SizedBox(height: 30,),
            ElevatedButton(onPressed:(){
              String? myUid = SharedPrefs.getUid();
              User newProfile = User(
                name:controller.text,
                uid: myUid.toString(),
                imagePath: imagePath.toString(),
              );
              Firestore.updateProfile(newProfile);
            }, child: Text("編集")
            )
          ],
        ),
      ),
    );
  }
}
