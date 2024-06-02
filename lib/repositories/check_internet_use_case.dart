import 'dart:io';

abstract class CheckInternetUsecase {
  Future<bool> call();
}

class CheckInternetUsecaseImpl extends CheckInternetUsecase {
  @override
  Future<bool> call() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
