import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/favorite_model.dart';
import 'package:flutter_fiveflix/screens/widgets/snack_bar_helper.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FavoriteButton extends StatefulWidget {
  final FavoriteModel itemFavorite;

  const FavoriteButton({super.key, required this.itemFavorite});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

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
        if (state.item.id == widget.itemFavorite.id) {
          setState(() => _isFavorite = true);
        }
        SnackBarHelper.showSnackBar(
          context: context,
          text: FiveflixStrings.addToFavoritesSuccessMessage,
        );
      } else if (state is FavoriteItemRemovedState) {
        setState(() => _isFavorite = false);

        SnackBarHelper.showSnackBar(
          context: context,
          text: FiveflixStrings.removeFromFavoritesSuccessMessage,
        );
      } else if (state is FavoriteErrorState) {
        SnackBarHelper.showSnackBar(
          context: context,
          text: FiveflixStrings.errorMessage,
        );
      } else if (state is FavoriteGetAllSuccessState) {
        setState(() => _isFavorite =
            state.items.any((item) => item.id == widget.itemFavorite.id));
      }
    }, builder: (context, state) {
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
          child: Icon(
            _isFavorite ? Icons.check : Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
