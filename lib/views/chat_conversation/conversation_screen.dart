import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_decorations/common_decorations.dart';
import 'package:free_style/utils/common_methods.dart';
import 'package:free_style/utils/common_widgets/app_bars/custom_app_bar.dart';
import 'package:free_style/utils/common_widgets/common_image/common_image.dart';

import '../../main.dart';
import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_widgets/common_button/common_button.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'conversation_cubit.dart';

class ConversationScreen extends StatefulWidget {
  final String fullName;
  final String profileImage;
  final String userId;
  final String roomId;

  const ConversationScreen({
    super.key,
    required this.fullName,
    required this.profileImage,
    required this.userId,
    required this.roomId,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> with WidgetsBindingObserver {
  bool showWidget = false;

  @override
  void initState() {
    super.initState();
    addOnlineOffline(true);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    addOnlineOffline(false);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    debugPrint("AppLifecycleState ::: $state");
    switch (state) {
      case AppLifecycleState.paused:
        addOnlineOffline(false);
        break;

      case AppLifecycleState.resumed:
        addOnlineOffline(true);
        break;

      case AppLifecycleState.inactive:
        addOnlineOffline(false);
        break;

      case AppLifecycleState.detached:
        addOnlineOffline(false);
        break;

      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ConversationCubit(widget.roomId, widget.fullName, widget.profileImage, widget.userId),
      child: BlocBuilder<ConversationCubit, ConversationState>(
        builder: (context, state) {
          var cubitData = context.read<ConversationCubit>();

          if (widget.roomId.isNotEmpty) {
            cubitData.messages = FirebaseFirestore.instance
                .collection('Chat')
                .doc(widget.roomId)
                .collection('Messages');
          }

          return StreamBuilder<Map<String, bool>>(
            stream: cubitData.streamBlockStatus(
              widget.roomId,
              sharedPreferences.getString(PreferenceKeys.userIdKey)!,
              widget.userId,
            ),
            builder: (context, snapshot) {
              final data = snapshot.data ?? {};
              final blockedByMe = data["blockedByMe"] ?? false;
              final blockedByOther = data["blockedByOther"] ?? false;

              return Scaffold(
                appBar: CustomAppBar(
                  title: "",
                  showBack: false,
                  titleWidget: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => router.pop(),
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        height: size(context).width * numD10,
                        width: size(context).width * numD10,
                        margin: EdgeInsets.all(size(context).width * numD01),
                        child: ClipOval(
                          child: CommonImage(
                            imagePath: widget.profileImage,
                            isNetwork: true,
                            height: size(context).width * numD10,
                            width: size(context).width * numD10,
                          ),
                        ),
                      ),

                      SizedBox(width: size(context).width * numD02),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: .center,
                          children: [
                            CommonText(
                              text: widget.fullName,
                              fontWeight: FontWeight.w500,
                              fontSize: size(context).width * numD04,
                            ),
                            if(!blockedByOther)
                            onlineOfflineWidget(context, cubitData),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    if(!blockedByOther)
                    PopupMenuButton<String>(
                      onSelected: (value) {},
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: blockedByMe? "UnBlock": "Block",
                          onTap: () {

                            if(blockedByMe){
                              cubitData.blockUserInChat(
                                widget.roomId,
                                sharedPreferences.getString(PreferenceKeys.userIdKey)!,
                                false,
                              );

                            }else{
                              cubitData.blockUserInChat(
                                widget.roomId,
                                sharedPreferences.getString(PreferenceKeys.userIdKey)!,
                                true,
                              );
                            }

                          },
                          child: Row(
                            children: [
                              Icon(Icons.block, color: Colors.red),
                              SizedBox(width: size(context).width * numD02),
                              CommonText(
                                text: blockedByMe? "UnBlock": "Block",
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size(context).width * numD035,
                              ),
                            ],
                          ),
                        ),
                      ],
                      icon: Container(
                        padding: EdgeInsets.all(size(context).width * numD02),
                        child: Icon(Icons.more_vert_sharp, color: CommonColors.secondaryColor),
                      ),
                    ),
                  ],
                ),
                body: BlocBuilder<ConversationCubit, ConversationState>(
                  builder: (context, state) {
                    var cubitData = context.read<ConversationCubit>();

                    return Stack(
                      children: [
                        Column(
                          children: [
                            /// List
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: cubitData.streamFilteredMessages(widget.roomId),
                                builder:
                                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
                                      if (snapShot.hasError) {
                                        return Center(
                                          child: CommonText(
                                            text: "Some thing went wrong!",
                                            fontWeight: FontWeight.w500,
                                            fontSize: size(context).width * numD035,
                                          ),
                                        );
                                      }

                                      if (snapShot.data == null) {
                                        return Center(
                                          child: CommonText(
                                            text: "Loading...",
                                            fontWeight: FontWeight.w500,
                                            fontSize: size(context).width * numD035,
                                          ),
                                        );
                                      }

                                      final messages = snapShot.data!.docs;

                                      for (var doc in messages) {
                                        final data = doc.data() as Map<String, dynamic>;
                                        if (data['receiver_id'] ==
                                                sharedPreferences.getString(
                                                  PreferenceKeys.userIdKey,
                                                ) &&
                                            data['read_status'] == "unread") {
                                          doc.reference.update({"read_status": "read"});
                                          debugPrint("RealTime::Read");
                                        }
                                      }

                                      return ListView.separated(
                                        controller: cubitData.scrollController,
                                        reverse: true,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size(context).width * numD04,
                                          vertical: size(context).width * numD04,
                                        ),
                                        itemBuilder: (context, index) {
                                          var document = snapShot.data!.docs[index];

                                          return document.get('sender_id') !=
                                                  sharedPreferences.getString(
                                                    PreferenceKeys.userIdKey,
                                                  )
                                              ? leftTextWidget(context, document, cubitData)
                                              : rightTextWidget(context, document, cubitData);
                                        },
                                        itemCount: snapShot.data != null
                                            ? snapShot.data!.docs.length
                                            : 0,
                                        separatorBuilder: (BuildContext context, int index) {
                                          return const SizedBox(height: 0);
                                        },
                                      );
                                    },
                              ),
                            ),

                            /// Typing
                            typingWidget(),

                            /// Message Box
                            Container(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: messageTypingBoxWidget(cubitData, context),
                            ),
                          ],
                        ),
                        Center(
                          child: blockedByMe
                              ? blockedWidget(
                                  context,
                                  message: "You’ve blocked this user. Tap Unblock to resume chat.",
                                  showUnblock: true,
                                  onUnblock: () {
                                    cubitData.blockUserInChat(
                                      widget.roomId,
                                      sharedPreferences.getString(PreferenceKeys.userIdKey)!,
                                      false,
                                    );
                                  },
                                )
                              : blockedByOther
                              ? blockedWidget(
                                  context,
                                  message: "You are blocked by this user. You can’t send messages.",
                                  showUnblock: false,
                                  onUnblock: () {},
                                )
                              : Container(),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget blockedWidget(
    BuildContext context, {
    required String message,
    bool showUnblock = false,
    required VoidCallback onUnblock,
  }) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
      blendMode: BlendMode.srcOver,
      child: Container(
        color: Colors.black.withValues(alpha: 0.3),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.block, size: size(context).width * numD20, color: Colors.red),
            SizedBox(height: size(context).width * numD05),
            CommonText(text: message,
                textAlign: TextAlign.center,
                color: Colors.red, fontWeight: FontWeight.w500),

            if (showUnblock) ...[
              SizedBox(height: size(context).width * numD04),
              CommonButton(onTap: onUnblock, text: "Unblock"),
            ],
          ],
        ),
      ),
    );
  }

  Widget messageTypingBoxWidget(ConversationCubit cubitData, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size(context).width * numD03,
        vertical: size(context).width * numD03,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: size(context).width * numD03),
              Expanded(
                child: TextFormField(
                  controller: cubitData.messageController,
                  onTap: () {},
                  onChanged: (text) {
                    cubitData.debounceTypingStatus(
                      sharedPreferences.getString(PreferenceKeys.userIdKey)!,
                      text,
                    );
                  },
                  decoration: InputDecoration(
                    hintText: "Write Your Message..",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size(context).width * numD035),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              IconButton(
                onPressed: () {
                  if (cubitData.messageController.text.isNotEmpty) {
                    cubitData.uploadChat(
                      cubitData.messageController.text,
                      "text",
                      "",
                      widget.fullName,
                      widget.profileImage,
                      widget.userId,
                      widget.roomId,
                    );
                    cubitData.messageController.clear();
                  }
                },
                icon: Container(
                  decoration: commonCircularFill(color: Colors.white),
                  padding: EdgeInsets.all(size(context).width * numD03),
                  child: Icon(Icons.send, color: CommonColors.secondaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget typingWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Chat").doc(widget.roomId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }

          if (snapshot.data != null && snapshot.data!.data() != null) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final typingStatus = data['typing_status'] ?? {};
            final isOtherTyping = typingStatus[widget.userId] == true;
            return isOtherTyping
                ? Padding(
                    padding: EdgeInsets.only(left: size(context).width * numD03),
                    child: CommonText(
                      text: "Typing..",
                      color: CommonColors.secondaryColor,
                      fontSize: size(context).width * numD03,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget onlineOfflineWidget(BuildContext context, ConversationCubit cubitData) {
    debugPrint("userId:::${widget.userId}");

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('online_offline')
          .doc(widget.userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        debugPrint("OnlineOffline data: $data");

        final bool isOnline = data['is_online'] == true;
        final String lastSeenRaw = data['last_seen'].toString().contains("Timestamp")
            ? ""
            : data['last_seen'].toString();

        String displayText = "";
        Color displayColor = Colors.grey;

        if (isOnline) {
          displayText = "Online";
          displayColor = Colors.green;
        } else if (lastSeenRaw.isNotEmpty) {
          displayText = "Last seen ${timeAgoFromString(lastSeenRaw)}";
          displayColor = Colors.grey;
        } else {
          displayText = "Offline";
          displayColor = Colors.grey;
        }

        return CommonText(
          text: displayText,
          fontSize: size(context).width * numD03,
          color: displayColor,
          fontWeight: FontWeight.w500,
        );
      },
    );
  }

  Widget leftTextWidget(
    BuildContext context,
    DocumentSnapshot document,
    ConversationCubit cubitData,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size(context).width * numD01),
      margin: EdgeInsets.only(bottom: size(context).width * numD01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: document.get("sender_name"),
            fontSize: size(context).width * numD03,
            color: CommonColors.secondaryColor,
            fontWeight: FontWeight.w500,
          ),
          if (document.get("message_type") == "text")
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size(context).width * numD03,
                vertical: size(context).width * numD03,
              ),
              margin: EdgeInsets.symmetric(vertical: size(context).width * numD015),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size(context).width * numD035),
              ),
              child: CommonText(
                text: document.get("message"),
                fontSize: size(context).width * numD035,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: size(context).width * numD02),
              CommonText(
                text: dateTimeFormatter(
                  dateTime: document.get("date"),
                  format: "MMM dd, yyyy hh:mm a",
                ),
                fontSize: size(context).width * numD03,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget rightTextWidget(
    BuildContext context,
    DocumentSnapshot document,
    ConversationCubit cubitData,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size(context).width * numD01),
      margin: EdgeInsets.only(bottom: size(context).width * numD01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (document.get("message_type") == "text")
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size(context).width * numD03,
                vertical: size(context).width * numD03,
              ),
              margin: EdgeInsets.symmetric(vertical: size(context).width * numD015),
              decoration: BoxDecoration(
                color: CommonColors.secondaryColor,
                borderRadius: BorderRadius.circular(size(context).width * numD035),
              ),
              child: CommonText(
                text: document.get("message"),
                fontSize: size(context).width * numD035,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: size(context).width * numD01),
              Row(
                children: [
                  CommonText(
                    text: dateTimeFormatter(
                      dateTime: document.get("date"),
                      format: "MMM dd, yyyy hh:mm a",
                    ),
                    fontSize: size(context).width * numD03,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: size(context).width * numD01),
                  CommonText(
                    text: document.get("read_status") == "read" ? "Read" : "Unread",
                    fontSize: size(context).width * numD03,
                    color: CommonColors.secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Firebase Methods::
  void addOnlineOffline(bool isOnline) async {
    final String? userId = sharedPreferences.getString(PreferenceKeys.userIdKey);
    if (userId == null) {
      debugPrint("Error: userId is null");
      return;
    }

    /// Setting chat image and name first else normal name and image ::
    final String? userName = sharedPreferences.getString(PreferenceKeys.fullNameKey);
    final String? userImage = sharedPreferences.getString(PreferenceKeys.avatarImageKey);

    final Map<String, dynamic> data = {
      'is_online': isOnline,
      'last_seen': DateTime.now().toUtc().toIso8601String(),
      'sender_name': userName ?? "Guest",
      'sender_image': userImage ?? "",
    };

    debugPrint("Updating online/offline status for userId: $userId, Data: $data");

    try {
      await FirebaseFirestore.instance
          .collection('online_offline')
          .doc(userId)
          .set(data, SetOptions(merge: true));
      debugPrint("✅ Online/offline status updated successfully.");
    } catch (e) {
      debugPrint("❌ Failed to update online/offline status: $e");
    }
  }
}
