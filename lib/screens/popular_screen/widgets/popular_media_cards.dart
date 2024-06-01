import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';

class PopularMediaCards extends StatelessWidget {
  final List<MediaModel> medias;
  final String titleMedia;

  const PopularMediaCards({
    super.key,
    required this.medias,
    required this.titleMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
          child: Text(
            titleMedia,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 170,
              child: ListView.builder(
                itemCount: medias.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final MediaModel itemMedia = medias[index];

                  return CardMedia(
                    media: itemMedia,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
