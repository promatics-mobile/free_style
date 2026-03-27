part of 'contact_us_cubit.dart';

@immutable
sealed class ContactUsState {}

final class ContactUsInitial extends ContactUsState {}

class AdminModel {
  final String id;
  final String number;
  final String email;

  AdminModel({required this.id, required this.number, required this.email});

  /// From JSON
  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['_id'] ?? '',
      number: json['mobile'] != null
          ? json['mobile']['country_code'].toString() + json['mobile']['number'].toString()
          : "",
      email: json['email'] ?? '',
    );
  }
}
