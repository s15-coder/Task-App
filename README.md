
# Tasks Stack 📝

It's a [Flutter](https://flutter.dev/) project created to help people to manage their tasks in a better way, and so be more productive and organized.✔️✔️

## Installation

If you want to run the project you might want to execute the command ``flutter pub get`` or ``flutter packages get`` to fetch the libraries used in the project from [pub.dev](https://link-url-here.org).

## Technical stuffs

It application has been created using the the state management library [BLoC](https://pub.dev/packages/flutter_bloc) following its conventios.

To manage the different http requests was used the library [http](https://pub.dev/packages/http/install).

The storage libraries used were [shared_preferences](https://pub.dev/packages/shared_preferences) to store a small amount of data like tokens and theme choice. To store amounts of data bigger like the name, email, etc,  I've used the library [Hive](https://pub.dev/packages/hive), because it has some advantages over [sqflite](https://pub.dev/packages/sqflite) about readibily and complexity,.


### Why another tasks app?
I know there are a lot of applications that have the same main idea. However every creation is unique on its own, also I thought it could be a good idea to show my current knowledge on differents areas of the framework Flutter.