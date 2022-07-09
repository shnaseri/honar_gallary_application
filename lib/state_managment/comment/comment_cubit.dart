import 'package:bloc/bloc.dart';
import 'package:honar_api_v17/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  late CommentApi commentApi;

  CommentCubit() : super(CommentInitial()) {
    commentApi = CommentApi(interfaceOfUser);
  }

  Future fetchComments(String artPieceId) async {
    try {
      emit(CommentLoading());
      List<Comments>? comments =
          await commentApi.commentAllCommentsList(artPieceId);
      print(comments);
      emit(CommentLoaded(comments!));
    } catch (e) {
      print(e);
      emit(CommentLoaded([]));
      emit(CommentError());
    }
  }

  Future<Comments?> sendCommentEvent(
      {required int adminId, required String text, int? parentId}) async {
    try {
      SingleComment? singleComment;
      if (parentId == null) {
        singleComment = await commentApi.commentAddCommentCreate(
            adminId.toString(), AddComment(content: text));
      } else {
        singleComment = await commentApi.commentAddCommentCreate(
            adminId.toString(), AddComment(content: text, parentId: parentId));
      }
      return Comments(
        id: singleComment!.id,
        content: singleComment.content,
        writer: singleComment.writer,
        createdAt: singleComment.createdAt,
        childComments: [],
      );
    } catch (e) {
      emit(CommentError());
      return null;
    }
  }
}
