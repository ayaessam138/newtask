part of 'albums_cubit.dart';

@immutable
abstract class AlbumsState {}

class AlbumsInitial extends AlbumsState {}

class GetAlbumsLoading extends AlbumsState {}
class LoadingMoreData extends AlbumsState {}
class LoadedMoreDataSuccess extends AlbumsState {}

class GetAlbumsFail extends AlbumsState {
  final String errorMessage;

  GetAlbumsFail({required this.errorMessage});
}

class GetAlbumsSuccess extends AlbumsState {
  // final List<AlbumModel> albumsList;
  //
  // GetAlbumsSuccess({required this.albumsList});
}
