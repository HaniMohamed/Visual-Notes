# Visual-notes

A Flutter app stores data locally using sqflite database. It's a simple solution of a test for using sqflite database, image picker and store Specially, Programming and flutter framework generally.

## 3rd party Packages:
- sqflite -> used to create and handeling local database.
- path_provider and path -> to save sqflite database file and save picked images in application directory.
- provider -> for State-managment.
- image_picker ->  pick image from camera.

## Importnat-Notes:
- ~~Images saved in database as list of bytes (Unit8List).~~
   Update: Image stores in ApplicationDirectory and save its path in database because of huge the images takes a huge list of bytes in database and it's a big resource consumption while add or retreiving.
- Project is build with MVVM design pattern.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
