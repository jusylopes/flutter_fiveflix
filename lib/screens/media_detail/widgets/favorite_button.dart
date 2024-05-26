import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/favorite_model.dart';
import 'package:flutter_fiveflix/screens/widgets/snack_bar_helper.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FavoriteButton extends StatelessWidget {
  final FavoriteModel itemFavorite;

  const FavoriteButton({super.key, required this.itemFavorite});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteItemSuccessState) {
          SnackBarHelper.showSnackBar(
            context: context,
            text: FiveflixStrings.sucessMessageFavorite,
          );
        } else if (state is FavoriteErrorState) {
          SnackBarHelper.showSnackBar(
            context: context,
            text: FiveflixStrings.errorMessage,
          );
        }
      },
      child: Align(
        alignment: Alignment.topRight,
        child: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<FavoriteBloc>(context, listen: false)
                .add(FavoriteSaveEvent(
              item: itemFavorite,
            ));
          },
          backgroundColor: FiveflixColors.primaryColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
