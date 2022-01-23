import '01_user.dart';

class TalkRoomModel{
  late String roomId;
  late User talkUser;
  late String lastMessage;

  TalkRoomModel({
    required this.roomId,required this.talkUser,required this.lastMessage
});
}