import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/favorite/favorite_empty_card.dart';
import 'package:flutter_fiveflix/screens/favorite/favorite_card.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'My list favorite',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FavoriteBloc, FavoriteState>(
            listenWhen: (previous, current) =>
                current is FavoriteItemRemovedState,
            listener: (context, state) {
              if (state is FavoriteItemRemovedState) {
                context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
              }
            },
          ),
          BlocListener<FavoriteBloc, FavoriteState>(
            listenWhen: (previous, current) =>
                current is FavoriteItemAddedState,
            listener: (context, state) {
              if (state is FavoriteItemAddedState) {
                context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
              }
            },
          ),
        ],
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteErrorState) {
              return ErrorLoadingMessage(
                errorMessage: state.message,
              );
            } else if (state is FavoriteGetAllSuccessState) {
              final List favoriteList = state.items;

              if (favoriteList.isEmpty) {
                return const FavoriteEmptyCard();
              }

              return ListView.builder(
                key: Key(WidgetKeys.favoritesCard.key),
                itemCount: favoriteList.length,
                itemBuilder: (BuildContext context, int index) {
                  final MediaModel item = favoriteList[index];

                  return FavoriteCard(
                    itemFavorite: item,
                  );
                },
              );
            } else {
              return const FiveflixCircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
