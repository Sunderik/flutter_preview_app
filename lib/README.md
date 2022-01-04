-------------------------------------Акуализация flutter--------------------------------------------
/// Перейти на стабильный канал и скачать актуальную версию
flutter channel stable && flutter upgrade
/// Подгрузить пакеты указанные в .yaml
flutter packages get

-------------------------------------Запуск сборки проекта------------------------------------------
/// Запустить сборку проекта единоразово
flutter packages pub run build_runner build --delete-conflicting-outputs
/// Запустить сборку проекта и следить за изменениями
flutter packages pub run build_runner watch --delete-conflicting-outputs

-------------------------------------Запуск создания билда------------------------------------------
To create a flutter build you need to use:
/// Очистить существующие былды для android
flutter clean
/// Неподписанный совместный билд
flutter build apk --split-per-abi  
/// Пакет приложения (для google play) с явным указанием названием и номером билда
flutter build appbundle --build-name=<build_name> --build-number=<build_code>

-----------------------------Подключение к логам телефона из консоли--------------------------------
Отладка через logcat:
/// Перейти в папку
cd C:\Users\<User>\AppData\Local\Android\Sdk\platform-tools
/// Если отладка на эмуляторе
.\adb logcat -s flutter
/// Если отладка по usb
/// Узнаем имя телефона
.\adb devices
/// Подключаемся к логам телефона
.\adb logcat -s "<device-name>" flutter
