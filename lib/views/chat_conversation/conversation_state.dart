part of 'conversation_cubit.dart';

class ConversationState {
  String subCollectionId = "";
  String roomId = "";
  String receiverName = "";
  String receiverImage = "";
  String receiverId = "";
  String fileImage = "";

  ConversationState({
    required this.subCollectionId,
    required this.roomId,
    required this.receiverName,
    required this.receiverImage,
    required this.receiverId,
    required this.fileImage,
  });

  ConversationState copyWith({
    String?subCollectionId,
    String?roomId,
    String?fileImage,
    String?receiverName ,
    String?receiverImage ,
    String?receiverId ,

  }){
    return ConversationState(
      subCollectionId: subCollectionId ?? this.subCollectionId,
      roomId: roomId ?? this.roomId,
      receiverName: receiverName ?? this.receiverName,
      receiverImage: receiverImage ?? this.receiverImage,
      receiverId: receiverId ?? this.receiverId,
      fileImage: fileImage ?? this.fileImage,
    );

  }

}