part of 'challenge_history_cubit.dart';

@immutable
sealed class ChallengeHistoryState {}

final class ChallengeHistoryInitial extends ChallengeHistoryState {}
class ChallengeHistoryModel {
  final String id;
  final String type;
  final FileModel file;
  final int attempt;
  final String status;
  final DateTime createdAt;
  final String? adminFeedback;
  final DateTime? reviewedAt;
  final ChallengeModel? challenge;

  ChallengeHistoryModel({
    required this.id,
    required this.type,
    required this.file,
    required this.attempt,
    required this.status,
    required this.createdAt,
    this.adminFeedback,
    this.reviewedAt,
    required this.challenge,
  });

  factory ChallengeHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChallengeHistoryModel(
      id: json['_id'] ?? '',
      type: json['type'] ?? '',
      file: FileModel.fromJson(json['file'] ?? {}),
      attempt: json['attempt'] ?? 0,
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      adminFeedback: json['admin_feedback']??"",
      reviewedAt: json['reviewed_at'] != null
          ? DateTime.parse(json['reviewed_at'])
          : null,
      challenge: json['challenge'] !=null ? ChallengeModel.fromJson(json['challenge'] ?? {}) :null,
    );
  }
}

class FileModel {
  final String id;
  final String originalName;
  final int size;
  final String mimeType;
  final String path;
  final String filename;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileModel({
    required this.id,
    required this.originalName,
    required this.size,
    required this.mimeType,
    required this.path,
    required this.filename,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['_id'] ?? '',
      originalName: json['original_name'] ?? '',
      size: json['size'] ?? 0,
      mimeType: json['mime_type'] ?? '',
      path: json['path'] ?? '',
      filename: json['filename'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class ChallengeModel {
  final String id;
  final DateTime date;
  final DateTime startAt;
  final DateTime endAt;

  ChallengeModel({
    required this.id,
    required this.date,
    required this.startAt,
    required this.endAt,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json['_id'] ?? '',
      date: DateTime.parse(json['date']),
      startAt: DateTime.parse(json['start_at']),
      endAt: DateTime.parse(json['end_at']),
    );
  }
}