part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


class MenuItemModel {
  final String title;
  final String icon;

  const MenuItemModel({
    required this.title,
    required this.icon,
  });
}