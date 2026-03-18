import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/views/battle_victory/battle_victory_cubit.dart';
import 'package:free_style/views/battle_victory/battle_victory_screen.dart';
import 'package:free_style/views/battles/battles_cubit.dart';
import 'package:free_style/views/battles/battles_screen.dart';
import 'package:free_style/views/challenge_approved/challenge_approved_screen.dart';
import 'package:free_style/views/challenge_history/challenge_history_screen.dart';
import 'package:free_style/views/chat_conversation/conversation_cubit.dart';
import 'package:free_style/views/chat_conversation/conversation_screen.dart';
import 'package:free_style/views/contact_us/contact_us_cubit.dart';
import 'package:free_style/views/create_account/create_account_cubit.dart';
import 'package:free_style/views/dashboard/dashboard_screen.dart';
import 'package:free_style/views/dialy_challenge/daily_challenge_cubit.dart';
import 'package:free_style/views/dialy_challenge/daily_challenge_screen.dart';
import 'package:free_style/views/email_mobile_verification/email_mobile_verification_screen.dart';
import 'package:free_style/views/faqs/faqs_cubit.dart';
import 'package:free_style/views/faqs/faqs_screen.dart';
import 'package:free_style/views/global_lead_board/global_lead_board_cubit.dart';
import 'package:free_style/views/global_lead_board/global_lead_board_screen.dart';
import 'package:free_style/views/inventory/inventory_cubit.dart';
import 'package:free_style/views/league_ranking/league_ranking_cubit.dart';
import 'package:free_style/views/league_ranking/league_ranking_screen.dart';
import 'package:free_style/views/login/login_cubit.dart';
import 'package:free_style/views/login/login_screen.dart';
import 'package:free_style/views/match_making/match_making_screen.dart';
import 'package:free_style/views/mission/mission_cubit.dart';
import 'package:free_style/views/mission/preview_submission_screen.dart';
import 'package:free_style/views/mission/record_video_screen.dart';
import 'package:free_style/views/mission/submit_proof_screen.dart';
import 'package:free_style/views/notifications/notification_cubit.dart';
import 'package:free_style/views/notifications/notification_screen.dart';
import 'package:free_style/views/otp_verification/otp_verification_cubit.dart';
import 'package:free_style/views/otp_verification/otp_verification_screen.dart';
import 'package:free_style/views/profile/profile_cubit.dart';
import 'package:free_style/views/profile/profile_screen.dart';
import 'package:free_style/views/profile_setup/profile_setup_cubit.dart';
import 'package:free_style/views/profile_setup/profile_setup_screen.dart';
import 'package:free_style/views/reset_password/reset_password_cubit.dart';
import 'package:free_style/views/reset_password/reset_password_screen.dart';
import 'package:free_style/views/search_players/search_players_cubit.dart';
import 'package:free_style/views/search_players/search_players_screen.dart';
import 'package:free_style/views/settings/settings_cubit.dart';
import 'package:free_style/views/settings/settings_screen.dart';
import 'package:free_style/views/shop/item_detail_screen.dart';
import 'package:free_style/views/shop/shop_cubit.dart';
import 'package:free_style/views/shop/shop_model.dart';
import 'package:free_style/views/shop/shop_screen.dart';
import 'package:free_style/views/skill_tree/skill_tree_cubit.dart';
import 'package:free_style/views/social/social_cubit.dart';
import 'package:free_style/views/social/social_screen.dart';
import 'package:free_style/views/splash/splash_cubit.dart';
import 'package:free_style/views/training/training_cubit.dart';
import 'package:free_style/views/tutorial/tutorial_cubit.dart';
import 'package:free_style/views/tutorial/tutorial_details.dart';
import 'package:free_style/views/victory/victory_cubit.dart';
import 'package:free_style/views/victory/victory_screen.dart';
import 'package:free_style/views/walkthrough/walkthrough_cubit.dart';
import 'package:free_style/views/walkthrough/walkthrough_screen.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../views/change_password/change_password.dart';
import '../views/change_password/change_password_cubit.dart';
import '../views/cms/cms_cubit.dart';
import '../views/cms/cms_screen.dart';
import '../views/contact_us/contact_us.dart';
import '../views/create_account/create_account_screen.dart';
import '../views/email_mobile_verification/email_mobile_verification_cubit.dart';
import '../views/forgot_password/forgot_password_cubit.dart';
import '../views/forgot_password/forgot_password_screen.dart';
import '../views/home/home_cubit.dart';
import '../views/home/home_screen.dart';
import '../views/inventory/inventory_screen.dart';
import '../views/mission/mission_screen.dart';
import '../views/other_profile/other_profile_cubit.dart';
import '../views/other_profile/other_profile_screen.dart';
import '../views/skill_state/skill_state_cubit.dart';
import '../views/skill_state/skill_state_screen.dart';
import '../views/skill_tree/skill_tree_screen.dart';
import '../views/splash/splash_screen.dart';
import '../views/training/training_screen.dart';
import '../views/tutorial/tutorial_screen.dart';
import '../views/tutorial/tutorial_video_details.dart';

class AppRouter {
  static const String splashScreen = "/splash_screen";
  static const String walkThroughScreen = "/walk_through_screen";
  static const String logInScreen = "/login_in_screen";
  static const String createAccountScreen = "/create_account_screen";
  static const String forgotPasswordScreen = "/forgot_password";
  static const String changePasswordScreen = "/change_password_screen";
  static const String dashboardScreen = "/dashboard";
  static const String accountScreen = "/account_screen";
  static const String homeScreen = "/home_screen";
  static const String cmsScreen = "/cms_Screen";
  static const String helpSupport = "/help_support";
  static const String otpVerificationScreen = "/otp_verification_screen";
  static const String resetPasswordScreen = "/reset_password_screen";
  static const String profileSetupScreen = "/profile_setup_screen";
  static const String settingsScreen = "/settings_screen";
  static const String notificationsScreen = "/notifications_screen";
  static const String searchPlayerScreen = "/search_player_screen";
  static const String contactUsScreen = "/contact_us_screen";
  static const String faqScreen = "/faq_screen";
  static const String profileScreen = "/profile_screen";
  static const String otherProfileScreen = "/other_profile_screen";
  static const String battleScreen = "/battle_screen";
  static const String socialScreen = "/social_screen";
  static const String shopScreen = "/shop_screen";
  static const String itemDetailScreen = "/item_detail_screen";
  static const String inventoryScreen = "/inventory_screen";
  static const String matchMakingScreen = "/match_making_screen";

  static const String tutorialScreen = "/tutorial_screen";
  static const String trainingScreen = "/training_screen";
  static const String skillTreeScreen = "/skill_tree_screen";
  static const String skillStateScreen = "/skill_state_screen";
  static const String missionScreen = "/mission_screen";
  static const String dailyChallenge = "/daily_challenge";
  static const String tutorialDetailScreen = "/tutorial_detail_screen";
  static const String tutorialVideoDetailScreen = "/tutorial_video_detail_screen";

  static const String challengeHistoryScreen = "/challenge_history_screen";
  static const String challengeApprovedScreen = "/challenge_approved_screen";
  static const String recordVideoScreen = "/record_video_screen";
  static const String submitProofScreen = "/submit_proof_screen";
  static const String previewSubmissionScreen = "/preview_submission_screen";

  static const String victoryScreen = "/victory_screen";
  static const String battleVictoryScreen = "/battle_victory_screen";
  static const String leagueRankingScreen = "/league_ranking_screen";
  static const String globalLeadBoardScreen = "/global_lead_board_screen";
  static const String emailMobileVerificationScreen = "/email_mobile_verification_screen";
  static const String conversationScreen = "/conversation_screen";
}

final GoRouter router = GoRouter(
  initialLocation: AppRouter.splashScreen,
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    /// Splash
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.splashScreen,
      name: AppRouter.splashScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => SplashCubit(), child: const SplashScreen());
      },
    ),

    /// WalkThrough
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.walkThroughScreen,
      name: AppRouter.walkThroughScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => WalkthroughCubit(), child: const WalkthroughScreen());
      },
    ),

    /// Log In
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.logInScreen,
      name: AppRouter.logInScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => LogInCubit(), child: LogInScreen());
      },
    ),

    /// Create Account
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.createAccountScreen,
      name: AppRouter.createAccountScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => CreateAccountCubit(), child: CreateAccountScreen());
      },
    ),

    /// Forgot Password
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.forgotPasswordScreen,
      name: AppRouter.forgotPasswordScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => ForgotPasswordCubit(), child: ForgotPasswordScreen());
      },
    ),

    /// Change Password
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.changePasswordScreen,
      name: AppRouter.changePasswordScreen,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => ChangePasswordCubit(),
          child: const ChangePasswordScreen(),
        );
      },
    ),

    /// Dashboard
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return DashboardScreen(child: child);
      },
      routes: [
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRouter.homeScreen,
          name: AppRouter.homeScreen,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(create: (context) => HomeCubit(), child: HomeScreen()),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRouter.battleScreen,
          name: AppRouter.battleScreen,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(create: (context) => BattlesCubit(), child: BattlesScreen()),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRouter.socialScreen,
          name: AppRouter.socialScreen,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(create: (context) => SocialCubit(), child: SocialScreen()),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRouter.profileScreen,
          name: AppRouter.profileScreen,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(create: (context) => ProfileCubit(), child: ProfileScreen()),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
      ],
    ),

    /// CMS Screen (Terms, Privacy, etc.)
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.cmsScreen,
      name: AppRouter.cmsScreen,
      builder: (context, state) {
        final type = state.extra as String;
        return BlocProvider(
          create: (_) => CmsCubit(type),
          child: CmsScreen(type: type),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.otpVerificationScreen,
      name: AppRouter.otpVerificationScreen,
      builder: (context, state) {
        final data = state.extra as Map;
        return BlocProvider(
          create: (_) => OtpVerificationCubit(
            email: data["email"] ?? "",
            phone: data["number"] ?? "",
            countryCode: data["country_code"] ?? "",
            verificationType: data["verification_type"] ?? "",
          ),
          child: OtpVerificationScreen(),
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.resetPasswordScreen,
      name: AppRouter.resetPasswordScreen,
      builder: (context, state) {
        final data = state.extra as Map;
        return BlocProvider(
          create: (_) => ResetPasswordCubit(email: data['email'], isReset: data['isReset']),
          child: ResetPasswordScreen(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.profileSetupScreen,
      name: AppRouter.profileSetupScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => ProfileSetupCubit(), child: ProfileSetupScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.settingsScreen,
      name: AppRouter.settingsScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => SettingsCubit(), child: SettingsScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.searchPlayerScreen,
      name: AppRouter.searchPlayerScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => SearchPlayersCubit(), child: SearchPlayersScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.notificationsScreen,
      name: AppRouter.notificationsScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => NotificationsCubit(), child: NotificationsScreen());
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.contactUsScreen,
      name: AppRouter.contactUsScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => ContactUsCubit(), child: ContactUs());
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.faqScreen,
      name: AppRouter.faqScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => FaqsCubit(), child: FaqsScreen());
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.otherProfileScreen,
      name: AppRouter.otherProfileScreen,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        final userId = extra["userId"];

        return BlocProvider(create: (_) => OtherProfileCubit(userId), child: OtherProfileScreen());
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.shopScreen,
      name: AppRouter.shopScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => ShopCubit(), child: ShopScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.itemDetailScreen,
      name: AppRouter.itemDetailScreen,
      builder: (context, state) {
        var data = state.extra as Map;
        var item = data['item'] as ShopItem;
        var cubit = data['cubit'] as ShopCubit;
        return ItemDetailScreen(cubit: cubit, item: item);
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.inventoryScreen,
      name: AppRouter.inventoryScreen,
      builder: (context, state) {
        return BlocProvider(create: (context) => InventoryCubit(), child: InventoryScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.matchMakingScreen,
      name: AppRouter.matchMakingScreen,
      builder: (context, state) {
        return MatchMakingScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.tutorialScreen,
      name: AppRouter.tutorialScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => TutorialCubit(), child: TutorialScreen());
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.trainingScreen,
      name: AppRouter.trainingScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => TrainingCubit(), child: TrainingScreen());
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.skillTreeScreen,
      name: AppRouter.skillTreeScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => SkillTreeCubit(), child: SkillTreeScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.skillStateScreen,
      name: AppRouter.skillStateScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => SkillStateCubit(), child: SkillStateScreen());
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.missionScreen,
      name: AppRouter.missionScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => MissionCubit(), child: MissionScreen());
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.dailyChallenge,
      name: AppRouter.dailyChallenge,
      builder: (context, state) {
        return BlocProvider(create: (_) => DailyChallengeCubit(), child: DailyChallengeScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.tutorialDetailScreen,
      name: AppRouter.tutorialDetailScreen,
      builder: (context, state) {
        return TutorialDetailScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.tutorialVideoDetailScreen,
      name: AppRouter.tutorialVideoDetailScreen,
      builder: (context, state) {
        return TutorialVideoDetailScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.challengeHistoryScreen,
      name: AppRouter.challengeHistoryScreen,
      builder: (context, state) {
        return ChallengeHistoryScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.challengeApprovedScreen,
      name: AppRouter.challengeApprovedScreen,
      builder: (context, state) {
        return ChallengeApprovedScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.recordVideoScreen,
      name: AppRouter.recordVideoScreen,
      builder: (context, state) {
        return RecordVideoScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.submitProofScreen,
      name: AppRouter.submitProofScreen,
      builder: (context, state) {
        return SubmitProofScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.previewSubmissionScreen,
      name: AppRouter.previewSubmissionScreen,
      builder: (context, state) {
        return PreviewSubmissionScreen();
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.victoryScreen,
      name: AppRouter.victoryScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => VictoryCubit(), child: const VictoryScreen());
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.battleVictoryScreen,
      name: AppRouter.battleVictoryScreen,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => BattleVictoryCubit(),
          child: const BattleVictoryScreen(),
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.leagueRankingScreen,
      name: AppRouter.leagueRankingScreen,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => LeagueRankingCubit(),
          child: const LeagueRankingScreen(),
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.globalLeadBoardScreen,
      name: AppRouter.globalLeadBoardScreen,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => GlobalLeadBoardCubit(),
          child: const GlobalLeadBoardScreen(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.emailMobileVerificationScreen,
      name: AppRouter.emailMobileVerificationScreen,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => EmailMobileVerificationCubit(),
          child: const EmailMobileVerificationScreen(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: AppRouter.conversationScreen,
      name: AppRouter.conversationScreen,
      builder: (context, state) {
        return BlocProvider(create: (_) => ConversationCubit(), child: const ConversationScreen());
      },
    ),
  ],
);
