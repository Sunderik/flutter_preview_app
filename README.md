## Задание
Стек: Flutter.

Используя сервис https://jsonplaceholder.typicode.com/ реализовать псевдо-приложение.

Список экранов:
  1. Список пользователей. Вывод списка пользователей, полученного по апи в виде карточек вида: 
    
    [
      username;
      name;
    ]
  2. Страница пользователя. Подробный вывод информации о пользователе
  
    [
     AppBar: username;
     Body:
      [
        name;
        email;
        phone;
        website;
        address;
        company:
          [
            name;
            bs;
            catchPhrase (курсив, как цитата);
          ]
        список из 3-х превью (заголовок, 1 строчка текста...) постов пользователя + возможность посмотреть все (экран 3)
        список из 3-х превью альбомов пользователя с миниатюрой + возможность посмотреть все (экран 4)
      ]
    ]
    
  3. Список постов пользователя. Все посты в формате превью + возможность перейти на детальную (экран 5)

  4. Список альбомов пользователя

  5. Детальная страница поста со списком всех комментариев c именем и email. Также, внизу экрана добавить кнопку добавления комментария. По клику открывается форма с 3 полями имя, email, текст комментария и кнопкой "отправить/send" (на выбор: отдельный экран, модальное окно, bottomSheet). Отправку сделать на тот же сервис.

  6. Детальная альбома. Все фото альбома с описанием и слайдером

  **Требования к внешнему виду**: понятный интерфейс.

  Дополнительное задание:
  Кэшировать все ответы от сервиса, т.е. по мере использования приложения создавать дубликат данных. Например, запросили пользователей – закэшировали, запросили альбомы пользователя, отправили комментарий к посту, закэшировали. И при каждом запросе проверять кэш на наличие данных, если они имеются отдавать из кэша, отсутствуют запросили с сервиса. Реализация кэша на ваш выбор (SharedPreferences, hive, SQLite, и т.д.).

## Выполнено
Приложение выполнено примерно на 90%, из шести экранов реализованы все экраны. Дополнительное задание реализовано. 

Осталось добавить докумментирование в фичах, провести небольшой рефакторинг кода, и по возможности добавить парочку тетсов.
## Описание

Используемые пакеты:
   - Архитектура:
      -  provider
      -  rxdart
   - Di:
      - injectable
      - get_it
   - Кодогенерация: 
      -  built_value
      -  built_collection
      -  built_redux
      -  flutter_built_redux
   - Сетевые запросы:
      - http
   - Кеширование:
      - shared_preferences
   - Логирование:
      - logger
   - Другое:
      - url_launcher
      - flutter_map
      - carousel_slider

Зпуск приложения: 
 - Для использования репозитория требуется версия flutter после перехода на nndb
 - Приложение создается на:
   
        Flutter 2.5.3 • channel stable • https://github.com/flutter/flutter.git
        Framework • revision 18116933e7 (3 months ago) • 2021-10-15 10:46:35 -0700
        Engine • revision d3ea636dc5
        Tools • Dart 2.14.4
       

Зпуск приложения: 
  1) Выкчать репозиторий на компьютер;
  2) В папке репозитория ввести в консоль flutter pub get для скачивания пакетов
  3) В папке репозитория ввести в консоль flutter packages pub run build_runner build --delete-conflicting-outputs для генерации кода и построения зависимостей (~ 1 минута).
  4) В папке репозитория ввести в консоль flutter run
