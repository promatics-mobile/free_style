import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'notification_cubit.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        var cubitData = context.read<NotificationsCubit>();
        return Scaffold(
          appBar: CommonAppBar(title: "Notifications", showBack: true),
          body: ListView.separated(
            itemCount: 10,
            padding: EdgeInsets.all(size(context).width * numD04),
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: size(context).width * numD05,
                    backgroundColor: CommonColors.secondaryColor,
                    child: Icon(
                      Icons.notifications_active_outlined,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(width: size(context).width * numD02),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: "Lorem Ipsum Title",
                          fontSize: size(context).width * numD04,
                          fontWeight: FontWeight.bold,
                        ),
                        CommonText(
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          fontSize: size(context).width * numD035,
                        ),
                        SizedBox(height: size(context).width * numD01),
                        CommonText(
                          text: "11:00 AM, March 5 2026",
                          fontSize: size(context).width * numD03,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: Colors.grey);
            },
          ),
        );
      },
    );
  }
}
