# CouponApp (client)
Develop coupon app (Android and IOS) for CMN

## Information

Language: Flutter (Android and IOS)

State management: Bloc (8.1.1)
- https://bloclibrary.dev/#/gettingstarted

Dependency injection: get_it: (7.2.0)

Multi language support: intl

Folder tree:

/lib:
- common
- database
- di
- environment
- generated
- l10n
- main
- model
- repository
- routing
- service
- ui
- utils

## Environment and run app

Environment: "dev" and "prod"
- dev: lib/main/main_dev.dart
- prod: lib/main/main_prod.dart

Run Android app with terminal:
- dev: flutter run -t lib/main/main_dev.dart --flavor dev
- prod: flutter run -t lib/main/main_prod.dart --flavor prod

Run with Visual Studio, add config:

{
"version": "1.0",
"configurations": [
{
"name": "Flutter-dev",
"request": "launch",
"type": "dart",
"args": [
"-t",
"lib/enviroment/main_dev.dart",
"--flavor",
"dev"
]
},
{
"name": "Flutter-prod",
"request": "launch",
"type": "dart",
"args": [
"-t",
"lib/enviroment/main_prod.dart",
"--flavor",
"prod"
]
}
]
}

Run IOS app: open IOS module with Xcode => select scheme "dev" or "prod" to run app

