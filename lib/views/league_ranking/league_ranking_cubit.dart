import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'league_ranking_state.dart';

class LeagueRankingCubit extends Cubit<LeagueRankingState> {
  LeagueRankingCubit() : super(LeagueRankingInitial());
}
