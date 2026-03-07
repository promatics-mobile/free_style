import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_players_state.dart';

class SearchPlayersCubit extends Cubit<SearchPlayersState> {
  SearchPlayersCubit() : super(SearchPlayersInitial());
}
