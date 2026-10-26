DELETE FROM animes
WHERE id NOT IN (SELECT DISTINCT anime_id FROM recipes_in_anime)
  AND title IN (
    SELECT title 
    FROM animes 
    GROUP BY title 
    HAVING COUNT(*) > 1
  );


CREATE UNIQUE INDEX IF NOT EXISTS idx_animes_title ON animes(title);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  '«Палец Сукуны»',
  30,
  'easy',
  1,
  'palec_sukuny.jpg',
  'https://vt.tiktok.com/ZSbMpP5gm/',
  'https://t.me/otakukitchen/93',
  0, 0,
  'Миндаль вставляется на место ногтя — так печенье становится похожим на палец.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Магическая битва', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Магическая битва' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло сливочное'),
('Мука'),
('Мед'),
('Соль'),
('Пищевой краситель'),
('Миндаль');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  40,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мед'),
  'Мёд',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Пищевой краситель'),
  'Фиолетовый пищевой краситель',
  NULL,
  'по желанию',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Миндаль'),
  'Миндаль',
  4,
  'шт',
  '4-5 орешков'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1),
  'Формирование «пальцев»',
  1
),
(
  (SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1),
  'Выпекание',
  2
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  'Растопите сливочное масло до жидкого состояния',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  'Добавьте муку, мёд и соль, тщательно перемешайте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  'Окрасьте тесто фиолетовым красителем и замесите до равномерного цвета',
  2
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование «пальцев»'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  'Разделите тесто на 4 части',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование «пальцев»'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  'Из каждой части сформируйте «палец»',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование «пальцев»'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  'Вставьте миндаль вместо ногтя и покрасьте его в фиолетовый цвет',
  2
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='«Палец Сукуны»' LIMIT 1) LIMIT 1),
  'Выпекайте в разогретой до 180°C духовке 10 минут.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Бенто Ренгоку',
  30,
  'medium',
  3,
  'bento_rengoku.jpg',
  'https://vt.tiktok.com/ZSbr2dQTC/',
  'https://t.me/otakukitchen/169',
  0, 0,
  'Маринованное яйцо для бенто нужно приготовить заранее.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Клинок, рассекающий демонов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1),
  (SELECT id FROM animes WHERE title='Клинок, рассекающий демонов' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло растительное'),
('Тофу'),
('Лук порей'),
('Лук'),
('Саке'),
('Мирин'),
('Соевый соус'),
('Сахар'),
('Говядина'),
('Яйца'),
('Имбирь маринованный'),
('Рис');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1),
  'Для гюнабэ',
  0
),
(
  (SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1),
  'Для сборки бенто',
  1
);

-- Ингредиенты в рецепте

-- Для гюнабэ
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тофу'),
  'Тофу',
  175,
  'г',
  'нарезать крупными кубиками'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук порей'),
  'Лук-порей',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Репчатый лук',
  100,
  'г',
  'половина небольшой луковицы, крупными кусочками'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Саке'),
  'Сакэ',
  60,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мирин'),
  'Мирин',
  60,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  60,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говядина'),
  'Тонко нарезанная говядина',
  250,
  'г',
  NULL
);

-- Для сборки бенто
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки бенто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Тёплый рис',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки бенто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Маринованное яйцо',
  1,
  'шт',
  'приготовить заранее'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки бенто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Имбирь маринованный'),
  'Бэнисё (красный маринованный имбирь)',
  NULL,
  'для украшения',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1),
  'Подготовка',
  0
),
(
  (SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1),
  'Приготовление гюнабэ',
  1
),
(
  (SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1),
  'Сборка бенто',
  2
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Нарежьте тофу крупными кубиками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Нарежьте лук-порей полосками около 2-3 см под углом',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Крупно нарежьте репчатый лук',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Смешайте сакэ, мирин, соевый соус и сахар',
  3
);

-- Шаги (Гюнабэ)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Нагрейте масло в сковороде или маленькой кастрюле',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Добавьте тофу и лук и слегка обжарьте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Влейте смесь с сакэ и доведите до кипения',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Выложите говядину и готовьте 2-3 минуты',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление гюнабэ'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Снимите с огня и дайте настояться 1-2 минуты',
  4
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка бенто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Выложите в коробочку рис',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка бенто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Сверху разложите порцию мяса с овощами',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка бенто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бенто Ренгоку' LIMIT 1) LIMIT 1),
  'Добавьте маринованное яйцо и украсьте бэнисё.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Бисквит Виктории',
  120,
  'hard',
  1,
  'biskvit_viktorii.jpg',
  'https://vt.tiktok.com/ZSbLWJrBt/',
  'https://t.me/otakukitchen/157',
  0, 0,
  'Берите густой джем, чтобы он не растекался между коржами.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Тёмный дворецкий', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1),
  (SELECT id FROM animes WHERE title='Тёмный дворецкий' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Сахар'),
('Мука'),
('Разрыхлитель'),
('Молоко'),
('Масло сливочное'),
('Сахарная пудра'),
('Джем клубничный'),
('Ягоды');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1),
  'Для бисквита',
  0
),
(
  (SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1),
  'Для крема',
  1
),
(
  (SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1),
  'Для начинки и украшения',
  2
);

-- Ингредиенты в рецепте

-- Для бисквита
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Куриные яйца',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Пшеничная мука',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  2,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  2,
  'ст.л',
  NULL
);

-- Для крема
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  200,
  'г',
  'немного оставьте для смазывания формы'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  140,
  'г',
  NULL
);

-- Для начинки и украшения
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки и украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Джем клубничный'),
  'Густой клубничный джем',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки и украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ягоды'),
  'Ягоды для украшения (черника, смородина, клюква)',
  NULL,
  'по желанию',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1),
  'Выпекание коржей',
  1
),
(
  (SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1),
  'Приготовление крема',
  2
),
(
  (SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1),
  'Сборка',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'В глубокой миске взбейте яйца до однородности',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Продолжая взбивать, постепенно всыпайте сахар',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Добавьте к яично-сахарной массе просеянную муку с разрыхлителем и замесите однородное тесто',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'В самом конце влейте молоко',
  3
);

-- Шаги (Коржи)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание коржей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Смажьте дно формы сливочным маслом и выложите половину теста. Так же поступите с оставшимся тестом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание коржей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Выпекайте коржи в разогретой до 190°C духовке примерно 20 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание коржей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Выложите готовый бисквит на решётку и дайте полностью остыть',
  2
);

-- Шаги (Крем)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Дайте сливочному маслу размягчиться',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Взбейте масло с сахарной пудрой до пышности',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Смажьте масляным кремом один корж',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Сверху выложите толстый слой джема — можно, чтобы он доходил до бортика',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Накройте вторым коржом',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бисквит Виктории' LIMIT 1) LIMIT 1),
  'Украсьте сверху ягодами.',
  3
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Бей хлеб (Bey Bread)',
  80,
  'medium',
  1,
  'beyblade.jpg',
  'https://vt.tiktok.com/ZSbrFhnw9/',
  'https://t.me/otakukitchen/113',
  0, 0,
  'Из теста получается 8 печений-волчков двух видов: с зелёной конфетой и с жёлтой конфетой и буквой V.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Бейблэйд Бёрст', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1),
  (SELECT id FROM animes WHERE title='Бейблэйд Бёрст' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло сливочное'),
('Сахар'),
('Яйца'),
('Ванильный сахар'),
('Мука'),
('Разрыхлитель'),
('Пищевой краситель'),
('Драже цветное');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1),
  'Для цвета',
  1
),
(
  (SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1),
  'Для декора',
  2
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  120,
  'г',
  'размягчённое'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  250,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  1,
  'ч.л',
  NULL
);

-- Для цвета
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для цвета'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Пищевой краситель'),
  'Красный или розовый пищевой краситель',
  NULL,
  'немного',
  'гелевый или порошковый'
);

-- Для декора
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для декора'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Драже цветное'),
  'Зелёные и жёлтые M&M''s (или аналогичные драже)',
  NULL,
  'по количеству печенья',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1),
  'Печенье с зелёной конфетой',
  1
),
(
  (SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1),
  'Печенье с жёлтой конфетой и буквой V',
  2
),
(
  (SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1),
  'Выпекание',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Взбейте масло с сахаром до кремовой текстуры',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Добавьте яйцо и ванильный сахар, перемешайте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Всыпьте муку с разрыхлителем и замесите мягкое тесто',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Оберните пищевой плёнкой и уберите в холодильник на 20-30 минут',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Разделите тесто на 8 частей — из каждой получится одно печенье',
  4
);

-- Шаги (Зелёная конфета)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с зелёной конфетой'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Отщипните половину порции теста, скатайте шарик и расплющите в круг толщиной около 1 см — это нижняя часть волчка',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с зелёной конфетой'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Аккуратно заверните края круга внутрь, формируя небольшую ямку в центре',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с зелёной конфетой'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Из остатков теста скатайте 4 маленькие полоски и уложите их крест-накрест — это лопасти волчка',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с зелёной конфетой'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Вдавите зелёную конфету в середину, где пересекаются лопасти',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с зелёной конфетой'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Шпажкой или зубочисткой сделайте выемки и надрезы по бокам и у основания лопастей — так печенье будет похоже на механическую деталь',
  4
);

-- Шаги (Жёлтая конфета и буква V)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с жёлтой конфетой и буквой V'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Из половины порции теста сделайте круг — это нижняя часть волчка',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с жёлтой конфетой и буквой V'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Заверните края круга, формируя ямку',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с жёлтой конфетой и буквой V'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Во вторую половину добавьте розовый краситель, перемешайте и расплющите в небольшой круг — это сердцевина волчка. Положите её в центр',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с жёлтой конфетой и буквой V'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Вырежьте из неокрашенного теста маленькую букву V и положите её сверху на розовую часть',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с жёлтой конфетой и буквой V'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Вставьте в центр жёлтую конфету — она будет как кнопка запуска',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Печенье с жёлтой конфетой и буквой V'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Добавьте по бокам три лопасти из неокрашенного теста',
  5
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Переложите печенье на противень с пергаментом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Выпекайте при 180°C около 10-12 минут, пока печенье не станет золотистым',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бей хлеб (Bey Bread)' LIMIT 1) LIMIT 1),
  'Полностью остудите перед подачей.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Блинчики',
  30,
  'medium',
  1,
  'blinchiki_dogs.jpg',
  'https://vm.tiktok.com/ZMAUxocum/',
  'https://t.me/otakukitchen/225',
  0, 0,
  'Сливки для крема должны быть холодными — так он лучше взбивается.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Великий из бродячих псов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Великий из бродячих псов' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Молоко'),
('Вода'),
('Мука'),
('Масло сливочное'),
('Соль'),
('Сахар'),
('Маскарпоне'),
('Сливки 33%'),
('Сахарная пудра'),
('Ванильный сахар'),
('Клубника'),
('Черника'),
('Мороженое'),
('Шоколадные палочки'),
('Мята');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1),
  'Для крема маскарпоне',
  1
),
(
  (SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1),
  'Для начинки',
  2
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  150,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  50,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Растопленное сливочное масло',
  15,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'ст.л',
  NULL
);

-- Для крема маскарпоне
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема маскарпоне'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Маскарпоне'),
  'Маскарпоне',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема маскарпоне'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливки 33-35%',
  100,
  'мл',
  'холодные'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема маскарпоне'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема маскарпоне'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар',
  1,
  'ч.л',
  NULL
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника'),
  'Свежая клубника',
  5,
  'шт',
  '5-6 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Черника'),
  'Черника или голубика',
  1,
  'горсть',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мороженое'),
  'Ягодное мороженое',
  1,
  'шарик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколадные палочки'),
  'Шоколадные палочки или вафельные трубочки',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мята'),
  'Листики мяты',
  NULL,
  'для украшения',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1),
  'Тесто для блинов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1),
  'Выпечка блинов',
  1
),
(
  (SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1),
  'Приготовление крема',
  2
),
(
  (SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1),
  'Сборка десерта',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тесто для блинов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'Взбейте яйцо с молоком, водой, сахаром и солью',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тесто для блинов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'Просейте муку и перемешайте венчиком до однородности',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Тесто для блинов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'Добавьте растопленное масло',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Тесто для блинов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'Оставьте тесто на 15-20 минут при комнатной температуре',
  3
);

-- Шаги (Выпечка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка блинов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'На разогретой сковороде выпекайте блинчики по 1-2 минуты с каждой стороны',
  0
);

-- Шаги (Крем)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'В миске взбейте холодные сливки, маскарпоне, сахарную пудру и ванильный сахар до мягких пиков, примерно 7-10 минут',
  0
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка десерта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'Сверните блин в конус',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка десерта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'Выложите внутрь крем',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка десерта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'Украсьте клубникой, черникой и листиком мяты',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка десерта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'Вставьте шоколадные палочки или вафельные трубочки',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка десерта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url = 'blinchiki_dogs.jpg' LIMIT 1) LIMIT 1),
  'Добавьте шарик мороженого.',
  4
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Блудные спагетти',
  30,
  'easy',
  3,
  'bloodniy_spageti.png',
  'https://vt.tiktok.com/ZSbLaj51S/',
  'https://t.me/otakukitchen/41',
  0, 0,
  'Перед подачей посыпьте пасту свежей петрушкой.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Невероятное приключение ДжоДжо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1),
  (SELECT id FROM animes WHERE title='Невероятное приключение ДжоДжо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Спагетти'),
('Маслины'),
('Чеснок'),
('Помидоры черри'),
('Томатная паста'),
('Петрушка'),
('Сыр пармезан'),
('Масло оливковое'),
('Перец красный острый');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Спагетти'),
  'Спагетти',
  0.5,
  'пачка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Маслины'),
  'Маслины без косточек',
  0.5,
  'банка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  2,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидоры черри'),
  'Помидоры черри',
  7,
  'шт',
  '7-10 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томатная паста'),
  'Томатная паста',
  3,
  'ст.л',
  '3-4 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Петрушка'),
  'Петрушка',
  1,
  'пучок',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр пармезан'),
  'Тертый сыр пармезан',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  NULL,
  'для жарки',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец красный острый'),
  'Красный острый перец',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1),
  'Подготовка ингредиентов',
  0
),
(
  (SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1),
  'Приготовление соуса',
  1
),
(
  (SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1),
  'Приготовление спагетти',
  2
),
(
  (SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Подготовка ингредиентов)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Помойте помидоры черри и разрежьте их на 4 части',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Нарежьте маслины и мелко нашинкуйте 2 зубчика чеснока',
  1
);

-- Шаги (Соус)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду с оливковым маслом, добавьте чеснок и обжарьте до появления аромата',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Добавьте помидоры черри и маслины. Посыпьте всё красным перцем и готовьте, пока помидоры не выпустят сок',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Снимите сковороду с огня',
  2
);

-- Шаги (Спагетти)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Поставьте кипятиться воду для спагетти. Опустите их в подсоленный кипяток и варите до состояния аль денте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Выложите готовые спагетти в сковородку, добавьте томатную пасту и перемешайте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Добавьте сыр и выключите огонь',
  2
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Выложите спагетти на тарелку. Сверху аккуратно распределите приготовленные томаты с маслинами',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блудные спагетти' LIMIT 1) LIMIT 1),
  'Перед подачей посыпьте пасту свежей петрушкой.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Булочки 4 сыра',
  165,
  'medium',
  3,
  '4cheese_noragami.jpg',
  'https://vt.tiktok.com/ZSVfqwAur/',
  'https://t.me/otakukitchen/485',
  0, 0,
  'Из этого количества получается 10-12 булочек.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Бездомный бог', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1),
  (SELECT id FROM animes WHERE title='Бездомный бог' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Молоко'),
('Дрожжи сухие'),
('Сахар'),
('Мука'),
('Соль'),
('Масло растительное'),
('Сыр'),
('Масло сливочное'),
('Яйца');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1),
  'Для начинки',
  1
),
(
  (SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1),
  'Для смазывания',
  2
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Тёплое молоко',
  250,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Дрожжи сухие'),
  'Сухие дрожжи',
  5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  380,
  'г',
  'около 380 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  2,
  'ст.л',
  NULL
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр'),
  'Сыр 4 видов',
  250,
  'г',
  'например, чеддер, пармезан, моцарелла, гауда'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Размягчённое сливочное масло',
  50,
  'г',
  NULL
);

-- Для смазывания
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для смазывания'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Желток',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для смазывания'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  1,
  'ст.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1),
  'Формирование булочек',
  1
),
(
  (SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1),
  'Выпекание',
  2
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Смешайте тёплое молоко, дрожжи и сахар. Оставьте на 5-10 минут, чтобы дрожжи активировались',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Добавьте соль и постепенно всыпьте муку',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Когда тесто станет густым, влейте растительное масло и вымешивайте мягкое, эластичное тесто 8-10 минут',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Переложите тесто в смазанную маслом миску, накройте и оставьте в тёплом месте примерно на 1 час, пока оно не увеличится вдвое',
  3
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование булочек'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Раскатайте тесто в прямоугольник толщиной около 5 мм',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование булочек'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Смажьте пласт размягчённым сливочным маслом, оставив один длинный край шириной 1,5-2 см без масла',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование булочек'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Натрите сыр на крупной тёрке и равномерно распределите по тесту',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование булочек'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Сверните плотный рулет, защипните край и нарежьте на 10-12 кусочков толщиной 4-5 см',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование булочек'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Слегка придавите каждую булочку рукой, чтобы получились толстые лепёшки около 1,5-2 см',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование булочек'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Переложите на противень с пергаментом, накройте и оставьте ещё на 30 минут для расстойки',
  5
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Смешайте желток с молоком и аккуратно смажьте булочки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки 4 сыра' LIMIT 1) LIMIT 1),
  'Выпекайте при 190°C 20-25 минут до красивой золотистой корочки.',
  1
);

-- Рецепт
INSERT INTO recipes (
    name, cooking_time, level, category_id, image_url, tiktok_url, telegram_url, is_favourite, is_cooked, note
) VALUES (
    'Бургер', 25, 'easy', 3, 'burger_nana.jpg', 'https://vt.tiktok.com/ZSqtBMeuL/', 'https://t.me/otakukitchen/500', 0, 0, 'Рецепт рассчитан на 2 бургера.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode) VALUES ('Нана', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id) VALUES (
    (SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1),
    (SELECT id FROM animes WHERE title='Нана' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES 
('Фарш'), ('Соль'), ('Перец черный'), ('Масло растительное'), ('Специи BBQ'), 
('Булочки для бургеров'), ('Сыр чеддер'), ('Соус для бургеров'), ('Огурцы маринованные'), ('Листья салата');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES (
    (SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1), 'Для котлет', 0
), (
    (SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1), 'Для сборки', 1
);

-- Ингредиенты в рецепте
-- Для котлет
INSERT INTO ingredients_in_recipe ( group_id, ingredient_id, display_name, quantity, unit, note ) VALUES (
    (SELECT id FROM ingredient_groups WHERE title='Для котлет' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Фарш'), 'Говяжий фарш', 240, 'г', NULL
), (
    (SELECT id FROM ingredient_groups WHERE title='Для котлет' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Соль'), 'Соль', 0.5, 'ч.л', NULL
), (
    (SELECT id FROM ingredient_groups WHERE title='Для котлет' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Перец черный'), 'Чёрный перец', NULL, 'по вкусу', NULL
), (
    (SELECT id FROM ingredient_groups WHERE title='Для котлет' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Масло растительное'), 'Растительное масло', NULL, 'немного для жарки', NULL
), (
    (SELECT id FROM ingredient_groups WHERE title='Для котлет' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Специи BBQ'), 'BBQ приправа', NULL, 'по вкусу', NULL
);

-- Для сборки
INSERT INTO ingredients_in_recipe ( group_id, ingredient_id, display_name, quantity, unit, note ) VALUES (
    (SELECT id FROM ingredient_groups WHERE title='Для сборки' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Булочки для бургеров'), 'Булочки для бургеров', 4, 'шт', NULL
), (
    (SELECT id FROM ingredient_groups WHERE title='Для сборки' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Сыр чеддер'), 'Чеддер', 2, 'ломтик', NULL
), (
    (SELECT id FROM ingredient_groups WHERE title='Для сборки' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Соус для бургеров'), 'Соус для бургеров', NULL, 'по вкусу', NULL
), (
    (SELECT id FROM ingredient_groups WHERE title='Для сборки' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Огурцы маринованные'), 'Маринованный огурец', 1, 'шт', '1-2 шт'
), (
    (SELECT id FROM ingredient_groups WHERE title='Для сборки' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name='Листья салата'), 'Салат', 2, 'лист', '2-4 листа'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES (
    (SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1), 'Приготовление котлет', 0
), (
    (SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1), 'Подготовка булочек', 1
), (
    (SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1), 'Сборка', 2
);

-- Шаги (Котлеты)
INSERT INTO steps (section_id, description, order_index) VALUES (
    (SELECT id FROM recipe_sections WHERE title='Приготовление котлет' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    'Разделите говяжий фарш на две части, посолите, поперчите, добавьте BBQ приправу и перемешайте', 0
), (
    (SELECT id FROM recipe_sections WHERE title='Приготовление котлет' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    'Сформируйте плоские котлеты', 1
), (
    (SELECT id FROM recipe_sections WHERE title='Приготовление котлет' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    'Жарьте на хорошо разогретой сковороде с небольшим количеством масла примерно 3-4 минуты с каждой стороны', 2
);

-- Шаги (Булочки)
INSERT INTO steps (section_id, description, order_index) VALUES (
    (SELECT id FROM recipe_sections WHERE title='Подготовка булочек' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    'Разрежьте булочки и смажьте соусом для бургеров', 0
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES (
    (SELECT id FROM recipe_sections WHERE title='Сборка' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    'На нижнюю половинку булочки положите салат', 0
), (
    (SELECT id FROM recipe_sections WHERE title='Сборка' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    'Выложите говяжью котлету, сверху — ломтик чеддера', 1
), (
    (SELECT id FROM recipe_sections WHERE title='Сборка' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    'Добавьте маринованный огурец', 2
), (
    (SELECT id FROM recipe_sections WHERE title='Сборка' AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_nana.jpg' LIMIT 1) LIMIT 1),
    'Накройте верхней половинкой булочки.', 3
);

-- Рецепт
INSERT INTO recipes (
    name, cooking_time, level, category_id,
    image_url, tiktok_url, telegram_url,
    is_favourite, is_cooked, note
) VALUES (
    'Бургер',
    20,
    'easy',
    3,
    'burger_tokyo_ghoul.jpg',
    'https://vt.tiktok.com/ZSbrNnTTY/',
    'https://t.me/otakukitchen/100',
    0, 0,
    'Котлету кладите на булочку сразу, пока она горячая.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Токийский гуль', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
    (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1),
    (SELECT id FROM animes WHERE title = 'Токийский гуль' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Булочки для бургеров'),
('Котлета говяжья'),
('Листья салата'),
('Майонез'),
('Соль'),
('Перец черный'),
('Огурцы маринованные');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
    (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1),
    'Основные ингредиенты',
    0
);

-- Ингредиенты в рецепте
INSERT INTO ingredients_in_recipe (
    group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
    (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name = 'Булочки для бургеров'),
    'Булочка для бургера',
    1, 'шт', NULL
),
(
    (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name = 'Котлета говяжья'),
    'Говяжья котлета',
    1, 'шт', NULL
),
(
    (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name = 'Листья салата'),
    'Лист салата',
    1, 'лист', '1-3 листа'
),
(
    (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name = 'Майонез'),
    'Соус (майонез, кетчуп или другой по вкусу)',
    1, 'ст.л', '1-2 ст.л'
),
(
    (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name = 'Соль'),
    'Соль',
    NULL, 'по вкусу', NULL
),
(
    (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name = 'Перец черный'),
    'Перец',
    NULL, 'по вкусу', NULL
),
(
    (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    (SELECT id FROM ingredients WHERE name = 'Огурцы маринованные'),
    'Маринованный огурец',
    2, 'ломтик', '2-3 ломтика'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
    (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1),
    'Приготовление котлеты',
    0
),
(
    (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1),
    'Подготовка булочки',
    1
),
(
    (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1),
    'Сборка',
    2
);

-- Шаги: котлета
INSERT INTO steps (section_id, description, order_index) VALUES
(
    (SELECT id FROM recipe_sections WHERE title = 'Приготовление котлеты'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    'Обжарьте котлету на среднем огне по 3-4 минуты с каждой стороны',
    0
),
(
    (SELECT id FROM recipe_sections WHERE title = 'Приготовление котлеты'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    'Посолите и поперчите',
    1
);

-- Шаги: булочка
INSERT INTO steps (section_id, description, order_index) VALUES
(
    (SELECT id FROM recipe_sections WHERE title = 'Подготовка булочки'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    'Разрежьте булочку и слегка подрумяньте на сухой сковороде или гриле',
    0
),
(
    (SELECT id FROM recipe_sections WHERE title = 'Подготовка булочки'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    'Намажьте соусом обе половинки',
    1
);

-- Шаги: сборка
INSERT INTO steps (section_id, description, order_index) VALUES
(
    (SELECT id FROM recipe_sections WHERE title = 'Сборка'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    'Выложите горячую котлету на нижнюю половинку булочки',
    0
),
(
    (SELECT id FROM recipe_sections WHERE title = 'Сборка'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    'Сверху положите лист салата и маринованные огурцы',
    1
),
(
    (SELECT id FROM recipe_sections WHERE title = 'Сборка'
     AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'burger_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
    'Накройте верхней половинкой булочки.',
    2
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Ванильно-клубничное печенье',
  105,
  'medium',
  1,
  'vanilla_strawberry_bisvuits.jpg',
  'https://vt.tiktok.com/ZSqR7BAVo/',
  'https://t.me/otakukitchen/491',
  0, 0,
  'Горячее печенье очень мягкое — дайте ему постоять на противне 5-10 минут, после остывания оно станет плотнее.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Мой братик больше не братик', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Мой братик больше не братик' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло сливочное'),
('Сахарная пудра'),
('Яйца'),
('Мука'),
('Крахмал кукурузный'),
('Ванильный сахар'),
('Разрыхлитель'),
('Соль'),
('Клубника сублимированная'),
('Пищевой краситель');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1),
  'Для основного теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1),
  'Для розового теста',
  1
);

-- Ингредиенты в рецепте

-- Для основного теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для основного теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло 82,5%',
  120,
  'г',
  'мягкое, но не растопленное'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основного теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  70,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основного теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  'около 50 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основного теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Пшеничная мука',
  220,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основного теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал кукурузный'),
  'Кукурузный крахмал',
  30,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основного теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар',
  8,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основного теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  0.5,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основного теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
);

-- Для розового теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для розового теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника сублимированная'),
  'Сублимированная клубника (порошок)',
  8,
  'г',
  '8-10 г, измельчить в порошок'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для розового теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Пищевой краситель'),
  'Розовый или красный пищевой краситель',
  NULL,
  'совсем немного',
  'по желанию'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1),
  'Розовое тесто',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1),
  'Формирование ванильного печенья',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1),
  'Формирование печенья с розовой серединкой',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1),
  'Украшение',
  4
),
(
  (SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1),
  'Выпекание',
  5
);

-- Шаги: тесто
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Заранее достаньте масло из холодильника — оно должно стать мягким, но не растопленным',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Взбейте масло с сахарной пудрой и ванильным сахаром примерно 2 минуты, пока масса не станет светлой и кремовой',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Добавьте яйцо и ещё раз хорошо перемешайте',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Отдельно смешайте муку, крахмал, разрыхлитель и щепотку соли',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Всыпьте сухие ингредиенты к маслу и быстро замесите мягкое однородное тесто. Долго месить не нужно',
  4
);

-- Шаги: розовое тесто
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Розовое тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Разделите тесто примерно в соотношении 60/40. Большая часть останется ванильной',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Розовое тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'В меньшую часть добавьте 8-10 г порошка сублимированной клубники. Если цвет недостаточно яркий, добавьте буквально каплю красителя',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Розовое тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Заверните оба вида теста и уберите в холодильник примерно на 30 минут',
  2
);

-- Шаги: ванильное печенье
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование ванильного печенья'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Отщипывайте примерно по 25-30 г теста. Скатайте шарик, затем слегка вытяните ладонями в толстенький овал',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование ванильного печенья'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Приплюсните сверху пальцами — толщина заготовки должна остаться примерно 8-10 мм. Тонко не раскатывайте',
  1
);

-- Шаги: печенье с розовой серединкой
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование печенья с розовой серединкой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Возьмите примерно 20 г розового теста и 7-8 г ванильного',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование печенья с розовой серединкой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Сформируйте из розового теста небольшой толстый овал',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование печенья с розовой серединкой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте ванильное тесто в тонкий жгутик и оберните им розовый овал по периметру. Аккуратно прижмите место соединения — получится розовая серединка в тонкой ванильной рамке',
  2
);

-- Шаги: украшение
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Украшение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Когда всё печенье уже лежит на противне, сделайте зубочисткой два маленьких неглубоких прокола для глаз',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Украшение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Рот аккуратно продавите кончиком чайной ложки или проведите зубочисткой небольшую дугу',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Украшение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Поставьте заготовки вместе с противнем в холодильник ещё на 15-20 минут',
  2
);

-- Шаги: выпекание
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Тем временем разогрейте духовку до 170°C, режим верх-низ',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте примерно 11-14 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='vanilla_strawberry_bisvuits.jpg' LIMIT 1) LIMIT 1),
  'Достаньте противень и оставьте печенье на нём на 5-10 минут.',
  2
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Гедза',
  110,
  'medium',
  4,
  'gedza_bluelock.jpg',
  'https://vt.tiktok.com/ZSbr18QU7/',
  'https://t.me/otakukitchen/54',
  0, 0,
  'Смачивайте края теста водой — так гедза лучше склеятся.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Синяя тюрьма', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Синяя тюрьма' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Крахмал картофельный'),
('Соль'),
('Вода'),
('Фарш'),
('Соевый соус'),
('Лук зеленый'),
('Лимонный сок'),
('Имбирь'),
('Чеснок'),
('Капуста пекинская'),
('Масло оливковое');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1),
  'Для начинки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1),
  'Для жарки',
  2
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Пшеничная мука',
  2,
  'стакан',
  'лучше высшего сорта'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал картофельный'),
  'Картофельный крахмал',
  2,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  2,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Кипячёная вода',
  130,
  'мл',
  NULL
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фарш'),
  'Свиной фарш',
  400,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук зеленый'),
  'Зелёный лук',
  60,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонный сок',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Имбирь'),
  'Имбирь',
  5,
  'г',
  'натереть на мелкой тёрке'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  3,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Капуста пекинская'),
  'Пекинская капуста',
  150,
  'г',
  NULL
);

-- Для жарки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для жарки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для жарки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  100,
  'мл',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1),
  'Приготовление начинки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1),
  'Лепка гедза',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1),
  'Жарка',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Просейте муку в глубокую ёмкость, добавьте картофельный крахмал и две щепотки соли. Перемешайте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Постепенно вливайте 130 мл кипячёной воды и замешивайте тесто — сначала венчиком, затем руками или в тестомесе',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Когда тесто начнёт формироваться, выложите его на доску и вымешивайте ещё 5 минут, чтобы оно стало эластичным',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Верните тесто в ёмкость, накройте пищевой плёнкой и оставьте отдыхать на 30 минут',
  3
);

-- Шаги (Начинка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте зелёный лук маленькими колечками, а пекинскую капусту нашинкуйте тонкой соломкой',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Добавьте к фаршу лук, капусту, измельчённый чеснок, лимонный сок, натёртый имбирь, соевый соус и соль',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Тщательно перемешайте, чтобы все ингредиенты равномерно распределились',
  2
);

-- Шаги (Лепка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Лепка гедза'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Разделите тесто примерно на 6 частей. Раскатайте одну часть в тонкий пласт и вырежьте кружки диаметром около 10 см, при необходимости присыпая мукой',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Лепка гедза'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Выложите в центр каждого кружка по 1 ч.л начинки с горкой',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Лепка гедза'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Смочите пальцы водой и проведите по краю кружка, чтобы тесто лучше склеилось',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Лепка гедза'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Наложите одну половинку теста на другую, не прижимая. Нижнюю часть оставьте ровной, а верхнюю постепенно прижимайте к ней, делая складочки слева направо',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Лепка гедза'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Выкладывайте готовые гедза на доску, застеленную плёнкой, и накрывайте сверху плёнкой, чтобы они не подсыхали. Так слепите все гедза',
  4
);

-- Шаги (Жарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Налейте оливковое масло в блюдце, окуните в него каждую гедза и выложите на сковороду с толстым дном',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Жарьте до золотистой корочки около 5 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Влейте 100 мл воды, накройте крышкой, убавьте огонь до среднего или чуть ниже и готовьте ещё 7 минут',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='gedza_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Снимите крышку и продолжайте жарить, пока вода полностью не испарится.',
  3
),(
  (SELECT id FROM recipe_sections WHERE title='Приготовление картошки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Отварите картошку 7 минут после закипания, затем слейте воду',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление картошки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Выложите картошку на противень, добавьте соль, перец и масло',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление картошки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Отправьте в духовку, разогретую до 180°C, на 3 минуты',
  3
);

-- Шаги (Подготовка котлеты)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка котлеты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте лук мелкими кубиками и добавьте к фаршу',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка котлеты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Посолите, поперчите и сформируйте котлету',
  1
);

-- Шаги (Жарка котлеты)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка котлеты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Нагрейте немного масла на сковороде и обжарьте котлету с обеих сторон до золотистой корочки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка котлеты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Добавьте все ингредиенты для соуса (барбекю соус, соевый соус, кетчуп, сахар) и перемешайте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка котлеты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'При подаче полейте котлету соусом',
  2
);

-- Шаги (Рис)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление риса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Отварите рис до готовности',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление риса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Добавьте немного кетчупа и перемешайте для лёгкого аромата и цвета',
  1
);

-- Шаги (Сосиска и креветка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосиски и креветки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Сделайте надрезы на концах сосиски — при готовке они раскроются, и получится «осьминожка»',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосиски и креветки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Варите сосиску 4-5 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосиски и креветки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Обваляйте креветку в муке, затем в яйце и в панировочных сухарях',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосиски и креветки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте креветку на сковороде 4-5 минут с каждой стороны',
  3
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'На тарелку выложите котлету, картофель, рис, сосиску и креветку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='detskiy_obed_mikey.jpg' LIMIT 1) LIMIT 1),
  'Добавьте пару ложек кукурузы, помидоры черри и несколько ломтиков огурца для яркого цвета и свежести.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Дынное парфе',
  60,
  'medium',
  1,
  'parfe_jojo.png',
  'https://vm.tiktok.com/ZMAa7m7fc/',
  'https://t.me/otakukitchen/236',
  0, 0,
  'Собирайте парфе в бокале слоями снизу вверх.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Невероятное приключение ДжоДжо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1),
  (SELECT id FROM animes WHERE title='Невероятное приключение ДжоДжо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Дыня'),
('Сливки взбитые'),
('Мороженое'),
('Кукурузные хлопья'),
('Сок дыни'),
('Желатин');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1),
  'Для желе из дыни',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1),
  'Для дынной граниты',
  2
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Дыня'),
  'Дыня (мускусная или канталупа)',
  0.5,
  'шт',
  'для ломтиков и шариков'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки взбитые'),
  'Взбитые сливки',
  150,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мороженое'),
  'Мороженое',
  1,
  'шарик',
  '1-2 шарика'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кукурузные хлопья'),
  'Кукурузные хлопья',
  20,
  'г',
  '20-40 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сок дыни'),
  'Сок дыни',
  NULL,
  'немного',
  'для нижнего слоя'
);

-- Для желе из дыни
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для желе из дыни'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сок дыни'),
  'Сок дыни',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для желе из дыни'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желатин'),
  'Желатин',
  10,
  'г',
  NULL
);

-- Для дынной граниты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для дынной граниты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сок дыни'),
  'Сок дыни',
  150,
  'мл',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1),
  'Подготовка дыни',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1),
  'Приготовление желе из дыни',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1),
  'Приготовление дынной граниты',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1),
  'Сборка в бокале',
  3
);

-- Шаги (Подготовка дыни)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка дыни'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Вырежьте несколько крупных ломтиков дыни для украшения',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка дыни'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'С помощью ложки для шариков сделайте дынные шарики',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка дыни'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Немного мякоти отожмите для сока',
  2
);

-- Шаги (Желе)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление желе из дыни'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Подогрейте 200 мл сока дыни, добавьте 10 г желатина и дайте застыть в холодильнике',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление желе из дыни'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Нарежьте застывшее желе кубиками',
  1
);

-- Шаги (Гранита)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление дынной граниты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Заморозьте 150 мл сока дыни в контейнере',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление дынной граниты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Каждые 30 минут разрыхляйте вилкой, пока не получится снежная структура',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка в бокале'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'На дно бокала налейте немного сока дыни',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка в бокале'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Выложите слой желе из дыни и взбитых сливок',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка в бокале'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Добавьте кукурузные хлопья',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка в бокале'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Выложите слой дынной граниты',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка в бокале'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Положите 1-2 шарика мороженого',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка в бокале'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Добавьте ещё один слой желе и сливок',
  5
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка в бокале'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='parfe_jojo.png' LIMIT 1) LIMIT 1),
  'Украсьте сверху дынными шариками и ломтиками дыни.',
  6
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Жареная «свинина»',
  70,
  'medium',
  4,
  'roasted_pork.jpg',
  'https://vm.tiktok.com/ZMAKHKwfP/',
  'https://t.me/otakukitchen/300',
  0, 0,
  'Мука, разведённая в небольшом количестве сока или воды, поможет соусу загустеть.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('В поисках божественного рецепта', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='В поисках божественного рецепта' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Грибы эринги'),
('Картофель'),
('Бекон'),
('Лук'),
('Масло сливочное'),
('Гранатовый сок'),
('Мука'),
('Розмарин'),
('Соевый соус сладкий');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Грибы эринги'),
  'Грибы эринги',
  2,
  'шт',
  'можно заменить вешенкой'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  5,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бекон'),
  'Ломтики бекона',
  11,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  30,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Гранатовый сок'),
  'Гранатовый сок',
  120,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Розмарин'),
  'Розмарин',
  NULL,
  'несколько веточек',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус сладкий'),
  'Сладкий соевый соус',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1),
  'Приготовление «свинины»',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1),
  'Приготовление гранатового соуса',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Приготовление «свинины»)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление «свинины»'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте картофель пополам и отварите',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление «свинины»'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'Мелко нарежьте грибы и лук, обжарьте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление «свинины»'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'Разомните картофель и смешайте с грибами и луком, посолите и поперчите',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление «свинины»'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'Сформируйте овал и оберните его беконом и розмарином',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление «свинины»'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте при 200°C около 30 минут',
  4
);

-- Шаги (Гранатовый соус)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление гранатового соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'Смешайте гранатовый сок и соевый соус, доведите до кипения',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление гранатового соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'Когда смесь начнёт густеть, добавьте сливочное масло',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление гранатового соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'В небольшом количестве сока или воды разведите 1 ст.л муки, влейте в соус и снова доведите до лёгкого кипения, чтобы он загустел',
  2
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'Достаньте «свинину» из духовки и выложите на тарелку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='roasted_pork.jpg' LIMIT 1) LIMIT 1),
  'Полейте гранатовым соусом и украсьте розмарином.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Жареная картошка на шпажках',
  45,
  'medium',
  3,
  'potato_witch.jpg',
  'https://vt.tiktok.com/ZSbrYupjS/',
  'https://t.me/otakukitchen/142',
  0, 0,
  'Картошку можно подать с соусом, например сметанно-чесночным.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Пока ведьма не умрет', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Пока ведьма не умрет' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Картофель'),
('Соль'),
('Травы сушеные'),
('Чеснок'),
('Масло оливковое'),
('Масло сливочное'),
('Деревянные шпажки');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  4,
  'шт',
  '4-5 шт, лучше мелкий или средний'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Травы сушеные'),
  'Сушёные травы (розмарин, тимьян, орегано)',
  NULL,
  'по желанию',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чесночный порошок или мелко рубленый чеснок',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое или растительное масло',
  2,
  'ст.л',
  '2-3 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  10,
  'г',
  'для подачи, по желанию'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Деревянные шпажки'),
  'Деревянные шпажки',
  4,
  'шт',
  '4-6 шт'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1),
  'Подготовка картошки',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1),
  'Маринад',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1),
  'Нанизывание',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1),
  'Запекание',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1),
  'Подача',
  4
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картошки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  'Очистите картофель и нарежьте крупными кусками. Маленькие клубни достаточно разрезать на 2-3 части',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картошки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  'Отварите в подсоленной воде 5-7 минут до полуготовности и слейте воду',
  1
);

-- Шаги (Маринад)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Маринад'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  'В миске смешайте масло, соль, чеснок и травы',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Маринад'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  'Обваляйте в смеси тёплый картофель',
  1
);

-- Шаги (Нанизывание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Нанизывание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  'Немного остудите картошку и аккуратно нанижите кусочки на шпажки',
  0
);

-- Шаги (Запекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Запекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  'Выложите шпажки на противень, застеленный пергаментом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Запекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  'Запекайте в разогретой до 200°C духовке примерно 20-25 минут, пока картофель не станет румяным',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_witch.jpg' LIMIT 1) LIMIT 1),
  'По желанию смажьте горячие кусочки сливочным маслом.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Завтрак',
  30,
  'easy',
  2,
  'breakfast_dandandan.jpg',
  'https://vt.tiktok.com/ZSbMEf8o2/',
  'https://t.me/otakukitchen/211',
  0, 0,
  'Мисо-суп можно сварить самостоятельно или взять готовый в порошке.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Дандадан', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Дандадан' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Сосиски'),
('Листья салата'),
('Помидоры черри'),
('Рис'),
('Грейпфрут'),
('Чай черный'),
('Даси'),
('Паста мисо'),
('Тофу'),
('Морские водоросли');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1),
  'Для мисо-супа (1 порция)',
  1
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  3,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  2,
  'лист',
  '2-3 листа'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидоры черри'),
  'Помидоры черри',
  2,
  'шт',
  '2-3 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Рис отварной',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Грейпфрут'),
  'Грейпфрут',
  2,
  'долька',
  '2-3 дольки'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чай черный'),
  'Чай или кофе',
  NULL,
  'по вкусу',
  NULL
);

-- Для мисо-супа
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для мисо-супа (1 порция)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Даси'),
  'Даси-бульон или вода',
  NULL,
  '1 порция',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для мисо-супа (1 порция)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Паста мисо'),
  'Мисо-паста',
  NULL,
  'по вкусу',
  'или готовый мисо-суп в порошке'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для мисо-супа (1 порция)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тофу'),
  'Тофу',
  NULL,
  'по вкусу',
  'кубиками'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для мисо-супа (1 порция)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морские водоросли'),
  'Водоросли вакаме',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1),
  'Основное блюдо',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1),
  'Гарнир',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1),
  'Мисо-суп',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Основное блюдо)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Основное блюдо'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте сосиски на сухой сковороде до золотистой корочки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Основное блюдо'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  'На той же сковороде пожарьте яйцо-глазунью так, чтобы желток остался жидким',
  1
);

-- Шаги (Гарнир)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Гарнир'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  'Отварите рис заранее или приготовьте его в рисоварке',
  0
);

-- Шаги (Мисо-суп)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Мисо-суп'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  'В подогретый даси-бульон или воду добавьте мисо-пасту и размешайте. Можно использовать готовый порошковый мисо-суп',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Мисо-суп'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  'Добавьте кубики тофу и водоросли вакаме',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  'Выложите на тарелку листья салата, сосиски, глазунью и помидоры черри',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  'Разложите по отдельным мискам рис, суп и дольки грейпфрута',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_dandandan.jpg' LIMIT 1) LIMIT 1),
  'Дополнительно подайте чашку чая или кофе.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Завтрак',
  20,
  'easy',
  2,
  'breakfast_chainsaw.jpg',
  'https://vm.tiktok.com/ZMDY3uBG7/',
  'https://t.me/otakukitchen/327',
  0, 0,
  'К завтраку можно заварить кофе или чай — на выбор.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Человек-бензопила', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Человек-бензопила' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Масло сливочное'),
('Яйца'),
('Сосиски'),
('Масло растительное'),
('Соль'),
('Листья салата'),
('Помидор'),
('Грейпфрут'),
('Кофе'),
('Чай черный'),
('Вода');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1),
  'Для напитка (кофе или чай)',
  1
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Тостовый хлеб',
  2,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  10,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  2,
  'шт',
  '2 маленькие или 1 большая'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Масло для жарки',
  0.5,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  1,
  'горсть',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидор'),
  'Помидоры',
  1,
  'шт',
  '1 маленький или 4-5 черри, дольками'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Грейпфрут'),
  'Грейпфрут',
  0.5,
  'шт',
  NULL
);

-- Для напитка (кофе или чай)
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для напитка (кофе или чай)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кофе'),
  'Кофе молотый или растворимый',
  1,
  'порция',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для напитка (кофе или чай)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чай черный'),
  'Чай',
  1,
  'пакетик',
  'или 1 ч.л листового'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для напитка (кофе или чай)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  NULL,
  'для заваривания',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1),
  'Тосты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1),
  'Яичница и сосиски',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1),
  'Салат',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1),
  'Грейпфрут',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1),
  'Кофе или чай',
  4
);

-- Шаги (Тосты)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тосты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Подрумяньте хлеб в тостере или на сухой сковороде до золотистого цвета',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тосты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Положите кусочек сливочного масла на тарелку рядом, чтобы потом намазать тост',
  1
);

-- Шаги (Яичница и сосиски)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Яичница и сосиски'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду с небольшим количеством масла',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Яичница и сосиски'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте сосиски до румяной корочки и отложите',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Яичница и сосиски'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'На той же сковороде аккуратно разбейте яйцо и жарьте на среднем огне, пока белок не приготовится, а желток останется мягким',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Яичница и сосиски'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Посолите яичницу',
  3
);

-- Шаги (Салат)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Салат'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Выложите на тарелку листья салата, сверху разложите дольки помидора',
  0
);

-- Шаги (Грейпфрут)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Грейпфрут'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте грейпфрут пополам. Можно слегка надрезать сегменты, чтобы было удобно есть ложкой',
  0
);

-- Шаги (Кофе или чай)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Кофе или чай'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Заварите чёрный кофе или чай.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Завтрак',
  15,
  'easy',
  2,
  'breakfast_sestra_umaru.jpg',
  'https://vm.tiktok.com/ZMD1SpMDY/',
  'https://t.me/otakukitchen/304',
  0, 0,
  'Сосиски обжаривают целиком, не нарезая.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Двуличная сестра Умару', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Двуличная сестра Умару' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Сосиски'),
('Хлеб'),
('Масло сливочное'),
('Апельсиновый сок');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  3,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Тостовый хлеб',
  1,
  'ломтик',
  '1-2 ломтика'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло',
  NULL,
  'маленький кусочек',
  'для жарки'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Апельсиновый сок'),
  'Апельсиновый сок',
  1,
  'стакан',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1),
  'Обжарка сосисок',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1),
  'Яичница-глазунья',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1),
  'Тост',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1),
  'Сборка',
  3
);

-- Шаги (Сосиски)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка сосисок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду и добавьте чуть-чуть масла или жарьте на сухой',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка сосисок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  'Положите три целые сосиски и обжарьте со всех сторон, пока не станут румяными',
  1
);

-- Шаги (Глазунья)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Яичница-глазунья'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  'Добавьте на сковороду немного масла',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Яичница-глазунья'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  'Аккуратно разбейте яйцо, чтобы остался красивый целый желток',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Яичница-глазунья'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  'Жарьте до нужной степени готовности и посолите',
  2
);

-- Шаги (Тост)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тост'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  'Подрумяньте хлеб в тостере или на сковороде до золотистой корочки',
  0
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  'Выложите на тарелку глазунью, сверху или рядом — три целые сосиски',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  'Положите рядом тост',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_sestra_umaru.jpg' LIMIT 1) LIMIT 1),
  'Налейте стакан апельсинового сока.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Завтрак',
  20,
  'easy',
  2,
  'breakfast_spyfamily.jpg',
  'https://vm.tiktok.com/ZMDNY1LYw/',
  'https://t.me/otakukitchen/317',
  0, 0,
  'Глазунья должна остаться с жидким желтком.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Семья шпиона', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Семья шпиона' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Ветчина'),
('Яйца'),
('Масло сливочное'),
('Сосиски'),
('Листья салата'),
('Соль'),
('Перец черный');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Тостовый хлеб',
  2,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'Ветчина',
  1,
  'ломтик',
  '1-2 ломтика'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  NULL,
  'для жарки',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  3,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1),
  'Жарка яйца',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1),
  'Тосты с ветчиной',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1),
  'Сосиски',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1),
  'Сборка и подача',
  3
);

-- Шаги (Яйцо)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка яйца'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  'Пожарьте яйцо на сковороде глазуньей с жидким желтком, посолите и поперчите',
  0
);

-- Шаги (Тосты)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тосты с ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  'Поджарьте тосты на сливочном масле до золотистой корочки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тосты с ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  'Выложите ветчину на тёплый хлеб',
  1
);

-- Шаги (Сосиски)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сосиски'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  'Надрежьте сосиски и обжарьте до румяности',
  0
);

-- Шаги (Сборка и подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  'Аккуратно переложите яйцо сверху на тост с ветчиной',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_spyfamily.jpg' LIMIT 1) LIMIT 1),
  'Выложите всё на тарелку и добавьте свежий салат.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Завтрак с беконом и яйцами',
  15,
  'easy',
  2,
  'breakfast_zamok.jpg',
  'https://vt.tiktok.com/ZSbMGBnv7/',
  'https://t.me/otakukitchen/12',
  0, 0,
  'Если накрыть яйца крышкой, белок приготовится быстрее, а желток останется тягучим.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Ходячий замок', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Ходячий замок' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Бекон'),
('Масло сливочное'),
('Соль'),
('Перец черный');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бекон'),
  'Бекон',
  2,
  'полоска',
  '2-3 полоски'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло (лучше сливочное)',
  1,
  'ч.л',
  '1-2 ч.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1),
  'Подготовка сковороды',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1),
  'Жарка бекона',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1),
  'Жарка яиц',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Сковорода)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сковороды'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду на среднем огне и добавьте сливочное масло — оно придаст блюду аромат и золотистый оттенок',
  0
);

-- Шаги (Бекон)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка бекона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  'Выложите полоски бекона на горячую сковороду и жарьте, пока они не станут хрустящими',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка бекона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  'Чтобы бекон получился особенно румяным, уменьшите огонь и готовьте медленно, время от времени переворачивая кусочки',
  1
);

-- Шаги (Яйца)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка яиц'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  'Осторожно разбейте яйца прямо на сковороду с оставшимся жиром',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка яиц'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  'Посолите и поперчите по вкусу',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка яиц'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  'Готовьте, пока белки не схватятся, а желтки останутся слегка жидкими, или до нужной вам степени готовности',
  2
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  'Выложите яйца и бекон на тарелку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='breakfast_zamok.jpg' LIMIT 1) LIMIT 1),
  'По желанию подайте с тостом или поджаренным хлебом.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Замороженные сладости',
  260,
  'medium',
  1,
  'sladosti_frozen.jpg',
  'https://vt.tiktok.com/ZS44uvYHF/',
  'https://t.me/otakukitchen/481',
  0, 0,
  'Перед подачей оставьте десерт при комнатной температуре на 5-10 минут, чтобы он приобрёл нежную полузамороженную текстуру.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('История империи Тиамун', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='История империи Тиамун' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Клубника'),
('Йогурт греческий'),
('Сливки 33%'),
('Сахар'),
('Желатин'),
('Вода'),
('Сахарная пудра'),
('Ванильный сахар'),
('Черешня'),
('Голубика'),
('Манго'),
('Яблоко');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1),
  'Для клубничного слоя',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1),
  'Для взбитых сливок',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1),
  'Для украшения',
  2
);

-- Ингредиенты в рецепте

-- Для клубничного слоя
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для клубничного слоя'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника'),
  'Клубника',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для клубничного слоя'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Йогурт греческий'),
  'Греческий йогурт',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для клубничного слоя'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливки 33-35%',
  50,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для клубничного слоя'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для клубничного слоя'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желатин'),
  'Желатин',
  3,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для клубничного слоя'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  15,
  'мл',
  NULL
);

-- Для взбитых сливок
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для взбитых сливок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливки 33-35%',
  100,
  'мл',
  'охлаждённые'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для взбитых сливок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  10,
  'г',
  '10-15 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для взбитых сливок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар',
  0.5,
  'ч.л',
  'по желанию'
);

-- Для украшения
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника'),
  'Клубника',
  3,
  'шт',
  '3-4 ягоды'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Черешня'),
  'Черешня',
  2,
  'шт',
  'с хвостиком'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Голубика'),
  'Голубика',
  NULL,
  'несколько ягод',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Манго'),
  'Манго или персик',
  NULL,
  'небольшой кусочек',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яблоко'),
  'Яблоко',
  NULL,
  'несколько долек',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1),
  'Приготовление клубничной основы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1),
  'Приготовление взбитых сливок',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1),
  'Украшение',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Клубничная основа)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление клубничной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Залейте желатин водой и оставьте набухать на 10 минут',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление клубничной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Измельчите клубнику блендером до однородного пюре',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление клубничной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Подогрейте желатин до полного растворения, не доводя до кипения',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление клубничной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Смешайте клубничное пюре, греческий йогурт и сахар. Добавьте желатин и хорошо перемешайте',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление клубничной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Отдельно взбейте сливки до мягких пиков и аккуратно вмешайте их в клубничную массу',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление клубничной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Разлейте смесь по прозрачным стаканам, заполняя их примерно на две трети',
  5
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление клубничной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Уберите в холодильник на 2-3 часа, пока слой полностью не застынет',
  6
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление клубничной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Поставьте десерт в морозильную камеру на 30-60 минут',
  7
);

-- Шаги (Взбитые сливки)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление взбитых сливок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Охладите сливки, миску и венчики',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление взбитых сливок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Взбивайте сливки на средней скорости. Когда они начнут густеть, добавьте сахарную пудру и по желанию ванильный сахар',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление взбитых сливок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Продолжайте взбивать до устойчивых пиков',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление взбитых сливок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Переложите сливки в кондитерский мешок с насадкой «закрытая звезда» и отсадите красивую спираль поверх клубничного слоя',
  3
);

-- Шаги (Украшение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Украшение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Разложите сверху ломтики клубники, черешню с хвостиком и голубику',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Украшение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Добавьте небольшие кубики манго или персика и дольки яблока',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sladosti_frozen.jpg' LIMIT 1) LIMIT 1),
  'Перед подачей оставьте десерт при комнатной температуре на 5-10 минут, чтобы он слегка размягчился.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Канадский путин',
  60,
  'medium',
  3,
  'putin.png',
  'https://vt.tiktok.com/ZS4yjUd61/',
  'https://t.me/otakukitchen/480',
  0, 0,
  'Картофель жарится в два этапа, а подливу нужно подавать очень горячей.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('SK8', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1),
  (SELECT id FROM animes WHERE title='SK8' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Картофель'),
('Масло растительное'),
('Соль'),
('Моцарелла'),
('Масло сливочное'),
('Мука'),
('Бульон говяжий'),
('Вустерский соус'),
('Перец черный');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1),
  'Для картофеля',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1),
  'Для подливы',
  1
);

-- Ингредиенты в рецепте

-- Для картофеля
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  500,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  NULL,
  'для жарки',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Моцарелла или чеддер',
  150,
  'г',
  '150-200 г'
);

-- Для подливы
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бульон говяжий'),
  'Говяжий бульон',
  350,
  'мл',
  'горячий'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вустерский соус'),
  'Вустерширский соус',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1),
  'Подготовка картофеля',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1),
  'Жарка картофеля',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1),
  'Приготовление подливы',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Подготовка картофеля)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Очистите картофель и нарежьте толстой соломкой',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Замочите в холодной воде на 30 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Хорошо обсушите бумажными полотенцами',
  2
);

-- Шаги (Жарка картофеля)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Обжарьте картофель во фритюре или в глубокой сковороде при 150°C около 5-6 минут',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Дайте картофелю немного остыть',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Обжарьте второй раз при 190°C около 2-3 минут до золотистой корочки',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Посолите сразу после жарки',
  3
);

-- Шаги (Подлива)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Растопите сливочное масло',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Добавьте муку и обжаривайте около минуты, постоянно помешивая',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Постепенно влейте горячий говяжий бульон',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Добавьте вустерширский соус',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Варите 5-7 минут, пока подлива не станет достаточно густой, чтобы слегка покрывать ложку',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление подливы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Приправьте солью и перцем',
  5
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Выложите горячий картофель на тарелку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Сразу добавьте кусочки сыра',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='putin.png' LIMIT 1) LIMIT 1),
  'Полейте очень горячей подливой.',
  2
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Карри',
  60,
  'medium',
  4,
  'curry_bluelock.jpg',
  'https://vt.tiktok.com/ZSbr1Aobf/',
  'https://t.me/otakukitchen/73',
  0, 0,
  'Карри-кубики добавляйте при выключенном огне, чтобы они хорошо растворились.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Синяя тюрьма', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Синяя тюрьма' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Свинина'),
('Лук'),
('Морковь'),
('Картофель'),
('Вода'),
('Карри в кубиках');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Свинина'),
  'Свинина (или любое другое мясо)',
  280,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  750,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Карри в кубиках'),
  'Карри-кубики',
  NULL,
  'по вкусу',
  'продаются в магазинах азиатских продуктов'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1),
  'Подготовка ингредиентов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1),
  'Обжарка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1),
  'Тушение',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1),
  'Добавление карри',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1),
  'Финальное тушение',
  4
),
(
  (SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1),
  'Подача',
  5
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте мясо кубиками около 2 см. Лишний жир можно убрать',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Очистите овощи. Лук нарежьте крупными дольками',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Морковь нарежьте большими кусками — толстыми брусочками или крупными дольками по диагонали',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Картофель нарежьте кубиками 2-3 см',
  3
);

-- Шаги (Обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте немного масла в глубокой сковороде или кастрюле на среднем огне',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте мясо до лёгкой румяной корочки, 5-7 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Добавьте лук и жарьте около 3 минут, пока он не станет мягким и полупрозрачным',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Положите морковь и картофель, перемешайте и обжаривайте ещё 3-4 минуты',
  3
);

-- Шаги (Тушение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Влейте воду так, чтобы она покрыла все ингредиенты',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Доведите до кипения, затем убавьте огонь, снимите пенку и накройте крышкой',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Тушите примерно 20 минут, пока овощи не станут мягкими',
  2
);

-- Шаги (Карри)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Добавление карри'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Выключите огонь, разломайте карри-кубики и добавьте в кастрюлю',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Добавление карри'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Тщательно перемешайте, чтобы кубики растворились и бульон превратился в густой соус. При необходимости добавьте немного воды',
  1
);

-- Шаги (Финальное тушение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Финальное тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Включите слабый огонь и готовьте ещё 5-10 минут, периодически помешивая, пока соус не загустеет',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Финальное тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Попробуйте на вкус и при необходимости добавьте соль и другие специи',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Подавайте с горячим рисом: рис выложите на одну сторону тарелки, а карри — на другую',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_bluelock.jpg' LIMIT 1) LIMIT 1),
  'По желанию украсьте свежей зеленью.',
  1
);
-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Карри-плов',
  60,
  'medium',
  3,
  'curry_plov.jpg',
  'https://vt.tiktok.com/ZS41j7uwk/',
  'https://t.me/otakukitchen/476',
  0, 0,
  'Для онсэн-тамаго берите яйцо комнатной температуры.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Дни проходят, а еда по-прежнему хороша', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Дни проходят, а еда по-прежнему хороша' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рис'),
('Сосиски'),
('Лук'),
('Овощная смесь замороженная'),
('Камамбер'),
('Кетчуп'),
('Порошок карри'),
('Яблочный сок'),
('Вода'),
('Соль'),
('Перец черный'),
('Яйца');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1),
  'Для плова',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1),
  'Для онсэн-тамаго',
  1
);

-- Ингредиенты в рецепте

-- Для плова
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Круглозёрный рис',
  250,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  4,
  'шт',
  '4-5 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Репчатый лук',
  1,
  'шт',
  'небольшая луковица'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Овощная смесь замороженная'),
  'Замороженная смесь (кукуруза, зелёный горошек, морковь)',
  120,
  'г',
  '120-150 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Камамбер'),
  'Камамбер',
  1,
  'головка',
  'небольшая, 120-150 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Томатный соус или кетчуп',
  3,
  'ст.л',
  '3-4 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Порошок карри'),
  'Порошок карри',
  1,
  'ч.л',
  '1-1,5 ч.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яблочный сок'),
  'Яблочный сок',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  350,
  'мл',
  '350-400 мл'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.5,
  'ч.л',
  'или по вкусу'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  NULL,
  'по вкусу',
  NULL
);

-- Для онсэн-тамаго
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для онсэн-тамаго'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  'комнатной температуры'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для онсэн-тамаго'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  1,
  'л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для онсэн-тамаго'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Холодная вода',
  NULL,
  'миска',
  'для охлаждения яйца'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1),
  'Подготовка ингредиентов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1),
  'Приготовление плова',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1),
  'Добавление камамбера',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1),
  'Приготовление онсэн-тамаго',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1),
  'Подача',
  4
);

-- Шаги (Подготовка ингредиентов)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Мелко нашинкуйте лук',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте сосиски кружочками толщиной около 1 см',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Хорошо промойте рис до прозрачной воды и дайте ему стечь',
  2
);

-- Шаги (Плов)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Выложите сырой рис в глубокую сковороду. Добавьте лук, сосиски, овощную смесь, тёртый сыр, томатный соус и карри',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Посолите, поперчите и при желании добавьте сушёный чеснок',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Влейте яблочный сок и воду так, чтобы жидкость почти полностью покрывала рис. Хорошо перемешайте',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Готовьте на среднем огне до закипания',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Как только всё закипит, накройте крышкой, уменьшите огонь до минимального и готовьте 15 минут',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление плова'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Выключите плиту и оставьте рис под крышкой ещё на 10 минут',
  5
);

-- Шаги (Камамбер)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Добавление камамбера'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Перемешайте рис',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Добавление камамбера'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Положите в центр целую головку камамбера, при желании слегка надрезав корочку крест-накрест',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Добавление камамбера'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Оставьте под крышкой на 10 минут, чтобы сыр полностью размягчился',
  2
);

-- Шаги (Онсэн-тамаго)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление онсэн-тамаго'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Доведите 1 литр воды до кипения',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление онсэн-тамаго'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Снимите кастрюлю с огня и сразу влейте 200 мл холодной воды',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление онсэн-тамаго'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Аккуратно опустите яйцо в воду',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление онсэн-тамаго'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Накройте крышкой и оставьте на 17 минут',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление онсэн-тамаго'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Переложите яйцо в холодную воду на 2-3 минуты, чтобы остановить приготовление',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление онсэн-тамаго'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Разбейте скорлупу и аккуратно вылейте яйцо',
  5
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Разломайте расплавленный камамбер и вмешайте его в рис',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='curry_plov.jpg' LIMIT 1) LIMIT 1),
  'Сверху положите онсэн-тамаго или яйцо пашот.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Картофель на пару',
  45,
  'easy',
  4,
  'steam_potato.jpg',
  'https://vt.tiktok.com/ZSXCYa3Lg/',
  'https://t.me/otakukitchen/473',
  0, 0,
  'Подавайте сразу, пока масло полностью не растаяло.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Кафе из другого мира', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Кафе из другого мира' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Картофель'),
('Масло сливочное'),
('Соль');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель небольшой',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  40,
  'г',
  '40-60 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1),
  'Подготовка картофеля',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1),
  'Приготовление на пару',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Подготовка картофеля)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1) LIMIT 1),
  'Тщательно вымойте картофель, не очищая от кожуры',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1) LIMIT 1),
  'Сделайте сверху крестообразный надрез, не прорезая картофель до конца',
  1
);

-- Шаги (На пару)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление на пару'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1) LIMIT 1),
  'Выложите картофель в пароварку и готовьте 25-35 минут, пока он не станет очень мягким',
  0
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1) LIMIT 1),
  'Переложите картофель на тарелку и слегка раскройте надрез',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1) LIMIT 1),
  'Положите внутрь щедрый кусочек сливочного масла',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steam_potato.jpg' LIMIT 1) LIMIT 1),
  'Посолите по вкусу и подавайте сразу, пока масло полностью не растаяло.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Картофельный салат',
  50,
  'medium',
  3,
  'potato_salat_mirai.jpg',
  'https://vt.tiktok.com/ZSXWEUSF7/',
  'https://t.me/otakukitchen/475',
  0, 0,
  'Добавляйте рисовый уксус, пока картофель ещё горячий, — так он лучше впитается.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Дневник будущего', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Дневник будущего' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Картофель'),
('Морковь'),
('Огурец'),
('Яйца'),
('Майонез'),
('Рисовый уксус'),
('Соль'),
('Перец белый'),
('Листья салата'),
('Помидоры черри'),
('Бекон');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1),
  'Для украшения',
  1
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  600,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  'небольшая'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Огурец'),
  'Огурец',
  0.5,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  5,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рисовый уксус'),
  'Рисовый уксус',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец белый'),
  'Белый перец',
  NULL,
  'по вкусу',
  NULL
);

-- Для украшения
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  NULL,
  'для подачи',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидоры черри'),
  'Помидоры черри',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бекон'),
  'Хрустящий жареный бекон',
  NULL,
  'немного',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1),
  'Подготовка картофеля',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1),
  'Подготовка овощей и яиц',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1),
  'Смешивание',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Картофель)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Очистите картофель и отварите до мягкости',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Пока картофель горячий, слегка разомните его вилкой, чтобы остались небольшие кусочки',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Добавьте рисовый уксус, перемешайте и дайте картофелю немного остыть',
  2
);

-- Шаги (Овощи и яйца)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка овощей и яиц'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте морковь очень маленькими кубиками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка овощей и яиц'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте огурец тонкими четвертинками, слегка посолите и оставьте на 10 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка овощей и яиц'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Переложите огурец на бумажные полотенца, чтобы убрать лишнюю влагу',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка овощей и яиц'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Сварите яйца вкрутую, 10 минут, и крупно нарежьте',
  3
);

-- Шаги (Смешивание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Смешивание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Смешайте картофель, морковь, огурец и яйца с майонезом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Смешивание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Посолите и поперчите по вкусу',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Выложите по краю глубокой деревянной миски крупные листья салата',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Переложите картофельный салат горкой в центр',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'Разложите по кругу 4 помидора черри',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potato_salat_mirai.jpg' LIMIT 1) LIMIT 1),
  'В центр добавьте немного мелко нарезанного хрустящего бекона.',
  3
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Картошка фри',
  80,
  'medium',
  3,
  'kartoshka_fri_onepunchman.jpg',
  'https://vt.tiktok.com/ZSbrREwjK/',
  'https://t.me/otakukitchen/65',
  0, 0,
  'Хрустящую корочку даёт повторная обжарка при 170°C.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Ванпачмен', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Ванпачмен' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло растительное'),
('Картофель'),
('Соль'),
('Крахмал кукурузный'),
('Вода'),
('Кетчуп'),
('Сырный соус');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1),
  'Для подачи',
  1
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  500,
  'мл',
  'без запаха'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  700,
  'г',
  'крупные клубни'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  7,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал кукурузный'),
  'Кукурузный крахмал',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  2,
  'л',
  'для бланширования'
);

-- Для подачи
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для подачи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для подачи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сырный соус'),
  'Сырный соус',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1),
  'Подготовка картофеля',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1),
  'Нарезка и замачивание',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1),
  'Бланширование',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1),
  'Обваливание в крахмале',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1),
  'Первая обжарка',
  4
),
(
  (SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1),
  'Вторая обжарка',
  5
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Вымойте крупные клубни холодной водой и очистите от кожуры. При необходимости удалите повреждённые места',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Ещё раз промойте очищенный картофель и обсушите полотенцем',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Обровняйте клубни ножом вдоль по четырём сторонам, чтобы в сечении получился прямоугольник. Обрезки можно использовать для других блюд',
  2
);

-- Шаги (Нарезка и замачивание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Нарезка и замачивание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте картофель брусками толщиной около 1 см и сложите в просторную миску',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Нарезка и замачивание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Залейте холодной водой и оставьте на 30 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Нарезка и замачивание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Промойте картофель проточной водой от лишнего крахмала',
  2
);

-- Шаги (Бланширование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Бланширование'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Налейте в глубокую кастрюлю 2 л чистой воды, накройте и доведите до кипения на сильном огне',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Бланширование'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Добавьте 1 ч.л соли, выложите картофель и снова доведите до кипения',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Бланширование'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Проварите 1 минуту, откиньте на дуршлаг, слегка остудите и обсушите на полотенце',
  2
);

-- Шаги (Крахмал)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обваливание в крахмале'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Переложите подсушенный картофель в миску и насыпьте 1 ст.л кукурузного крахмала',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обваливание в крахмале'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Аккуратно встряхивая миску, распределите крахмал по всем ломтикам',
  1
);

-- Шаги (Первая обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Первая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Налейте масло в кастрюлю или сковороду с высокими бортиками и нагрейте на среднем огне до 140-150°C',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Первая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Если нет термометра, опустите в масло один ломтик: при правильной температуре вокруг него образуется плотная пена и он сразу всплывёт',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Первая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Выкладывайте картофель в масло небольшими порциями, примерно по 100 г, и готовьте, аккуратно помешивая, до бледной корочки и мягкости',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Первая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Выньте картофель шумовкой',
  3
);

-- Шаги (Вторая обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Вторая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Когда весь картофель обжарен, повысьте температуру масла до 170°C',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Вторая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Выложите примерно треть картофеля во фритюр и обжарьте, помешивая, до желаемой румяности',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Вторая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Переложите в миску с бумажным полотенцем, чтобы убрать лишний жир. Так же дожарьте остальной картофель',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Вторая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kartoshka_fri_onepunchman.jpg' LIMIT 1) LIMIT 1),
  'Подавайте с кетчупом или сырным соусом.',
  3
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Клубничный пирог',
  100,
  'medium',
  1,
  'strawberry_pie.jpg',
  'https://vt.tiktok.com/ZSbrYtQEL/',
  'https://t.me/otakukitchen/173',
  0, 0,
  'Рецепт рассчитан на форму диаметром 20-22 см.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Атака титанов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Атака титанов' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Клубника'),
('Масло сливочное'),
('Яйца'),
('Сахар'),
('Мука'),
('Разрыхлитель'),
('Крахмал кукурузный'),
('Вода');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника'),
  'Клубника',
  400,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  'в тесто и для смазывания'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  150,
  'г',
  '2 ст.л в тесто, остальное в начинку'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  230,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал кукурузный'),
  'Крахмал',
  3,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  3,
  'ст.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1),
  'Подготовка теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1),
  'Формовка основы',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1),
  'Начинка',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1),
  'Выпекание',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте сливочное масло кубиками, положите в миску и дайте постоять при комнатной температуре',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Разотрите масло с мукой, добавьте разрыхлитель и 2 ст.л сахара, перемешайте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'В другой посуде взбейте яйцо с водой и добавьте к тесту',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Замесите мягкое тесто. Если оно липнет, добавьте 1-2 ст.л муки',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Таким же образом приготовьте тесто для полосок',
  4
);

-- Шаги (Основа)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формовка основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте тесто толщиной 0,5 см и выложите в форму, закрывая дно и бортики',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Наколите основу вилкой, чтобы она не вздулась',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Уберите форму и тесто для полосок в холодильник на 30 минут',
  2
);

-- Шаги (Начинка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Начинка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Вымойте клубнику, удалите хвостики и разрежьте ягоды на 2-4 части',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Начинка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Переложите в миску, добавьте крахмал и оставшийся сахар, перемешайте',
  1
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте духовку до 180°C',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Достаньте основу из холодильника и выложите в неё клубничную начинку',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте тесто для полосок, нарежьте полосками, выложите решёткой сверху и защипните по краям',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Смажьте пирог желтком',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_pie.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте 40 минут до золотистой корочки.',
  4
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Клубничный торт',
  220,
  'hard',
  1,
  'strawberry_cake_jojo.jpg',
  'https://vm.tiktok.com/ZMAkQkphf/',
  'https://t.me/otakukitchen/221',
  0, 0,
  'Сливки для крема должны быть очень холодными — так они лучше взбиваются.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Невероятное приключение ДжоДжо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Невероятное приключение ДжоДжо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Форма для выпечки'),
('Пергамент'),
('Длинный нож'),
('Кондитерский мешок'),
('Яйца'),
('Сахар'),
('Мука'),
('Крахмал кукурузный'),
('Молоко'),
('Масло сливочное'),
('Соль'),
('Вода'),
('Сливки 33%'),
('Маскарпоне'),
('Сахарная пудра'),
('Ваниль'),
('Клубника');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Инвентарь',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Для бисквита',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Для пропитки',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Для крема',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Для декора',
  4
);

-- Ингредиенты в рецепте

-- Инвентарь
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Инвентарь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Форма для выпечки'),
  'Форма 18-22 см',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Инвентарь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Пергамент'),
  'Пергамент',
  NULL,
  'для формы',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Инвентарь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Длинный нож'),
  'Длинный нож',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Инвентарь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кондитерский мешок'),
  'Кондитерский мешок с насадкой «звезда»',
  1,
  'шт',
  NULL
);

-- Для бисквита
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  120,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал кукурузный'),
  'Крахмал кукурузный',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  30,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло сливочное',
  30,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
);

-- Для пропитки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для пропитки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  80,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пропитки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  60,
  'г',
  NULL
);

-- Для крема
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливки 33-38%',
  450,
  'мл',
  'очень холодные'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Маскарпоне'),
  'Маскарпоне',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  70,
  'г',
  '70-90 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ваниль'),
  'Ваниль',
  NULL,
  'по вкусу',
  NULL
);

-- Для декора
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для декора'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника'),
  'Клубника',
  450,
  'г',
  '450-500 г'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Приготовление бисквита',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Приготовление пропитки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Приготовление крема',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Подготовка клубники',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1),
  'Сборка торта',
  4
);

-- Шаги (Бисквит)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте духовку до 170°C. Дно формы выстелите пергаментом, борта не смазывайте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Яйца с сахаром и щепоткой соли прогрейте на водяной бане до 35-40°C, постоянно помешивая — тёплые яйца лучше взбиваются',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Снимите с водяной бани и взбивайте миксером 7-9 минут, пока масса не станет плотной и светлой, а стекающая струйка не будет оставлять след',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Просейте муку с крахмалом и в 2-3 приёма аккуратно вмешайте лопаткой',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Подогрейте масло с молоком до горячего состояния, смешайте с 2-3 ст.л теста, затем верните в основную массу и аккуратно вмешайте',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Вылейте тесто в форму и выпекайте 25-30 минут до сухой шпажки',
  5
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Остудите 5 минут, проведите ножом по борту, переверните на решётку и полностью остудите',
  6
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление бисквита'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Охладите бисквит 1-2 часа, затем разрежьте на 3 коржа',
  7
);

-- Шаги (Пропитка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление пропитки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Прокипятите воду с сахаром 1-2 минуты и остудите',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление пропитки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Добавьте ваниль или ликёр',
  1
);

-- Шаги (Крем)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Взбейте холодные сливки до мягких пиков',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Отдельно размешайте маскарпоне с пудрой и ванилью до гладкости',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Соедините обе массы и взбейте до средних пиков, чтобы крем держал форму',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Охладите крем 10 минут',
  3
);

-- Шаги (Клубника)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка клубники'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Для «полумесяцев» в разрезе выберите одинаковую по размеру клубнику и разрежьте её пополам',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка клубники'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Для верха торта отложите красивые крупные ягоды',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка торта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Положите корж №1 на подложку, слегка пропитайте и нанесите тонкий слой крема (2-3 мм)',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка торта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Вдоль самого края разложите половинки клубники срезом к борту — тогда на разрезе будут красные полуокружности. Заполните середину кремом',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка торта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Положите корж №2, пропитайте и повторите выкладку клубники и крема',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка торта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Положите корж №3 и пропитайте. Нанесите тонкий «черновой» слой крема по верху и бокам и охладите 15-20 минут',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка торта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'Нанесите финальный ровный слой крема',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка торта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='strawberry_cake_jojo.jpg' LIMIT 1) LIMIT 1),
  'По верху отсадите «розочки» насадкой «звезда» и установите на них клубнику.',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Колбаски и омлет',
  60,
  'medium',
  4,
  'kolbaski_jojo.jpg',
  'https://vt.tiktok.com/ZSbLQmAG4/',
  'https://t.me/otakukitchen/163',
  0, 0,
  'Рецепт рассчитан на 2 порции.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Невероятное приключение ДжоДжо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Невероятное приключение ДжоДжо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Соль'),
('Молоко'),
('Лук зеленый'),
('Масло сливочное'),
('Фарш'),
('Морковь'),
('Сельдерей'),
('Перец черный'),
('Соевый соус'),
('Мед'),
('Масло растительное'),
('Петрушка');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1),
  'Для омлета',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1),
  'Для говяжьих рулетиков',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1),
  'Для украшения',
  2
);

-- Ингредиенты в рецепте

-- Для омлета
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для омлета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  3,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для омлета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для омлета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  1,
  'ст.л',
  'по желанию, для мягкости'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для омлета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук зеленый'),
  'Зелёный лук',
  1,
  'перо',
  '1-2 перышка, мелко нарезать'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для омлета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло сливочное',
  1,
  'ч.л',
  NULL
);

-- Для говяжьих рулетиков
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фарш'),
  'Говяжий фарш',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сельдерей'),
  'Сельдерей (стебель)',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мед'),
  'Мёд или сахар',
  1,
  'ч.л',
  'по желанию, для глазури'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Масло для жарки',
  NULL,
  'для жарки',
  NULL
);

-- Для украшения
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Петрушка'),
  'Петрушка',
  2,
  'веточка',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1),
  'Приготовление омлета',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1),
  'Приготовление говяжьих рулетиков',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Омлет)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление омлета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Взбейте яйца с солью и молоком',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление омлета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду с небольшим количеством сливочного масла',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление омлета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Вылейте яйца и жарьте на среднем огне, аккуратно помешивая, чтобы получился слегка «рваный» омлет, как скрэмбл',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление омлета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Выложите готовый омлет на тарелку и посыпьте нарезанным зелёным луком',
  3
);

-- Шаги (Говяжьи рулетики)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте морковь и сельдерей тонкими брусочками длиной около 5-6 см',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Разделите фарш на 6 порций и руками расплющите каждую в лепёшку',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Оберните каждый овощной брусок лепёшкой из фарша, придавая форму рулета',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте рулетики на сковороде до золотистой корочки',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Добавьте немного воды, соевый соус и мёд или сахар, накройте крышкой и тушите 5-7 минут',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление говяжьих рулетиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Когда соус загустеет, рулетики готовы',
  5
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Выложите на тарелку порцию омлета с луком, а рядом — 2-3 говяжьих рулетика',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kolbaski_jojo.jpg' LIMIT 1) LIMIT 1),
  'Добавьте веточку свежей петрушки.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Конфеты Маомао',
  200,
  'easy',
  1,
  'konfeti_monolog.jpg',
  'https://vt.tiktok.com/ZSbMc953t/',
  'https://t.me/otakukitchen/503',
  0, 0,
  'Добавляйте молочную смесь к какао понемногу — иначе оно может собраться в комки.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Монолог фармацевта', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Монолог фармацевта' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Какао-порошок'),
('Сахарная пудра'),
('Молоко'),
('Масло сливочное'),
('Мед'),
('Ванильный экстракт'),
('Сухофрукты'),
('Орехи');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1),
  'Для шоколадной массы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1),
  'Для конфет',
  1
);

-- Ингредиенты в рецепте

-- Для шоколадной массы
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Какао-порошок'),
  'Какао-порошок',
  45,
  'г',
  'плюс немного для посыпки'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  45,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  50,
  'г',
  'при необходимости ещё 1 ч.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мед'),
  'Мёд',
  3,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный экстракт'),
  'Ванильный экстракт',
  1,
  'капля',
  NULL
);

-- Для конфет
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для конфет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухофрукты'),
  'Сухофрукты (курага, чернослив)',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для конфет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Орехи'),
  'Орехи',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1),
  'Приготовление шоколадной массы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1),
  'Глазирование',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1),
  'Застывание',
  2
);

-- Шаги (Шоколадная масса)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Смешайте какао и сахарную пудру',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Отдельно смешайте молоко, мёд и ванильный экстракт',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Поставьте миску с какао на водяную баню — вода должна быть горячей, но не кипеть сильно',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Понемногу добавляйте молочную смесь к какао, постоянно размешивая. Не выливайте всё сразу',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Добавьте сливочное масло и мешайте до гладкой, густой, блестящей массы',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Масса должна быть достаточно жидкой, чтобы в неё можно было окунуть сухофрукт. Если она слишком густая, добавьте 1 ч.л молока',
  5
);

-- Шаги (Глазирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Глазирование'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Окуните каждый кусочек кураги, чернослива или ореха в шоколад — полностью или наполовину',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Глазирование'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Выложите на пергамент или тарелку',
  1
);

-- Шаги (Застывание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Застывание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Уберите в холодильник на 2-3 часа, а лучше на ночь',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Застывание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_monolog.jpg' LIMIT 1) LIMIT 1),
  'Когда конфеты застынут, слегка присыпьте их какао-порошком.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Корн-доги',
  45,
  'medium',
  3,
  'corn_dog.jpg',
  'https://vm.tiktok.com/ZMDJuAXgk/',
  'https://t.me/otakukitchen/311',
  0, 0,
  'Перелейте кляр в высокий стакан — так сосиски удобнее окунать.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Кулинарные скитания в параллельном мире', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Кулинарные скитания в параллельном мире' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Сосиски'),
('Деревянные шпажки'),
('Мука кукурузная'),
('Мука'),
('Соль'),
('Сахар'),
('Яйца'),
('Молоко'),
('Масло растительное'),
('Кетчуп'),
('Горчица');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1),
  'Для основы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1),
  'Для жарки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1),
  'Для соуса',
  2
);

-- Ингредиенты в рецепте

-- Для основы
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Венские сосиски',
  8,
  'шт',
  '8-10 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Деревянные шпажки'),
  'Деревянные шпажки',
  8,
  'шт',
  '8-10 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука кукурузная'),
  'Кукурузная мука',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Пшеничная мука',
  120,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.5,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  180,
  'мл',
  '180-200 мл'
);

-- Для жарки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для жарки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Масло',
  NULL,
  'для фритюра',
  'много'
);

-- Для соуса
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Горчица'),
  'Горчица',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1),
  'Подготовка сосисок',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1),
  'Приготовление кляра',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1),
  'Жарка',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Подготовка сосисок)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосисок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'Обсушите венские сосиски и насадите каждую на шпажку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосисок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'По желанию обваляйте сосиски в муке — так кляр будет лучше держаться',
  1
);

-- Шаги (Кляр)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление кляра'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'В миске смешайте кукурузную и пшеничную муку, добавьте соль и сахар',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление кляра'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'Вбейте яйцо',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление кляра'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'Влейте молоко и перемешайте до густой массы, по консистенции как сметана',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление кляра'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'Перелейте кляр в высокий стакан, чтобы в него было удобнее окунать сосиски',
  3
);

-- Шаги (Жарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте масло до 170-180°C',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'Окуните сосиску в кляр и проверните её, затем аккуратно опустите в масло',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'Жарьте 3-4 минуты до золотистой корочки',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'Выложите корн-доги на бумажное полотенце, чтобы ушёл лишний жир',
  3
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='corn_dog.jpg' LIMIT 1) LIMIT 1),
  'Полейте корн-доги сверху кетчупом и горчицей.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Куриный бургер',
  50,
  'medium',
  3,
  'burger_guren.jpg',
  'https://vt.tiktok.com/ZSbrYdwcn/',
  'https://t.me/otakukitchen/141',
  0, 0,
  'Подавайте с картофелем фри и соусом по вкусу. Рецепт картофеля фри: https://t.me/otakukitchen/65'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Гуррен-Лаганн', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Гуррен-Лаганн' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Булочки для бургеров'),
('Куриные ножки'),
('Соль'),
('Перец черный'),
('Паприка'),
('Панко'),
('Масло растительное'),
('Листья салата'),
('Сыр плавленый'),
('Кетчуп'),
('Майонез');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Булочки для бургеров'),
  'Пышная булочка для бургера',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриные ножки'),
  'Куриные ножки',
  2,
  'шт',
  'небольшие, чтобы поместились в булку'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Паприка'),
  'Паприка',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Панко'),
  'Панировочные сухари панко',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Масло',
  NULL,
  'для жарки и смазывания',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  2,
  'лист',
  '2-3 листа'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр плавленый'),
  'Плавленый сыр',
  NULL,
  'по желанию',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп или острый соус',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1),
  'Подготовка куриных ножек',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1),
  'Приготовление курицы',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1),
  'Подготовка булки',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1),
  'Сборка',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1),
  'Подача',
  4
);

-- Шаги (Подготовка ножек)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка куриных ножек'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  'Натрите ножки солью, перцем и паприкой',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка куриных ножек'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  'Смажьте маслом и обваляйте в сухарях панко',
  1
);

-- Шаги (Курица)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте ножки на сковороде по 10 минут с каждой стороны',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  'Или запеките в духовке при 200°C около 30-40 минут до хрустящей корочки и полной готовности',
  1
);

-- Шаги (Булка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка булки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте булочку и подрумяньте на сковороде',
  0
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  'Смажьте обе половинки булочки соусом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  'На нижнюю половинку положите салат и сыр, затем аккуратно разместите жареные куриные ножки',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  'Накройте верхней половинкой булочки',
  2
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_guren.jpg' LIMIT 1) LIMIT 1),
  'Подавайте с картофелем фри.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Курица карааге',
  65,
  'medium',
  3,
  'kurica_karaage_chainsaw.jpg',
  'https://vt.tiktok.com/ZSbMs8Nwy/',
  'https://t.me/otakukitchen/204',
  0, 0,
  'Курицу обжаривают дважды — так корочка получается насыщенно-золотистой и хрустящей.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Человек-бензопила', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Человек-бензопила' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Куриные бедра'),
('Соль'),
('Перец черный'),
('Крахмал картофельный'),
('Мука'),
('Масло растительное'),
('Имбирь'),
('Чеснок'),
('Соевый соус'),
('Мирин'),
('Масло кунжутное'),
('Соус чили'),
('Вода');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1),
  'Для курицы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1),
  'Для маринада',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1),
  'Для соуса',
  2
);

-- Ингредиенты в рецепте

-- Для курицы
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриные бедра'),
  'Куриные бёдра',
  600,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.5,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  0.5,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал картофельный'),
  'Картофельный крахмал (или кукурузный)',
  5,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  5,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  NULL,
  'для фритюра',
  NULL
);

-- Для маринада
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для маринада'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Имбирь'),
  'Тёртый имбирь',
  0.5,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для маринада'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  1,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для маринада'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  0.5,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для маринада'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мирин'),
  'Мирин',
  0.5,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для маринада'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло кунжутное'),
  'Кунжутное масло',
  0.5,
  'ч.л',
  NULL
);

-- Для соуса
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соус чили'),
  'Сладкий чили соус',
  8,
  'ст.л',
  '1/2 стакана'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  2,
  'ст.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1),
  'Подготовка и маринад',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1),
  'Панировка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1),
  'Первая обжарка',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1),
  'Вторая обжарка',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1),
  'Соус',
  4
);

-- Шаги (Подготовка и маринад)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка и маринад'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте бёдра на небольшие кусочки. Приправьте солью и перцем',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка и маринад'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Смешайте имбирь, чеснок, соевый соус, мирин и кунжутное масло',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка и маринад'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Замаринуйте курицу минимум на 30 минут в холодильнике',
  2
);

-- Шаги (Панировка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Панировка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Насыпьте крахмал и муку в разные тарелки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Панировка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Обваляйте каждый кусочек сначала в муке, стряхнув лишнее, затем в крахмале, тоже стряхнув лишнее',
  1
);

-- Шаги (Первая обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Первая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте масло во фритюре',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Первая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Обжаривайте по 3-5 кусочков за раз около 90 секунд до светло-золотистого цвета',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Первая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Выложите на бумажное полотенце, чтобы впиталось масло',
  2
);

-- Шаги (Вторая обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Вторая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Повторно обжарьте те же кусочки по 45 секунд до насыщенного золотистого цвета и хрустящей корочки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Вторая обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Выложите готовые кусочки на бумажное полотенце',
  1
);

-- Шаги (Соус)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Соус'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'На сковороде смешайте сладкий чили соус и воду, доведите до лёгкого кипения',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Соус'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_karaage_chainsaw.jpg' LIMIT 1) LIMIT 1),
  'Добавьте жареную курицу и перемешивайте 10-15 секунд, чтобы она покрылась соусом.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Курица на шпажках',
  200,
  'easy',
  3,
  'kurica_okean.jpg',
  'https://vm.tiktok.com/ZMAM6BgN6/',
  'https://t.me/otakukitchen/214',
  0, 0,
  'Лучше всего мариновать курицу 2 часа в холодильнике.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Необъятный океан', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Необъятный океан' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Куриное филе'),
('Соль'),
('Перец черный'),
('Чеснок'),
('Соевый соус'),
('Мед'),
('Мирин'),
('Масло растительное'),
('Листья салата'),
('Деревянные шпажки');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриное филе'),
  'Куриное филе',
  600,
  'г',
  'бедро или грудка'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  0.5,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  2,
  'зубчик',
  'по желанию'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  3,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мед'),
  'Мед или сахар',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мирин'),
  'Мирин',
  2,
  'ст.л',
  'или белое вино'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  NULL,
  'для подачи',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Деревянные шпажки'),
  'Деревянные шпажки',
  NULL,
  'по необходимости',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1),
  'Подготовка',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1),
  'Маринад',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1),
  'Шпажки',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1),
  'Обжарка',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1),
  'Подача',
  4
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте курицу кубиками 3x3 см',
  0
);

-- Шаги (Маринад)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Маринад'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  'Смешайте соевый соус, мирин, мёд или сахар, измельчённый чеснок и масло',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Маринад'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  'Положите курицу в маринад минимум на 30 минут, а лучше на 2 часа в холодильник',
  1
);

-- Шаги (Шпажки)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Шпажки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  'Нанижите кусочки курицы на шпажки',
  0
);

-- Шаги (Обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  'Жарьте на гриле, сковороде или в духовке при 200°C 10-12 минут, периодически смазывая остатками маринада',
  0
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='kurica_okean.jpg' LIMIT 1) LIMIT 1),
  'Выложите шашлычки на тарелку и украсьте листьями салата.',
  0
);
-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Лимонный пирог с меренгой',
  300,
  'hard',
  1,
  'lemon_pie_blackbutler.jpg',
  'https://vt.tiktok.com/ZSbLnWYng/',
  'https://t.me/otakukitchen/72',
  0, 0,
  'Меренга должна соприкасаться со стенками основы. Подавайте пирог охлаждённым.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Темный дворецкий', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Темный дворецкий' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Масло сливочное'),
('Соль'),
('Сахар'),
('Вода'),
('Яйца'),
('Крахмал кукурузный'),
('Лимонный сок'),
('Цедра лимона'),
('Ванилин');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1),
  'Для лимонной начинки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1),
  'Для меренги',
  2
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  115,
  'г',
  'холодное'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  2,
  'г',
  'по вкусу'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  5,
  'г',
  'по вкусу'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода холодная',
  2,
  'ст.л',
  NULL
);

-- Для лимонной начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яичный желток',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал кукурузный'),
  'Кукурузный крахмал',
  120,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  330,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонный сок',
  120,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Цедра лимона'),
  'Лимонная цедра',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  75,
  'г',
  NULL
);

-- Для меренги
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для меренги'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яичный белок',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для меренги'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  170,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для меренги'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванилин'),
  'Ванилин',
  2,
  'г',
  'по вкусу'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1),
  'Приготовление лимонной начинки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1),
  'Приготовление меренги',
  2
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Выложите в чашу холодное масло, муку и сахар. Перемешайте до мелкой крошки — в блендере, вилкой или руками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Влейте воду и максимально быстро замесите тесто. Долго месить нельзя, иначе масло растает и тесто получится деревянным',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Сформируйте из теста шар, заверните в пищевую плёнку и уберите в холодильник на 30-40 минут',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Достаньте тесто из холодильника и раскатайте в пласт. Аккуратно намотайте тесто на скалку, чтобы перенести в форму',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Уложите тесто на дно и борта формы, лучше разъёмной. Наколите вилкой в нескольких местах, накройте фольгой и насыпьте сверху груз (фасоль, рис или горох)',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте в разогретой до 170°C духовке 12-15 минут. Достаньте и уберите фольгу с грузом',
  5
);

-- Шаги (Начинка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Натрите на тёрке лимонную цедру',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Слегка взбейте желтки венчиком',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'В ковшике смешайте воду, лимонный сок, цедру, сахар и крахмал',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Поставьте смесь на огонь и, помешивая, доведите до кипения — масса загустеет',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Снимите с огня и добавьте половину смеси к желткам, тщательно и интенсивно перемешивая венчиком',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Переложите полученную массу к оставшейся половине лимонной смеси в ковшике, хорошо перемешайте и снова поставьте на огонь',
  5
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Доведите до кипения и загустения, снимите с огня, добавьте сливочное масло и перемешайте',
  6
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лимонной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Переложите начинку в остывшую выпеченную основу',
  7
);

-- Шаги (Меренга)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление меренги'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Взбейте белки с сахаром до средних пиков',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление меренги'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Выложите меренгу поверх лимонной начинки ложкой или кондитерским мешком с фигурной насадкой. Следите, чтобы меренга соприкасалась со стенками основы',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление меренги'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Запекайте пирог в разогретой до 180°C духовке 8-10 минут, пока верх меренги не станет золотисто-коричневым',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление меренги'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Достаньте пирог, остудите до комнатной температуры, затем уберите в холодильник до полного охлаждения',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление меренги'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_pie_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Подавайте охлаждённым.',
  4
);
-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Лимонный торт-суфле',
  450,
  'medium',
  1,
  'lemon_suffle_soyuz.jpg',
  'https://vt.tiktok.com/ZSV3RC64r/',
  'https://t.me/otakukitchen/488',
  0, 0,
  'Рецепт рассчитан на форму диаметром 12,5 см. Суфле лучше оставить в холодильнике на ночь.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Союз Серокрылых', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Союз Серокрылых' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Печенье песочное'),
('Масло сливочное'),
('Сливки 33%'),
('Йогурт натуральный'),
('Лимонный сок'),
('Сахар'),
('Желатин'),
('Вода'),
('Цедра лимона'),
('Шоколад белый');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1),
  'Для основы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1),
  'Для лимонного суфле',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1),
  'Для белой заливки',
  2
);

-- Ингредиенты в рецепте

-- Для основы
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Печенье песочное'),
  'Песочное печенье',
  75,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  30,
  'г',
  NULL
);

-- Для лимонного суфле
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонного суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливки 33-35%',
  125,
  'мл',
  'очень холодные'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонного суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Йогурт натуральный'),
  'Густой натуральный йогурт',
  75,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонного суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонный сок',
  35,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонного суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  45,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонного суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желатин'),
  'Желатин',
  5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонного суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Холодная вода',
  25,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для лимонного суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Цедра лимона'),
  'Цедра лимона',
  0.5,
  'шт',
  'примерно с половины лимона'
);

-- Для белой заливки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для белой заливки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколад белый'),
  'Белый шоколад',
  35,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для белой заливки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливки 33-35%',
  25,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для белой заливки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  3,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для белой заливки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонный сок',
  0.5,
  'ч.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1),
  'Приготовление основы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1),
  'Лимонная смесь с желатином',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1),
  'Приготовление суфле',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1),
  'Приготовление белой глазури',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1),
  'Покрытие глазурью',
  4
);

-- Шаги (Основа)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Измельчите печенье в мелкую крошку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Растопите масло, смешайте с печеньем и выложите на дно формы',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Хорошо утрамбуйте стаканом или ложкой - слой должен быть тонким и плотным',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Уберите в холодильник на 30 минут',
  3
);

-- Шаги (Лимонная смесь)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Лимонная смесь с желатином'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Залейте 5 г желатина 25 мл холодной воды, перемешайте и оставьте на 10-15 минут, чтобы он полностью набух',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Лимонная смесь с желатином'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'В маленькой кастрюле смешайте 35 мл лимонного сока и 45 г сахара',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Лимонная смесь с желатином'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Нагревайте на слабом огне, помешивая, пока сахар не растворится. Кипятить не нужно',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Лимонная смесь с желатином'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Снимите с огня, добавьте набухший желатин и хорошо размешайте, чтобы он полностью растворился',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Лимонная смесь с желатином'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Добавьте цедру половины лимона',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Лимонная смесь с желатином'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Оставьте смесь остывать примерно до комнатной температуры - она должна оставаться жидкой',
  5
);

-- Шаги (Суфле)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Положите в миску 75 г натурального йогурта',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Постепенно влейте остывшую лимонную смесь, постоянно перемешивая венчиком, - получится довольно жидкая однородная кремово-желтая масса',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Взбейте 125 мл очень холодных сливок до мягких пиков',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Добавьте сливки в лимонно-йогуртовую массу в 2-3 приема, каждый раз аккуратно перемешивая лопаткой снизу вверх',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Достаньте основу из холодильника, вылейте сверху все суфле и аккуратно разровняйте. Можно пару раз слегка постучать формой по столу, чтобы убрать крупные пузыри воздуха',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление суфле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Уберите в холодильник минимум на 5-6 часов, а лучше на ночь',
  5
);

-- Шаги (Белая глазурь)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление белой глазури'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Мелко нарежьте белый шоколад',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление белой глазури'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Нагрейте 25 мл сливок почти до кипения и залейте ими шоколад',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление белой глазури'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Оставьте примерно на минуту, затем перемешайте до гладкой однородной массы',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление белой глазури'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Добавьте масло и перемешайте',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление белой глазури'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Дайте глазури немного остыть. Когда она станет теплой, а не горячей, вмешайте 0.5 ч.л лимонного сока',
  4
);

-- Шаги (Покрытие)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Покрытие глазурью'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Достаньте хорошо охлажденный торт из формы',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Покрытие глазурью'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Вылейте глазурь в центр и осторожно распределите к краям - слой сверху нужен совсем небольшой, примерно 2-3 мм',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Покрытие глазурью'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'В нескольких местах подтолкните глазурь ложкой через край, чтобы появились небольшие белые потеки',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Покрытие глазурью'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='lemon_suffle_soyuz.jpg' LIMIT 1) LIMIT 1),
  'Поставьте торт еще примерно на 1-2 часа в холодильник.',
  3
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Луковая пицца',
  90,
  'medium',
  3,
  'pizza_onion.jpg',
  'https://vt.tiktok.com/ZSq6PB3jj/',
  'https://t.me/otakukitchen/492',
  0, 0,
  'Лук нарежьте очень тонкими полукольцами и разложите щедро - он главный в этой пицце.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Подземелье вкусностей', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Подземелье вкусностей' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Вода'),
('Дрожжи сухие'),
('Соль'),
('Масло растительное'),
('Лук'),
('Моцарелла'),
('Сыр гауда');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1),
  'Для начинки',
  1
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Пшеничная мука',
  85,
  'г',
  '85-100 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Теплая вода',
  50,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Дрожжи сухие'),
  'Сухие дрожжи',
  1.5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.25,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Масло',
  1,
  'ч.л',
  NULL
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Репчатый лук',
  0.5,
  'шт',
  '0.5-1 небольшой луковицы'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Моцарелла для пиццы',
  45,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр гауда'),
  'Гауда',
  15,
  'г',
  '15-20 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Масло',
  1,
  'ч.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1),
  'Формирование пиццы',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1),
  'Выпекание',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  'В теплой воде размешайте дрожжи',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  'Добавьте муку, соль и масло. Замесите мягкое тесто, примерно 5-7 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  'Накройте тесто и оставьте в тепле на 45-60 минут',
  2
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование пиццы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте или растяните тесто в круг примерно 16-18 см, оставляя пухлый бортик',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование пиццы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  'Слегка смажьте середину маслом',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование пиццы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  'Посыпьте сыром',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование пиццы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте лук очень тонкими полукольцами и щедро разложите сверху',
  3
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте при 230-250°C около 10-13 минут, пока бортик не подрумянится',
  0
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_onion.jpg' LIMIT 1) LIMIT 1),
  'При подаче положите сверху кусочек мяса.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Лунные пряники',
  140,
  'hard',
  1,
  'moon_pryaniki_monolog.jpg',
  'https://vt.tiktok.com/ZSbMHVEty/',
  'https://t.me/otakukitchen/97',
  0, 0,
  'Для узора лучше использовать формочки, а не штамп: пока раскатываются остальные шарики, узор на первых пряниках пропадает.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Монолог фармацевта', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Монолог фармацевта' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Соль'),
('Мед'),
('Вода'),
('Мука'),
('Масло растительное'),
('Ананасовое пюре'),
('Сахар коричневый'),
('Сахар'),
('Лимонный сок'),
('Яйца');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1),
  'Для начинки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1),
  'Для смазывания',
  2
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мед'),
  'Мед',
  75,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  180,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  60,
  'мл',
  NULL
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ананасовое пюре'),
  'Ананасовое пюре',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар коричневый'),
  'Коричневый сахар',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Белый сахар',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонный сок',
  1,
  'ч.л',
  NULL
);

-- Для смазывания
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для смазывания'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яичный желток',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для смазывания'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  1,
  'ст.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1),
  'Замес теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1),
  'Приготовление начинки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1),
  'Формирование пряников',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1),
  'Выпекание',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Замес теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Смешайте все ингредиенты для теста в глубокой миске до однородности',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Замес теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Если тесто получается рассыпчатым, добавьте еще немного воды и масла',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Замес теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Накройте тесто пленкой и уберите в холодильник на 1 час',
  2
);

-- Шаги (Начинка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'В сотейнике соедините ананасовое пюре и сахар',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Варите на среднем огне, помешивая, пока масса не загустеет',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Остудите начинку',
  2
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование пряников'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Достаньте тесто из холодильника и разделите на 8 частей',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование пряников'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте каждую часть в кружок диаметром около 10 см',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование пряников'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Положите в центр кружка 1 ч.л начинки',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование пряников'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Аккуратно защипните края, формируя ровный шарик',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование пряников'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Придайте пряникам форму с помощью формочки или штампа',
  4
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте духовку до 180C',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Смешайте желток с водой и смажьте пряники',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Выложите пряники на противень с пергаментной бумагой',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте 8 минут',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Достаньте из духовки и снова смажьте желтком с водой',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='moon_pryaniki_monolog.jpg' LIMIT 1) LIMIT 1),
  'Верните в духовку и выпекайте еще 10 минут до золотистого цвета.',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Митболы',
  45,
  'medium',
  3,
  'meatballs_hunterhunter.jpg',
  'https://vt.tiktok.com/ZSbrdFKtp/',
  'https://t.me/otakukitchen/27',
  0, 0,
  'Если соус получился слишком густым, добавьте немного воды. Митболы хорошо сочетаются с рисом или лапшой.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Hunter x Hunter', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Hunter x Hunter' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Фарш'),
('Панировочные сухари'),
('Молоко'),
('Лук'),
('Чеснок'),
('Соль'),
('Перец черный'),
('Сахар'),
('Соевый соус'),
('Рисовый уксус'),
('Кетчуп'),
('Крахмал кукурузный'),
('Вода');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1),
  'Для митболов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1),
  'Для соуса',
  1
);

-- Ингредиенты в рецепте

-- Для митболов
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фарш'),
  'Фарш',
  400,
  'г',
  'смесь свиного и говяжьего'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Панировочные сухари'),
  'Панировочные сухари',
  35,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  60,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  0.5,
  'шт',
  'мелко нарезать'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  3,
  'зубчик',
  'измельчить или натереть'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
);

-- Для соуса
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  3,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рисовый уксус'),
  'Уксус (рисовый или яблочный)',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал кукурузный'),
  'Крахмал',
  1,
  'ст.л',
  'развести в воде'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  2,
  'ст.л',
  'для крахмала'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1),
  'Подготовка митболов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1),
  'Обжарка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1),
  'Приготовление соуса',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1),
  'Тушение в соусе',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1),
  'Подача',
  4
);

-- Шаги (Подготовка митболов)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'В глубокой миске смешайте свиной и говяжий фарш',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Добавьте панировочные сухари, молоко, мелко нарезанный лук и чеснок',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Посолите, поперчите и тщательно перемешайте до однородности',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка митболов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Сформируйте небольшие шарики размером примерно с грецкий орех',
  3
);

-- Шаги (Обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду с небольшим количеством масла на среднем огне',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Обжаривайте митболы со всех сторон до золотистой корочки, по 3-4 минуты с каждой стороны',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Переложите митболы на тарелку',
  2
);

-- Шаги (Соус)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'В отдельной миске смешайте сахар, соевый соус, уксус и кетчуп до однородности',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Разведите крахмал в 2 ст.л воды',
  1
);

-- Шаги (Тушение в соусе)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тушение в соусе'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Влейте соус в чистую сковороду и доведите до кипения на среднем огне',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение в соусе'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Влейте разведенный крахмал, постоянно помешивая, чтобы не было комочков',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение в соусе'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Варите соус, пока он не загустеет',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение в соусе'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Верните митболы в сковороду, уменьшите огонь и тушите 3-4 минуты, периодически переворачивая, чтобы они хорошо пропитались',
  3
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='meatballs_hunterhunter.jpg' LIMIT 1) LIMIT 1),
  'Подавайте митболы горячими, украсив свежей зеленью.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Мороженое',
  360,
  'medium',
  1,
  'morozhenoe_monolog.jpg',
  'https://vt.tiktok.com/ZSbLmDywW/',
  'https://t.me/otakukitchen/155',
  0, 0,
  'Каждые 30 минут перемешивайте мороженое, чтобы не образовывались кристаллы льда.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Монолог фармацевта', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Монолог фармацевта' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Молоко'),
('Сливки 33%'),
('Мед'),
('Сухофрукты'),
('Соль'),
('Ванильный экстракт');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  500,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливки 30-35%',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мед'),
  'Мед или сахар',
  3,
  'ст.л',
  '3-4 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухофрукты'),
  'Сухофрукты (курага, изюм, цукаты)',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный экстракт'),
  'Ванильный экстракт',
  1,
  'капля',
  'по желанию'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1),
  'Подготовка основы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1),
  'Добавление аромата',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1),
  'Охлаждение',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1),
  'Подготовка сухофруктов',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1),
  'Заморозка',
  4
),
(
  (SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1),
  'Подача',
  5
);

-- Шаги (Подготовка основы)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'В кастрюле слегка подогрейте молоко и сливки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'Добавьте мед или сахар и щепотку соли. Перемешайте до растворения. Не доводите до кипения - смесь должна быть просто теплой',
  1
);

-- Шаги (Аромат)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Добавление аромата'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'По желанию добавьте ванильный экстракт - буквально одну каплю',
  0
);

-- Шаги (Охлаждение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Охлаждение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'Полностью остудите смесь до комнатной температуры',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Охлаждение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'Поставьте смесь в холодильник на 1 час',
  1
);

-- Шаги (Сухофрукты)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сухофруктов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте курагу и другие сухофрукты мелкими кусочками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сухофруктов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'При желании замочите сухофрукты в теплой воде или меде, чтобы они стали мягче',
  1
);

-- Шаги (Заморозка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Заморозка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'Вылейте молочную смесь в контейнер, добавьте сухофрукты и перемешайте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Заморозка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'Поставьте контейнер в морозилку и каждые 30 минут перемешивайте, чтобы не образовывались кристаллы льда. Повторите 5-7 раз',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'Когда мороженое станет плотным, разложите его по пиалам',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='morozhenoe_monolog.jpg' LIMIT 1) LIMIT 1),
  'Украсьте мороженое дополнительными сухофруктами сверху.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Моти',
  110,
  'hard',
  1,
  'mochi_jujutsu_kaisen.jpg',
  'https://vt.tiktok.com/ZSaPB24wY/',
  'https://t.me/otakukitchen/362',
  0, 0,
  'Не раскатывайте тесто тоньше 3-4 мм - иначе оно порвется.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Магическая битва', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Магическая битва' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Эдамаме'),
('Сахар'),
('Соль'),
('Вода'),
('Сливки 33%'),
('Сахарная пудра'),
('Мука рисовая клейкая'),
('Крахмал кукурузный'),
('Масло растительное');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1),
  'Для пасты из эдамаме (дзунда)',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1),
  'Для сливочной начинки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1),
  'Для теста моти',
  2
);

-- Ингредиенты в рецепте

-- Для пасты из эдамаме
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для пасты из эдамаме (дзунда)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Эдамаме'),
  'Эдамаме (очищенные бобы сои)',
  250,
  'г',
  '250-300 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пасты из эдамаме (дзунда)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  30,
  'г',
  '30-60 г, по вкусу'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пасты из эдамаме (дзунда)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пасты из эдамаме (дзунда)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  NULL,
  'по необходимости',
  'для нужной текстуры'
);

-- Для сливочной начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для сливочной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Жирные сливки для взбивания',
  250,
  'мл',
  'около 250 мл, холодные'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сливочной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  1,
  'ст.л',
  '1-3 ст.л'
);

-- Для теста моти
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука рисовая клейкая'),
  'Клейкая рисовая мука',
  150,
  'г',
  '150-160 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  230,
  'мл',
  'около 230 мл'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал кукурузный'),
  'Крахмал (кукурузный или картофельный)',
  NULL,
  'для раскатки',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  10,
  'мл',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1),
  'Паста из эдамаме',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1),
  'Сливочная начинка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1),
  'Приготовление теста',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1),
  'Заваривание теста на сковороде',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1),
  'Формирование моти',
  4
);

-- Шаги (Паста из эдамаме)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Паста из эдамаме'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Отварите эдамаме 10-15 минут до мягкости',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Паста из эдамаме'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Очистите остывшие бобы от тонкой кожицы - так паста получится более гладкой',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Паста из эдамаме'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Измельчите бобы в блендере до пасты, при необходимости добавляя немного воды',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Паста из эдамаме'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'В кастрюле смешайте пасту с сахаром и щепоткой соли и готовьте на медленном огне 5-7 минут',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Паста из эдамаме'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Охладите пасту',
  4
);

-- Шаги (Сливочная начинка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сливочная начинка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Взбейте холодные сливки с сахарной пудрой до мягких пиков',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сливочная начинка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Охладите начинку',
  1
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'В миске смешайте рисовую муку и сахар',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Влейте воду и растительное масло',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Перемешайте до однородности - должно получиться жидкое тесто без комков',
  2
);

-- Шаги (Заваривание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание теста на сковороде'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Перелейте тесто в холодную антипригарную сковороду и накройте крышкой',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание теста на сковороде'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Включите минимальный огонь и грейте 2 минуты под крышкой',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание теста на сковороде'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Слегка прибавьте огонь и перемешивайте силиконовой лопаткой, распределяя тесто по поверхности',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание теста на сковороде'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Сначала масса будет неоднородной, но примерно через 3-4 минуты соберется в гладкую однородную массу',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание теста на сковороде'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Выключите огонь, накройте крышкой и оставьте тесто до полного остывания',
  4
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Посыпьте рабочую поверхность крахмалом и переложите остывшее тесто. Сверху тесто тоже присыпьте крахмалом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Разделите тесто на равные кусочки примерно по 30 г',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте каждый кусочек в лепешку диаметром 8-10 см и толщиной 3-4 мм',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Положите в центр каждой лепешки пасту из эдамаме, сверху сливки и еще немного пасты',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование моти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='mochi_jujutsu_kaisen.jpg' LIMIT 1) LIMIT 1),
  'Аккуратно соберите края теста книзу и плотно закройте начинку.',
  4
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Напоритан',
  30,
  'easy',
  3,
  'naporitan_windbreaker.jpg',
  'https://vt.tiktok.com/ZSbMtXnao/',
  'https://t.me/otakukitchen/170',
  0, 0,
  'Желток в глазунье должен остаться жидким.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Ветролом', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Ветролом' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Спагетти'),
('Сосиски'),
('Перец болгарский'),
('Лук'),
('Кетчуп'),
('Соевый соус'),
('Масло сливочное'),
('Яйца'),
('Петрушка'),
('Соль'),
('Перец черный');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1),
  'Основные ингредиенты (на 2 порции)',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Спагетти'),
  'Спагетти',
  160,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  4,
  'шт',
  '4-5 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец болгарский'),
  'Болгарский перец (зеленый)',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  0.5,
  'шт',
  'по желанию'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  4,
  'ст.л',
  '4-5 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло (сливочное или растительное)',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  'для глазуньи'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Петрушка'),
  'Петрушка',
  NULL,
  'для украшения',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1),
  'Варка спагетти',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1),
  'Подготовка ингредиентов',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1),
  'Обжарка и соединение',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1),
  'Приготовление глазуньи',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1),
  'Сервировка',
  4
);

-- Шаги (Спагетти)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Отварите спагетти в подсоленной воде до готовности и слейте воду',
  0
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте сосиски под углом на кусочки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте болгарский перец кольцами, несколько колец отложите для украшения',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Мелко нарежьте лук',
  2
);

-- Шаги (Обжарка и соединение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка и соединение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте сосиски на сковороде с маслом до румяной корочки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка и соединение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Добавьте лук и перец и обжаривайте до мягкости 2-3 минуты',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка и соединение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Добавьте спагетти, кетчуп и соевый соус. Перемешайте и прогрейте 1-2 минуты',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка и соединение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Посолите и поперчите по вкусу',
  3
);

-- Шаги (Глазунья)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление глазуньи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'На отдельной сковороде пожарьте яйца глазуньей так, чтобы желток остался жидким',
  0
);

-- Шаги (Сервировка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сервировка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Выложите спагетти на тарелку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сервировка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Сверху положите глазунью, отложенные кольца перца и немного петрушки.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Напоритан',
  30,
  'medium',
  3,
  'naporitan_dlya_tebya_bessmertniy.jpg',
  'https://vt.tiktok.com/ZS4Md5fJS/',
  'https://t.me/otakukitchen/479',
  0, 0,
  'Прогревание кетчупа в сковороде делает вкус насыщеннее и убирает лишнюю кислинку.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Для тебя, Бессмертный', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Для тебя, Бессмертный' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Спагетти'),
('Сосиски'),
('Лук'),
('Перец болгарский'),
('Шампиньоны'),
('Кетчуп'),
('Томатная паста'),
('Масло сливочное'),
('Масло растительное'),
('Вода'),
('Соль'),
('Перец черный'),
('Сыр пармезан');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Спагетти'),
  'Спагетти',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Репчатый лук',
  0.5,
  'шт',
  'половина крупной луковицы'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец болгарский'),
  'Зеленый болгарский перец',
  0.5,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шампиньоны'),
  'Шампиньоны',
  100,
  'г',
  'по желанию'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  6,
  'ст.л',
  '6-7 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томатная паста'),
  'Томатная паста',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода от варки спагетти',
  50,
  'мл',
  '50-100 мл'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Черный перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр пармезан'),
  'Тертый пармезан',
  NULL,
  'для подачи',
  'по желанию'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1),
  'Варка спагетти',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1),
  'Подготовка ингредиентов',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1),
  'Приготовление соуса',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1),
  'Соединение и подача',
  3
);

-- Шаги (Спагетти)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Отварите спагетти в большом количестве подсоленной воды до состояния аль денте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Сохраните около 100 мл воды от варки',
  1
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте сосиски кружочками толщиной около 1 см',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте лук тонкими перьями, а зеленый перец длинными полосками',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Если используете шампиньоны, нарежьте их пластинками',
  2
);

-- Шаги (Соус)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте растительное масло в большой сковороде и обжарьте сосиски 2-3 минуты, пока они слегка не подрумянятся',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Добавьте лук, зеленый перец и шампиньоны. Обжаривайте еще 4-5 минут, пока лук не станет мягким',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Добавьте кетчуп и томатную пасту прямо в сковороду и готовьте 1-2 минуты, постоянно помешивая',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Влейте 50-100 мл воды от варки спагетти, добавьте соль и черный перец. Перемешайте до однородного соуса',
  3
);

-- Шаги (Соединение и подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Соединение и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Переложите в сковороду готовые спагетти и тщательно перемешайте, чтобы каждая нить покрылась соусом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Соединение и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Добавьте сливочное масло и готовьте еще 1-2 минуты, пока оно полностью не растает',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Соединение и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='naporitan_dlya_tebya_bessmertniy.jpg' LIMIT 1) LIMIT 1),
  'Подавайте сразу, выложив пасту высокой горкой. По желанию посыпьте тертым пармезаном.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Окинавская лапша',
  150,
  'hard',
  3,
  'okinava_mag_bitva.jpg',
  'https://vt.tiktok.com/ZSVxSQV25/',
  'https://t.me/otakukitchen/486',
  0, 0,
  'Рецепт рассчитан на 2 большие порции. Свиной бульон с первого этапа (около 900 мл) нужен для всех остальных этапов.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Магическая битва', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Магическая битва' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Свиная грудинка'),
('Вода'),
('Имбирь'),
('Лук зеленый'),
('Бульон свиной'),
('Соевый соус'),
('Сахар'),
('Саке'),
('Даси порошковый'),
('Соль'),
('Дайкон'),
('Лапша удон'),
('Имбирь маринованный');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Для свинины и бульона',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Для тушеной свинины',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Для супа',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Для дайкона',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Для сборки',
  4
);

-- Ингредиенты в рецепте

-- Для свинины и бульона
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Свиная грудинка'),
  'Свиная грудинка',
  400,
  'г',
  'без кости'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  1.5,
  'л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Имбирь'),
  'Свежий имбирь',
  3,
  'ломтик',
  '3-4 тонких ломтика'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук зеленый'),
  'Зеленая часть зеленого лука',
  1,
  'перо',
  '1-2 пера, по желанию'
);

-- Для тушеной свинины
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для тушеной свинины'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бульон свиной'),
  'Готовый свиной бульон',
  150,
  'мл',
  'с первого этапа'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для тушеной свинины'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  3,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для тушеной свинины'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1.5,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для тушеной свинины'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Саке'),
  'Сакэ',
  2,
  'ст.л',
  NULL
);

-- Для супа
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для супа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бульон свиной'),
  'Готовый свиной бульон',
  600,
  'мл',
  'с первого этапа'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для супа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Даси порошковый'),
  'Ajinomoto Hondashi Bonito',
  1,
  'ч.л',
  'без горки'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для супа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для супа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.5,
  'ч.л',
  'затем по вкусу'
);

-- Для дайкона
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для дайкона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Дайкон'),
  'Дайкон (белый редис)',
  100,
  'г',
  '100-120 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для дайкона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бульон свиной'),
  'Свиной бульон',
  150,
  'мл',
  'примерно 150-200 мл, с первого этапа'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для дайкона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  0.5,
  'ч.л',
  NULL
);

-- Для сборки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лапша удон'),
  'Удон',
  350,
  'г',
  '350-400 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук зеленый'),
  'Зеленый лук',
  3,
  'перо',
  '3-4 пера'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Имбирь маринованный'),
  'Красный маринованный имбирь',
  NULL,
  'немного',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Приготовление свинины и бульона',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Тушение свинины',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Приготовление дайкона',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Приготовление супа',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Варка лапши',
  4
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Подготовка лука и имбиря',
  5
),
(
  (SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1),
  'Сборка',
  6
);

-- Шаги (Свинина и бульон)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Оставьте грудинку целым куском. Положите ее в кастрюлю, залейте 1,5 л холодной воды и поставьте на сильный огонь',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'После закипания тщательно снимите всю пену. Добавьте 3-4 ломтика имбиря и, если есть, зеленую часть лука',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Убавьте огонь до слабого - бульон должен слегка побулькивать, а не активно кипеть. Прикройте крышкой и варите 1-1,5 часа',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Готовая свинина должна легко прокалываться ножом, но еще держать форму. Достаньте мясо и отложите',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Процедите бульон через мелкое сито. Если сверху очень много жира, часть снимите ложкой, но немного оставьте - он нужен для вкуса',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление свинины и бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Для остальных этапов понадобится примерно 900 мл свиного бульона',
  5
);

-- Шаги (Тушение свинины)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тушение свинины'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Когда грудинка немного остынет, нарежьте ее поперек на ломтики толщиной примерно 5-7 мм',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение свинины'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'В небольшой сотейник налейте 150 мл свиного бульона, 3 ст.л соевого соуса, 1,5 ст.л сахара и 2 ст.л сакэ. Размешайте и доведите до кипения',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение свинины'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Выложите свинину, убавьте огонь и тушите 20-30 минут, аккуратно переворачивая кусочки примерно каждые 5 минут',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение свинины'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Мясо должно стать очень мягким, блестящим, сладковато-соленым, а соус - немного увариться',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение свинины'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Не выпаривайте жидкость полностью. Оставьте свинину в небольшом количестве соуса до подачи',
  4
);

-- Шаги (Дайкон)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление дайкона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Очистите дайкон и нарежьте тонкими кружочками или полукружьями толщиной 2-3 мм',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление дайкона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Положите в небольшую кастрюлю и залейте 150-200 мл свиного бульона, чтобы редис был почти покрыт',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление дайкона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Добавьте 1/2 ч.л соевого соуса и варите на небольшом огне примерно 10-15 минут',
  2
);

-- Шаги (Суп)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление супа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Налейте в кастрюлю 600 мл свиного бульона',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление супа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Добавьте 1 ч.л Hondashi без горки, 1 ст.л соевого соуса и 1/2 ч.л соли. Хорошо размешайте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление супа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Хорошо прогрейте суп',
  2
);

-- Шаги (Лапша)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка лапши'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Отварите лапшу отдельно согласно инструкции на упаковке и хорошо слейте воду',
  0
);

-- Шаги (Лук и имбирь)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка лука и имбиря'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Мелко нарежьте 3-4 пера зеленого лука',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка лука и имбиря'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Достаньте маринованный имбирь из маринада и слегка отожмите - на каждую порцию нужна маленькая горка',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Положите в каждую миску половину лапши и залейте 350-400 мл горячего бульона',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Сверху выложите 2-3 больших ломтика свиной грудинки и несколько ломтиков мягкого дайкона',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='okinava_mag_bitva.jpg' LIMIT 1) LIMIT 1),
  'Добавьте горку зеленого лука и немного маринованного имбиря.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Оладьи',
  30,
  'medium',
  2,
  'pancakes_trigan.jpg',
  'https://vm.tiktok.com/ZMAya6Puf/',
  'https://t.me/otakukitchen/226',
  0, 0,
  'Белки взбивайте до устойчивых пиков, как для безе, и вмешивайте в тесто аккуратно.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Триган', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Триган' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Молоко'),
('Мука'),
('Сахар'),
('Соль'),
('Масло сливочное'),
('Мед');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  4,
  'шт',
  'отделить белки от желтков'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  60,
  'мл',
  '4 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  60,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  5,
  'ст.л',
  'с горкой'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  NULL,
  'для жарки и подачи',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мед'),
  'Сироп или мед',
  NULL,
  'для подачи',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1),
  'Формовка и жарка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Смешайте желтки с молоком и мукой до кремового теста',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Взбейте белки с солью, постепенно добавляя сахар, до устойчивых пиков, как для безе',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Аккуратно вмешайте белки в желтковую массу лопаткой',
  2
);

-- Шаги (Формовка и жарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формовка и жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Нагрейте сковороду и смажьте ее маслом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка и жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Выкладывайте тесто большими порциями по 2-3 ст.л, формируя толстые кружки',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка и жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Налейте вокруг каждой порции 1 ч.л воды',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка и жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Жарьте под крышкой на слабом огне 5-6 минут с одной стороны',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка и жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Аккуратно переверните и готовьте еще 3-4 минуты',
  4
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Сложите оладьи стопкой по 3-4 штуки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pancakes_trigan.jpg' LIMIT 1) LIMIT 1),
  'Полейте сверху сиропом или медом и положите кусочек масла.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Онигири',
  30,
  'easy',
  3,
  'onigiri_onepiece.jpg',
  'https://vt.tiktok.com/ZSbLsN6Xq/',
  'https://t.me/otakukitchen/153',
  0, 0,
  'У Рики в аниме онигири круглые, а не треугольные.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('One Piece', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='One Piece' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рис'),
('Вода'),
('Соль');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Японский рис (клейкий, круглозернистый)',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  200,
  'мл',
  'для варки'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода для смачивания рук',
  NULL,
  'немного',
  'смешать с солью'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1),
  'Варка риса',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1),
  'Подготовка рук',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1),
  'Формирование онигири',
  2
);

-- Шаги (Варка риса)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка риса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  'Промойте рис до прозрачной воды 2-3 раза',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка риса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  'Положите рис в кастрюлю, влейте 200 мл воды и доведите до кипения',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка риса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  'Уменьшите огонь, накройте крышкой и варите 12-15 минут',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка риса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  'Снимите с огня и оставьте под крышкой еще на 10 минут',
  3
);

-- Шаги (Подготовка рук)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка рук'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  'В мисочке смешайте немного воды и соли',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка рук'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  'Смочите руки этой смесью - так рис не будет прилипать, а онигири получатся посоленными',
  1
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование онигири'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  'Возьмите горячий рис руками, будьте осторожны',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование онигири'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  'Скатайте рис в шарик - именно такая форма у онигири Рики в аниме',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование онигири'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='onigiri_onepiece.jpg' LIMIT 1) LIMIT 1),
  'Плотно придавите, чтобы онигири держали форму, но не расплющите.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Острые сэндвичи',
  60,
  'medium',
  3,
  'ostriy_sandwich.jpg',
  'https://vm.tiktok.com/ZMAqR6XfA/',
  'https://t.me/otakukitchen/257',
  0, 0,
  'Котлеты и соус «спайси майо» можно взять готовые из магазина.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Мастера меча онлайн', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Мастера меча онлайн' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Фарш'),
('Лук'),
('Чеснок'),
('Яйца'),
('Соль'),
('Перец черный'),
('Зелень'),
('Кетчуп'),
('Соус чили'),
('Соевый соус'),
('Мед'),
('Майонез'),
('Соус шрирача');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1),
  'Для глазури',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1),
  'Для соуса «спайси майо»',
  2
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Хлеб',
  4,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фарш'),
  'Говяжий фарш',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  0.5,
  'шт',
  'мелко нарезать'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  1,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелень'),
  'Зелень или микрозелень',
  1,
  'горсть',
  NULL
);

-- Для глазури
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для глазури'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для глазури'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соус чили'),
  'Соус чили',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для глазури'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для глазури'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мед'),
  'Мед',
  0.5,
  'ч.л',
  NULL
);

-- Для соуса «спайси майо»
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса «спайси майо»'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса «спайси майо»'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соус шрирача'),
  'Соус шрирача',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1),
  'Приготовление котлет',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1),
  'Глазурь',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1),
  'Соус «спайси майо»',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1),
  'Сборка сэндвича',
  3
);

-- Шаги (Котлеты)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Смешайте фарш, лук, чеснок, яйцо, соль и перец',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Сформируйте 2 плотные котлеты',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте на масле по 3-4 минуты с каждой стороны до румяной корочки',
  2
);

-- Шаги (Глазурь)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Глазурь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Смешайте все ингредиенты для глазури',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Глазурь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Добавьте глазурь на сковороду к котлетам и прогрейте 1-2 минуты, чтобы мясо покрылось блестящей острой глазурью',
  1
);

-- Шаги (Спайси майо)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Соус «спайси майо»'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Соедините майонез, шрирачу и лимонный сок, перемешайте до однородности',
  0
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Подрумяньте хлеб',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  'На нижний ломтик выложите зелень и котлету',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ostriy_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Накройте вторым ломтиком и сверху добавьте спайси майо зигзагом.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Панини',
  15,
  'easy',
  3,
  'panini_bleach.jpg',
  'https://vt.tiktok.com/ZSbr8rA3u/',
  'https://t.me/otakukitchen/90',
  0, 0,
  'В рецепте два варианта панини: с хамоном и огурцом и с моцареллой и помидором.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Блич', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Блич' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Ветчина'),
('Листья салата'),
('Огурец'),
('Майонез'),
('Помидор'),
('Моцарелла');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1),
  'Для панини с хамоном',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1),
  'Для панини с моцареллой',
  1
);

-- Ингредиенты в рецепте

-- Для панини с хамоном
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Чиабатта или кусок багета',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'Хамон или ветчина',
  2,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  2,
  'лист',
  '2-3 листа: айсберг, романо или латук'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Огурец'),
  'Огурец',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез или песто',
  1,
  'ст.л',
  NULL
);

-- Для панини с моцареллой
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с моцареллой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Чиабатта или кусок багета',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с моцареллой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидор'),
  'Помидор',
  3,
  'ломтик',
  '3-4 ломтика'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с моцареллой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Моцарелла',
  2,
  'ломтик',
  '2-3 ломтика'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с моцареллой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  2,
  'лист',
  '2-3 листа'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для панини с моцареллой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  1,
  'ст.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1),
  'Панини с хамоном',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1),
  'Панини с моцареллой',
  1
);

-- Шаги (Панини с хамоном)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте чиабатту пополам и смажьте майонезом или песто',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  'Выложите салат, огурец и хамон или ветчину',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  'Накройте верхней частью хлеба и слегка прижмите',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду-гриль или пресс для панини',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Панини с хамоном'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  'Обжаривайте 3-4 минуты, пока хлеб не станет хрустящим',
  4
);

-- Шаги (Панини с моцареллой)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Панини с моцареллой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте чиабатту пополам и смажьте майонезом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Панини с моцареллой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  'Выложите салат, помидоры и моцареллу',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Панини с моцареллой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  'Закройте сэндвич и слегка прижмите',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Панини с моцареллой'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='panini_bleach.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду-гриль и обжаривайте 3-4 минуты.',
  3
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Пахлава',
  45,
  'medium',
  1,
  'pahlava.jpg',
  'https://vt.tiktok.com/ZSbrFLFpE/',
  'https://t.me/otakukitchen/123',
  0, 0,
  'Поливайте пахлаву медовым сиропом, пока она еще горячая.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Лазарь', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Лазарь' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Тесто слоеное бездрожжевое'),
('Масло сливочное'),
('Орехи'),
('Мед'),
('Яйца'),
('Молоко'),
('Вода');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тесто слоеное бездрожжевое'),
  'Слоеное бездрожжевое тесто',
  250,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Орехи'),
  'Орехи (фисташки или любые другие)',
  150,
  'г',
  '150-200 г, немного оставить для посыпки'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мед'),
  'Мед',
  4,
  'ст.л',
  '4-6 ст.л, часть для сиропа'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Желток',
  1,
  'шт',
  'для смазывания'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  NULL,
  'немного',
  'для смазывания, смешать с желтком'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Кипяток',
  NULL,
  'немного',
  'для медового сиропа'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1),
  'Приготовление начинки',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1),
  'Формирование трубочек',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1),
  'Нарезка',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1),
  'Смазывание',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1),
  'Выпекание',
  4
),
(
  (SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1),
  'Финальный штрих',
  5
);

-- Шаги (Начинка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Измельчите орехи, немного отложите для посыпки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Растопите сливочное масло и смешайте с орехами',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Добавьте мед и перемешайте до однородности, немного меда оставьте для сиропа',
  2
);

-- Шаги (Трубочки)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование трубочек'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте тесто и разрежьте на 3 полоски',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование трубочек'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Выложите начинку по центру каждой полоски',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование трубочек'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Защипните края, чтобы получились трубочки',
  2
);

-- Шаги (Нарезка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Нарезка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Сложите все 3 трубочки вместе и нарежьте на кубики',
  0
);

-- Шаги (Смазывание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Смазывание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Смешайте желток с молоком и смажьте пахлаву сверху',
  0
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте при 200°C около 20 минут до золотистой корочки',
  0
);

-- Шаги (Финальный штрих)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте немного меда с кипятком - получится теплый сироп',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Полейте сиропом горячую пахлаву',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pahlava.jpg' LIMIT 1) LIMIT 1),
  'Посыпьте сверху отложенными орехами.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Печенье',
  60,
  'medium',
  1,
  'biscuits_blackbutler.jpg',
  'https://vm.tiktok.com/ZMAffskCc/',
  'https://t.me/otakukitchen/229',
  0, 0,
  'Для печенья в форме косточек понадобится соответствующая формочка.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Темный дворецкий', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Темный дворецкий' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло сливочное'),
('Сахар'),
('Яйца'),
('Мука'),
('Ванильный сахар'),
('Соль');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло сливочное',
  100,
  'г',
  'комнатной температуры'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар или экстракт',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1),
  'Охлаждение',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1),
  'Формовка',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1),
  'Выпекание',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'В миске взбейте масло с сахаром до кремовой массы',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Добавьте яйцо и ваниль, перемешайте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Постепенно всыпьте муку с солью и замесите мягкое тесто',
  2
);

-- Шаги (Охлаждение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Охлаждение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Заверните тесто в пленку и уберите в холодильник на 30 минут',
  0
);

-- Шаги (Формовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте тесто толщиной 5 мм',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Вырежьте формочкой печенье в виде "косточек"',
  1
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Выложите печенье на противень с пергаментом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте при 180°C около 10-12 минут, до золотистого края.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Печенье',
  35,
  'medium',
  1,
  'biscuits_akame.jpg',
  'https://vt.tiktok.com/ZSbrYH2r4/',
  'https://t.me/otakukitchen/164',
  0, 0,
  'Тесто очень тугое - отсаживать его из мешка непросто, понадобится сила.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Убийца Акаме', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Убийца Акаме' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло сливочное'),
('Сахарная пудра'),
('Ванильный сахар'),
('Соль'),
('Яйца'),
('Мука'),
('Разрыхлитель'),
('Джем');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1),
  'Для начинки',
  1
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  120,
  'г',
  'комнатной температуры'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  60,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар',
  10,
  'г',
  '10-12 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Пшеничная мука',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  0.5,
  'ч.л',
  'по желанию'
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Джем'),
  'Повидло, варенье или джем (густой)',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1),
  'Подготовка мешков',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1),
  'Формирование печенья',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1),
  'Выпекание',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Взбейте мягкое масло миксером, пока оно не побелеет',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Всыпьте сахарную пудру и ванильный сахар и взбивайте до однородной кремовой массы',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Добавьте щепотку соли, вбейте яйцо и еще раз взбейте',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Просейте муку с разрыхлителем и замесите мягкое тесто',
  3
);

-- Шаги (Мешки)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка мешков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Переложите тесто в кондитерский мешок с насадкой "звезда"',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка мешков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Переложите варенье в другой мешок или в обычный пакет с надрезанным уголком',
  1
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование печенья'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Отсадите печенье на противень с пергаментом на расстоянии 3-4 см друг от друга',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование печенья'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Сделайте в каждом печенье небольшое углубление пальцем или ложкой и выдавите туда варенье',
  1
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте в разогретой до 190°C духовке 10 минут до легкого румянца',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='biscuits_akame.jpg' LIMIT 1) LIMIT 1),
  'Пока печенье теплое, можно добавить в серединки еще немного джема.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Пицца',
  110,
  'medium',
  3,
  'pizza_hanako.jpg',
  'https://vm.tiktok.com/ZMAm79hRL/',
  'https://t.me/otakukitchen/237',
  0, 0,
  'Если нет готового теста, его можно замесить самостоятельно - с подъемом это займет около часа.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Туалетный мальчик Ханако', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Туалетный мальчик Ханако' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Тесто для пиццы готовое'),
('Мука'),
('Вода'),
('Дрожжи сухие'),
('Сахар'),
('Соль'),
('Масло оливковое'),
('Томатная паста'),
('Орегано сушеный'),
('Базилик сушеный'),
('Перец черный'),
('Моцарелла'),
('Салями');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Для основы (покупное тесто)',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Для теста (если нет покупного)',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Для соуса',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Для начинки',
  3
);

-- Ингредиенты в рецепте

-- Для основы (покупное тесто)
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы (покупное тесто)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тесто для пиццы готовое'),
  'Готовое тесто для пиццы',
  300,
  'г',
  '300-350 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы (покупное тесто)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  NULL,
  'немного',
  'для присыпки'
);

-- Для теста (если нет покупного)
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода теплая',
  180,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Дрожжи сухие'),
  'Дрожжи сухие',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  2,
  'ст.л',
  NULL
);

-- Для соуса
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томатная паста'),
  'Томатная паста',
  3,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Орегано сушеный'),
  'Сушеный орегано',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Базилик сушеный'),
  'Сушеный базилик',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Сыр моцарелла (тертый), чеддер',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Салями'),
  'Салями',
  100,
  'г',
  '100-120 г, тонкие кружочки'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Приготовление теста (если нет покупного)',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Приготовление соуса',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Подготовка основы',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Сборка',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Выпекание',
  4
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1),
  'Подача',
  5
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'В теплой воде растворите дрожжи и сахар, оставьте на 10 минут до появления пены',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'В миске смешайте муку и соль, влейте дрожжевую воду и масло',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Замесите мягкое тесто',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Накройте и оставьте в теплом месте на 1 час',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста (если нет покупного)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'После подъема используйте тесто как основу для пиццы',
  4
);

-- Шаги (Соус)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Смешайте томатную пасту, масло, орегано, базилик, сахар, щепотку соли и перец',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Прогрейте соус 2-3 минуты на сковороде или в сотейнике',
  1
);

-- Шаги (Основа)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте тесто на присыпанной мукой поверхности и вырежьте круг',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Переложите основу на противень, застеленный пергаментом',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Смажьте основу томатным соусом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Посыпьте сыром и выложите кружочки салями',
  1
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Запекайте в разогретой до 220°C духовке 10-12 минут до золотистой корочки',
  0
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_hanako.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте пиццу на треугольники и подавайте.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Пицца',
  45,
  'medium',
  3,
  'pizza_code.jpg',
  'https://vt.tiktok.com/ZSbrY1wJM/',
  'https://t.me/otakukitchen/140',
  0, 0,
  'Сосиски в тесте расставьте вертикально по краю вплотную друг к другу - так получится бортик.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Код Гиас', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Код Гиас' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Тесто для пиццы готовое'),
('Сосиски'),
('Тесто слоеное бездрожжевое'),
('Кетчуп'),
('Майонез'),
('Моцарелла'),
('Говядина'),
('Ветчина'),
('Брокколи'),
('Нори');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1),
  'Для основы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1),
  'Для бортика',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1),
  'Для начинки',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1),
  'Для топпинга',
  3
);

-- Ингредиенты в рецепте

-- Для основы
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тесто для пиццы готовое'),
  'Готовое тесто для пиццы',
  1,
  'круг',
  'или домашнее'
);

-- Для бортика
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для бортика'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Маленькие сосиски',
  10,
  'шт',
  '10-12 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для бортика'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тесто слоеное бездрожжевое'),
  'Дополнительное тесто (слоеное или для пиццы)',
  NULL,
  'для обертывания сосисок',
  NULL
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  2,
  'ст.л',
  '2-3 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  2,
  'ст.л',
  '2-3 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Тертый сыр (моцарелла, чеддер или смесь)',
  150,
  'г',
  NULL
);

-- Для топпинга
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для топпинга'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говядина'),
  'Жареная говядина',
  80,
  'г',
  'ломтиками'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для топпинга'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'Ветчина или тунец',
  50,
  'г',
  'кусочками'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для топпинга'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Брокколи'),
  'Брокколи',
  4,
  'соцветие',
  '4-5 мелких отварных соцветий'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для топпинга'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Нори'),
  'Нори',
  1,
  'лист',
  'нарезать полосками'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1),
  'Подготовка сосисок',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1),
  'Подготовка пиццы',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1),
  'Топпинг',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1),
  'Выпечка',
  3
);

-- Шаги (Сосиски)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосисок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте сосиски пополам',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосисок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте дополнительное тесто полосками шириной около 2 см',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосисок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Оберните каждую половинку сосиски полоской теста - по спирали или полностью',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сосисок'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Расставьте их вертикально по краю основы вплотную друг к другу и слегка вдавите, чтобы зафиксировать',
  3
);

-- Шаги (Пицца)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка пиццы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Смешайте кетчуп с майонезом и смажьте середину основы',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка пиццы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Равномерно посыпьте тертым сыром',
  1
);

-- Шаги (Топпинг)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Топпинг'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Разложите по поверхности кусочки говядины и ветчину или тунец',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Топпинг'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Добавьте соцветия брокколи и полоски нори',
  1
);

-- Шаги (Выпечка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте духовку до 180°C',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_code.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте 20-25 минут, пока корочка не станет золотистой, а сыр не расплавится.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Пицца-тосты',
  15,
  'easy',
  3,
  'pizza_toasts.jpg',
  'https://vt.tiktok.com/ZSVjThtVc/',
  'https://t.me/otakukitchen/484',
  0, 0,
  'Духовку нужно разогреть до максимальной температуры — тосты пекутся всего несколько минут.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Готовка с Валькириями', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Готовка с Валькириями' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Бекон'),
('Сыр чеддер'),
('Перец болгарский'),
('Лук'),
('Томатная паста');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1),
  'Основные ингредиенты (на 2 порции)',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1),
  'Дополнительно',
  1
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Тостовый хлеб',
  2,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бекон'),
  'Бекон',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр чеддер'),
  'Чеддер или моцарелла',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец болгарский'),
  'Красный болгарский перец',
  NULL,
  'несколько колечек',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец болгарский'),
  'Зелёный болгарский перец',
  NULL,
  'несколько колечек',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Репчатый лук',
  20,
  'г',
  NULL
);

-- Дополнительно
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Дополнительно'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томатная паста'),
  'Томатная паста',
  15,
  'г',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1),
  'Подготовка',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1),
  'Сборка тостов',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1),
  'Выпекание',
  2
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте духовку до максимальной температуры',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте лук соломкой, а красный и зелёный перец — тонкими кольцами',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  'Застелите противень фольгой',
  2
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка тостов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  'Смажьте каждый ломтик хлеба тонким слоем томатной пасты',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка тостов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  'Посыпьте хлеб примерно третью натёртого сыра',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка тостов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  'Выложите сверху лук и оба вида перца',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка тостов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  'Накройте овощи ломтиками бекона',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка тостов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  'Посыпьте оставшимся сыром',
  4
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='pizza_toasts.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте 2-5 минут, пока сыр полностью не расплавится.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Пончики',
  150,
  'hard',
  1,
  'ponchiki_hanako.jpg',
  'https://vt.tiktok.com/ZSbLbmTdm/',
  'https://t.me/otakukitchen/62',
  0, 0,
  'Нагрейте масло, выключите огонь и подождите 5 минут перед жаркой — так пончики не будут гореть.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Туалетный мальчик Ханако', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Туалетный мальчик Ханако' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Сахар'),
('Яйца'),
('Дрожжи сухие'),
('Масло сливочное'),
('Молоко'),
('Соль'),
('Ванильный сахар');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  640,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  60,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  'комнатной температуры'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Дрожжи сухие'),
  'Сухие дрожжи',
  14,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  90,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко 3,2%',
  250,
  'мл',
  'еле тёплое'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  'Подготовка ингредиентов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  'Замес теста',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  'Вымешивание',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  'Подъём теста',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  'Формовка пончиков',
  4
),
(
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  'Второй подъём',
  5
),
(
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  'Жарка',
  6
),
(
  (SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1),
  'Остывание',
  7
);

-- Шаги (Подготовка ингредиентов)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Растопите сливочное масло и дайте ему немного остыть',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Слегка подогрейте молоко — оно должно быть тёплым, но не горячим',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Просейте муку через сито',
  2
);

-- Шаги (Замес теста)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Замес теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'В чашу миксера или большую ёмкость влейте жидкие ингредиенты: тёплое молоко, растопленное сливочное масло и яйца',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Замес теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Добавьте сахар, ванильный сахар, щепотку соли и сухие дрожжи',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Замес теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Всыпьте муку в два приёма',
  2
);

-- Шаги (Вымешивание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Вымешивание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Замешивайте тесто в комбайне 5-8 минут на малой скорости, пока оно не станет однородным и не перестанет липнуть к рукам',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Вымешивание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Если месите руками, сначала перемешайте ингредиенты ложкой, затем выложите тесто на стол и вымешивайте 15 минут',
  1
);

-- Шаги (Подъём теста)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подъём теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Накройте миску с тестом пищевой плёнкой и оставьте в тёплом месте на 1 час',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подъём теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Если не уверены, где тёплое место: разогрейте духовку до 200°C в течение 1 минуты (без противня, режим верх-низ), выключите и поставьте туда тесто на противне на 1 час',
  1
);

-- Шаги (Формовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формовка пончиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте тесто в пласт толщиной 1 см',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка пончиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Вырежьте кружочки диаметром не более 9 см кулинарным кольцом или стаканом',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка пончиков'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Сделайте дырочки в центре пробкой или насадкой от кондитерского мешка',
  2
);

-- Шаги (Второй подъём)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Второй подъём'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Переложите заготовки на противень с пергаментом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Второй подъём'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Дайте им постоять, чтобы они снова поднялись',
  1
);

-- Шаги (Жарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте растительное масло в сковороде, выключите огонь и подождите 5 минут — так пончики не будут гореть',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Выложите 3-4 пончика и обжаривайте до золотистого цвета с одной стороны',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Переверните и подрумяньте с другой стороны — она прожаривается быстрее',
  2
);

-- Шаги (Остывание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Остывание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Выложите готовые пончики на бумажные полотенца, чтобы убрать лишний жир',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Остывание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ponchiki_hanako.jpg' LIMIT 1) LIMIT 1),
  'Дайте пончикам полностью остыть.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Потофе с сосисками',
  65,
  'medium',
  3,
  'potofe_s_sosiskami.jpg',
  'https://vt.tiktok.com/ZSbLuxyQC/',
  'https://t.me/otakukitchen/209',
  0, 0,
  'Перед подачей не забудьте вынуть лавровый лист.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Кулинарные скитания в параллельном мире', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Кулинарные скитания в параллельном мире' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Сосиски'),
('Картофель'),
('Морковь'),
('Лук'),
('Капуста'),
('Бекон'),
('Чеснок'),
('Вода'),
('Лавровый лист'),
('Соль'),
('Перец черный'),
('Масло сливочное');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  3,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Капуста'),
  'Капуста',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бекон'),
  'Бекон',
  100,
  'г',
  'толстые куски'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  2,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  1,
  'л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лавровый лист'),
  'Лавровый лист',
  1,
  'шт',
  '1-2 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  NULL,
  'по желанию',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1),
  'Подготовка ингредиентов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1),
  'Обжарка бекона',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1),
  'Сборка супа',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1),
  'Добавление капусты',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1),
  'Финальные штрихи',
  4
);

-- Шаги (Подготовка ингредиентов)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Очистите картофель, морковь и лук',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Картофель разрежьте на 4 части, морковь — крупными шайбами, лук — на четвертинки',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Капусту порвите руками на крупные куски',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Бекон нарежьте брусками',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Чеснок раздавите плоской стороной ножа',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Сосиски оставьте целыми или слегка надрежьте по диагонали',
  5
);

-- Шаги (Обжарка бекона)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка бекона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'В глубокой кастрюле без масла немного обжарьте бекон до лёгкой корочки, чтобы вытопился жир',
  0
);

-- Шаги (Сборка супа)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка супа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Добавьте в кастрюлю воду, картофель, морковь, лук, лавровый лист, чеснок и сосиски',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка супа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Варите на среднем огне около 30 минут под крышкой',
  1
);

-- Шаги (Капуста)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Добавление капусты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Добавьте капусту и варите ещё 10-15 минут, пока всё не станет мягким',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Добавление капусты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Посолите и поперчите по вкусу',
  1
);

-- Шаги (Финальные штрихи)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Финальные штрихи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'Выньте лавровый лист',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Финальные штрихи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potofe_s_sosiskami.jpg' LIMIT 1) LIMIT 1),
  'По желанию добавьте небольшой кусочек сливочного масла для насыщенности.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Рагу',
  80,
  'medium',
  3,
  'ragu_ataka_titanov.jpg',
  'https://vt.tiktok.com/ZSbLGbTUU/',
  'https://t.me/otakukitchen/159',
  0, 0,
  'Зелёный горошек добавляйте в самом конце, всего на 2-3 минуты.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Атака титанов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Атака титанов' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Лук'),
('Морковь'),
('Картофель'),
('Сельдерей'),
('Свинина'),
('Горошек зеленый замороженный'),
('Вода'),
('Томатная паста'),
('Лавровый лист'),
('Соль'),
('Перец черный'),
('Бульон мясной гранулированный'),
('Масло растительное');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  'крупная'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  1,
  'шт',
  'крупный'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сельдерей'),
  'Стебель сельдерея',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Свинина'),
  'Свинина (отбивная)',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Горошек зеленый замороженный'),
  'Замороженный зелёный горошек',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  1,
  'л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томатная паста'),
  'Томатная паста',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лавровый лист'),
  'Лавровый лист',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бульон мясной гранулированный'),
  'Гранулированный мясной бульон',
  3,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  NULL,
  'для жарки',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1),
  'Обжарка мяса',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1),
  'Приготовление основы',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1),
  'Тушение',
  2
);

-- Шаги (Обжарка мяса)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте свинину кубиками, приправьте солью и перцем',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте масло в кастрюле с толстым дном и обжарьте мясо до золотистой корочки',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  'Выньте мясо и отложите в сторону',
  2
);

-- Шаги (Основа)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте лук полукольцами и обжарьте на том же масле до мягкости',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  'Верните мясо в кастрюлю, добавьте томатную пасту и лавровый лист. Обжаривайте 5 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  'Влейте воду, добавьте бульон и доведите до кипения',
  2
);

-- Шаги (Тушение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  'Накройте крышкой и тушите свинину около 30 минут',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  'Добавьте морковь, картофель и сельдерей и тушите ещё 20-30 минут, пока всё не станет мягким',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_ataka_titanov.jpg' LIMIT 1) LIMIT 1),
  'В конце добавьте зелёный горошек и готовьте ещё 2-3 минуты.',
  2
);
-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Рагу из кролика',
  90,
  'medium',
  4,
  'ragu_krolik.jpg',
  'https://vt.tiktok.com/ZSbLpQXbn/',
  'https://t.me/otakukitchen/156',
  0, 0,
  'Подавайте рагу горячим в глубокой миске.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Мастера меча онлайн', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Мастера меча онлайн' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Филе кролика'),
('Лук'),
('Капуста'),
('Картофель'),
('Помидор'),
('Петрушка'),
('Соль'),
('Перец черный'),
('Масло оливковое');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Филе кролика'),
  'Филе кролика',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  2,
  'шт',
  '2-3 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Капуста'),
  'Капуста',
  0.5,
  'кочан',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  2,
  'шт',
  '2-3 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидор'),
  'Помидоры',
  1,
  'шт',
  '1-2 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Петрушка'),
  'Петрушка',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  NULL,
  'для жарки',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1),
  'Подготовка ингредиентов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1),
  'Обжарка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1),
  'Тушение',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1),
  'Финальный штрих',
  3
);

-- Шаги (Подготовка ингредиентов)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте мясо средними кубиками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Очистите лук и нарежьте полукольцами',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте картофель и помидоры крупными кусками',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Капусту нашинкуйте или порвите руками',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Подготовьте зелень и специи по вкусу',
  4
);

-- Шаги (Обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте немного масла в глубокой кастрюле или казане',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте мясо до золотистой корочки со всех сторон',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Добавьте лук и жарьте до мягкости',
  2
);

-- Шаги (Тушение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Добавьте картофель, помидоры и капусту',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Влейте воду или мясной бульон так, чтобы жидкость покрывала все ингредиенты',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Посолите и поперчите',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Уменьшите огонь и тушите под крышкой 30-40 минут, пока мясо и овощи не станут мягкими',
  3
);

-- Шаги (Финальный штрих)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'За 5 минут до готовности добавьте зелень',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Попробуйте на вкус и при необходимости добавьте специй',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='ragu_krolik.jpg' LIMIT 1) LIMIT 1),
  'Подавайте горячим в глубокой миске.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Рис по-китайски',
  20,
  'easy',
  3,
  'chinese_rice.jpg',
  'https://vt.tiktok.com/ZSbMnfuJ3/',
  'https://t.me/otakukitchen/33',
  0, 0,
  'Для этого блюда нужен уже сваренный рис.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Монстр за соседней партой', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Монстр за соседней партой' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рис'),
('Ветчина'),
('Лук зеленый'),
('Яйца'),
('Соевый соус'),
('Соль'),
('Перец черный'),
('Горошек зеленый');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Рис варёный',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'Ветчина',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук зеленый'),
  'Зелёный лук',
  2,
  'перо',
  '2-3 пера'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  'ст.л',
  '1-2 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Горошек зеленый'),
  'Зелёный горошек',
  NULL,
  'для украшения',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1),
  'Подготовка ингредиентов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1),
  'Жарка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте ветчину небольшими кубиками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  'Мелко нарежьте зелёный лук',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  'В миске слегка взбейте яйца до однородности',
  2
);

-- Шаги (Жарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду на среднем огне, влейте взбитые яйца и дайте им слегка схватиться',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  'Добавьте ветчину и зелёный лук, перемешайте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  'Выложите на сковороду варёный рис, полейте соевым соусом, посолите и поперчите по вкусу. Хорошо перемешайте',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  'Жарьте 2-3 минуты, пока рис полностью не прогреется и не пропитается ароматами',
  3
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chinese_rice.jpg' LIMIT 1) LIMIT 1),
  'Переложите блюдо горкой на тарелку и посыпьте сверху зелёным горошком.',
  0
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Рис с грибами',
  80,
  'medium',
  3,
  'rice_with_mushrooms.jpg',
  'https://vt.tiktok.com/ZSVsTgLru/',
  'https://t.me/otakukitchen/487',
  0, 0,
  'Рис можно приготовить в мультиварке или в обычной кастрюле — выберите один из двух способов.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Моя подруга-олениха Нокотан', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Моя подруга-олениха Нокотан' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рис'),
('Грибы симэдзи'),
('Грибы шиитаке'),
('Даси порошковый'),
('Соевый соус'),
('Мирин'),
('Саке'),
('Сахар'),
('Соль'),
('Вода');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1),
  'Основные ингредиенты (на 3-4 порции)',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Японский круглозёрный рис',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Грибы симэдзи'),
  'Грибы симэдзи',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Грибы шиитаке'),
  'Грибы шиитаке',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Даси порошковый'),
  'Рыбный бульон хондаси',
  1,
  'ч.л',
  'без горки'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мирин'),
  'Мирин',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Саке'),
  'Сакэ',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  0.5,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.25,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 3-4 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  380,
  'мл',
  'около 380 мл'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1),
  'Подготовка риса',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1),
  'Приготовление заливки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1),
  'Приготовление в мультиварке',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1),
  'Приготовление в обычной кастрюле',
  3
);

-- Шаги (Подготовка риса)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка риса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Хорошо промойте рис и замочите в холодной воде на 30 минут',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка риса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Полностью слейте воду',
  1
);

-- Шаги (Заливка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление заливки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'В мерном стакане смешайте хондаси, соевый соус, мирин, сакэ, сахар и соль',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление заливки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Добавьте воды, чтобы всего получилось примерно 400 мл жидкости',
  1
);

-- Шаги (Мультиварка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в мультиварке'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Переложите рис в чашу мультиварки и залейте смесью. Один раз аккуратно перемешайте и разровняйте рис',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в мультиварке'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Выложите сверху симэдзи и нарезанные шиитаке. Не перемешивайте грибы с рисом — они должны лежать сверху',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в мультиварке'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Закройте мультиварку и выберите программу «Рис» или «Крупы» на 30 минут',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в мультиварке'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'После окончания программы не открывайте сразу — оставьте на подогреве или под закрытой крышкой ещё на 10 минут',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в мультиварке'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Откройте и аккуратно перемешайте лопаткой снизу вверх, распределяя грибы по рису',
  4
);

-- Шаги (Кастрюля)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в обычной кастрюле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Переложите рис в кастрюлю с толстым дном и залейте смесью. Один раз аккуратно перемешайте и разровняйте рис',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в обычной кастрюле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Выложите сверху симэдзи и нарезанные шиитаке. Не перемешивайте грибы с рисом — они должны оставаться сверху',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в обычной кастрюле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Накройте крышкой и доведите до кипения на среднем огне. Как только жидкость закипит, сразу убавьте огонь до самого слабого',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в обычной кастрюле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Готовьте под закрытой крышкой примерно 12-15 минут. Не открывайте крышку и не перемешивайте рис',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в обычной кастрюле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Выключите огонь и оставьте под закрытой крышкой ещё на 10-15 минут, чтобы рис дошёл на пару',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление в обычной кастрюле'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_mushrooms.jpg' LIMIT 1) LIMIT 1),
  'Откройте крышку и аккуратно перемешайте рис лопаткой снизу вверх, равномерно распределяя грибы.',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Рис с чаем',
  35,
  'medium',
  3,
  'rice_with_tea.jpg',
  'https://vt.tiktok.com/ZSbLnkNQA/',
  'https://t.me/otakukitchen/191',
  0, 0,
  'Не нарезайте лист нори целиком — получится слишком много.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Великий из бродячих псов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Великий из бродячих псов' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рис'),
('Куриное филе'),
('Вода'),
('Нори'),
('Лук зеленый'),
('Хлопья бонито'),
('Маринованная слива');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Варёный рис',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриное филе'),
  'Куриная грудка',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Горячая вода',
  300,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Нори'),
  'Нори',
  1,
  'лист',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук зеленый'),
  'Зелёный лук',
  1,
  'стебель',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлопья бонито'),
  'Стружка тунца бонито',
  5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Маринованная слива'),
  'Маринованная слива',
  NULL,
  'по желанию',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1),
  'Варка риса',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1),
  'Приготовление бульона',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1),
  'Подготовка лука и нори',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1),
  'Приготовление курицы',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1),
  'Сборка',
  4
);

-- Шаги (Рис)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка риса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Отварите рис согласно инструкции на упаковке',
  0
);

-- Шаги (Бульон)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Залейте стружку тунца 300 мл горячей воды и дайте настояться 10-15 минут — это будет ароматный бульон',
  0
);

-- Шаги (Лук и нори)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка лука и нори'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Мелко нарежьте зелёный лук',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка лука и нори'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте часть листа нори тонкими полосками — весь лист резать не нужно',
  1
);

-- Шаги (Курица)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте куриную грудку небольшими кусочками размером с орех, посолите и поперчите',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте на сковороде с 1 ч.л масла по 1 минуте с каждой стороны',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление курицы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Накройте крышкой и готовьте ещё 5 минут',
  2
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Выложите горячий рис в тарелку, сверху — курицу и по желанию маринованную сливу',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Посыпьте зелёным луком и залейте тёплым бульоном из тунца',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='rice_with_tea.jpg' LIMIT 1) LIMIT 1),
  'Украсьте соломкой из нори.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Салат Капрезе',
  10,
  'easy',
  3,
  'salat_capreze.jpg',
  'https://vt.tiktok.com/ZSbLuhQLY/',
  'https://t.me/otakukitchen/177',
  0, 0,
  'Бальзамического уксуса нужно буквально несколько капель.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Невероятное приключение ДжоДжо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Невероятное приключение ДжоДжо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Моцарелла'),
('Помидор'),
('Базилик'),
('Масло оливковое'),
('Лимонный сок'),
('Перец черный'),
('Бальзамический уксус'),
('Соевый соус'),
('Морские водоросли'),
('Хлеб'),
('Листья салата');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1),
  'Для заправки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1),
  'Для украшения',
  2
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Моцарелла',
  4,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидор'),
  'Помидоры',
  5,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Базилик'),
  'Листья свежего базилика',
  2,
  'шт',
  'для украшения'
);

-- Для заправки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для заправки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  1.5,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для заправки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонный сок',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для заправки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для заправки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бальзамический уксус'),
  'Бальзамический уксус',
  NULL,
  'несколько капель',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для заправки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  0.5,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для заправки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морские водоросли'),
  'Измельчённые морские водоросли',
  1,
  'щепотка',
  'например, вакаме или нори'
);

-- Для украшения
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Белый хлеб',
  2,
  'ломтик',
  '2-3 ломтика, обжаренный или подсушенный'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  NULL,
  'для подачи',
  'ромэн или айсберг'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1),
  'Сборка салата',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1),
  'Приготовление заправки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Сборка салата)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка салата'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте помидоры и моцареллу кольцами',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка салата'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  'Выложите их на тарелку, чередуя: помидор, затем моцарелла',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка салата'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  'На первый ломтик помидора положите листики базилика',
  2
);

-- Шаги (Заправка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление заправки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  'Смешайте все ингредиенты для заправки и тщательно перемешайте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление заправки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  'Полейте салат заправкой сверху',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='salat_capreze.jpg' LIMIT 1) LIMIT 1),
  'Украсьте салат листьями салата и ломтиками хлеба сбоку.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сконы',
  35,
  'medium',
  1,
  'skony_hanako.jpg',
  'https://vt.tiktok.com/ZSbLbp8oE/',
  'https://t.me/otakukitchen/143',
  0, 0,
  'Сливочное масло для теста должно быть холодным.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Туалетный мальчик Ханако', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Туалетный мальчик Ханако' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло сливочное'),
('Сахар'),
('Цедра лимона'),
('Мука'),
('Разрыхлитель'),
('Яйца'),
('Молоко');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло 82,5%',
  70,
  'г',
  'холодное'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  70,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Цедра лимона'),
  'Цедра лимона или лайма',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  240,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  7,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  55,
  'мл',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1),
  'Подготовка теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1),
  'Формирование сконов',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1),
  'Выпечка',
  2
);

-- Шаги (Подготовка теста)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  'В миске соедините холодное сливочное масло, сахар и цедру лимона или лайма. Перемешайте, чтобы цедра отдала аромат сахару и маслу',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  'Добавьте муку, разрыхлитель и яйцо. Перемешайте до состояния крошки',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  'Влейте молоко и замесите тесто до однородности. Тесто должно быть мягким, но не липким',
  2
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование сконов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте тесто на посыпанной мукой поверхности до толщины около 2 см',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование сконов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  'Вырежьте круглые заготовки вырубкой или стаканом',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование сконов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  'Выложите сконы на противень, застеленный пергаментной бумагой',
  2
);

-- Шаги (Выпечка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  'Смажьте верх сконов взбитым яйцом для золотистой корочки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='skony_hanako.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте в разогретой до 180°C духовке (режим верх-низ) до румяной корочки, примерно 12-15 минут.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сливочный суп',
  65,
  'medium',
  3,
  'soup_ariette.jpg',
  'https://vt.tiktok.com/ZSbrFHTeL/',
  'https://t.me/otakukitchen/124',
  0, 0,
  'Чем больше бульона вы добавите к соусу бешамель, тем менее сливочным получится суп.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Ариэтти из страны лилипутов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Ариэтти из страны лилипутов' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Чеснок'),
('Имбирь'),
('Морковь'),
('Картофель'),
('Брокколи'),
('Бульон овощной'),
('Саке'),
('Соевый соус'),
('Петрушка'),
('Масло растительное'),
('Масло сливочное'),
('Мука'),
('Соль'),
('Мускатный орех'),
('Молоко');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1),
  'Для овощной основы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1),
  'Для соуса бешамель',
  1
);

-- Ингредиенты в рецепте

-- Для овощной основы
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для овощной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  2,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для овощной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Имбирь'),
  'Свежий корень имбиря',
  2,
  'см',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для овощной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Большая морковь',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для овощной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для овощной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Брокколи'),
  'Брокколи',
  0.5,
  'кочан',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для овощной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бульон овощной'),
  'Овощной бульон',
  2,
  'стакан',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для овощной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Саке'),
  'Сакэ (или сухое белое вино)',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для овощной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для овощной основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Петрушка'),
  'Петрушка',
  NULL,
  'несколько листочков',
  NULL
);

-- Для соуса бешамель
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло без запаха',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  'большая щепотка'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мускатный орех'),
  'Мускатный орех',
  1,
  'щепотка',
  'маленькая щепотка'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  250,
  'мл',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1),
  'Подготовка овощей',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1),
  'Варка овощей',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1),
  'Приготовление соуса бешамель',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1),
  'Соединение',
  3
);

-- Шаги (Подготовка овощей)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Раздавите чеснок. Так же раздавите имбирь — руками или плоской стороной ножа',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Очистите морковь и картофель и разрежьте на четвертинки',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Разделите брокколи на соцветия',
  2
);

-- Шаги (Варка овощей)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Налейте бульон в большую кастрюлю, выложите овощи, добавьте сакэ или вино и соевый соус',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Хорошо перемешайте и варите под крышкой на среднем огне 45 минут',
  1
);

-- Шаги (Бешамель)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Пока овощи варятся, нагрейте в сотейнике сливочное и растительное масло',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Добавьте муку, хорошо перемешайте и готовьте ещё 1,5 минуты, чтобы она не слиплась',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Когда появится выраженный сладковатый аромат, снимите сотейник с огня',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса бешамель'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Влейте молоко, посолите, добавьте мускатный орех и перемешайте',
  3
);

-- Шаги (Соединение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Соединение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Когда овощи станут мягкими, выньте их шумовкой',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Соединение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_ariette.jpg' LIMIT 1) LIMIT 1),
  'Поставьте сотейник с бешамелем на средний огонь и смешайте его с бульоном в желаемой пропорции.',
  1
);

-- Рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Семья шпиона' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Картофель'),
('Сосиски'),
('Лук'),
('Масло растительное'),
('Соль'),
('Перец черный'),
('Тимьян');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  500,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  4,
  'шт',
  '4-5 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт',
  'крупная головка'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  NULL,
  'для картошки и жарки',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  NULL,
  'по вкусу',
  'для картофеля'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тимьян'),
  'Свежий тимьян',
  4,
  'веточка',
  '4-6 веточек'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1),
  'Запекание картофеля',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1),
  'Лук и сосиски',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1),
  'Соединение',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Картофель)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Запекание картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  'Очистите картофель и нарежьте крупными кусочками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Запекание картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  'Перемешайте картофель с растительным маслом, солью, чёрным перцем и паприкой',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Запекание картофеля'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  'Выложите на противень и запекайте в разогретой до 180°C духовке 30-40 минут до мягкости и лёгкой золотистой корочки',
  2
);

-- Шаги (Лук и сосиски)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Лук и сосиски'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  'Пока картофель запекается, нарежьте лук крупными полукольцами',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Лук и сосиски'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте на сковороде немного масла и обжарьте лук до золотистого цвета',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Лук и сосиски'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте сосиски кусочками, добавьте к луку и обжаривайте 3-5 минут',
  2
);

-- Шаги (Соединение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Соединение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  'Добавьте запечённый картофель в сковороду к сосискам и луку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Соединение'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  'Перемешайте, добавьте веточки тимьяна и обжаривайте ещё 3-5 минут на среднем огне',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='potat0_spufamily.jpg' LIMIT 1) LIMIT 1),
  'Подавайте горячим прямо в сковороде или переложите на тарелку.',
  0
);
-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Спагетти Болоньезе',
  40,
  'medium',
  3,
  'spagetti_porkorosso.jpg',
  'https://vt.tiktok.com/ZSbrdG6Dr/',
  'https://t.me/otakukitchen/13',
  0, 0,
  'Если соус получается слишком густым, добавьте ещё немного воды.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Порко Россо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Порко Россо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Лук'),
('Морковь'),
('Фарш'),
('Соус болоньезе'),
('Вода'),
('Спагетти');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фарш'),
  'Фарш (свиной или говяжий)',
  400,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соус болоньезе'),
  'Соус болоньезе',
  5,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  100,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Спагетти'),
  'Спагетти',
  0.5,
  'пачка',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1),
  'Подготовка овощей',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1),
  'Обжарка овощей и фарша',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1),
  'Тушение соуса',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1),
  'Приготовление спагетти',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1),
  'Смешивание и подача',
  4
);

-- Шаги (Овощи)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Очистите лук и морковь',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Лук мелко нарежьте, а морковь натрите на тёрке или нарежьте небольшими кубиками',
  1
);

-- Шаги (Обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка овощей и фарша'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'На разогретой сковороде с небольшим количеством масла обжарьте лук и морковь 3-5 минут на среднем огне, пока они не станут мягкими и золотистыми',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка овощей и фарша'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Добавьте фарш и обжаривайте, помешивая, пока он не изменит цвет и не станет рассыпчатым',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка овощей и фарша'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Разбивайте фарш на небольшие кусочки, чтобы соус получился однородным',
  2
);

-- Шаги (Тушение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тушение соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Влейте в сковороду соус болоньезе и воду, перемешайте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тушение соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Убавьте огонь до слабого, накройте крышкой и тушите примерно 10-15 минут',
  1
);

-- Шаги (Спагетти)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Пока готовится соус, отварите спагетти в подсоленной воде до состояния аль денте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Слейте воду, но немного оставьте для соуса — так блюдо станет насыщеннее',
  1
);

-- Шаги (Смешивание и подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Смешивание и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Выложите спагетти в сковороду с соусом и хорошо перемешайте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Смешивание и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Оставьте на огне ещё на минуту, чтобы спагетти впитали соус',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Смешивание и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='spagetti_porkorosso.jpg' LIMIT 1) LIMIT 1),
  'Выложите на тарелку и по желанию посыпьте тёртым сыром и свежей зеленью.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Стейк',
  45,
  'medium',
  4,
  'steak_bluelock.jpg',
  'https://vt.tiktok.com/ZSbr1JfLS/',
  'https://t.me/otakukitchen/32',
  0, 0,
  'Перед нарезкой дайте стейку отдохнуть под фольгой 10 минут.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Синяя тюрьма', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Синяя тюрьма' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Говяжий стейк'),
('Масло растительное'),
('Чеснок'),
('Тимьян'),
('Соль'),
('Перец черный'),
('Морковь'),
('Картофель'),
('Масло сливочное');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говяжий стейк'),
  'Стейк из говядины',
  NULL,
  'шт',
  'количество в оригинале не указано'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  NULL,
  'для жарки',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  2,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тимьян'),
  'Тимьян',
  3,
  'веточка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картошка',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  2,
  'ст.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1),
  'Подготовка',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1),
  'Приготовление стейка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1),
  'Приготовление овощей',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Хорошо посолите и поперчите стейк с обеих сторон',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте морковь толстыми кружками',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте картошку на 4 части',
  2
);

-- Шаги (Стейк)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление стейка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду с растительным маслом на сильном огне, пока она не станет очень горячей',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление стейка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Положите стейк на сковороду и обжаривайте около 3 минут с каждой стороны до золотистой корочки',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление стейка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Добавьте крупно нарезанный чеснок, веточки тимьяна и сливочное масло. Около минуты поливайте стейк маслом',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление стейка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Переложите стейк на тарелку и накройте фольгой на 10 минут, чтобы он отдохнул',
  3
);

-- Шаги (Овощи)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'В той же сковороде обжарьте морковь и картошку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Готовьте, пока овощи не станут мягкими внутри и хрустящими снаружи',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Приправьте солью и перцем',
  2
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте стейк поперёк волокон',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Разложите на тарелке вместе с овощами',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='steak_bluelock.jpg' LIMIT 1) LIMIT 1),
  'Подавайте сразу, пока горячее.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Суп',
  120,
  'hard',
  3,
  'soup_monolog.jpg',
  'https://vm.tiktok.com/ZMAguXpNH/',
  'https://t.me/otakukitchen/265',
  0, 0,
  'Белковая «шапка» собирает все примеси — благодаря ей бульон получается прозрачным.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Монолог фармацевта', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Монолог фармацевта' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Куриные крылышки'),
('Фарш'),
('Морковь'),
('Лук'),
('Сельдерей'),
('Помидор'),
('Соль'),
('Петрушка'),
('Яйца'),
('Вода');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриные крылышки'),
  'Куриные крылышки или бёдра',
  500,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фарш'),
  'Говяжий фарш (или куриный)',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сельдерей'),
  'Сельдерей',
  1,
  'стебель',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидор'),
  'Томаты',
  1,
  'шт',
  'по желанию, для цвета'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Петрушка'),
  'Петрушка или лук-резанец',
  NULL,
  'для украшения',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яичный белок',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  1.5,
  'л',
  '1,5-2 л'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1),
  'Приготовление основы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1),
  'Процеживание',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1),
  'Осветление фаршем',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1),
  'Финальная фильтрация',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1),
  'Подача',
  4
);

-- Шаги (Основа)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  'Налейте в кастрюлю воду, добавьте курицу, овощи и немного соли',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  'Доведите до кипения и варите на слабом огне около 1 часа',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление основы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  'Снимайте пенку, чтобы бульон оставался чистым',
  2
);

-- Шаги (Процеживание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Процеживание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  'Процедите бульон через сито или марлю — понадобится только жидкость',
  0
);

-- Шаги (Осветление фаршем)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Осветление фаршем'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  'В миске смешайте фарш, яичные белки и мелко нарезанные лук и морковь',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Осветление фаршем'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  'Добавьте смесь в остывший бульон и медленно нагревайте, постоянно помешивая',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Осветление фаршем'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  'Когда белок свернётся, он поднимет все примеси наверх и образует «шапку»',
  2
);

-- Шаги (Финальная фильтрация)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Финальная фильтрация'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  'Осторожно сделайте отверстие в «шапке» и процедите бульон через марлю или фильтр',
  0
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_monolog.jpg' LIMIT 1) LIMIT 1),
  'Перелейте суп в чистую пиалу и украсьте зеленью.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Суп',
  55,
  'medium',
  3,
  'soup_vinlandsaga.jpg',
  'https://vt.tiktok.com/ZSbreL9P2/',
  'https://t.me/otakukitchen/50',
  0, 0,
  'Вместо кролика можно взять куриное филе бедра, а жирность сливок выбрать на свой вкус.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Сага о Винланде', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Сага о Винланде' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло сливочное'),
('Лук'),
('Лук красный'),
('Куриные бедра'),
('Картофель'),
('Морковь'),
('Фасоль стручковая'),
('Капуста'),
('Вода'),
('Сливки'),
('Соль'),
('Перец черный');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  NULL,
  'для обжарки',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Репчатый лук',
  0.5,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук красный'),
  'Красный лук',
  0.5,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриные бедра'),
  'Куриное филе бедра (или мясо кролика)',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  2,
  'шт',
  'очистить и нарезать кубиками'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  'нарезать кубиками'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фасоль стручковая'),
  'Стручковая фасоль',
  5,
  'стручок',
  'нарезать'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Капуста'),
  'Капуста',
  NULL,
  'несколько листов',
  'по вкусу'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  300,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки'),
  'Сливки',
  200,
  'мл',
  'примерно 200-250 мл, жирность на ваш вкус'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1),
  'Обжарка',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1),
  'Варка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1),
  'Заправка сливками',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  'Растопите сливочное масло в кастрюле',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  'Добавьте нарезанный репчатый и красный лук и обжаривайте, пока он не станет мягким и прозрачным',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  'Положите кусочки кролика или куриного филе и обжарьте до лёгкой румяности',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  'Добавьте картофель, морковь и фасоль, перемешайте и немного обжарьте',
  3
);

-- Шаги (Варка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  'Влейте 300 мл воды и варите на среднем огне, пока овощи не станут мягкими',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  'Добавьте нашинкованную капусту и варите ещё 5-7 минут',
  1
);

-- Шаги (Сливки)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Заправка сливками'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  'Влейте сливки, добавьте соль и перец по вкусу и перемешайте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Заправка сливками'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  'Оставьте на слабом огне ещё на 5-10 минут',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_vinlandsaga.jpg' LIMIT 1) LIMIT 1),
  'Снимите с огня, дайте супу немного настояться и подавайте.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Суп со свининой',
  40,
  'medium',
  3,
  'soup_windbreaker.jpg',
  'https://vt.tiktok.com/ZSbMt5va4/',
  'https://t.me/otakukitchen/133',
  0, 0,
  'Мисо пасту сначала разведите в небольшом количестве бульона и только потом верните в кастрюлю.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Ветролом', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Ветролом' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Свинина'),
('Морковь'),
('Картофель'),
('Лук'),
('Грибы'),
('Паста мисо'),
('Соевый соус'),
('Сахар'),
('Вода'),
('Лук зеленый');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Свинина'),
  'Свинина',
  200,
  'г',
  '200-300 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Грибы'),
  'Грибы (вешенки, шиитаке или любые другие)',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Паста мисо'),
  'Мисо паста',
  2,
  'ст.л',
  '2-3 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'ч.л',
  'по желанию'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  1,
  'л',
  '1-1,2 л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук зеленый'),
  'Зелёный лук',
  NULL,
  'для подачи',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1),
  'Подготовка ингредиентов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1),
  'Обжарка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1),
  'Варка',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1),
  'Заправка мисо',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1),
  'Подача',
  4
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка ингредиентов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте мясо и овощи на удобные куски',
  0
);

-- Шаги (Обжарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'В кастрюле немного обжарьте свинину до побеления',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Добавьте овощи и грибы и обжаривайте пару минут',
  1
);

-- Шаги (Варка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Залейте водой и доведите до кипения',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Варите 15-20 минут, пока овощи не станут мягкими',
  1
);

-- Шаги (Мисо)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Заправка мисо'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Зачерпните немного бульона, разведите в нём мисо пасту и верните в кастрюлю',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Заправка мисо'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Добавьте соевый соус и по желанию сахар',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_windbreaker.jpg' LIMIT 1) LIMIT 1),
  'Подавайте суп горячим, посыпав зелёным луком.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сэндвич Асуны',
  90,
  'medium',
  3,
  'sandwich_asuna.jpg',
  'https://vt.tiktok.com/ZSbLg3rYS/',
  'https://t.me/otakukitchen/53',
  0, 0,
  'Мясо нужно мариновать в холодильнике 1 час.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Мастера меча онлайн', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Мастера меча онлайн' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Говяжий стейк'),
('Чеснок'),
('Соль'),
('Перец черный'),
('Имбирь'),
('Соус терияки'),
('Яйца'),
('Масло оливковое'),
('Листья салата'),
('Майонез'),
('Гранат'),
('Хлеб');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1),
  'Для мяса',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1),
  'Для сборки',
  1
);

-- Ингредиенты в рецепте

-- Для мяса
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говяжий стейк'),
  'Говяжий стейк',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  2,
  'зубчик',
  '2-3 зубчика, мелко нарубить'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Имбирь'),
  'Имбирь',
  0.25,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соус терияки'),
  'Соус терияки',
  150,
  'мл',
  NULL
);

-- Для сборки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  'на каждый сэндвич'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья шпината или салата',
  6,
  'лист',
  '6-8 крупных листьев'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Гранат'),
  'Зёрна граната',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Багет',
  1,
  'шт',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1),
  'Маринование мяса',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1),
  'Жарка стейка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1),
  'Жарка яйца',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1),
  'Сборка сэндвича',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1),
  'Финальный штрих',
  4
);

-- Шаги (Маринование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Маринование мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'Положите стейк в ёмкость, добавьте чеснок, соль, перец по вкусу и соус терияки',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Маринование мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'Хорошо распределите маринад по мясу и уберите в холодильник на 1 час',
  1
);

-- Шаги (Стейк)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка стейка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте большую сковороду на сильном огне',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка стейка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'Жарьте стейк 3 минуты с одной стороны, затем переверните и готовьте ещё 2 минуты с другой',
  1
);

-- Шаги (Яйцо)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка яйца'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'Разбейте яйцо на сковороду и пожарьте',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка яйца'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'Если хотите прожаренный желток, переверните яйцо',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте половину багета вдоль',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'Смажьте каждую половинку майонезом изнутри',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'На нижнюю половину выложите по порядку: зелень, яйцо, 1 ст.л зёрен граната и ломтики стейка',
  2
);

-- Шаги (Финальный штрих)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_asuna.jpg' LIMIT 1) LIMIT 1),
  'Накройте второй половиной багета и заверните сэндвич в пергамент.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сэндвич',
  NULL, -- время приготовления не указано, заполните при необходимости
  'easy',
  3,
  'sandwich_tokyo_ghoul.jpg',
  'https://vt.tiktok.com/ZSbMnWu4g/',
  'https://t.me/otakukitchen/91',
  0, 0,
  'Сэндвич разрезают по диагонали, чтобы получились треугольники.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Токийский гуль', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Токийский гуль' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло сливочное'),
('Листья салата'),
('Ветчина'),
('Сыр'),
('Хлеб');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Лист салата',
  1,
  'лист',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'Ветчина',
  1,
  'ломтик',
  '1-2 ломтика'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр'),
  'Сыр (квадратный)',
  1,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Тостовый хлеб',
  2,
  'ломтик',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1),
  'Подготовка хлеба',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1),
  'Сборка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Хлеб)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка хлеба'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  'Обрежьте корочки у хлеба',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка хлеба'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  'Смажьте один ломтик хлеба сливочным маслом',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  'Выложите сверху лист салата, затем ветчину и сыр',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  'Накройте вторым ломтиком хлеба',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_tokyo_ghoul.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте сэндвич по диагонали, чтобы получились треугольники.',
  0
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сэндвич Нанами',
  20,
  'easy',
  3,
  'nanami_sandwich.jpg',
  'https://vt.tiktok.com/ZSbMp6CM6/',
  'https://t.me/otakukitchen/44',
  0, 0,
  'Верхнюю половинку багета смазывают яйцом и посыпают кунжутом — так она получается румяной и хрустящей.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Магическая битва', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Магическая битва' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Масло сливочное'),
('Чеснок'),
('Перец черный'),
('Соль'),
('Горчица'),
('Зелень'),
('Лимонный сок'),
('Прошутто'),
('Сыр бри'),
('Яйца'),
('Кунжутные семена');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Багет',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  50,
  'г',
  'мягкое'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  1,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Горчица'),
  'Горчица',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелень'),
  'Смесь зелени',
  1,
  'горсть',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонный сок',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Прошутто'),
  'Прошутто или хамон',
  4,
  'ломтик',
  '4-5 тонких ломтиков'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр бри'),
  'Сыр бри',
  4,
  'ломтик',
  '4-5 ломтиков'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кунжутные семена'),
  'Кунжутные семена',
  1,
  'ст.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1),
  'Чесночное масло',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1),
  'Зелёная смесь',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1),
  'Подготовка багета',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1),
  'Сборка сэндвича',
  3
);

-- Шаги (Чесночное масло)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Чесночное масло'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Добавьте в мягкое сливочное масло измельчённый чеснок, немного соли, перца и горчицу',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Чесночное масло'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Тщательно перемешайте до однородности',
  1
);

-- Шаги (Зелёная смесь)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Зелёная смесь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'В миске соедините смесь зелени с лимонным соком, солью и перцем',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Зелёная смесь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Перемешайте, чтобы зелень пропиталась заправкой',
  1
);

-- Шаги (Багет)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка багета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте багет пополам вдоль',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка багета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Слегка смажьте верхнюю половинку взбитым яйцом и посыпьте кунжутом',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка багета'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Отправьте в разогретую до 190°C духовку на 5 минут, пока багет слегка не подрумянится и не станет хрустящим',
  2
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Намажьте чесночное масло на обе половинки багета',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Выложите на одну половинку зелёную смесь',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Сверху разложите ломтики прошутто или хамона и сыра бри',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='nanami_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Накройте второй половинкой багета.',
  3
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сэндвич Цеппели',
  10,
  'easy',
  3,
  'cepeli_jojo.jpg',
  'https://vt.tiktok.com/ZSbL4FgUG/',
  'https://t.me/otakukitchen/168',
  0, 0,
  'Для красивого разреза выбирайте сыр без дырок.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Невероятные приключение ДжоДжо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Невероятные приключение ДжоДжо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Сыр'),
('Ветчина'),
('Листья салата'),
('Майонез');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Белый тостовый хлеб',
  4,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр'),
  'Сыр',
  2,
  'ломтик',
  'например, гауда или чеддер, без дырок'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'Ветчина',
  2,
  'ломтик',
  '2-4 ломтика, лучше тонко нарезанная'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листовой салат',
  2,
  'лист',
  'латук, айсберг или романо'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  1,
  'ч.л',
  '1-2 ч.л на сэндвич'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1),
  'Подготовка хлеба',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1),
  'Сборка сэндвича',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Подготовка хлеба)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка хлеба'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  'Намажьте одну сторону каждого ломтика хлеба тонким слоем майонеза',
  0
);

-- Шаги (Сборка сэндвича)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  'На один ломтик выложите по очереди салат, ломтик сыра и ветчину',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  'Накройте вторым ломтиком хлеба намазанной стороной внутрь',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  'Слегка придавите сэндвич ладонью',
  2
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='cepeli_jojo.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте сэндвич по диагонали, чтобы получилось два треугольника.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сэндвичи',
  25,
  'easy',
  3,
  'sandwich_kon.jpg',
  'https://vt.tiktok.com/ZSVeveUxa/',
  'https://t.me/otakukitchen/483',
  0, 0,
  'Срежьте корочки хлеба, чтобы сэндвичи получились аккуратными.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('K-On!', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='K-On!' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Сыр'),
('Ветчина'),
('Масло сливочное'),
('Хлеб'),
('Листья салата'),
('Яйца'),
('Майонез'),
('Соль'),
('Перец черный'),
('Помидоры черри'),
('Петрушка');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1),
  'Для сэндвичей с сыром и ветчиной',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1),
  'Для яичных сэндвичей',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1),
  'Для подачи',
  2
);

-- Ингредиенты в рецепте

-- Для сэндвичей с сыром и ветчиной
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для сэндвичей с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр'),
  'Сыр',
  4,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сэндвичей с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'Ветчина',
  4,
  'ломтик',
  'тонкие ломтики'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сэндвичей с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сэндвичей с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Белый тостовый хлеб',
  4,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сэндвичей с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  4,
  'лист',
  NULL
);

-- Для яичных сэндвичей
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для яичных сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для яичных сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  2,
  'ст.л',
  '2-4 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для яичных сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Белый тостовый хлеб',
  8,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для яичных сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'Ветчина',
  4,
  'ломтик',
  'тонкие ломтики'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для яичных сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для яичных сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Чёрный перец',
  NULL,
  'по вкусу',
  NULL
);

-- Для подачи
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для подачи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидоры черри'),
  'Помидоры черри',
  NULL,
  'по желанию',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для подачи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Петрушка'),
  'Петрушка или салатная зелень',
  NULL,
  'по желанию',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1),
  'Сэндвичи с сыром и ветчиной',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1),
  'Яичные сэндвичи',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Сэндвичи с сыром и ветчиной)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сэндвичи с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Смажьте сливочным маслом 2 ломтика тостового хлеба',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сэндвичи с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'На один ломтик положите лист салата, ветчину и ломтик сыра',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сэндвичи с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Накройте вторым ломтиком хлеба',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Сэндвичи с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Срежьте корочки хлеба и лишние края листа салата',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Сэндвичи с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте сэндвич по диагонали на два треугольника',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Сэндвичи с сыром и ветчиной'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Повторите с оставшимися двумя ломтиками хлеба',
  5
);

-- Шаги (Яичные сэндвичи)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Яичные сэндвичи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Разбейте яйца в миску, добавьте соль и перец, взбейте венчиком',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Яичные сэндвичи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Вылейте смесь на сковороду и обжарьте яичный блинчик 3-5 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Яичные сэндвичи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Срежьте корочки у хлеба и смажьте два ломтика майонезом',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Яичные сэндвичи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Выложите на хлеб кусочек яичного блинчика, сверху — ветчину, и накройте вторым ломтиком хлеба',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Яичные сэндвичи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Повторите с оставшимися ломтиками хлеба',
  4
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Разложите треугольные и квадратные сэндвичи на большом блюде',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='sandwich_kon.jpg' LIMIT 1) LIMIT 1),
  'Добавьте помидоры черри и веточки зелени.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Тайяки',
  25,
  'medium',
  1,
  'tayaki_hero_academia.jpg',
  'https://vt.tiktok.com/ZSbLqSdu7/',
  'https://t.me/otakukitchen/95',
  0, 0,
  'Заполняйте ячейки формы тестом на 2/3, чтобы рыбки не вытекали за края.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Моя геройская академия', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Моя геройская академия' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Разрыхлитель'),
('Сахар'),
('Соль'),
('Яйца'),
('Молоко'),
('Масло сливочное'),
('Шоколад');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Пшеничная мука',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  40,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  2,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко или вода',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  40,
  'г',
  'или 2 ст.л растительного масла'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколад'),
  'Шоколад',
  NULL,
  'для начинки',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1),
  'Выпекание',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'В миске смешайте муку, разрыхлитель, сахар и соль',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'В отдельной ёмкости взбейте яйцо, добавьте молоко (или воду) и растопленное сливочное масло (или растительное)',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Постепенно влейте жидкие ингредиенты в сухие, тщательно перемешивая, чтобы не было комков',
  2
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте форму для тайяки и смажьте её маслом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Влейте тесто в ячейки, заполняя их на 2/3',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'В центр каждой рыбки положите кусочек шоколада',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Переворачивайте рыбку, чтобы она прожарилась равномерно с обеих сторон',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Жарьте, пока тайяки не станут золотистыми и полностью не пропекутся, обычно 3-4 минуты',
  4
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Подавайте тёплыми. По желанию посыпьте сахарной пудрой или полейте шоколадным соусом.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Тайяки с клубникой',
  35,
  'medium',
  1,
  'tayaki_medalistka.jpg',
  'https://vt.tiktok.com/ZSbr2xTtR/',
  'https://t.me/otakukitchen/178',
  0, 0,
  'Перед тем как разрезать рыбок, дайте им немного остыть.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Медалистка', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Медалистка' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Разрыхлитель'),
('Сахар'),
('Соль'),
('Яйца'),
('Молоко'),
('Масло сливочное'),
('Шоколадная паста'),
('Клубника'),
('Сливки взбитые');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1),
  'Для начинки и украшения',
  1
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Пшеничная мука',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  40,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  2,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко или вода',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло (растопленное)',
  40,
  'г',
  'или 2 ст.л растительного масла'
);

-- Для начинки и украшения
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки и украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколадная паста'),
  'Нутелла (или любой шоколадный крем)',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки и украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника'),
  'Свежая клубника',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки и украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки взбитые'),
  'Взбитые сливки (готовые или домашние)',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1),
  'Подготовка теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1),
  'Выпечка',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1),
  'Сборка десерта',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  'В миске смешайте муку, разрыхлитель, сахар и соль',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  'В другой ёмкости взбейте яйцо, добавьте молоко и растопленное масло',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  'Постепенно соедините обе смеси и перемешайте до однородности',
  2
);

-- Шаги (Выпечка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте форму для тайяки в виде рыбок и смажьте её маслом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  'Вылейте тесто в форму, заполняя её на 2/3',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  'Жарьте до золотистой корочки по 3-4 минуты с каждой стороны',
  2
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка десерта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  'Дайте рыбкам немного остыть, затем аккуратно разрежьте вдоль',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка десерта'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  'Щедро смажьте внутри нутеллой, добавьте взбитые сливки и половинки клубники',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tayaki_medalistka.jpg' LIMIT 1) LIMIT 1),
  'Уложите рыбок на тарелку и украсьте сверху клубникой, сливками и по желанию капелькой нутеллы.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Томатная брускетта',
  20,
  'easy',
  3,
  'tomatni_sandwich.jpg',
  'https://vm.tiktok.com/ZMACq2CHq/',
  'https://t.me/otakukitchen/250',
  0, 0,
  'Натирайте хлеб чесноком, пока он ещё горячий.'
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Томатная брускетта',
  20,
  'easy',
  3,
  'tomatni_sandwich.jpg',
  'https://vm.tiktok.com/ZMACq2CHq/',
  'https://t.me/otakukitchen/250',
  0, 0,
  'Натирайте хлеб чесноком, пока он еще горячий.'
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Томатная брускетта',
  20,
  'easy',
  3,
  'tomatnaya_brusketta_jojo.jpg',
  'https://vm.tiktok.com/ZMACq2CHq/',
  'https://t.me/otakukitchen/250',
  0, 0,
  'Натирайте хлеб чесноком, пока он еще горячий.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Невероятные приключение ДжоДжо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Невероятные приключение ДжоДжо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Помидор'),
('Перец болгарский'),
('Моцарелла'),
('Чеснок'),
('Базилик'),
('Масло оливковое'),
('Соль'),
('Перец черный'),
('Бальзамический уксус');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Багет или чиабатта',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидор'),
  'Помидоры спелые',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец болгарский'),
  'Болгарский перец',
  1,
  'шт',
  'Половина красного и половина зеленого'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Моцарелла',
  100,
  'г',
  '100-120 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  1,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Базилик'),
  'Базилик свежий',
  NULL,
  'несколько листиков',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  2,
  'ст.л',
  '2-3 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Черный перец',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бальзамический уксус'),
  'Бальзамический уксус',
  0.5,
  'ч.л',
  'по желанию'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1),
  'Подрумянивание хлеба',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1),
  'Ароматная основа',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1),
  'Овощная смесь',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1),
  'Сборка',
  3
);

-- Шаги (Хлеб)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подрумянивание хлеба'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте багет ломтиками толщиной примерно 1,5 см',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подрумянивание хлеба'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  'Поджарьте ломтики в духовке или на сухой сковороде до золотистой корочки',
  1
);

-- Шаги (Ароматная основа)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Ароматная основа'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  'Пока хлеб горячий, натрите его чесноком и сбрызните оливковым маслом',
  0
);

-- Шаги (Овощная смесь)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Овощная смесь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте помидоры и перец мелкими кубиками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Овощная смесь'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  'Добавьте соль, перец и немного масла. По желанию капните бальзамического уксуса для легкой кислинки',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  'Выложите на каждый ломтик хлеба овощную смесь и кусочек сыра',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatnaya_brusketta_jojo.jpg' LIMIT 1) LIMIT 1),
  'Украсьте листиком базилика.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Томатный сэндвич',
  15,
  'easy',
  2,
  'tomatni_sandwich.jpg',
  'https://vm.tiktok.com/ZMAVLFCWm/',
  'https://t.me/otakukitchen/256',
  0, 0,
  'Промокните помидоры бумажным полотенцем, чтобы они не размочили хлеб.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Завтрашний Джо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Завтрашний Джо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Помидор'),
('Яйца'),
('Масло сливочное'),
('Майонез'),
('Соль');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Хлеб',
  4,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидор'),
  'Помидор средний',
  1,
  'шт',
  'Спелый, но плотный'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло сливочное',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  2,
  'ст.л',
  '2-3 ст.л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло для жарки',
  NULL,
  'немного',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1),
  'Приготовление яичной начинки',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1),
  'Подготовка хлеба',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1),
  'Подготовка помидоров',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1),
  'Сборка сэндвича',
  3
);

-- Шаги (Яичная начинка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление яичной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Отварите яйца вкрутую (7-8 минут), остудите и очистите',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление яичной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Разомните яйца вилкой, добавьте майонез и немного соли',
  1
);

-- Шаги (Хлеб)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка хлеба'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Смажьте каждый ломтик хлеба сливочным маслом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка хлеба'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Если хотите теплый вариант, слегка обжарьте хлеб на сухой сковороде или в тостере',
  1
);

-- Шаги (Помидоры)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка помидоров'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Нарежьте помидор тонкими кружочками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка помидоров'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Промокните кружочки бумажным полотенцем, чтобы помидоры не размочили хлеб',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  'На один ломтик выложите слой яичной смеси, затем помидоры и накройте вторым ломтиком',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвича'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tomatni_sandwich.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте сэндвич по диагонали.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Тост Денджи',
  10,
  'easy',
  1,
  'toast_dendzhi.jpg',
  'https://vm.tiktok.com/ZMApuhP2P/',
  'https://t.me/otakukitchen/266',
  0, 0,
  'Джем намазывается слоями: сначала клубничный, затем черничный и апельсиновый.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Человек-бензопила', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title = 'Человек-бензопила' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Джем клубничный'),
('Джем черничный'),
('Джем апельсиновый'),
('Масло сливочное'),
('Мед'),
('Корица');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте
-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Хлеб'),
  'Тостовый хлеб',
  2,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Джем клубничный'),
  'Клубничный джем',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Джем черничный'),
  'Черничный джем',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Джем апельсиновый'),
  'Апельсиновый джем',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Масло сливочное'),
  'Сливочное масло',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Мед'),
  'Мёд цветочный',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Корица'),
  'Корица',
  5,
  'г',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1),
  'Подготовка хлеба',
  0
),
(
  (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1),
  'Слои джема',
  1
),
(
  (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1),
  'Финальный штрих',
  2
);

-- Шаги (Хлеб)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Подготовка хлеба'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  'Поджарьте хлеб в тостере или на сухой сковороде до золотистой корочки',
  0
);

-- Шаги (Джем)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Слои джема'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  'Намажьте тосты слоями: сначала клубничный джем, затем черничный и апельсиновый',
  0
);

-- Шаги (Финальный штрих)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Финальный штрих'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  'Сверху полейте мёдом и посыпьте корицей',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Финальный штрих'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'toast_dendzhi.jpg' LIMIT 1)
   LIMIT 1),
  'Добавьте кусочек сливочного масла.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Удон с жареным яйцом',
  20,
  'easy',
  3,
  'udon_demon_slayer.jpg',
  'https://vt.tiktok.com/ZSqQYbBF3/',
  'https://t.me/otakukitchen/499',
  0, 0,
  'В оригинале сверху кладут тороро из японского ямса нагаймо, но его сложно найти, поэтому здесь более доступная версия с жареным яйцом.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Клинок, рассекающий демонов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title = 'Клинок, рассекающий демонов' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Лапша удон'),
('Яйца'),
('Лук зеленый'),
('Нори'),
('Васаби'),
('Соевый соус'),
('Мирин'),
('Даси'),
('Сахар');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1),
  'Основные ингредиенты (на 1 порцию)',
  0
);

-- Ингредиенты в рецепте
-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 1 порцию)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Лапша удон'),
  'Удон',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 1 порцию)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 1 порцию)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Лук зеленый'),
  'Зелёный лук',
  1,
  'стебель',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 1 порцию)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Нори'),
  'Нори',
  0.5,
  'лист',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 1 порцию)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Васаби'),
  'Васаби',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 1 порцию)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Соевый соус'),
  'Соевый соус',
  1.5,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 1 порцию)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Мирин'),
  'Мирин',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 1 порцию)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Даси'),
  'Даси или вода',
  70,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 1 порцию)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Сахар'),
  'Сахар',
  0.5,
  'ч.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1),
  'Варка удона',
  0
),
(
  (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1),
  'Приготовление соуса',
  1
),
(
  (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1),
  'Жарка яйца',
  2
),
(
  (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1),
  'Сборка',
  3
);

-- Шаги (Удон)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Варка удона'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  'Отварите удон по инструкции на упаковке',
  0
);

-- Шаги (Соус)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Приготовление соуса'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  'Смешайте даси или воду, соевый соус, мирин и сахар',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Приготовление соуса'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  'Немного прогрейте, чтобы сахар полностью растворился',
  1
);

-- Шаги (Яйцо)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Жарка яйца'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  'Обжарьте яйцо глазуньей на небольшом огне. Белок должен полностью приготовиться, а желток лучше оставить жидким',
  0
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Сборка'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  'Выложите удон в глубокую миску и полейте соусом',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Сборка'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  'Сверху положите жареное яйцо',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Сборка'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'udon_demon_slayer.jpg' LIMIT 1)
   LIMIT 1),
  'Добавьте нарезанный зелёный лук, полоски нори и немного васаби.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Французские тосты',
  20,
  'easy',
  1,
  'french_toasts_velikolepniy.jpg',
  'https://vt.tiktok.com/ZSqTGdPKF/',
  'https://t.me/otakukitchen/501',
  0, 0,
  'Хлеб должен хорошо пропитаться смесью, но не начать разваливаться.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Великолепный кондитер', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title = 'Великолепный кондитер' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Яйца'),
('Молоко'),
('Сахар'),
('Ванильный сахар'),
('Масло сливочное'),
('Мед');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1),
  'Основные ингредиенты (на 2 порции)',
  0
);

-- Ингредиенты в рецепте
-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 2 порции)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Хлеб'),
  'Белый тостовый хлеб',
  4,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 2 порции)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 2 порции)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Молоко'),
  'Молоко',
  120,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 2 порции)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Сахар'),
  'Сахар',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 2 порции)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Ванильный сахар'),
  'Ванильный сахар',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 2 порции)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Масло сливочное'),
  'Сливочное масло',
  15,
  'г',
  '15-20 г'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title = 'Основные ингредиенты (на 2 порции)'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Мед'),
  'Мёд, кленовый сироп или карамельный соус',
  NULL,
  'для подачи',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1),
  'Приготовление яично-молочной смеси',
  0
),
(
  (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1),
  'Пропитка хлеба',
  1
),
(
  (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1),
  'Жарка',
  2
),
(
  (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Смесь)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Приготовление яично-молочной смеси'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  'В глубокой тарелке взбейте яйца с молоком, сахаром и ванильным сахаром',
  0
);

-- Шаги (Пропитка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Пропитка хлеба'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  'Опустите каждый ломтик хлеба в яично-молочную смесь на несколько секунд с каждой стороны',
  0
);

-- Шаги (Жарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Жарка'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  'Растопите сливочное масло на сковороде',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Жарка'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  'Жарьте тосты на среднем огне примерно 2-3 минуты с каждой стороны до красивой золотистой корочки',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title = 'Подача'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'french_toasts_velikolepniy.jpg' LIMIT 1)
   LIMIT 1),
  'Выложите тосты на тарелку и щедро полейте сверху мёдом, кленовым сиропом или карамельным соусом.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Фурикаке Гохан',
  270,
  'medium',
  4,
  'furikake_gohan.gif',
  'https://vt.tiktok.com/ZSbL9vdoD/',
  'https://t.me/otakukitchen/129',
  0, 0,
  'Бульону с желатином нужно минимум 2-3 часа в холодильнике, чтобы полностью застыть.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('В поисках божественного рецепта', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1),
  (SELECT id FROM animes WHERE title = 'В поисках божественного рецепта' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Масло кунжутное'),
('Куриные крылышки'),
('Даси порошковый'),
('Вода'),
('Имбирь'),
('Сахар'),
('Соевый соус'),
('Саке'),
('Желатин'),
('Рис'),
('Лук зеленый'),
('Яйца');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Масло кунжутное'),
  'Масло кунжутное', 30, 'мл', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Куриные крылышки'),
  'Куриные крылышки', 15, 'шт', '15-20 шт'
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Даси порошковый'),
  'Порошковый даси', 10, 'г', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Вода'),
  'Вода', 1.5, 'л', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Имбирь'),
  'Имбирь свежий', 2, 'ч.л', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Сахар'),
  'Сахар', 3, 'ст.л', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Соевый соус'),
  'Соевый соус', 75, 'мл', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Саке'),
  'Саке', 100, 'мл', 'или белое сухое вино'
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Желатин'),
  'Желатин', 2, 'ч.л', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Вода'),
  'Вода (для желатина)', 100, 'мл', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Рис'),
  'Короткозернистый рис', 1.5, 'чашка', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Лук зеленый'),
  'Зелёный лук', 4, 'перо', NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Основные ингредиенты'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Яйца'),
  'Куриные яйца', 4, 'шт', NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Обжарка крылышек', 0),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Приготовление бульона', 1),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Добавление курицы и специй', 2),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Добавление сока из сковороды', 3),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Подготовка основы для желе', 4),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Добавление желатина', 5),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Застывание бульона', 6),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Разделка курицы и подготовка лука', 7),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Приготовление риса', 8),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Приготовление яичницы-болтуньи', 9),
((SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1), 'Сборка блюда', 10);

-- Шаги (Обжарка крылышек)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Обжарка крылышек'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'В сковороде нагрейте кунжутное масло',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Обжарка крылышек'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Обжаривайте крылышки на среднем огне до золотистой корочки с обеих сторон — они должны быть полностью прожарены. Это основа аромата для будущего бульона',
  1
);

-- Шаги (Бульон)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление бульона'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'В кастрюлю налейте 1,5 литра воды и доведите до кипения',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление бульона'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Добавьте порошок даси и перемешайте до растворения. Это придаст бульону насыщенный вкус умами',
  1
);

-- Шаги (Курица и специи)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Добавление курицы и специй'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Переложите обжаренные крылышки в кастрюлю с бульоном и убавьте огонь до среднего',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Добавление курицы и специй'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Добавьте 2 ч.л свежего измельчённого имбиря, 75 мл соевого соуса, 100 мл саке и 3 ст.л сахара',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Добавление курицы и специй'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Всё хорошо перемешайте',
  2
);

-- Шаги (Сок из сковороды)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Добавление сока из сковороды'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Влейте в бульон остатки масла и сока из сковороды — это добавит глубины вкусу',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Добавление сока из сковороды'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Варите на медленном огне 20 минут, периодически снимая пену',
  1
);

-- Шаги (Основа для желе)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Подготовка основы для желе'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Снимите кастрюлю с огня и дайте ей немного остыть',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Подготовка основы для желе'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Выньте крылышки — мясо понадобится позже',
  1
);

-- Шаги (Желатин)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Добавление желатина'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'В отдельной миске растворите 2 ч.л желатина в 100 мл воды и хорошо перемешайте, чтобы не было комочков',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Добавление желатина'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Влейте желатин в бульон и тщательно размешайте',
  1
);

-- Шаги (Застывание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Застывание бульона'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Смажьте форму (глубокую тарелку или контейнер) сливочным маслом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Застывание бульона'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Налейте туда бульон с желатином, накройте пищевой плёнкой и уберите в холодильник минимум на 2-3 часа до полного застывания',
  1
);

-- Шаги (Курица и лук)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Разделка курицы и подготовка лука'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'С остывших крылышек снимите кожу и отделите мясо от костей',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Разделка курицы и подготовка лука'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Мелко нарежьте мясо',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Разделка курицы и подготовка лука'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Нарежьте зелёный лук мелкими колечками',
  2
);

-- Шаги (Рис)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление риса'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Промойте короткозернистый рис до прозрачности воды и отварите как обычно или в рисоварке',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление риса'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Добавьте в готовый рис нарезанное куриное мясо и аккуратно перемешайте',
  1
);

-- Шаги (Яичница-болтунья)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление яичницы-болтуньи'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Взбейте 4 яйца со щепоткой соли',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление яичницы-болтуньи'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.jpg' LIMIT 1) LIMIT 1),
  'На слабом огне приготовьте нежную яичницу, постоянно помешивая, чтобы получились мягкие кусочки',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Сборка блюда'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Нарежьте застывшее желе небольшими кубиками',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Сборка блюда'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'В миску выложите горячий рис с курицей, сверху — яичницу, а затем кусочки куриного желе',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Сборка блюда'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'furikake_gohan.gif' LIMIT 1) LIMIT 1),
  'Украсьте зелёным луком.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Холодная соба',
  30,
  'medium',
  3,
  'cold_Soba_hero_academia.jpg',
  'https://vt.tiktok.com/ZS4nwPn8r/',
  'https://t.me/otakukitchen/482',
  0, 0,
  'Для подачи соус менцую разбавляется холодной водой в соотношении 1:1.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Моя геройская академия', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title = 'Моя геройская академия' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Саке'),
('Мирин'),
('Соевый соус'),
('Комбу'),
('Хлопья бонито'),
('Лапша соба'),
('Чеснок'),
('Имбирь'),
('Лук зеленый'),
('Вода');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1),
  'Для соуса менцую',
  0
),
(
  (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1),
  'Для собы',
  1
);

-- Ингредиенты в рецепте

-- Для соуса менцую
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для соуса менцую'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Саке'),
  'Саке',
  100,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для соуса менцую'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Мирин'),
  'Мирин',
  100,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для соуса менцую'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Соевый соус'),
  'Соевый соус',
  100,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для соуса менцую'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Комбу'),
  'Комбу',
  1,
  'кусочек',
  '5x5 см'
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для соуса менцую'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Хлопья бонито'),
  'Стружка тунца (бонито)',
  6,
  'г',
  '6-10 г'
);

-- Для собы
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для собы'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Лапша соба'),
  'Лапша соба',
  0.5,
  'упаковка',
  'около 180-200 г'
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для собы'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Чеснок'),
  'Чеснок',
  1,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для собы'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Имбирь'),
  'Свежий имбирь',
  5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для собы'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Лук зеленый'),
  'Зеленый лук',
  3,
  'перо',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title = 'Для собы'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name = 'Вода'),
  'Вода',
  50,
  'мл',
  'для разбавления соуса'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1),
  'Приготовление соуса менцую',
  0
),
(
  (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1),
  'Варка собы',
  1
),
(
  (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1),
  'Подготовка соуса для подачи',
  2
),
(
  (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Соус менцую)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление соуса менцую'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'В небольшой кастрюле соедините саке и мирин, доведите до кипения и проварите 1-2 минуты, чтобы испарился алкоголь',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление соуса менцую'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Добавьте соевый соус и комбу. Нагрейте почти до кипения, но не кипятите',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление соуса менцую'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Снимите с огня, добавьте хлопья бонито и оставьте настаиваться на 5-10 минут',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Приготовление соуса менцую'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Процедите соус и полностью остудите',
  3
);

-- Шаги (Соба)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Варка собы'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Отварите лапшу согласно инструкции на упаковке',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Варка собы'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Сразу переложите ее в ледяную воду, чтобы остановить приготовление',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Варка собы'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Хорошо промойте лапшу руками под холодной водой, удаляя лишний крахмал',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Варка собы'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Откиньте на дуршлаг и дайте воде полностью стечь',
  3
);

-- Шаги (Соус для подачи)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Подготовка соуса для подачи'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Смешайте 50 мл менцую и 50 мл холодной воды (соотношение 1:1)',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Подготовка соуса для подачи'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'В отдельную миску выложите тертый чеснок, натертый имбирь и нарезанный зеленый лук',
  1
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title = 'Подача'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Выложите охлажденную собу на тарелку и добавьте к ней приправы',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Подача'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Подавайте вместе с охлажденным соусом менцую',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title = 'Подача'
   AND recipe_id = (SELECT id FROM recipes WHERE image_url = 'cold_Soba_hero_academia.jpg' LIMIT 1) LIMIT 1),
  'Перед каждым кусочком окунайте лапшу в соус и сразу ешьте.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Чай Вайолета',
  10,
  'easy',
  5,
  'tea_violetta_blackbutler.jpg',
  'https://vt.tiktok.com/ZSqPdoo4H/',
  'https://t.me/otakukitchen/493',
  0, 0,
  'Подавайте напиток сразу после смешивания.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Темный дворецкий', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Темный дворецкий' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Чай черный Earl Grey'),
('Яблочный сок'),
('Лайм');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чай черный Earl Grey'),
  'Крепкий чёрный чай Earl Grey',
  100,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яблочный сок'),
  'Яблочный сок',
  60,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лайм'),
  'Лайм',
  3,
  'кружок',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1),
  'Заваривание чая',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1),
  'Подготовка сока с лаймом',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1),
  'Смешивание и подача',
  2
);

-- Шаги (Чай)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание чая'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Заварите крепкий чёрный чай',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание чая'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Перелейте чай в небольшой графин',
  1
);

-- Шаги (Сок с лаймом)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сока с лаймом'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Во втором графине смешайте яблочный сок и кружки лайма',
  0
);

-- Шаги (Смешивание и подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Смешивание и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Постепенно наливайте в чашку чёрный чай и сок с лаймом из обоих графинов',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Смешивание и подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='tea_violetta_blackbutler.jpg' LIMIT 1) LIMIT 1),
  'Слегка перемешайте и сразу подавайте.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Чёрные спагетти',
  25,
  'medium',
  4,
  'black_spagetti.jpg',
  'https://vt.tiktok.com/ZSbLxGS6D/',
  'https://t.me/otakukitchen/89',
  0, 0,
  'Отправляйте спагетти в соус сразу, пока они горячие, и сразу подавайте.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Невероятные приключения ДжоДжо', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Невероятные приключения ДжоДжо' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Спагетти черные'),
('Лук'),
('Чеснок'),
('Томатная паста'),
('Вода'),
('Масло оливковое');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1),
  'Основные ингредиенты (на 2 порции)',
  0
);

-- Ингредиенты в рецепте
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Спагетти черные'),
  'Чёрные спагетти (с чернилами каракатицы)',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт',
  'небольшая луковица'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  2,
  'зубчик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томатная паста'),
  'Томатная паста',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода или овощной бульон',
  70,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты (на 2 порции)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  NULL,
  'для жарки',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1),
  'Приготовление соуса',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1),
  'Варка спагетти',
  1
);

-- Шаги (Соус)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  'Мелко нарежьте лук. Чеснок натрите на тёрке, мелко порубите или выдавите',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду с оливковым маслом и обжаривайте лук 1 минуту',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  'Добавьте чеснок, перемешайте и жарьте ещё 30 секунд',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  'Положите томатную пасту, перемешайте и тушите 1 минуту',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  'Влейте воду или бульон, уменьшите огонь и тушите 4 минуты, помешивая',
  4
);

-- Шаги (Спагетти)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  'Отварите спагетти по инструкции на упаковке',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  'Слейте воду и сразу отправьте горячие спагетти в сковороду с соусом',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка спагетти'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='black_spagetti.jpg' LIMIT 1) LIMIT 1),
  'Перемешайте, дайте пасте пропитаться и сразу подавайте.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Чуррос',
  30,
  'hard',
  1,
  'churros_drstone.jpg',
  'https://vm.tiktok.com/ZMAEbGx2S/',
  'https://t.me/otakukitchen/302',
  0, 0,
  'Традиционно чуррос подают горячими.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Доктор Стоун', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Доктор Стоун' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Молоко'),
('Мука'),
('Сахар'),
('Соль'),
('Масло оливковое'),
('Масло растительное'),
('Шоколадный соус');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1),
  'Для подачи (по желанию)',
  1
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  120,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло оливковое'),
  'Оливковое масло',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  NULL,
  'для жарки',
  NULL
);

-- Для подачи (по желанию)
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для подачи (по желанию)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколадный соус'),
  'Шоколадный или карамельный соус',
  NULL,
  'по желанию',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1),
  'Подготовка',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1),
  'Заваривание теста',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1),
  'Формирование и жарка',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1),
  'Подача',
  3
);

-- Шаги (Подготовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'В маленькой кастрюльке нагрейте молоко и добавьте оливковое масло',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'В чаше просейте муку, добавьте сахар и соль, перемешайте венчиком или вилкой',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'В отдельной кастрюльке начните нагревать масло для жарки',
  2
);

-- Шаги (Заваривание теста)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'Как только молоко закипит, уменьшите огонь до минимального',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'Частями всыпайте муку в кипящее молоко, активно перемешивая. Варите до гладкой, густой и однородной массы без комочков',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Заваривание теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'Снимите с огня и дайте тесту немного остыть',
  2
);

-- Шаги (Формирование и жарка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование и жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'Переложите тёплое тесто в кондитерский мешок с насадкой «звёздочка»',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование и жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'Придавливая мешок, выдавите полоски теста',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование и жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'Жарьте в разогретом масле до золотисто-коричневого цвета примерно 2-3 минуты',
  2
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'Подавайте чуррос горячими, обмакивая в шоколадный или карамельный соус, мёд или сгущёнку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='churros_drstone.jpg' LIMIT 1) LIMIT 1),
  'Можно есть и просто так.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Шоколадные конфеты',
  600,
  'easy',
  1,
  'konfeti_kiminotodoke.jpg',
  'https://vt.tiktok.com/ZSbLM2va1/',
  'https://t.me/otakukitchen/502',
  0, 0,
  'Большая часть времени уходит на застывание: конфетам нужна ночь в холодильнике.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Дотянуться до тебя', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Дотянуться до тебя' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Шоколад'),
('Сливки 33%'),
('Миндаль'),
('Посыпка кондитерская'),
('Формочки для конфет');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколад'),
  'Шоколад',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливки 30-35%',
  90,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Миндаль'),
  'Миндаль',
  30,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Посыпка кондитерская'),
  'Кондитерская посыпка',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Формочки для конфет'),
  'Формочки для конфет',
  NULL,
  'по необходимости',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1),
  'Приготовление шоколадной массы',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1),
  'Формирование конфет',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1),
  'Застывание',
  2
);

-- Шаги (Шоколадная масса)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  'Мелко нарубите шоколад и переложите в миску',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  'Нагрейте сливки почти до кипения, но не кипятите',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадной массы'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  'Залейте шоколад горячими сливками и перемешайте до гладкой блестящей массы',
  2
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование конфет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  'Разложите шоколадную массу по маленьким формочкам',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование конфет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  'Украсьте сверху миндалём и цветной посыпкой',
  1
);

-- Шаги (Застывание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Застывание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='konfeti_kiminotodoke.jpg' LIMIT 1) LIMIT 1),
  'Уберите конфеты в холодильник на ночь, чтобы они хорошо застыли.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Шоколадные рогалики',
  140,
  'hard',
  1,
  'chocolate_rogaliki_lucky_star.jpg',
  'https://vm.tiktok.com/ZMAcYYrNt/',
  'https://t.me/otakukitchen/288',
  0, 0,
  'Конусные формы для рогаликов можно сделать из фольги.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Lucky Star', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Lucky Star' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Сахар'),
('Соль'),
('Молоко'),
('Яйца'),
('Дрожжи сухие'),
('Масло сливочное'),
('Крахмал кукурузный'),
('Какао-порошок'),
('Шоколад');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1),
  'Для шоколадного крема',
  1
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  250,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  30,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко теплое',
  130,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Дрожжи сухие'),
  'Дрожжи сухие',
  5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло сливочное (мягкое)',
  25,
  'г',
  NULL
);

-- Для шоколадного крема
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  250,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  40,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Желток',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Крахмал кукурузный'),
  'Крахмал кукурузный',
  15,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Какао-порошок'),
  'Какао-порошок',
  10,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколад'),
  'Шоколад (темный или молочный)',
  40,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло сливочное',
  10,
  'г',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1),
  'Формирование',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1),
  'Выпекание',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1),
  'Приготовление шоколадного крема',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1),
  'Сборка',
  4
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'В миске смешайте муку, сахар, соль и дрожжи',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Добавьте теплое молоко и яйцо, замесите мягкое тесто',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Вмешайте сливочное масло и месите 10-15 минут, пока тесто не станет эластичным',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Накройте и оставьте подходить на 1 час, пока тесто не увеличится в 2 раза',
  3
);

-- Шаги (Формирование)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формирование'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Разделите тесто на 6-8 кусочков и раскатайте каждый в длинную колбаску около 40 см',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Намотайте тесто спиралью на конусную форму, ее можно сделать из фольги',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формирование'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Оставьте еще на 20-30 минут под полотенцем',
  2
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Смажьте рогалики яйцом и выпекайте при 180 C 12-15 минут до золотистого цвета',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Остудите и аккуратно снимите с формы',
  1
);

-- Шаги (Шоколадный крем)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'В сотейнике смешайте желток, сахар, какао и крахмал',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Влейте молоко, размешайте и нагревайте до загустения',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Добавьте шоколад и масло, перемешайте до гладкости',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление шоколадного крема'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Остудите крем и переложите в кондитерский мешок',
  3
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'Наполните рогалики шоколадным кремом через узкий конец',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='chocolate_rogaliki_lucky_star.jpg' LIMIT 1) LIMIT 1),
  'По желанию посыпьте сахарной пудрой или украсьте каплей шоколада сверху.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Штоллен',
  300,
  'hard',
  1,
  'stollen_drstone.jpg',
  'https://vm.tiktok.com/ZMA5vY36H/',
  'https://t.me/otakukitchen/234',
  0, 0,
  'Сухофрукты лучше замочить в роме или коньяке на ночь.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Доктор Стоун', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Доктор Стоун' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Сахар'),
('Молоко'),
('Масло сливочное'),
('Яйца'),
('Соль'),
('Цедра лимона'),
('Ванильный сахар'),
('Дрожжи сухие'),
('Изюм'),
('Клюква сушеная'),
('Цукаты'),
('Миндаль'),
('Ром'),
('Сахарная пудра');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  'Для начинки',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  'Для покрытия',
  2
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука пшеничная',
  500,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко теплое',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло сливочное',
  150,
  'г',
  'мягкое'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Цедра лимона'),
  'Цедра лимона или апельсина',
  1,
  'шт',
  'цедра с 1 фрукта'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар',
  1,
  'пакетик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Дрожжи сухие'),
  'Дрожжи сухие',
  7,
  'г',
  '1 пакетик'
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Изюм'),
  'Изюм',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клюква сушеная'),
  'Сушеная клюква или вишня',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Цукаты'),
  'Цукаты апельсина или лимона',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Миндаль'),
  'Миндаль или орехи',
  70,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ром'),
  'Ром или коньяк',
  100,
  'мл',
  'для вымачивания сухофруктов'
);

-- Для покрытия
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для покрытия'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло сливочное',
  50,
  'г',
  'растопить'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для покрытия'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  100,
  'г',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  'Подготовка фруктов',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  'Приготовление теста',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  'Добавки',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  'Формовка',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  'Выпечка',
  4
),
(
  (SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1),
  'Финальный штрих',
  5
);

-- Шаги (Подготовка фруктов)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка фруктов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Залейте сушеные фрукты и цукаты ромом или коньяком и оставьте минимум на 2-3 часа, а лучше на ночь',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка фруктов'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Мелко нарежьте орехи',
  1
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'В теплом молоке растворите дрожжи и 1 ст.л сахара, оставьте на 10 минут',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Добавьте мягкое масло, оставшийся сахар, яйцо, соль, ванильный сахар и цедру',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Постепенно вмешивайте муку и замесите мягкое тесто',
  2
);

-- Шаги (Добавки)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Добавки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Вмешайте в тесто сухофрукты вместе с алкоголем и орехи',
  0
);

-- Шаги (Формовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Раскатайте тесто в продолговатый пласт',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формовка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Сложите пласт пополам, чтобы получилась традиционная форма штоллена',
  1
);

-- Шаги (Выпечка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Переложите штоллен на противень с пергаментом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Дайте расстояться 30-40 минут',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Выпекайте при 160 C около 40-50 минут',
  2
);

-- Шаги (Финальный штрих)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Горячий штоллен обильно смажьте растопленным маслом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='stollen_drstone.jpg' LIMIT 1) LIMIT 1),
  'Щедро посыпьте сахарной пудрой.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Яичница по рецепту Итачи',
  5,
  'easy',
  2,
  'egg_naruto.jpg',
  'https://vm.tiktok.com/ZMAX4D2G4/',
  'https://t.me/otakukitchen/251',
  0, 0,
  'Воду добавляйте сбоку на сковороду, а не на яйцо — пар сделает белок мягким и нежным.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Наруто', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Наруто' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Вода'),
('Соль'),
('Масло растительное');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  'по желанию'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Масло для жарки',
  NULL,
  'немного',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1),
  'Подготовка сковороды',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1),
  'Жарка на пару',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Сковорода)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка сковороды'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду на среднем огне и добавьте немного масла',
  0
);

-- Шаги (Жарка на пару)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка на пару'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  'Осторожно разбейте яйцо, чтобы желток остался целым. По желанию посолите',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка на пару'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  'Добавьте ложку воды сбоку на сковороду, не на яйцо',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка на пару'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  'Быстро накройте крышкой, чтобы пар сделал белок мягким и нежным',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Жарка на пару'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  'Готовьте 1-2 минуты, пока белок не станет матовым, а желток останется жидким',
  3
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_naruto.jpg' LIMIT 1) LIMIT 1),
  'Осторожно переложите яичницу на тарелку.',
  0
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Яичный сэндвич',
  30,
  'easy',
  2,
  'egg_sandwich_wind_breaker.jpg',
  'https://vt.tiktok.com/ZSbMtP6E5/',
  'https://t.me/otakukitchen/31',
  0, 0,
  'Из этого количества получается 2 сэндвича.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Ветролом', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Ветролом' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Хлеб'),
('Яйца'),
('Майонез'),
('Масло сливочное'),
('Листья салата'),
('Соль'),
('Перец черный'),
('Апельсин'),
('Клубника');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1),
  'Для подачи',
  1
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хлеб'),
  'Хлеб для тостов',
  4,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Куриные яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Сливочное масло',
  NULL,
  'для смазывания хлеба',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  2,
  'лист',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец черный'),
  'Перец',
  NULL,
  'по вкусу',
  NULL
);

-- Для подачи
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для подачи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Апельсин'),
  'Апельсин',
  NULL,
  'кусочек',
  'для украшения'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для подачи'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника'),
  'Клубника',
  NULL,
  'для украшения',
  'вместе с апельсином или вместо него'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1),
  'Приготовление яичной начинки',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1),
  'Сборка сэндвичей',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1),
  'Подача',
  2
);

-- Шаги (Яичная начинка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление яичной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'Сварите яйца вкрутую, примерно 10 минут после закипания',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление яичной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'Остудите, очистите и отделите желтки от белков. Белки мелко порубите',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление яичной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'Смешайте желтки с майонезом, добавьте соль и перец по вкусу',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление яичной начинки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'Добавьте мелко нарезанные белки и перемешайте',
  3
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'Смажьте ломтики хлеба сливочным маслом',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'На один ломтик положите лист салата, сверху выложите половину яичной смеси',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'Накройте вторым ломтиком хлеба',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка сэндвичей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'Повторите то же самое для второго сэндвича',
  3
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте сэндвичи на половинки или треугольники и уложите на тарелку',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='egg_sandwich_wind_breaker.jpg' LIMIT 1) LIMIT 1),
  'Украсьте апельсином и клубникой.',
  1
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Якисоба',
  30,
  'easy',
  3,
  'yakisoba_monster.jpg',
  'https://vm.tiktok.com/ZMDrrbGV6/',
  'https://t.me/otakukitchen/346',
  0, 0,
  'Если есть готовый соус для якисобы, можно использовать его вместо домашнего.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Выдающиеся звери', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Выдающиеся звери' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Лапша якисоба'),
('Морковь'),
('Шампиньоны'),
('Перец болгарский'),
('Капуста пекинская'),
('Яйца'),
('Масло растительное'),
('Вустерский соус'),
('Устричный соус'),
('Рисовый уксус'),
('Кетчуп'),
('Соус хойсин'),
('Соевый соус');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1),
  'Для соуса (если нет готового)',
  1
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лапша якисоба'),
  'Лапша якисоба',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  'нарезать соломкой'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шампиньоны'),
  'Шампиньоны',
  150,
  'г',
  '150-200 г, нарезать ломтиками'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец болгарский'),
  'Красный болгарский перец',
  1,
  'шт',
  'нарезать соломкой'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Капуста пекинская'),
  'Пекинская капуста',
  4,
  'лист',
  'крупно нарезать'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  NULL,
  'для жарки',
  NULL
);

-- Для соуса (если нет готового)
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса (если нет готового)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вустерский соус'),
  'Вустерский соус',
  120,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса (если нет готового)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Устричный соус'),
  'Устричный соус',
  50,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса (если нет готового)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рисовый уксус'),
  'Рисовый уксус',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса (если нет готового)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  1,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса (если нет готового)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соус хойсин'),
  'Соус хойсин',
  2,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для соуса (если нет готового)'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  'ч.л',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1),
  'Приготовление соуса',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1),
  'Обжарка овощей',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1),
  'Приготовление лапши',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1),
  'Жарка яиц',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1),
  'Подача',
  4
);

-- Шаги (Соус)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление соуса'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  'Смешайте все ингредиенты для соуса в миске и отставьте',
  0
);

-- Шаги (Овощи)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду на среднем огне с небольшим количеством масла',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  'Обжарьте морковь, шампиньоны и болгарский перец 2-3 минуты, помешивая',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  'Добавьте капусту и жарьте еще 1-2 минуты, чтобы она стала мягкой, но не потеряла текстуру',
  2
);

-- Шаги (Лапша)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лапши'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  'Залейте лапшу кипятком в дуршлаге или миске, подержите 2-3 минуты, разрыхлите и слейте воду',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лапши'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  'Добавьте лапшу к овощам, влейте соус и готовьте все вместе 2-3 минуты, хорошо перемешивая, чтобы соус равномерно покрыл лапшу',
  1
);

-- Шаги (Яйца)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Жарка яиц'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  'На отдельной сковороде пожарьте яйца глазуньей, чтобы желток остался мягким',
  0
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='yakisoba_monster.jpg' LIMIT 1) LIMIT 1),
  'Выложите лапшу по тарелкам и сверху положите по яйцу.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Суп',
  50,
  'medium',
  3,
  'soup_podzemelie.jpg',
  'https://vm.tiktok.com/ZMA9rE92V/',
  'https://t.me/otakukitchen/241',
  0, 0,
  'Суп должен остаться прозрачным, с естественной сладостью овощей и лёгким мясным ароматом.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Подземелье вкусностей', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Подземелье вкусностей' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Капуста'),
('Картофель'),
('Морковь'),
('Лук'),
('Бекон'),
('Вода'),
('Соль');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1),
  'Основные ингредиенты',
  0
);

-- Ингредиенты в рецепте

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Капуста'),
  'Молодая капуста',
  0.5,
  'кочан',
  'половина небольшого кочана (или 1/4 обычного)'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель маленький',
  4,
  'шт',
  'или 2 крупные, разрезанные пополам'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт',
  'можно оставить целиком или разрезать пополам'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бекон'),
  'Бекон',
  200,
  'г',
  '200-250 г, лучше цельный кусок или толстые ломтики, можно копчёный'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  1.5,
  'л',
  '1,5-2 л'
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  'по вкусу',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1),
  'Варка овощей',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1),
  'Добавление бекона',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1),
  'Финальный штрих',
  2
);

-- Шаги (Варка овощей)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Варка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  'В большую кастрюлю налейте воду, положите картофель, крупные куски моркови, лук и капусту',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  'Доведите до кипения и снимите пенку',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Варка овощей'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  'Варите на среднем огне 20-25 минут',
  2
);

-- Шаги (Бекон)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Добавление бекона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  'Положите в суп куски бекона',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Добавление бекона'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  'Варите ещё 10-15 минут, чтобы бекон отдал аромат и лёгкую копчёность, но не стал слишком жёстким',
  1
);

-- Шаги (Финальный штрих)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Финальный штрих'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='soup_podzemelie.jpg' LIMIT 1) LIMIT 1),
  'Посолите суп по вкусу.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Бургер',
  35,
  'medium',
  3,
  'burger_pompoko.jpg',
  'https://vt.tiktok.com/ZSbrdUsoW/',
  'https://t.me/otakukitchen/14',
  0, 0,
  'Бургеры хорошо подать с картофелем фри или свежими овощами.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Помпоко: Война тануки', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1),
  (SELECT id FROM animes WHERE title='Помпоко: Война тануки' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Фарш'),
('Яйца'),
('Панировочные сухари'),
('Масло растительное'),
('Булочки для бургеров'),
('Сыр чеддер'),
('Кетчуп'),
('Листья салата'),
('Огурцы маринованные'),
('Лук');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1),
  'Для котлет',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1),
  'Для сборки',
  1
);

-- Ингредиенты в рецепте

-- Для котлет
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фарш'),
  'Говяжий фарш',
  250,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фарш'),
  'Свиной фарш',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Куриное яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Панировочные сухари'),
  'Панировочные сухари',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло растительное'),
  'Растительное масло',
  NULL,
  'для жарки',
  NULL
);

-- Для сборки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Булочки для бургеров'),
  'Булочки с кунжутом',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр чеддер'),
  'Сыр чеддер',
  4,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Домашний кетчуп',
  4,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  4,
  'лист',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Огурцы маринованные'),
  'Маринованные огурцы',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Большая луковица',
  1,
  'шт',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1),
  'Подготовка фарша',
  0
),
(
  (SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1),
  'Обжарка котлет',
  1
),
(
  (SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1),
  'Приготовление лука',
  2
),
(
  (SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1),
  'Сборка бургера',
  3
),
(
  (SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1),
  'Подача',
  4
);

-- Шаги (Фарш)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка фарша'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'В глубокой миске смешайте говяжий и свиной фарш',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка фарша'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'Добавьте яйцо и панировочные сухари и тщательно перемешайте',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Подготовка фарша'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'Сформируйте 4 котлеты',
  2
);

-- Шаги (Котлеты)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'Разогрейте сковороду с небольшим количеством растительного масла',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'Обжаривайте котлеты на среднем огне по 4-5 минут с каждой стороны до румяной корочки. Убедитесь, что они полностью прожарились',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарка котлет'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'За минуту до готовности положите на каждую котлету ломтик чеддера, чтобы он немного расплавился',
  2
);

-- Шаги (Лук)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лука'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'Пока жарятся котлеты, нарежьте луковицу кольцами',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление лука'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'По желанию обжарьте кольца на сковороде до золотистого цвета',
  1
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сборка бургера'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'Разрежьте булочки пополам. По желанию подрумяньте внутренние стороны на сухой сковороде или гриле',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка бургера'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'На нижнюю половинку выложите лист салата, затем котлету с расплавленным сыром, пару колечек лука и маринованный огурец',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Сборка бургера'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'Добавьте по ложке домашнего кетчупа и накройте верхней половинкой булочки',
  2
);

-- Шаги (Подача)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE image_url='burger_pompoko.jpg' LIMIT 1) LIMIT 1),
  'Подавайте бургеры горячими.',
  0
);