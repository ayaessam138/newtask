import 'package:dartz/dartz.dart';
import 'package:newtask/core/failure.dart';
import 'package:newtask/features/item/data/models/albumModel.dart';


abstract class AlbumRepo{
  Future<Either<Failure,List<AlbumModel>>>getAllAlbums();

}