import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetService {
  static Future<bool> hasInternet() async {

    /// Check network type
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.contains(ConnectivityResult.none)) {
      return false;
    }

    /// Check real internet access
    bool result = await InternetConnection().hasInternetAccess;

    return result;
  }
}