part of 'gallery_cubit.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final List<InlineResponse2003Posts> arts;
  final int postCount;
  final InlineResponse2003Owner owner;

  GalleryLoaded(this.owner, this.postCount, this.arts);
}

class GalleryError extends GalleryState {}
