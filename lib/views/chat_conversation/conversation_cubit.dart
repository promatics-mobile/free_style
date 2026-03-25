import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_style/network_class/api_response.dart';
import '../../main.dart';
import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import '../../utils/common_constants.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> implements NetworkResponse {
  final ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  CollectionReference? messages;
  Set<String> selectedMessageIds = {};
  bool isBlocked = false;
  bool isCurrentlyTyping = false;
  Timer? typingTimer;

  ConversationCubit(String roomId, String fullName, String profileImage, String userId)
    : super(
        ConversationState(
          subCollectionId: "",
          roomId: "",
          receiverId: "",
          receiverImage: "",
          receiverName: "",
          fileImage: "",
        ),
      ) {
    if (roomId.isNotEmpty) {
      messages = FirebaseFirestore.instance.collection('Chat').doc(roomId).collection('Messages');
      state.roomId = roomId;
      state.receiverId = userId;
      state.receiverImage = profileImage;
      state.receiverName = fullName;
      debugPrint("::InsideReadAllMessages::");
      readAllMessages();
    }
  }

  Stream<QuerySnapshot> streamFilteredMessages(String roomId) async* {
    final roomDoc = FirebaseFirestore.instance.collection("Chat").doc(roomId);

    yield* roomDoc.collection("Messages").orderBy("date", descending: true).snapshots();
  }

  /// Firebase Chat push Methods ::
  Future<void> uploadChat(
    String message,
    String pickType,
    String path,
    String receiverName,
    String profileImage,
    String receiverId,
    String roomId,
  ) async {
    DocumentReference docReference = FirebaseFirestore.instance
        .collection('Chat')
        .doc(state.roomId)
        .collection('Messages')
        .doc();
    docReference.set({
      'message_type': pickType,
      'message': message,
      'duration': "",
      'sender_id': sharedPreferences.getString(PreferenceKeys.userIdKey),
      'sender_name': sharedPreferences.getString(PreferenceKeys.userNameKey),
      'sender_image': sharedPreferences.getString(PreferenceKeys.avatarImageKey),
      'receiver_id': receiverId,
      'receiver_name': receiverName,
      'receiver_image': profileImage,
      'room_id': state.roomId,
      'group_images_list': [],
      'upload_percent': 0.0,
      'cover_image': "",
      'is_block': false,
      'date': DateTime.now().toUtc().toIso8601String(),
      'read_status': "unread",
    });
    emit(state.copyWith(subCollectionId: docReference.id));

    DocumentReference roomDetails = FirebaseFirestore.instance.collection('Chat').doc(state.roomId);
    debugPrint("roomId::: ${state.roomId}");
    debugPrint("message::: $message");

    final docSnapshot = await roomDetails.get();
    if (docSnapshot.exists) {
      await roomDetails.update({
        'message_type': pickType,
        'message': message,
        'sender_id': sharedPreferences.getString(PreferenceKeys.userIdKey),
        'sender_name': sharedPreferences.getString(PreferenceKeys.userNameKey),
        'sender_image': sharedPreferences.getString(PreferenceKeys.avatarImageKey),
        'duration': "",
        'receiver_name': receiverName,
        'receiver_image': profileImage,
        'room_id': state.roomId,
        'upload_percent': 0.0,
        'date': DateTime.now().toUtc().toIso8601String(),
        'read_status': "unread",
        'cover_image': "",
        'is_block': false,
      });
    } else {
      await roomDetails.set({
        'message_type': pickType,
        'message': message,
        'sender_id': sharedPreferences.getString(PreferenceKeys.userIdKey),
        'sender_name': sharedPreferences.getString(PreferenceKeys.userNameKey),
        'sender_image': sharedPreferences.getString(PreferenceKeys.avatarImageKey),
        'receiver_id': receiverId,
        'duration': "",
        'receiver_name': receiverName,
        'receiver_image': profileImage,
        'room_id': state.roomId,
        'upload_percent': 0.0,
        'date': DateTime.now().toUtc().toIso8601String(),
        'read_status': "unread",
        'cover_image': "",
        'is_block': false,
      });
    }
    //callSendNotificationApi(message, receiverId);
  }

  void debounceTypingStatus(String userId, String text) {
    typingTimer?.cancel();

    if (!isCurrentlyTyping && text.isNotEmpty) {
      isCurrentlyTyping = true;
      setTypingStatus(userId, true);
    }

    typingTimer = Timer(const Duration(milliseconds: 1000), () {
      isCurrentlyTyping = false;
      setTypingStatus(userId, false);
    });
  }

  void setTypingStatus(String userId, bool isTyping) {
    FirebaseFirestore.instance.collection("Chat").doc(state.roomId).update({
      "typing_status.$userId": isTyping,
    });
  }

  void readAllMessages() async {
    final unreadMessages = await FirebaseFirestore.instance
        .collection("Chat")
        .doc(state.roomId)
        .collection("Messages")
        .where("receiver_id", isEqualTo: sharedPreferences.getString(PreferenceKeys.userIdKey))
        .where("read_status", isEqualTo: "unread")
        .get();

    debugPrint("UnReadMessages::${unreadMessages.size}");
    for (var doc in unreadMessages.docs) {
      doc.reference.update({"read_status": "read"});
    }
    debugPrint("AfterReadMessages::${unreadMessages.size}");
  }


  Future<void> blockUserInChat(String roomId, String myId, bool isBlocked) async {
    await FirebaseFirestore.instance.collection('Chat').doc(roomId).set({
      'blocked_by.$myId': isBlocked,
    }, SetOptions(merge: true));
  }

  Stream<Map<String, bool>> streamBlockStatus(String roomId, String myId, String otherId) {
    return FirebaseFirestore.instance
        .collection("Chat")
        .doc(roomId)
        .snapshots()
        .map((doc) {
      final data = doc.data();

      final blockedByMe = data?['blocked_by.$myId'] == true;
      final blockedByOther = data?['blocked_by.$otherId'] == true;

      return {
        "blockedByMe": blockedByMe,
        "blockedByOther": blockedByOther,
      };
    });
  }

  void callSendNotificationApi(String message, String receiverId) {
    Map<String, String> map = {
      "receiver_id": receiverId,
      "message": message,
      "title": "Free Style",
      "type": "chat",
    };
    debugPrint("SendNotificationParams: $map");
    DioNetworkCall().callApiRequest(
      networkResponse: this,
      method: "POST",
      endUrl: sendNotificationUrl,
      requestCode: sendNotificationReq,
      json: map,
    );
  }

  @override
  void onApiError({required int requestCode, required String response}) {}

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case sendNotificationReq:
        debugPrint("sendNotificationReq Success :::$response ");
        break;
    }
  }

  @override
  Future<void> close() {
    typingTimer?.cancel();
    return super.close();
  }
}
