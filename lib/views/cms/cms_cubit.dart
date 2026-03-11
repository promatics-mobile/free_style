import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_style/network_class/api_response.dart';
import '../../network_class/api_service.dart';
import '../../network_class/web_urls.dart';
import 'cms_state.dart';

class CmsCubit extends Cubit<CmsState> implements NetworkResponse{
  String type = "";
  String cmsType = "";
  String cmsValue = "";

  String privacyPolicy = '''
Effective Date: 01-03-2026

Welcome to Free Style, a Freestyle Skill Development and Competitive Battle platform. Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our mobile application.

1. Information We Collect

a. Account Information
- Username / Display Name
- Email address (if registered)
- Phone number (if registered)
- Profile avatar
- Authentication credentials

b. Usage & Gameplay Data
- Level, XP, SP, RP
- Skill unlock progress
- Battle history
- Daily challenge participation
- League and ranking information
- Mission progress

c. Device Information
- Device type and OS version
- App version
- IP address (for security and fraud prevention)

d. Media Submissions
- Videos submitted for missions, daily challenges, or battles
- Metadata related to submission timestamps

2. How We Use Your Information

We use collected data to:
- Provide gameplay features (Skill Tree, Battles, Ranking, Challenges)
- Manage rewards (XP, SP, Coins, RP)
- Verify challenge and battles submissions
- Improve matchmaking fairness
- Maintain leaderboards and league rankings
- Provide customer support
- Ensure account security and prevent fraud

3. Guest Mode

Guest users may access limited features. Guest progress may not be recoverable if the app is uninstalled unless converted to a registered account.

4. Data Sharing

We do NOT sell personal data.

We may share information with:
- Verification administrators (for challenge/battles review)
- Secure cloud storage providers (for video/media storage)
- Legal authorities if required by law

5. Data Security

We implement secure authentication, encrypted storage practices, and server-side validation to protect user accounts and gameplay integrity.

6. Children’s Privacy

You must be at least 13 years old to use this app. We do not knowingly collect data from children under 13.

7. Public Profile Information

Username, avatar, ranking, league, and selected achievements may be visible to other players based on your privacy settings.

8. Data Retention

We retain account and gameplay data as long as your account remains active.

9. Changes to This Policy

We may update this policy periodically. Continued use of the app means you accept the updated policy.

10. Contact Us

Email: support@humanapp.com
Address: India
''';
  String termsAndConditions = '''
Effective Date: 01-03-2026

Welcome to Free Style. These Terms and Conditions govern your use of our freestyle skill training and competitive battles platform.

1. Acceptance

By creating an account and agree to these Terms.

2. Eligibility

You must be at least 13 years old to use the app.

3. Account Responsibilities

You agree to:
- Provide accurate information
- Maintain account security
- Not share login credentials
- Not exploit bugs or unfair advantages

4. Gameplay Rules

- Battles are restricted to same color tier.
- Ranking Points (RP) are server-authoritative.
- Daily challenges must be completed within the specified time.
- Video submissions must follow duration rules.
- Abuse, cheating, or fraudulent submissions may result in suspension.

5. Virtual Rewards

XP, SP, Coins, and RP have no real-world monetary value and cannot be transferred outside the app.

6. Content Submission

By submitting videos:
- You confirm the content is yours.
- You grant us the right to review and store submissions for verification.
- Inappropriate content may result in penalties.

7. Leaderboards & Rankings

Rankings are calculated using defined RP and league rules. Results are final unless corrected by administrators.

8. Shop & Purchases

Coins are used for in-app customization (balls, outfits).
All purchases are final unless required by law.

9. Account Suspension

We may suspend or terminate accounts for:
- Cheating
- Harassment
- Exploiting system vulnerabilities
- Violating community guidelines

10. Limitation of Liability

We are not responsible for:
- Network failures
- Lost guest data
- User-generated content

11. Governing Law

These Terms are governed by the laws of India.

12. Contact

Email: support@humanapp.com
''';
  String licensesTerms = '''
Effective Date: 01-03-2026

These License Terms govern your use of the Human mobile application.

1. License Grant

We grant you a limited, non-transferable, non-exclusive license to use the app for personal, non-commercial use.

2. Restrictions

You may not:
- Reverse engineer the app
- Modify or redistribute the app
- Use automation to exploit gameplay
- Interfere with ranking or battles systems

3. Intellectual Property

All game mechanics, skill tree structure, ranking systems, and designs are owned by Human.

4. Third-Party Services

The app may use:
- Cloud storage services
- Push notification services
- Authentication providers

Their respective terms also apply.

5. No Warranty

The app is provided “as is” without warranties of uninterrupted service.

6. Termination

Your license terminates automatically if you violate these terms.

7. Governing Law

These License Terms are governed by the laws of India.

8. Contact

Email: support@humanapp.com
''';

  CmsCubit(String type) : super(CmsState()){
    callCmsApi(type.replaceAll(" ", "_").toLowerCase());
  }



  void callCmsApi(String type) {
    DioNetworkCall().callApiRequest(
      endUrl: cmsApiUrl,
      method: "GET",
      requestCode: cmsApiReq,
      networkResponse: this,
      showLoader: true,
      query: {"type":type}
    );
  }




  @override
  void onApiError({Key? key, required int requestCode, required String response}) {
    switch(requestCode){
      case cmsApiReq:
        var data = jsonDecode(response);
        break;
    }
  }

  @override
  void onResponse({Key? key, required int requestCode, required String response}) {
    switch(requestCode){
      case cmsApiReq:
        var data = jsonDecode(response) as Map;
        debugPrint("MESSAGE::${data["message"]}");
        break;
    }
  }

}
