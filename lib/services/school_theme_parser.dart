import '../ui/themes/esa.dart';
import '../ui/themes/esce.dart';
import '../ui/themes/esdl.dart';
import '../ui/themes/ese.dart';
import '../ui/themes/ess.dart';
import '../ui/themes/estg.dart';
import '../ui/themes/ipvc.dart';

dynamic parseSchoolTheme(String school) {
  switch (school) {
    case "ESA":
      return ESATheme;
    case "ESCE":
      return ESCETheme;
    case "ESDL":
      return ESDLTheme;
    case "ESE":
      return ESETheme;
    case "ESS":
      return ESSTheme;
    case "ESTG":
      return ESTGTheme;
    default:
      return IPVCTheme;
  }
}