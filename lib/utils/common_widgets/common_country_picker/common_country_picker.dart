import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import '../../common_constants.dart';

void showCountryCodePickerDialog(BuildContext context, {required Function(Country) onChanged}) {
  showCountryPicker(
    context: context,
    showPhoneCode: true,
    useSafeArea: true,
    countryListTheme: CountryListThemeData(
      margin: EdgeInsets.symmetric(horizontal: size(context).width * numD04),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(size(context).width * numD04),
        topRight: Radius.circular(size(context).width * numD04),
      ),
    ),
    onSelect: (Country country) {
      debugPrint('Select country: ${country.displayName}');
      onChanged(country);
    },
  );
}