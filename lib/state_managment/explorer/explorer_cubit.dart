import 'package:bloc/bloc.dart';
import 'package:honar_api_v8/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'explorer_state.dart';

class ExplorerCubit extends Cubit<ExplorerState> {
  late ArtApi artApi;

  ExplorerCubit() : super(ExplorerInitial()) {
    artApi = ArtApi(interfaceOfUser);
  }

  Future<void> fetchExplorer() async {
    emit(ExplorerLoading());
    try {
      List<ArtPiece> arts = await artApi.artExploreList();
      emit(ExplorerLoaded(arts));
    } catch (e) {
      emit(ExplorerError());
    }
  }
}
