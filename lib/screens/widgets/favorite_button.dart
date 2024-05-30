import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/favorite_model.dart';
import 'package:flutter_fiveflix/screens/widgets/favorite_icon.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FavoriteButton extends StatefulWidget {
  final FavoriteModel itemFavorite;

  const FavoriteButton({super.key, required this.itemFavorite});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  List _listFavorite = [];

  @override
  void initState() {
    super.initState();

    context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteItemAddedState) {
          context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
          showSnackBar(context, FiveflixStrings.addItemFavoriteSucess);
        } else if (state is FavoriteItemRemovedState) {
          context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
          showSnackBar(context, FiveflixStrings.removeItemFavoriteSucess);
        } else if (state is FavoriteErrorState) {
          showSnackBar(context, FiveflixStrings.errorMessage);
        }
        if (state is FavoriteGetAllSuccessState) {
          setState(() => _listFavorite = state.items);
        }
      },
      builder: (context, state) {
        return Align(
          alignment: Alignment.topRight,
          child: FloatingActionButton(
            onPressed: () {
              context.read<FavoriteBloc>().add(FavoriteToggleEvent(
                    item: widget.itemFavorite,
                    id: widget.itemFavorite.id,
                  ));
            },
            backgroundColor: FiveflixColors.primaryColor,
            shape: const CircleBorder(),
            child: FavoriteIcon(
              favoriteList: _listFavorite,
              mediaId: widget.itemFavorite.id,
            ),
          ),
        );
      },
    );
  }
}
