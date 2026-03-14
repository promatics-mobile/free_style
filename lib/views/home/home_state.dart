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


class ItemModel {
   String title;
   String? icon;
   bool isSelected;

   ItemModel({
     required this.title,
     required this.isSelected,
     this.icon,
  });
}