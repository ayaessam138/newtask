import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtask/features/item/persentation/controller/albums_cubit.dart';

class Albums extends StatefulWidget {
  const Albums({super.key});

  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  // final ScrollController _scrollController = ScrollController();
  // int _visibleItemCount = 20;
  // bool _isLoadingMore = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController.addListener(BlocProvider.of<AlbumsCubit>(context).onScroll);
  //   context.read<AlbumsCubit>().getAllAlbums();
  // }

  // void _onScroll() {
  //   if (_scrollController.position.pixels ==
  //           _scrollController.position.maxScrollExtent &&
  //       !_isLoadingMore) {
  //     _loadMoreItems();
  //   }
  // }
  //
  // Future<void> _loadMoreItems() async {
  //   setState(() {
  //     _isLoadingMore = true;
  //   });
  //
  //   await Future.delayed(const Duration(seconds: 1));
  //
  //   setState(() {
  //     _visibleItemCount += 20;
  //     _isLoadingMore = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AlbumsCubit, AlbumsState>(
        builder: (context, state) {
          if (state is GetAlbumsSuccess ||
              state is LoadedMoreDataSuccess ||
              state is LoadingMoreData) {
            final cubit = BlocProvider.of<AlbumsCubit>(context);
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: cubit.scrollController,
                    itemCount: cubit.visibleItemCount > cubit.albumsList.length
                        ? cubit.albumsList.length
                        : cubit.visibleItemCount,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 32.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 1),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                color: Colors.black,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: InteractiveViewer(
                                    minScale: 1,
                                    maxScale: 9,
                                    child: Image.network(
                                      cubit.albumsList[index].url,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Image.network(
                                cubit.albumsList[index].thumbnailUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                cubit.albumsList[index].title,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (cubit.isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ), // Loading indicator at the bottom
              ],
            );
          } else if (state is GetAlbumsFail) {
            return const Center(child: Text('Failed To Load Data'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
}
