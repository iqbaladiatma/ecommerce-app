// file: ondeh_uda.dart
import 'dart:async';
import 'dart:io';

Future<void> main() async {
  final lyrics = [
    "Ondeh Uda, jan lah baitu bana",
    "Denai ko indaklah nan sarupo itu",
    "Dek hanyo takuik mancaliak Uda",
    "Acok mabuak-mabuakan",
    "",
    "Dulu denai lah suko mancaliak Uda bakawan",
    "Raso-raso ko ado, tapi denai diamkan",
    "",
    "A wadaw wadaw, ini anak gagah lai",
    "Su bale Jawa, tambah bening aja lai",
    "Gaya semakin beda, bibir merah-merah",
    "Aduh mama, mama ini siapa punya anak?",
  ];

  print("🎶 Tabola Bale 🎶\n");

  for (final line in lyrics) {
    await showLine(line);
    await Future.delayed(const Duration(seconds: 1)); // jeda antar baris
  }

  print("\n✅ Karaoke selesai!");
}

Future<void> showLine(String line) async {
  for (int i = 0; i < line.length; i++) {
    stdout.write(line[i]);
    await Future.delayed(const Duration(milliseconds: 90)); // kecepatan ketik
  }
  stdout.write("\n");
}
