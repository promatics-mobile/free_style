part of 'tutorial_cubit.dart';

@immutable
sealed class TutorialState {}

final class TutorialInitial extends TutorialState {}

class TutorialModel {
  final String id;
  final String displayTitle;
  final LanguageTag languageTag;
  final String externalUrl;
  final InternalMediaModel? internalUrl;
  final List<StepModel> steps;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  TutorialModel({
    required this.id,
    required this.displayTitle,
    required this.languageTag,
    required this.externalUrl,
    required this.internalUrl,
    required this.steps,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TutorialModel.fromJson(Map<String, dynamic> json) {
    return TutorialModel(
      id: json['_id'] ?? '',
      displayTitle: json['display_title'] ?? '',
      languageTag: LanguageTag.fromJson(json['language_tag'] ?? {}),
      externalUrl: json['externel_url'] ?? '',
      internalUrl: json['internal_url'] != null
          ? InternalMediaModel.fromJson(json['internal_url'])
          : null,
      steps: (json['steps'] as List<dynamic>? ?? []).map((e) => StepModel.fromJson(e)).toList(),
      isActive: json['is_active'] ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'display_title': displayTitle,
      'language_tag': languageTag.toJson(),
      'externel_url': externalUrl,
      'internal_url': internalUrl,
      'steps': steps.map((e) => e.toJson()).toList(),
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class LanguageTag {
  final String language;
  final String code;

  LanguageTag({required this.language, required this.code});

  factory LanguageTag.fromJson(Map<String, dynamic> json) {
    return LanguageTag(language: json['language'] ?? '', code: json['code'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'language': language, 'code': code};
  }
}

class StepModel {
  final String title;
  final String description;

  StepModel({required this.title, required this.description});

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(title: json['title'] ?? '', description: json['description'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description};
  }
}



class InternalMediaModel {
  final String id;
  final String originalName;
  final int size;
  final String mimeType;
  final String path;
  final String filename;
  final DateTime createdAt;
  final DateTime updatedAt;

  InternalMediaModel({
    required this.id,
    required this.originalName,
    required this.size,
    required this.mimeType,
    required this.path,
    required this.filename,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 🔹 From JSON
  factory InternalMediaModel.fromJson(Map<String, dynamic> json) {
    return InternalMediaModel(
      id: json['_id'] ?? '',
      originalName: json['original_name'] ?? '',
      size: json['size'] ?? 0,
      mimeType: json['mime_type'] ?? '',
      path: json['path'] ?? '',
      filename: json['filename'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 To JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "original_name": originalName,
      "size": size,
      "mime_type": mimeType,
      "path": path,
      "filename": filename,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }

  /// 🔹 Full URL (VERY USEFUL)
  String getFileUrl(String baseUrl) {
    return "$baseUrl$path/$filename";
  }
}
