import 'package:bloc/bloc.dart';
import 'package:honar_api_v19/api.dart';
import 'package:meta/meta.dart';

import '../../logic/consts.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late CoreApi coreApi;

  HomeCubit() : super(HomeInitial()) {
    coreApi = CoreApi(interfaceOfUser);
  }

  Future fetchHome() async {
    try {
      emit(HomeLoading());
      CoreHomepageList200Response? coreHomepageList200Response =
      await coreApi.coreHomepageList(page: 1, pageCount: 20);
      print(coreHomepageList200Response);
      emit(HomeLoaded(coreHomepageList200Response!));
    } catch (e) {
      print(e);
      emit(HomeError());
    }
  }
}
