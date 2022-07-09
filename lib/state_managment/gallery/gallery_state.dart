part of 'gallery_cubit.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final List<ArtGalleryRead200ResponsePostsInner> arts;
  final int postCount;
  final ArtGalleryRead200ResponseOwner owner;
  final ArtGalleryRead200ResponseProfile profile;

  GalleryLoaded(this.owner, this.postCount, this.arts, this.profile);
}

class GalleryError extends GalleryState {}
