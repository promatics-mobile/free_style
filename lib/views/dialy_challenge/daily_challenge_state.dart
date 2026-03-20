part of 'daily_challenge_cubit.dart';

@immutable
sealed class DailyChallengeState {}

final class DailyChallengeInitial extends DailyChallengeState {}


enum ChallengeStatus {
  approved,
  rejected,
  pending,
  review,
}


extension ChallengeStatusX on String {
  ChallengeStatus get toStatus {
    switch (toLowerCase()) {
      case 'approved':
        return ChallengeStatus.approved;
      case 'rejected':
      case 'reject':
        return ChallengeStatus.rejected;
      case 'pending':
        return ChallengeStatus.pending;
      case 'review':
        return ChallengeStatus.review;
      default:
        return ChallengeStatus.pending;
    }
  }
}
class StatusUI {
  final Color bgColor;
  final Color iconColor;
  final IconData icon;

  StatusUI({
    required this.bgColor,
    required this.iconColor,
    required this.icon,
  });
}

StatusUI getStatusUI(String status) {
  switch (status.toStatus) {
    case ChallengeStatus.approved:
      return StatusUI(
        bgColor: Colors.green.shade50,
        iconColor: Colors.green,
        icon: Icons.check,
      );

    case ChallengeStatus.rejected:
      return StatusUI(
        bgColor: Colors.red.shade50,
        iconColor: Colors.red,
        icon: Icons.close,
      );

    case ChallengeStatus.pending:
      return StatusUI(
        bgColor: Colors.orange.shade50,
        iconColor: Colors.orange,
        icon: Icons.access_time,
      );

    case ChallengeStatus.review:
      return StatusUI(
        bgColor: Colors.blue.shade50,
        iconColor: Colors.blue,
        icon: Icons.rate_review,
      );
  }
}