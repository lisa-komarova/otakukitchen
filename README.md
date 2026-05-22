**Otaku Kitchen: рецепты из аниме**

Мобильное приложение с рецептами из аниме.

[Приложение в google play](https://play.google.com/store/apps/details?id=com.lvcorporation.otaku_kitchen)

_Технологии_

В этом проекте используются следующие инструменты разработки:

•	Framework: Flutter 3.35.5

•	State Management & DI: Riverpod

•	Database: SQLite (через пакет sqflite)

•	Architecture: проект организован с разделением логики и интерфейса


```text
lib/
├── core/
│   ├── recipe_database.dart
│   └── theme.dart
├── features.recipes/
│   ├── data/
│   │   ├── mappers/
│   │   ├── models/
│   │   ├── repositories/
│   │   └── sources/
│   ├── domain/
│   │   ├── entities/
│   │   ├── repositories/
│   │   └── usecases/
│   └── presentation/
│       ├── pages/
│       ├── providers/
│       └── widgets/
└── main.dart
```


_Ключевые функции_
 
•	 Просмотр рецептов: список блюд по категориям с детальным описанием ингредиентов и шагов приготовления.

•	 Локальное хранение: возможность сохранять любимые рецепты в избранное (работает офлайн).

•	 Поиск и фильтрация: поиск по названию блюд или названию аниме, а также фильтрация по категориям и уровням сложности

_Скриншоты_

<img width="396" height="843" alt="Screenshot_2026_05_12_07_52_54_682_com_lvcorporation_otakukitchen" src="https://github.com/user-attachments/assets/851964cf-8c7c-43fa-99bc-26d094f7638c" /> <img  width="396" height="843" alt="Screenshot_2026_05_12_07_53_04_805_com_lvcorporation_otakukitchen" src="https://github.com/user-attachments/assets/ac8f5228-6e1a-4537-b107-aa5311924983" /> <img  width="396" height="843" alt="Screenshot_2026_05_12_07_53_14_180_com_lvcorporation_otakukitchen" src="https://github.com/user-attachments/assets/1bd126d3-ab7d-43ab-940a-2dd6868c8e5b" /> <img  width="396" height="843"  alt="Screenshot_2026_05_12_07_53_36_715_com_lvcorporation_otakukitchen" src="https://github.com/user-attachments/assets/8e2b4302-e626-4238-a918-c2f5cce94533" /> <img  width="396" height="843"  alt="Screenshot_2026_05_12_07_53_52_067_com_lvcorporation_otakukitchen" src="https://github.com/user-attachments/assets/8410e3fa-eb5e-47e8-8f87-65fae0ca4b1d" /> <img  width="396" height="843" alt="Screenshot_2026_05_12_07_52_44_445_com_lvcorporation_otakukitchen" src="https://github.com/user-attachments/assets/e247fc2a-9394-492d-a752-2f8bb6509646" />







