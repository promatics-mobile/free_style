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
        var cubit = context.read<NotificationsCubit>();
        return Scaffold(
          appBar: const CommonAppBar(title: "Notifications", showBack: true),
          body: cubit.notificationsList.isEmpty
              ? Center(child: CommonText(text: "No notifications found", color: Colors.grey))
              : ListView.separated(
            itemCount: cubit.notificationsList.length,
            padding: EdgeInsets.all(size(context).width * numD04),
            itemBuilder: (context, index) {
              final notification = cubit.notificationsList[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: size(context).width * numD05,
                    backgroundColor: CommonColors.secondaryColor.withOpacity(0.1),
                    child: Icon(
                      notification.icon,
                      color: CommonColors.secondaryColor,
                      size: size(context).width * numD05,
                    ),
                  ),
                  SizedBox(width: size(context).width * numD03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: notification.title,
                          fontSize: size(context).width * numD04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        SizedBox(height: size(context).width * numD01),
                        CommonText(
                          text: notification.description,
                          fontSize: size(context).width * numD035,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        SizedBox(height: size(context).width * numD02),
                        CommonText(
                          text: notification.timeAgo,
                          fontSize: size(context).width * numD03,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  if (index==0)
                    Container(
                      width: size(context).width * numD02,
                      height: size(context).width * numD02,
                      decoration: BoxDecoration(
                        color: CommonColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: size(context).width * numD02),
                child: Divider(color: Colors.white.withOpacity(0.1)),
              );
            },
          ),
        );
      },
    );
  }
}
