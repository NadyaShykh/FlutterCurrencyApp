import '../data/currency_data.dart';
import '../data/currency_data_impl.dart';
import '../data/currency_data_mock.dart';


enum Flavor {
  MOCK,
  PRO
}

/// Simple DI
class Injector {
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  CurrencyRepository get contactRepository {
    switch(_flavor) {
      case Flavor.MOCK: return MockCurrencyRepository();
      default: // Flavor.PRO:
        return PrivatBankRepository();
    }
  }
}