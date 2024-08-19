import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/all_medias/all_media_screen.dart';
import 'package:flutter_fiveflix/screens/all_medias/all_media_type.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';

class PopularMediaCards extends StatelessWidget {
  final List<MediaModel> medias;
  final String titleMedia;
  final AllMediaType mediaType;
  final String idGenre;

  const PopularMediaCards(
      {super.key,
      required this.medias,
      required this.titleMedia,
      required this.mediaType,
      this.idGenre = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleMedia,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllMediaScreen(
                                mediaType: mediaType,
                                titleMedia: titleMedia,
                                idGenre: idGenre,
                              )));
                },
                child: Text(
                  'See all',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Column(
          children: [
            SizedBox(
              height: 180,
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
