import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/datasources/favorite_datasource.dart';
import 'package:flutter_fiveflix/datasources/http_datasource.dart';
import 'package:flutter_fiveflix/datasources/local_datasource.dart';
import 'package:flutter_fiveflix/repositories/chek_internet_use_case.dart';
import 'package:flutter_fiveflix/repositories/favorite_repository.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final httpDatasource = HttpDatasourceImpl(dioOptions: dioOptions);
    final localDatasource = LocalDatasourceImpl();
    final checkInternet = CheckInternetUsecaseImpl();

    final mediaRepository = MediaRepository(
        datasource: httpDatasource,
        checkInternetUsecase: checkInternet,
        localDatasource: localDatasource);

    final favoriteMediaRepository =
        FavoriteRepository(datasource: FavoriteDatasourceImpl());

    return RepositoryProvider.value(
      value: mediaRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MediaBloc(repository: mediaRepository),
          ),
          BlocProvider(
            create: (context) => SearchBloc(repository: mediaRepository),
          ),
          BlocProvider(
            create: (context) =>
                FavoriteBloc(repository: favoriteMediaRepository),
          ),
          BlocProvider(
            create: (context) => CategoriesBloc(repository: mediaRepository),
          ),
        ],
        child: child,
      ),
    );
  }
}
