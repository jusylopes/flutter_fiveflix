import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/datasources/http_datasource.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dioHttpDatasource = HttpDatasourceImpl(dioOptions: dioOptions);
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
        ],
        child: child,
      ),
    );
  }
}
