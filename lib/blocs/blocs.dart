import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/media_detail_screen/media_detail_bloc.dart';
import 'package:flutter_fiveflix/blocs/news_screen/news_bloc.dart';
import 'package:flutter_fiveflix/blocs/search/search_bloc.dart';
import 'package:flutter_fiveflix/datasources/http_datasource.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/utils/api_base_options.dart';

import 'popular_media_screen/media_bloc.dart';

class BlocWidget extends StatelessWidget {
  const BlocWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dioHttpDatasource = DioHttpDatasource(dioOptions: dioOptions);
    final mediaRepository = MediaRepository(dioHttpDatasource);

    return RepositoryProvider.value(
      value: mediaRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MediaBloc(
              repository: mediaRepository,
            ),
          ),
          BlocProvider(
            create: (context) => MediaDetailBloc(
              repository: mediaRepository,
            ),
          ),
          BlocProvider(
            create: (context) => SearchBloc(
              repository: mediaRepository,
            ),
          ),
          BlocProvider(
            create: (context) => NewsBloc(
              repository: mediaRepository,
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
