import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/cast_model.dart';
import 'package:flutter_fiveflix/utils/colors.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({
    super.key,
    required this.castList,
  });

  final List<CastModel> castList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          'Cast',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: SizedBox(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: castList.length,
                    itemBuilder: (context, index) {
                      final castMember = castList[index];
                      return Container(
                        width: 70,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.backgroundColor,
                              backgroundImage: NetworkImage(
                                castMember.profilePath != null
                                    ? '${AppStrings.urlImagePoster}${castMember.profilePath}'
                                    : AppStrings.urlImagePlaceholder,
                              ),
                              radius: 48,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              castMember.name,
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
