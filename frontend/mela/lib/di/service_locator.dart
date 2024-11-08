
import 'package:get_it/get_it.dart';
import 'package:mela/domain/di/domain_layer_injection.dart';

import '../data/di/data_layer_injection.dart';
import '../presentation/di/presentation_layer_injection.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> configureDependencies() async {
    await DataLayerInjection.configureDataLayerInjection();
    await DomainLayerInjection.configureDomainLayerInjection();
    await PresentationLayerInjection.configurePresentationLayerInjection();
  }
}
