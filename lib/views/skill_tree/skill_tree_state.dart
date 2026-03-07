part of 'skill_tree_cubit.dart';

@immutable
sealed class SkillTreeState {}

final class SkillTreeInitial extends SkillTreeState {}



class StepperData {
  final String? icon;
  final String? title;
  final String? subtitle;

  const StepperData({this.icon, this.title, this.subtitle});
}