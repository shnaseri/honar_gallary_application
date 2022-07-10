import 'package:bloc/bloc.dart';
import 'package:honar_api_v19/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  late ArtApi artApi;

  SearchCubit() : super(SearchInitial()) {
    artApi = ArtApi(interfaceOfUser);
  }

  Future<void> search(String text) async {
    try {
      emit(SearchLoading());
      SearchResult? searchResult = await artApi.artSearchList(query: text);
      print(searchResult);
      emit(SearchLoaded(searchResult!.artists, searchResult.artPieces, text));
    } catch (e) {
      emit(SearchError());
    }
  }
}
