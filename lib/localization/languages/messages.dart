import 'package:cloneapp/localization/languages/en_us.dart';
import 'package:cloneapp/localization/languages/hi_in.dart';
import 'package:get/get.dart';



class Messages extends Translations {
@override
Map<String, Map<String, String>> get keys => {
'en_UST' : EnUs.map,
'hi_IN': HiIn.map,

};
}