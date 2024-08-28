import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:newtask/core/dio_helper.dart';
import 'package:newtask/core/failure.dart';
import 'package:newtask/features/item/data/models/albumModel.dart';
import 'package:newtask/features/item/data/repo/albumRepo.dart';

class AlbumRepoImpl implements AlbumRepo {
  List<AlbumModel> albumList = [];

  @override
  Future<Either<Failure, List<AlbumModel>>> getAllAlbums() async {
    print('object');
    try {
      await DioHelper.getData(
        url: 'photos',
      ).then((response) {
        albumList =
            List.of(response.data).map((e) => AlbumModel.fromJson(e)).toList();
        // for (var album in albumList) {
        //   print('Album ID: ${album.url}, Title: ${album.title}');
        // }
        // print(response.statusCode);
        // print(albumList);
      });

      return right(albumList);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}
