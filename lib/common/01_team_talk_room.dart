import '01_team.dart';

class TeamTalkRoomModel{
  late String roomId;
  late Team talkTeam;
  late String lastMessage;

  TeamTalkRoomModel({
    required this.roomId,required this.talkTeam,required this.lastMessage
  });
}