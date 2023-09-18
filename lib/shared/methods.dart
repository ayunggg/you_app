import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import ini untuk inisialisasi lokalasi

formatDate(String dateString) {
  DateFormat format = DateFormat("dd MM y");
  DateTime dateDay = format.parse(dateString);
  DateTime dateNow = DateTime.now();

  num age = dateNow.year - dateDay.year;

  return age;
}

Future<String?> selectImage() async {
  XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  return selectedImage!.path;
}

Future<String> selectDate(
    BuildContext context, TextEditingController birthdayController) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (picked != null && picked != DateTime.now()) {
    return birthdayController.text = DateFormat('dd MM y').format(picked);
  }

  return "DD MM YYYY";
}

Future<String> getHoroscope(
    String birthdate, TextEditingController horoscope) async {
  DateFormat format = DateFormat("dd MM y");
  DateTime dateDay = format.parse(birthdate);
  int day = dateDay.day;
  int month = dateDay.month;

  try {
    switch (month) {
      case 1: // Januari
        return (day >= 20)
            ? horoscope.text = 'Aquarius'
            : horoscope.text = 'Capricorn';
      case 2: // Februari
        return (day >= 19)
            ? horoscope.text = 'Pisces'
            : horoscope.text = 'Aquarius';
      case 3: // Maret
        return (day >= 21)
            ? horoscope.text = 'Aries'
            : horoscope.text = 'Pisces';
      case 4: // April
        return (day >= 20)
            ? horoscope.text = 'Taurus'
            : horoscope.text = 'Aries';
      case 5: // Mei
        return (day >= 21)
            ? horoscope.text = 'Gemini'
            : horoscope.text = 'Taurus';
      case 6: // Juni
        return (day >= 21)
            ? horoscope.text = 'Cancer'
            : horoscope.text = 'Gemini';
      case 7: // Juli
        return (day >= 23) ? horoscope.text = 'Leo' : horoscope.text = 'Cancer';
      case 8: // Agustus
        return (day >= 23) ? horoscope.text = 'Virgo' : horoscope.text = 'Leo';
      case 9: // September
        return (day >= 23)
            ? horoscope.text = 'Libra'
            : horoscope.text = 'Virgo';
      case 10: // Oktober
        return (day >= 23)
            ? horoscope.text = 'Scorpio'
            : horoscope.text = 'Libra';
      case 11: // November
        return (day >= 22)
            ? horoscope.text = 'Sagittarius'
            : horoscope.text = 'Scorpio';
      case 12: // Desember
        return (day >= 22)
            ? horoscope.text = 'Capricorn'
            : horoscope.text = 'Sagittarius';
      default:
        return horoscope.text = 'Tidak Valid';
    }
  } catch (e) {
    throw e.toString();
  }
}

Future<String> getZodiac(TextEditingController zodiac, String date) async {
  DateFormat format = DateFormat("dd MM yyyy");
  DateTime dateDay = format.parse(date);
  const zodiakCina = [
    'Tikus',
    'Kerbau',
    'Macan',
    'Kelinci',
    'Naga',
    'Ular',
    'Kuda',
    'Kambing',
    'Monyet',
    'Ayam',
    'Anjing',
    'Babi'
  ];
  return zodiac.text = zodiakCina[(dateDay.year - 1900) % 12].toString();
}
