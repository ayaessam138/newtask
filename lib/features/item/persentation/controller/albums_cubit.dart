import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:newtask/features/item/data/models/albumModel.dart';
import 'package:newtask/features/item/data/repo/albumRepo.dart';

part 'albums_state.dart';

class AlbumsCubit extends Cubit<AlbumsState> {
  AlbumsCubit(this.albumRepo) : super(AlbumsInitial()) {}
  final ScrollController scrollController = ScrollController();
  int visibleItemCount = 20;
  bool isLoadingMore = false;
  final AlbumRepo albumRepo;
  init() {
    scrollController.addListener(onScroll);
    getAllAlbums();
  }

  List<AlbumModel> albumsList = [];
  Future<void> getAllAlbums() async {
    print('object66');
    emit(GetAlbumsLoading());
    var response = await albumRepo.getAllAlbums();
    response.fold((failure) {
      emit(GetAlbumsFail(errorMessage: failure.errorMessage));
    }, (albums) {
      albumsList = albums;
      emit(GetAlbumsSuccess());
    });
  }

  void onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadingMore) {
      if (visibleItemCount <= albumsList.length) loadMoreItems();
    }
  }

  Future<void> loadMoreItems() async {
    isLoadingMore = true;
    emit(LoadingMoreData());
    await Future.delayed(const Duration(seconds: 1));

    visibleItemCount += 20;
    isLoadingMore = false;
    emit(LoadedMoreDataSuccess());
  }
}
