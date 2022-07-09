import 'package:bloc/bloc.dart';
import 'package:honar_api_v17/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'explorer_state.dart';

class ExplorerCubit extends Cubit<ExplorerState> {
  late ArtApi artApi;

  ExplorerCubit() : super(ExplorerInitial()) {
    artApi = ArtApi(interfaceOfUser);
  }

  Future<void> fetchExplorer(int categoryItemSelectedId) async {
    emit(ExplorerLoading());
    try {
      List<ArtPiece> arts;
      if (categoryItemSelectedId == -1) {
        arts = (await artApi.artExploreList())!;
      } else {
        arts = (await artApi.artExploreList(categoryId: categoryItemSelectedId))!;
        print(arts);
      }
      emit(ExplorerLoaded(arts));
    } catch (e) {
      emit(ExplorerError());
    }
  }
}
