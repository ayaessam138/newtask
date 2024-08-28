import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtask/core/BlocObsever.dart';
import 'package:newtask/core/dio_helper.dart';
import 'package:newtask/features/item/data/repo/albumRepoImpl.dart';
import 'package:newtask/features/item/persentation/controller/albums_cubit.dart';
import 'package:newtask/features/item/persentation/view/albums.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AlbumsCubit(AlbumRepoImpl())..init(),
        child: const MaterialApp(home: Albums()));
  }
}
