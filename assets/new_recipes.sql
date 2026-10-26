
-- Ингредиенты
INSERT OR IGNORE INTO ingredients (id, name) VALUES
(0, '');

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Батон',
  180,
  'hard',
  3,
  'bntjNQRYSLmLxxeMz04JPa6XZ-hfMNLk5qDWUfFenlTqe3tDTdDwAAaONDSCF3TcoDPV2JdVy2.jpg',
  'https://vt.tiktok.com/ZS93vYsAA/',
  'https://t.me/otakukitchen/450',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Роза Версаля', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Батон' LIMIT 1),
  (SELECT id FROM animes WHERE title='Роза Версаля' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Вода'),
('Соль'),
('Сахар'),
('Сухие дрожжи');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Батон' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  500,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  350,
  'мл',
  'тёплая'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  10,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухие дрожжи'),
  'Сухие дрожжи',
  5,
  '–7 г',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES

  ((SELECT id FROM recipes WHERE name='Батон' LIMIT 1),
    'Активируем дрожжи',
    0), 
  ((SELECT id FROM recipes WHERE name='Батон' LIMIT 1),
    'Замешиваем тесто',
    1), 
   ((SELECT id FROM recipes WHERE name='Батон' LIMIT 1),
    'Подъём теста',
    2), 
   ((SELECT id FROM recipes WHERE name='Батон' LIMIT 1),
    'Формируем багеты',
    3), 
   ((SELECT id FROM recipes WHERE name='Батон' LIMIT 1),
    'Делаем надрезы',
    4), 
   ((SELECT id FROM recipes WHERE name='Батон' LIMIT 1),
    'Выпечка',
    5 
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Активируем дрожжи'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'В миске смешай воду + сахар + дрожжи. Оставь на 10–15 минут, пока появится пенка',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Замешиваем тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Добавь муку и соль.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Замешиваем тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Замеси тесто (руками или тестомешалкой)',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Замешиваем тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Оно должно быть: мягкое, немного липкое, эластичное. Меси ~10 минут',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Подъём теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Накрой и оставь в тёплом месте на 1–1.5 часа',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='3. Подъём теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Тесто должно увеличиться в 2 раза',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Формируем багеты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Раздели тесто на 2 части',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Формируем багеты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Каждую: 1. Раскатай в прямоугольник 2. Сверни в рулет 3. Защипни шов 4. Прокатай руками',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Формируем багеты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Выложи на противень (с бумагой). Накрой и оставь ещё на 30–40 минут',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Делаем надрезы'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Острым ножом сделай косые надрезы.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Разогрей духовку до 230°C',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Поставь внутрь миску с водой',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Батон' LIMIT 1)
   LIMIT 1),
  'Выпекай 20–25 минут до золотистой корочки',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Блинчики из «АККА: Инспекция по 13 округам»',
  45,
  'hard',
  2,
  'f580db8a6582d132361571df6865a984.gif',
  'https://vt.tiktok.com/ZSQX9g35t/',
  'https://t.me/otakukitchen/462',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('АККА: Инспекция по 13 округам', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1),
  (SELECT id FROM animes WHERE title='АККА: Инспекция по 13 округам' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Пшеничная мука'),
('Разрыхлитель'),
('Яйца'),
('Сахарная пудра'),
('Мелкий сахар'),
('Молоко'),
('Сливочное масло'),
('Мёд'),
('Голубика');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1),
  'Ингредиенты:',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Пшеничная мука'),
  'Пшеничная мука',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  2,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца (белки и желтки отдельно)',
  6,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра или очень мелкий сахар',
  160,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  140,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  60,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мёд'),
  'Мёд',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Голубика'),
  'Для украшения голубика',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'Отдели белки от желтков.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'Просей вместе муку и разрыхлитель.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'В небольшой миске смешай молоко, масло и мёд. Подогрей, пока масло полностью не растает, затем немного остуди.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'Взбей белки, постепенно добавляя сахар, до плотной блестящей меренги.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'Добавь сразу все желтки и аккуратно перемешай.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'В три приёма вмешай мучную смесь.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'Добавь немного готового теста в молочно-масляную смесь, перемешай, а затем верни её обратно в основное тесто. Получится гладкая воздушная масса.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'Хорошо разогрей широкую сковороду для блинов и слегка смажь маслом. Нанеси слой теста.',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'Когда появятся пузырьки и поверхность схватится, аккуратно переверни и быстро допеки вторую сторону.',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики из «АККА: Инспекция по 13 округам»' LIMIT 1)
   LIMIT 1),
  'Укрась сверху голубикой.',
  9
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Блинчики с кремом из «Оглянись»',
  35,
  'medium',
  1,
  '1651474.jpg',
  'https://vt.tiktok.com/ZSCCoQ2Bp/',
  'https://t.me/otakukitchen/468',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Оглянись', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Оглянись' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Молоко'),
('Мука'),
('Сахар'),
('Соль'),
('Сливочное масло'),
('Сливки 33–35%'),
('Сахарная пудра'),
('Клубника');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  250,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Муки',
  120,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахара',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Щепотка соли',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочного масла',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33–35%'),
  'Сливок 33–35%',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарной пудры',
  '1–2',
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника'),
  'Клубника',
  NULL,
  '',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  'Смешайте яйца, молоко, сахар и соль. Постепенно добавьте муку и перемешайте до однородности.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  'Влейте растопленное сливочное масло и оставьте тесто на 15 минут.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  'Выпекайте блинчики на хорошо разогретой сковороде по 1–2 минуты с каждой стороны.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  'Взбейте сливки с сахарной пудрой до плотного крема.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  'В центр блинчика выложите крем и при желании добавьте клубнику.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Блинчики с кремом из «Оглянись»' LIMIT 1)
   LIMIT 1),
  'Сложите блинчик.',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Булочка-мишка',
  210,
  'hard',
  1,
  '5K3oOPcVGi0Kd--vM_uV5tMiqjvR4FRJcWOTfYvbyEmoVro_K3Ok1BnZUTRNk-2.jpg',
  'https://vt.tiktok.com/ZSXBdTLyt/',
  'https://t.me/otakukitchen/464',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Билд Дивайд: Черный код', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1),
  (SELECT id FROM animes WHERE title='Билд Дивайд: Черный код' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Тёплое молоко'),
('Сахар'),
('Сливочное масло'),
('Яйцо'),
('Соль'),
('Сухие дрожжи'),
('Молоко'),
('Желтки'),
('Кукурузный крахмал'),
('Сливки 33%'),
('Шоколад');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1),
  'Ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1),
  'Для крема',
  1
),
(
  (SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1),
  'Для украшения',
  2
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тёплое молоко'),
  'Тёплое молоко',
  170,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  35,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  35,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Яйцо',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  5,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухие дрожжи'),
  'Сухие дрожжи',
  5,
  'г',
  NULL
);

-- Для крема
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  250,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желтки'),
  'Желтка',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахара',
  45,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кукурузный крахмал'),
  'Кукурузный крахмал',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочного масла',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливок 33%',
  100,
  'мл',
  NULL
);

-- Для украшения
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколад'),
  'Шоколад',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Смешай тёплое молоко, дрожжи и сахар. Добавь яйцо, затем муку и соль. Замеси тесто, в конце вмешай мягкое сливочное масло. Вымешивай около 10 минут до гладкости.',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Накрой и оставь подходить на 1–1,5 часа, пока тесто не увеличится примерно вдвое.',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Отдели небольшой кусочек теста. Из основной части сформируй круглую голову мишки.',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Из оставшегося теста сделай: круг для мордочки, два маленьких кружочка для внутренней части ушек, два небольших шарика для самих ушек. Прикрепи ушки к голове, вставь светлые кружочки и по центру положи круглую мордочку.',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Оставь булочку на расстойку ещё на 30–40 минут.',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Основную часть булочки смажь яйцом, а светлую мордочку и внутреннюю часть ушек лучше не смазывать — тогда они останутся светлее и будут похожи на аниме.',
  5
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Выпекай при 170°C около 15–18 минут до красивого золотистого цвета. Полностью остуди.',
  6
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'В кастрюле смешай молоко, желтки, сахар и крахмал. Постоянно помешивая, вари на небольшом огне до загустения.',
  7
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Добавь сливочное масло и полностью остуди.',
  8
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Отдельно взбей холодные сливки до мягких пиков и аккуратно вмешай их в заварной крем.Получится лёгкий белый крем.',
  9
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Сделай небольшое отверстие снизу и с помощью кондитерского мешка заполни булочку большим количеством крема. Начинки должно быть много, тогда при разломе или лёгком нажатии крем будет красиво вытекать, как в аниме.',
  10
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочка-мишка' LIMIT 1) LIMIT 1),
  'Растопленным шоколадом нарисуй: глазки, носик, ротик, маленькие бровки.',
  11
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Булочки Бао из «Волейбол!!»',
  120,
  'hard',
  3,
  '04TdL-HF6m48VSafNGJ-JWPbyVThq4Ru3vsOdrTmsf8-vJhrfvw8CBwBAK.jpg',
  'https://vt.tiktok.com/ZSXhJMVUc/',
  'https://telegram.me/otakukitchen/102',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Волейбол!!', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Волейбол!!' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Свиной фарш'),
('Тертый имбирь'),
('Соевый соус'),
('Кунжутное масло'),
('Соль'),
('Черный перец молотый'),
('Мука'),
('Вода'),
('Дрожжи'),
('Сахар');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1),
  'Ингредиенты:',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Свиной фарш'),
  'Свиной фарш',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тертый имбирь'),
  'Тертый имбирь',
  1,
  'ч.л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  2,
  'ст.л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кунжутное масло'),
  'Кунжутное масло (лучше нерафинированное)',
  1,
  'ст.л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1.5,
  'ч.л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Черный перец молотый'),
  'Черный перец молотый',
  0.5,
  'ч.л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  400,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  420,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Дрожжи'),
  'Дрожжи',
  6,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  NULL,
  'щепотка',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1),
  'Тесто',
  0
),
(
  (SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1),
  'Совет',
  1
),
(
  (SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1),
  'Начинка',
  2
),
(
  (SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1),
  'Формируем булочки',
  3
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Тесто' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Сначала наливаю 70 мл теплой воды в мисочку. Добавляю щепотку сахара и насыпаю 6 г дрожжей, температура которой должна быть примерна равна температуре тела. Перемешиваю и оставляю постоять несколько минут. Как только смесь запенятся можно замешивать тесто.',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Тесто' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'В чашу миксера-тестомеса насыпаю 400 г муки, выливаю дрожжи. Смешиваю.',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Тесто' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Наливаю постепенно 220 мл воды комнатной температуры',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Тесто' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Вымешиваю пока масса не соберется в ком и дрожжи не распределятся по нему равномерно, только потом кладу 0,5 ч.л. соли. Так соль не помешает подниматься.',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Тесто' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Затягиваю чашу пищевой пленкой и оставляю в теплом месте примерно на 1 час.',
  4
);

-- Шаг (Совет)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Совет' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Я разогреваю духовку 1-2 минуты на 200 градусах. Выключаю и ставлю туда чашу с тестом, чтобы тесто подходило в теплом месте',
  0
);

-- Шаги (Начинка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Начинка' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Беру 300 г свиного фарша, добавляю 1 ч.л. соли, 0,5 ч.л. черного перца, 1 ч.л. тертого на мелкой терке имбиря. Вымешиваю, чтобы соединить эти ингредиенты.',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Начинка' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Hаливаю 1 ст.л. кунжутного масла и 2 ст.л. соевого соуса. Хорошо вмешиваю их в фарш. Начинаю добавлять холодную воду. Добавляю частями, хорошо вмешивая ее в фарш, чтобы он получился очень сочным. Всего вмешиваю 130 мл воды.',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Начинка' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'В конце фарш отбиваю. Беру весь объем в руку и бросаю в миску. Делаю так несколько раз, чтобы баоцзы были сочными.',
  2
);

-- Шаги (Формируем булочки)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Формируем булочки' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Тесто за час увеличилось в размере в 3 раза и стало очень пышным.',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Формируем булочки' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Перекладываю его на рабочую поверхность. Еще немного вымешиваю и делю сначала пополам, затем каждую часть еще пополам и так, пока не получу 16 кусочков, каждый из которых скатываю в шарик.',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Формируем булочки' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Накрываю пленкой, чтобы не подсыхало и начинаю делать баоцзы. Раскатываю шарик в лепешечку диаметром 12 см. Пальцами придавливаю края, чтобы они стали потоньше.',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Формируем булочки' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Кладу в центр 1 ст.л. с горкой фарша.',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Формируем булочки' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Поднимаю края и, закладывая складки, защипываю их по кругу, формуя мешочек.',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Формируем булочки' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Булочки варятся на пару. Чтобы они не прилипали, под каждую подкладываю кусочек пергамента. Во время варки дрожжевые булочки сильно увеличиваются в объеме, поэтом оставляется побольше месте между ними.',
  5
),
(
  (SELECT id FROM recipe_sections WHERE title='Формируем булочки' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки Бао из «Волейбол!!»' LIMIT 1) LIMIT 1),
  'Ставлю поддоны с булочками в кастрюлю с кипящей водой, закрываю крышкой и варю 25 минут.',
  6
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Булочки с кремом',
  170,
  'hard',
  1,
  '1591176464_04f548daafa984b3d73367d3f1f742c5.gif',
  'https://vt.tiktok.com/ZSuBUxxwn/',
  'https://t.me/otakukitchen/408',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Дракон-горничная Кобаяси', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1),
  (SELECT id FROM animes WHERE title='Дракон-горничная Кобаяси' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Молоко'),
('Сахар'),
('Соль'),
('Сухие дрожжи'),
('Яйцо'),
('Сливочное масло'),
('Желтки'),
('Кукурузный крахмал'),
('Ваниль');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1),
  'Тесто',
  0
),
(
  (SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1),
  'Крем',
  1
);

-- Тесто
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко тёплое',
  160,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  40,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.5,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухие дрожжи'),
  'Сухие дрожжи',
  6,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло (мягкое)',
  40,
  'г',
  NULL
);

-- Крем
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Крем'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  300,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Крем'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желтки'),
  'Желтки',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Крем'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  60,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Крем'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кукурузный крахмал'),
  'Кукурузный крахмал',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Крем'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ваниль'),
  'Ваниль',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Крем'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  15,
  'г',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'В тёплое молоко добавь дрожжи + 1 ч. л. сахара, оставь на 10 минут.',0),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Смешай муку, сахар, соль.',1),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Добавь яйцо и дрожжевую смесь. Замеси.',2),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Когда тесто станет однородным — добавь масло и вымешивай 10–12 минут.',3),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Накрой и оставь на 1–1,5 часа — пока не увеличится в 2 раза.',4),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Нагрей молоко почти до кипения.',5),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Отдельно смешай желтки + сахар + крахмал.',6),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Влей немного горячего молока в желтки, перемешай.',7),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Верни всё в сотейник и вари на среднем огне, помешивая, пока не загустеет.',8),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Добавь масло и ваниль.',9),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Накрой плёнкой и полностью остуди.(Крем должен быть густой, чтобы не вытекал.)',10),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Тесто раздели на 6 шариков. Раскатай каждый в овал.',11),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'В центр выложи 1–2 ст. л. крема.',12),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Защипни как пирожок и переверни швом вниз.',13),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Сделай сверху 3–4 неглубоких надреза.',14),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Оставь ещё на 30–40 минут.',15),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Смажь яйцом',16),
((SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Булочки с кремом' LIMIT 1) LIMIT 1),'Выпекай при 180°C ~15–18 минут. До золотистой корочки.',17);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Бургер из Dr.Stone',
  30,
  'medium',
  3,
  'GiR__VhaAAAdPTq.jpg',
  'https://vt.tiktok.com/ZSXjh9wxc/',
  'https://t.me/otakukitchen/471',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Dr. Stone', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1),
  (SELECT id FROM animes WHERE title='Dr. Stone' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Говяжий фарш'),
('Говядина'),
('Индейка'),
('Соль'),
('Черный перец'),
('BBQ специи'),
('Майонез'),
('Кетчуп'),
('Горчица'),
('Рассол от маринованных огурцов'),
('Булочки для бургеров'),
('Сыр чеддер'),
('Листья салата'),
('Маринованные огурчики');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1),
  'Котлеты:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1),
  'Соус:',
  1
),
(
  (SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1),
  'Для сборки:',
  2
);

-- Котлеты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Котлеты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говяжий фарш'),
  'Говяжьего фарша (или 400 г говядины + 200 г индейки)',
  600,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Котлеты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соли',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Котлеты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Черный перец'),
  'Черного перца',
  0.5,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Котлеты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='BBQ специи'),
  'BBQ специи',
  2,
  'ч. л.',
  NULL
);

-- Соус
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соус:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонеза',
  4,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соус:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчупа',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соус:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Горчица'),
  'Горчицы',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соус:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рассол от маринованных огурцов'),
  'Рассола от маринованных огурцов (по желанию)',
  1,
  'ч. л.',
  NULL
);

-- Для сборки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для сборки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Булочки для бургеров'),
  'Булочки для бургеров',
  4,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для сборки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр чеддер'),
  'Ломтика сыра чеддер',
  4,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для сборки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для сборки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Маринованные огурчики'),
  'Маринованные огурчики (по желанию)',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Смешайте фарш с солью, перцем, BBQ специями. Сформируйте 4 котлеты.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Обжарьте по 3–4 минуты с каждой стороны. За минуту до готовности положите сверху сыр на одну котлету.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Смешайте ингредиенты для соуса.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Соберите бургер:',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Нижняя булочка',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Листья салата',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Котлета с сыром',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Соус',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Вторая котлета без сыра',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Соус',
  9
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Маринованные огурчики (если используете)',
  10
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Листья салата',
  11
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Бургер из Dr.Stone' LIMIT 1)
   LIMIT 1),
  'Верхняя булочка',
  12
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Ганаш из «Хоримия»',
  260,
  'easy',
  1,
  'tumblr_6dfb9c1235c1cb59c09acfbdd191a3c4_3721f4fe_2048.png',
  'https://vt.tiktok.com/ZS9YFoVMR/',
  'https://t.me/otakukitchen/441',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Хоримия', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Хоримия' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Тёмный шоколад'),
('Сливки'),
('Сливочное масло'),
('Какао-порошок');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тёмный шоколад'),
  'Тёмный шоколад',
  200,
  'г',
  '50–70%'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки'),
  'Сливки 33–35%',
  100,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Какао-порошок'),
  'Какао-порошок',
  NULL,
  NULL,
  'для обсыпки'
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Нарежь шоколад на мелкие кусочки',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Нагрей сливки почти до кипения (но не кипяти!)',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Залей горячие сливки в шоколад',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Перемешай до гладкой массы',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Добавь сливочное масло и перемешай до блеска',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Перелей массу в форму (лучше застелить пергаментом)',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Убери в холодильник на 3–5 часов (или на ночь)',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Достань, нарежь на кубики',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Ганаш из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Посыпь какао сверху',
  8
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Гюдон из Dragon Ball',
  25,
  'medium',
  3,
  '_eYJQ6I8z5sPuf9i_oB4xxR9w7f2tozVJC_xQ8Wd2qO7aZnbCUNhMD-sKxViv66Vwr.jpg',
  'https://vt.tiktok.com/ZSQ7atjVK/',
  'https://t.me/otakukitchen/463',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Dragon Ball', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1),
  (SELECT id FROM animes WHERE title='Dragon Ball' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рис'),
('Тонко нарезанная говядина'),
('Лук'),
('Соевый соус'),
('Мирин'),
('Саке'),
('Сахар'),
('Вода'),
('Даси');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1),
  'Ингредиенты:',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Рис',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тонко нарезанная говядина'),
  'Тонко нарезанная говядина',
  150,
  '–200 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  0.5,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мирин'),
  'Мирин',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Саке'),
  'Саке',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода или даси',
  80,
  '–100 мл',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Свари рис до мягкости и выложи в глубокую миску.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Нарежь лук тонкими полукольцами.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'В сковороду добавь воду/даси, соевый соус, мирин, саке и сахар. Перемешай.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Добавь лук и туши 3–5 минут, пока он станет мягким.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Добавь тонкую говядину и готовь 5-10 минут, пока мясо полностью приготовится и впитает соус.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Гюдон из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Выложи говядину с луком поверх риса. Полей оставшимся соусом.',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Данго из «Наруто»',
  30,
  'easy',
  1,
  'a8d41a223d2118b5e1f09c434d93b8ed.jpg',
  'https://vm.tiktok.com/ZMAh4DGKH/',
  'https://telegram.me/otakukitchen/220',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Наруто', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Наруто' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рисовая мука'),
('Вода'),
('Сахар'),
('Клубничный сок'),
('Пищевой краситель'),
('Матча'),
('Шпинатный сок');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1),
  'Для окрашивания:',
  1
);

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рисовая мука'),
  'Рисовая мука (ширатамако или моти-ко)',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  160,
  'мл',
  'добавлять постепенно'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  2,
  'ст.л.',
  NULL
);

-- Для окрашивания
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для окрашивания:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубничный сок'),
  'Розовый: клубничного сока или пищевого красителя',
  '1–2 капли',
  '',
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для окрашивания:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Матча'),
  'Зелёный: матча (порошок зелёного чая) или шпинатный сок',
 ' 1 ч.л.',
  '',
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для окрашивания:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  0,
  'Белый: оставить без добавок',
  '  ',
  '',
  ''
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1),
  'Тесто',
  0
),
(
  (SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1),
  'Деление',
  1
),
(
  (SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1),
  'Формовка',
  2
),
(
  (SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1),
  'Варка',
  3
),
(
  (SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1),
  'Сборка',
  4
);

-- Шаги (Тесто)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'Смешайте рисовую муку с сахаром.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'Постепенно добавляйте воду, пока тесто не станет мягким, как пластилин.',
  1
);

-- Шаги (Деление)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Деление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'Разделите тесто на 3 части.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Деление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'В одну вмешайте розовый краситель/сок.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Деление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'В другую — порошок матча (или шпинатный сок).',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Деление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'Третью оставьте белой.',
  3
);

-- Шаги (Формовка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Формовка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'Из каждой части скатайте по 10 маленьких шариков (чтобы всего получилось 30). Размер — примерно как грецкий орех.',
  0
);

-- Шаги (Варка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Варка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'Закипятите воду. Опускайте шарики партиями.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Варка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'Когда всплывут — варите ещё 1–2 минуты.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Варка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'Переложите в миску с холодной водой.',
  2
);

-- Шаги (Сборка)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'На шпажку насадите шарики в порядке: розовый → белый → зелёный.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Данго из «Наруто»' LIMIT 1)
   LIMIT 1),
  'Подавайте тёплыми или комнатной температуры.',
  1
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Жареная курица из «Случайное такси»',
  155,
  'hard',
  4,
  'zfwtR-fgv5Ge5zAEQSaReMoPVuXmrNMWobNq0lK2wYZysLK1CEGS5pKz9geh5nw2IW.jpg',
  'https://vt.tiktok.com/ZSm2vYAuU/',
  'https://t.me/otakukitchen/374',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Случайное такси', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Случайное такси' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Куриные бёдра'),
('Репчатый лук'),
('Чеснок'),
('Мирин'),
('Растительное масло'),
('Картофельный крахмал'),
('Чёрный перец'),
('Соль');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1),
  'Ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1),
  'Кухонная утварь:',
  1
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриные бёдра'),
  'Куриные бёдра (филе)',
  8,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Репчатый лук'),
  'Репчатый лук',
  0.5,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  4,
  'зубчика',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мирин'),
  'Мирин',
  3,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Растительное масло'),
  'Растительное масло',
  1,
  'л',
  'для фритюра'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофельный крахмал'),
  'Картофельный крахмал',
  40,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чёрный перец'),
  'Чёрный перец',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  ''
);

-- Кухонная утварь
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Кухонная утварь:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  0,
  'Глубокая кастрюля / сотейник для фритюра',
  '',
  '',
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Кухонная утварь:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  0,
  'Решётка или бумажные полотенца',
 '',
  '',
  ''
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  'Нарежьте филе куриного бедра на кусочки примерно по 2–3 см.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  'В большой миске смешайте: мелко нарезанный лук, чеснок, мирин и щепотку чёрного перца. Добавьте курицу, тщательно перемешайте, накройте и уберите в холодильник минимум на 2 часа.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  'В глубокой кастрюле разогрейте масло до 175°C (средний огонь, масло должно быть горячим, но не дымиться).',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  'Насыпьте картофельный крахмал в отдельную миску и обваляйте каждый кусочек курицы.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  'Подготовьте решётку или застелите тарелку бумажными полотенцами, чтобы выкладывать готовую курицу.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  'Аккуратно опустите курицу в масло и жарьте 7–8 минут.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  'Выньте шумовкой, дайте маслу разогреться до 190°C и обжарьте курицу второй раз 3–5 минут до золотистой корочки.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареная курица из «Случайное такси»' LIMIT 1)
   LIMIT 1),
  'Выложите курицу на решётку/бумажные полотенца.',
  7
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Жареный рис из «Кланнад»',
  20,
  'medium',
  3,
  '5c4037d93a43a78a3390dbc023ce915f.jpg',
  'https://vt.tiktok.com/ZSmaeheh6/',
  'https://t.me/otakukitchen/389',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Кланнад', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Кланнад' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рис'),
('Яйца'),
('Морковь'),
('Кукуруза'),
('Ветчина'),
('Сосиски'),
('Зелёный лук'),
('Соль'),
('Чёрный перец'),
('Растительное масло'),
('Соевый соус');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты рецепта
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'рис',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'яйца',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'морковь',
  0.5,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кукуруза'),
  'кукуруза',
  2,
  '–3 ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'ветчина или сосиски',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелёный лук'),
  'зелёный лук',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'соль',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чёрный перец'),
  'чёрный перец',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Растительное масло'),
  'растительное масло',
  NULL,
  NULL,
  'для жарки'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'соевый соус',
  NULL,
  NULL,
  'по желанию'
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  'Мелко нарежь морковь и ветчину.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  'Разогрей сковороду с маслом, обжарь морковь до мягкости.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  'Добавь ветчину, обжарь 1–2 минуты.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  'Сдвинь всё в сторону, вбей яйца и быстро перемешай.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  'Добавь рис, разбей комочки и обжарь на сильном огне 3–4 минуты.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  'Всыпь кукурузу и зелёный лук.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Жареный рис из «Кланнад»' LIMIT 1)
   LIMIT 1),
  'Посоли, поперчи и при желании добавь немного соевого соуса.',
  6
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Завтрак из «Кошачий рай»',
  30,
  'medium',
  2,
  'anime-food-chocola-nekopara-usaklivxb9y5pdhz.jpg',
  'https://vt.tiktok.com/ZSxvfQRfE/',
  'https://telegram.me/otakukitchen/458',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Кошачий рай', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Кошачий рай' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Бекон'),
('Сосиска'),
('Картошка'),
('Мука'),
('Салат'),
('Помидор'),
('Соль'),
('Чёрный перец'),
('Масло');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1),
  'Ингредиенты:',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  3,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бекон'),
  'Бекон',
  2,
  'полоски',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиска'),
  'Большая сосиска',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картошка'),
  'Картошки',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  50,
  'гр',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Салат'),
  'Листа салата',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидор'),
  'Маленький помидор',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чёрный перец'),
  'Чёрный перец',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло'),
  'Масла',
  1,
  'ч. л.',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1),
  'Сделай драник',
  0
),
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1),
  'Обжарь бекон и сосиску',
  1
),
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1),
  'Приготовь глазунью',
  2
),
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1),
  'Собери тарелку',
  3
);

-- Шаги (Сделай драник)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Сделай драник' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'Натри 1 небольшую картошку, отожми воду, посоли, добавь яйцо, муку и сформируй лепёшку.',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Сделай драник' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'Обжарь на среднем огне по 4–5 минут с каждой стороны до золотистой корочки.',
  1
);

-- Шаги (Обжарь бекон и сосиску)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Обжарь бекон и сосиску' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'Разогрей сковороду.',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарь бекон и сосиску' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'Выложи бекон и жарь 2–3 минуты до румяности.',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Обжарь бекон и сосиску' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'Положи сосиску и периодически переворачивай, чтобы появилась красивая корочка.',
  2
);

-- Шаги (Приготовь глазунью)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовь глазунью' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'После бекона добавь немного масла.',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовь глазунью' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'Аккуратно разбей 2 яйца на сковороду.',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовь глазунью' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'Готовь на слабом огне 3–4 минуты.',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовь глазунью' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'Слегка посоли и поперчи.',
  3
);

-- Шаги (Собери тарелку)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Собери тарелку' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'На большую тарелку выложи:',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Собери тарелку' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'глазунью',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Собери тарелку' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'бекон',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Собери тарелку' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'сосиску',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Собери тарелку' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'драник',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Собери тарелку' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'листья салата',
  5
),
(
  (SELECT id FROM recipe_sections WHERE title='Собери тарелку' AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Кошачий рай»' LIMIT 1) LIMIT 1),
  'дольки помидора',
  6
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Завтрак из «Патриотизм Мориарти»',
  20,
  'easy',
  2,
 'e1aadc6650975c7d6cc0fef1b6880999.jpg',
  'https://vt.tiktok.com/ZSHbAkuFU/',
  'https://t.me/otakukitchen/435',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Патриотизм Мориарти', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Патриотизм Мориарти' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйцо'),
('Хамон'),
('Прошутто'),
('Бекон'),
('Фасоль в томатном соусе'),
('Шампиньоны'),
('Масло'),
('Соль'),
('Перец');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Хамон'),
  'Хамон / прошутто / бекон',
  2,
  'тонких ломтика',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фасоль в томатном соусе'),
  'Фасоль в томатном соусе',
  100,
  '–120 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шампиньоны'),
  'Шампиньоны',
  4,
  '–5 шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло'),
  'Масло (сливочное или немного растительного)',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль, перец',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1),
  'Приготовление',
  0
), 
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1),
  'Сборка',
  1
);


-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'Разогрей сухую сковороду.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'Выложи ломтики хамона:',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'жарь 1-2 минуты с каждой стороны. Сними и отложи.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'На той же сковороде:',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'нарежь шампиньоны пополам или пластинками',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'добавь немного масла',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'жарь 3–5 минут до румяности.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'В сковородку:',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'немного масла',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'разбей яйцо',
  9
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'жарь до состояния белок схватился, желток остался жидким',
  10
),

(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'яйцо',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'фасоль',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'хамон/бекон',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Патриотизм Мориарти»' LIMIT 1)
   LIMIT 1),
  'грибы',
  3
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Завтрак из «Последний Серафим»',
  45,
  'medium',
  2,
  'fa1242156c48751cedd1e68cdda1c85b.jpg',
  'https://vt.tiktok.com/ZSHv4Pocs/',
  'https://t.me/otakukitchen/437',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Последний Серафим', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Последний Серафим' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Белый хлеб'),
('Листья салата'),
('Сливочное масло'),
('Майонез'),
('Сосиски'),
('Яйца'),
('Брокколи'),
('Картофель фри'),
('Картофель'),
('Молоко'),
('Соль'),
('Масло'),
('Кетчуп'),
('Ветчина');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1),
  'Сэндвичи',
  0
),
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1),
  'Основное',
  1
),
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1),
  'Омлет',
  2
);

-- Сэндвичи
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Сэндвичи'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Белый хлеб'),
  'Белый хлеб',
  4,
  'ломтика',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Сэндвичи'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Сэндвичи'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло или майонез',
  NULL,
  NULL,
  ''
);

-- Основное
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основное'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Сосиски',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основное'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основное'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Брокколи'),
  'Брокколи',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основное'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель фри'),
  'Картофель фри',
  NULL,
  NULL,
  'горсть готового или 2 картофелины'
);

-- Омлет
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Омлет'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Омлет'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  1,
  '–2 ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Омлет'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  'щепотка'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Омлет'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло'),
  'Масло',
  NULL,
  NULL,
  'для жарки'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Омлет'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  NULL,
  NULL,
  'для рисунка сверху'
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1),
  'Приготовление',
  0
), 
(
  (SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1),
  'Сборка тарелки',
  1
);


-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Брокколи раздели на маленькие соцветия.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Отвари 2–3 минуты в подсоленной воде.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Картошку фри приготовь в духовке, аэрофритюрнице или на сковороде до золотистости.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Часть яиц отвари вкрутую или почти вкрутую.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Очисти и разрежь пополам.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Сделай на сосисках лёгкие надрезы.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Обжарь на сковороде до румяности.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Взбей яйца с молоком и щепоткой соли.',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Вылей на сковороду. Жарь на слабом огне, чтобы получился аккуратный овальный омлет или яичный блинчик. Сложи с двух сторон.',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Выложи на тарелку и сверху нарисуй кетчупом зигзаг.',
  9
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Хлеб слегка смажь маслом или майонезом.',
  10
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Положи внутрь ветчину и лист салата.',
  11
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Накрой вторым ломтиком.',
  12
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка тарелки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  '2 сэндвича',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка тарелки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  '2 сосиски',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка тарелки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'половинки варёных яиц',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка тарелки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'немного брокколи',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка тарелки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'немного картошки фри',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка тарелки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Завтрак из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'омлета с кетчупом',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Запечённая свинина из «Атака Титанов»',
  210,
  'medium',
  4,
  '592e9db551450de67a170b85352dbd0f.jpg',
  'https://vt.tiktok.com/ZSu3DHVof/',
  'https://t.me/otakukitchen/423',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Атака Титанов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Атака Титанов' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Свиной окорок'),
('Свиная шея'),
('Соль'),
('Чеснок'),
('Розмарин'),
('Тимьян'),
('Чёрный перец'),
('Мёд'),
('Соевый соус'),
('Оливковое масло'),
('Бульон');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Свиной окорок'),
  'Свиной окорок или шея',
  1,
  '–1.5 кг',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  '–1.5 ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  4,
  '–6 зубчиков',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Розмарин'),
  'Розмарин или тимьян',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чёрный перец'),
  'Чёрный перец',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мёд'),
  'Мёд',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Оливковое масло'),
  'Оливковое масло',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бульон'),
  'Бульон',
  150,
  'мл',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1),
  'Подготовка мяса',
  0
),
(
  (SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1),
  'Маринад',
  1
),
(
  (SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1),
  'Запекание',
  2
),
(
  (SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1),
  'Подача',
  3
);


-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Подготовка мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Возьмите цельный кусок свинины.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Подготовка мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Сделайте небольшие надрезы ножом.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Подготовка мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Вставьте в них кусочки чеснока.',
  2
),

(
  (SELECT id FROM recipe_sections
   WHERE title='Маринад'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Смешайте: соевый соус, мёд, масло, соль, перец, травы.',
  0
),

(
  (SELECT id FROM recipe_sections
   WHERE title='Маринад'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Натрите мясо и оставьте минимум на 1–2 часа (лучше на ночь).',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Запекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Разогрейте духовку до 180 °C.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Запекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Положите мясо в форму или на противень.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Запекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Налейте немного бульона на дно.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Запекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Накройте фольгой.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Запекание'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Запекайте: 1.5–2 часа',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Подача'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Запечённая свинина из «Атака Титанов»' LIMIT 1)
   LIMIT 1),
  'Дайте мясу отдохнуть 10 минут, потом нарежьте толстыми ломтиками.',
  0
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Карри-рагу из «Магической битвы»',
  50,
  'medium',
  3,
  '_eYJQ6I8z5sPuf9i_oB4xxR9w7f2tozVJC_xQ8Wd2qO7Vwr.jpg',
  'https://vt.tiktok.com/ZSxHSYCGb/',
  'https://telegram.me/otakukitchen/454',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Магическая битва', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Магическая битва' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Картофель'),
('Говядина'),
('Курица'),
('Морковь'),
('Лук'),
('Чеснок'),
('Томаты'),
('Томатная паста'),
('Сливки'),
('Карри'),
('Соль'),
('Перец'),
('Масло для жарки'),
('Тортилья'),
('Пита'),
('Чапати'),
('Мягкая лепёшка');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1),
  'Основные ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1),
  'Для подачи:',
  1
);

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'картофель',
  4,
  '–5 шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говядина'),
  'говядина или курица',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'морковь',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'лук',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'чеснок',
  2,
  'зубчика',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томаты'),
  'томаты /томатная паста',
  100,
  'г / 1 ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки'),
  'сливки',
  150,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Карри'),
  'карри',
  1,
  '–1,5 ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'соль, перец',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основные ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло для жарки'),
  'масло для жарки',
  NULL,
  NULL,
  NULL
);

-- Для подачи
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для подачи:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тортилья'),
  'тортилья, пита, чапати или любая мягкая лепёшка',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  'Нарежь мясо кусочками и обжарь до румяности.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  'Добавь лук, чеснок и морковь, жарь ещё пару минут.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  'Вмешай карри, томаты/томатную пасту, соль и перец.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  'Добавь картофель крупными кусочками и немного воды, чтобы почти покрывала ингредиенты.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  'Туши под крышкой 25–35 минут, пока картофель и мясо не станут мягкими.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  'Влей сливки и потуши ещё 5–7 минут, чтобы соус стал густым и оранжевым.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Карри-рагу из «Магической битвы»' LIMIT 1)
   LIMIT 1),
  'Подавай на лепёшке.',
  6
);
-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Кексы из «Дорохедоро»',
  45,
  'medium',
  1,
  '9FbtgFGcn6SKMllHfgD8JBwyGhNRtnwrlJiDDbHOLqQkjUtBHPZBQW85RUyqG-W5_3V.jpg',
  'https://vt.tiktok.com/ZSC6ucpd7/',
  'https://t.me/otakukitchen/465',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Дорохедоро', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Дорохедоро' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Пшеничная мука'),
('Миндальная мука'),
('Сахар'),
('Яйца'),
('Сливочное масло'),
('Молоко'),
('Мёд'),
('Ванильный экстракт'),
('Ванильный сахар'),
('Разрыхлитель'),
('Соль'),
('Миндальные орехи');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1),
  'Ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1),
  'Для украшения',
  1
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Пшеничная мука'),
  'Пшеничная мука',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Миндальная мука'),
  'Миндальная мука',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  90,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  60,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мёд'),
  'Мёд',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный экстракт'),
  'Ванильного экстракта или ванильного сахара',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  1,
  'ч. л.',
  NULL
);

-- Для украшения
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для украшения'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Миндальные орехи'),
  'Целые миндальные орехи',
  6,
  'шт.',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  'Размягчённое сливочное масло взбей с сахаром до пышной светлой массы.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  'По одному добавь яйца, каждый раз хорошо перемешивая.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  'Добавь молоко, мёд и ваниль.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  'Смешай пшеничную и миндальную муку, разрыхлитель и соль.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  'Постепенно добавь сухую смесь к жидкой и перемешай до однородного теста. Не вымешивай слишком долго.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  'Разложи тесто по формочкам примерно на ¾ объёма.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  'В центр каждого будущего кекса положи по одному миндалю, слегка утопив его в тесте.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Кексы из «Дорохедоро»' LIMIT 1)
   LIMIT 1),
  'Выпекай при 170°C около 20–25 минут, пока кексы не поднимутся и не станут золотистыми.',
  7
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Котлеты из «Конфликт братьев»',
  30,
  'medium',
  4,
  'xQ8Wd2qO7Vwr.jpg',
  'https://vt.tiktok.com/ZSxRby1Ta/',
  'https://t.me/otakukitchen/451',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Конфликт братьев', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Конфликт братьев' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Смешанный фарш'),
('Говядина'),
('Свинина'),
('Луковица'),
('Яйцо'),
('Панировочные сухари'),
('Молоко'),
('Соль'),
('Перец'),
('Сыр чеддер'),
('Кетчуп'),
('Соевый соус'),
('Вустерский соус'),
('Бальзамик'),
('Морковь'),
('Спаржа'),
('Брокколи');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1),
  'Ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1),
  'Соус',
  1
),
(
  (SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1),
  'Для подачи',
  2
);

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Смешанный фарш'),
  'Смешанного фарша (говядина + свинина)',
  400,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Луковица'),
  'Маленькая луковица',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Яйцо',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Панировочные сухари'),
  'Панировочных сухарей',
  3,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молока',
  '2–3',
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль, перец',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр чеддер'),
  'Ломтика сыра чеддер',
  2,
  'шт.',
  NULL
);

-- Соус
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Соус'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчупа',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Соус'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевого соуса',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Соус'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вустерский соус'),
  'Вустерского соуса (или немного бальзамика)',
  1,
  'ст. л.',
  NULL
);

-- Для подачи
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для подачи'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для подачи'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Спаржа'),
  'Спаржа/брокколи',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  'Лук мелко нарежь и обжарь до мягкости.',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  'Смешай фарш, лук, яйцо, сухари, молоко, соль и перец. Хорошо отбей массу руками.',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  'Сделай 2 большие овальные котлеты.',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  'Обжарь на среднем огне по 4–5 минут с каждой стороны.',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  'Сверху положи сыр и накрой крышкой, чтобы он расплавился.',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  'В сковороду добавь ингредиенты для соуса и прогрей 1–2 минуты.',
  5
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Конфликт братьев»' LIMIT 1) LIMIT 1),
  'Подавай с овощами и полей соусом.',
  6
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Котлеты из «Убей или умри»',
  35,
  'medium',
  3,
  'bntjNQRYSLmLxxeMz04JPa6XZ-hfMNLk5qDWUfFenlTqe3tF3TcoDPV2JdVy2.jpg',
  'https://www.tiktok.com/@otakukitchen/video/7622977311687576850',
  'https://t.me/otakukitchen/427',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Убей или умри', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Убей или умри' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Фарш'),
('Лук'),
('Чеснок'),
('Яйцо'),
('Панировочные сухари'),
('Молоко'),
('Соль'),
('Перец'),
('Мука'),
('Панко');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1),
  'Основа:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1),
  'Панировка:',
  1
);

-- Основа
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основа:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фарш'),
  'Фарш (свинина + говядина)',
  500,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основа:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основа:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  2,
  'зубчика',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основа:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основа:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Панировочные сухари'),
  'Панировочные сухари',
  2,
  '–3 ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основа:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  50,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Основа:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль, перец',
  NULL,
  NULL,
  ''
);

-- Панировка
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панировка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  NULL,
  NULL,
  'для обвалки'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панировка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панировка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Панко'),
  'Панко (или обычные сухари)',
  150,
  'г',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1),
  'Фарш',
  0
), 
(
  (SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1),
  'Формирование',
  1
), 
(
  (SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1),
  'Жарка',
  2
);



-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Фарш'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  'Сухари замочи в молоке на 2–3 минуты',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Фарш'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  'Смешай фарш + мелко нарезанный лук + чеснок',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Фарш'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  'Добавь яйцо, размоченные сухари, соль, перец. Хорошо вымеси.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Формирование'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  'Возьми порцию фарша. Сделай лепёшку',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Формирование'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  'Каждую котлету:',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Формирование'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  'Обвалять в муке',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Формирование'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  'Окунуть в яйцо',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Формирование'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  'Обвалять в панко',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Жарка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Котлеты из «Убей или умри»' LIMIT 1)
   LIMIT 1),
  'Разогрей масло (глубокая сковорода или фритюр). Жарь на среднем огне 5–6 минут с каждой стороны',
  0
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Куриная ножка из «Рубаки»',
  85,
  'medium',
  3,
  'lina-lina-invers.jpg',
  'https://vt.tiktok.com/ZSHyYjG4C/',
  'https://t.me/otakukitchen/431',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Рубаки', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Рубаки' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Куриные ножки'),
('Чеснок'),
('Мёд'),
('Соевый соус'),
('Соль'),
('Чёрный перец'),
('Паприка'),
('Сливочное масло'),
('Вода'),
('Бульон');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриные ножки'),
  'Куриные ножки',
  4,
  '–6 шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  4,
  '–5 зубчиков',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мёд'),
  'Мёд',
  1.5,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  3,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чёрный перец'),
  'Чёрный перец',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Паприка'),
  'Паприка (или BBQ приправа)',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода или бульон',
  100,
  'мл',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'Отдели мясо от куриной кости, но оставь верхнюю часть.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'Для маринада смешай:',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'соевый соус',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'мёд',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'измельчённый чеснок',
 4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'паприку',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'перец',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'Обмажь ножки и оставь минимум на 30–60 минут (лучше дольше).',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'Переложи в форму: добавь немного воды/бульона, сверху положи кусочек сливочного масла.',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Куриная ножка из «Рубаки»' LIMIT 1)
   LIMIT 1),
  'Запекай при 180°C ~35–45 минут.',
  9
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Манговое парфе',
  15,
  'medium',
  1,
  'photo_2026-07-15_16-01-32.jpg',
  'https://vt.tiktok.com/ZSHt1yPBD/',
  'https://t.me/otakukitchen/436',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Президент студсовета - горничная!', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1),
  (SELECT id FROM animes WHERE title='Президент студсовета - горничная!' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Манго'),
('Кукурузные хлопья'),
('Ванильное мороженое'),
('Яблоко'),
('Взбитые сливки');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Манго'),
  'Манго',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кукурузные хлопья'),
  'Кукурузные хлопья',
  15,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильное мороженое'),
  'Ванильное мороженое',
  2,
  'шарика',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Манго'),
  'Манго',
  1,
  'шт',
  'дополнительно для кусочков'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яблоко'),
  'Яблоко',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Взбитые сливки'),
  'Взбитые сливки',
  NULL,
  NULL,
  'для украшения'
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1),
  'Манговое пюре',
  0
),
(
  (SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1),
  'Подготовка фруктов',
  1
),
(
  (SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1),
  'Сборка',
  2
);


-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Манговое пюре'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'Нарежь манго',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Манговое пюре'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'Пробей в блендере до состояния пюре.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Подготовка фруктов'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'Манго и яблоко нарежь дольками',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'В высокий стакан слоями:',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'Манговое пюре',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'Мороженое',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'Хлопья',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'Манговое пюре',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'Вставить дольки манго и яблока',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Манговое парфе' LIMIT 1)
   LIMIT 1),
  'Взбитые сливки',
  6
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Меремере из «Семья Шпиона»',
  360,
  'hard',
  1,
  'photo_2026-07-15_16-04-45.jpg',
  'https://vt.tiktok.com/ZSxjxYvWv/',
  'https://t.me/otakukitchen/452',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Семья шпиона', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Семья шпиона' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Ванильное печенье'),
('Фундук'),
('Сливочное масло'),
('Апельсиновый сок'),
('Цедра'),
('Сахар'),
('Апельсиновый сироп'),
('Вода'),
('Соль'),
('Кукурузный крахмал'),
('Желтки'),
('Масло'),
('Лимонный сок'),
('Сухофрукты'),
('Ароматизатор рома'),
('Голубика'),
('Желатин'),
('Молоко'),
('Сливки'),
('Ваниль'),
('Жирные сливки'),
('Белки'),
('Лайм');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1),
  'Основа с фундуком:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1),
  'Апельсиновый сироп:',
  1
),
(
  (SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1),
  'Апельсиновый курд:',
  2
),
(
  (SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1),
  'Баварский крем с фруктами:',
  3
),
(
  (SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1),
  'Меренга:',
  4
);

-- Основа
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Основа с фундуком:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильное печенье'),
  'Ванильного печенья',
  177,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основа с фундуком:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Фундук'),
  'Фундука',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Основа с фундуком:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочного масла',
  200,
  'г',
  NULL
);

-- Апельсиновый сироп
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый сироп:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Апельсиновый сок'),
  'Сок 2 апельсинов',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый сироп:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Цедра'),
  'Цедры',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый сироп:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахара',
  60,
  'г',
  NULL
);

-- Апельсиновый курд
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый курд:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Апельсиновый сироп'),
  'Апельсинового сиропа',
  90,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый курд:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахара',
  90,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый курд:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Воды',
  150,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый курд:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Щепотка соли',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый курд:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кукурузный крахмал'),
  'Кукурузного крахмала',
  30,
  '–60 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый курд:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желтки'),
  'Желтка',
  3,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый курд:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло'),
  'Масла',
  25,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Апельсиновый курд:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонного сока',
  2,
  'ст. л.',
  NULL
);

-- Баварский крем
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухофрукты'),
  'Сухофруктов',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ароматизатор рома'),
  'Несколько капель ароматизатора рома',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Голубика'),
  'Голубики',
  25,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желатин'),
  'Желатина',
  12,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молока',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки'),
  'Сливок',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ваниль'),
  'Ванили',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желтки'),
  'Желтка',
  3,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахара',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Жирные сливки'),
  'Жирных сливок',
  440,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Баварский крем с фруктами:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Щепотка соли',
  NULL,
  NULL,
  NULL
);

-- Меренга
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Меренга:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Белки'),
  'Белков',
  6,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Меренга:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахара',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Меренга:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонного сока',
  0.5,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Меренга:' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лайм'),
  'Лайм',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
 (SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
 'Измельчи печенье и фундук, смешай с растопленным маслом. Утрамбуй в форму и выпекай 10 минут при 175°C',
 0
),
(
 (SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
 'Для сиропа провари апельсиновый сок, цедру и сахар 5–7 минут',
 1
),
(
 (SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
 'Для курда смешай сироп, воду, сахар, желтки и крахмал. Готовь до густоты, затем добавь масло и лимонный сок',
 2
),
(
 (SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
 'Замочи желатин. Подогрей молоко со сливками и ванилью. Отдельно взбей желтки с сахаром и постепенно введи горячую смесь. Верни на огонь до лёгкого загустения. Добавь желатин. Дай ему остыть',
 3
),
(
 (SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
 'Вмешай взбитые сливки, ягоды, сухофрукты и ароматизатор рома',
 4
),
(
 (SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
 'Вылей слой курда на основу, затем баварский крем и охлади несколько часов',
 5
),
(
 (SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
 'Для меренги прогрей белки с сахаром на водяной бане, затем взбей до плотных пиков',
 6
),
(
 (SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
 'Покрой торт меренгой, сделай красивые волны и слегка подпали горелкой или а духовку 220° на 2 минуты, режим гриль',
 7
),
(
 (SELECT id FROM recipe_sections WHERE title='Приготовление' AND recipe_id=(SELECT id FROM recipes WHERE name='Меремере из «Семья Шпиона»' LIMIT 1) LIMIT 1),
 'Укрась лаймом',
 8
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Мисосиро из «Боец-баки»',
  10,
  'medium',
  3,
  '518697014_10172359741640207_2367976522696214544_n.jpg',
  'https://vt.tiktok.com/ZSunWKy1H/',
  'https://t.me/otakukitchen/422',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Боец-баки', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Боец-баки' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Вода'),
('Мисо-паста'),
('Тофу'),
('Лук-порей'),
('Зелёный лук'),
('Водоросли вакаме');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  500,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мисо-паста'),
  'Мисо-паста',
  1,
  '–1,5 ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тофу'),
  'Тофу',
  120,
  '–150 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук-порей'),
  'Лук-порей',
  0.5,
  'стебля',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелёный лук'),
  'Зелёный лук',
  NULL,
  NULL,
  'немного для подачи'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Водоросли вакаме'),
  'Водоросли вакаме (по желанию)',
  1,
  'ч. л.',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  'В кастрюле доведи воду до горячего состояния, но не кипяти сильно.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  'Добавь водоросли вакаме и дай им размокнуть 1–2 минуты.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  'Нарежь тофу маленькими кубиками, а лук-порей — тонкими кольцами.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  'Выложи тофу и лук-порей в кастрюлю и прогрей около 1–2 минут.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  'В отдельной чашке размешай мисо-пасту с небольшим количеством горячего бульона из кастрюли, чтобы она полностью растворилась. Верни мисо-смесь обратно в суп и аккуратно перемешай.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Мисосиро из «Боец-баки»' LIMIT 1)
   LIMIT 1),
  'Разлей по мискам.',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Митараши данго из «Клинок, рассекающий демонов»',
  30,
  'medium',
  1,
  '489463075_10237291197727767_1505178345196480309_n.jpg',
  'https://www.tiktok.com/@otakukitchen/video/7499075582790028599',
  'https://t.me/otakukitchen/121',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Клинок, рассекающий демонов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes
   WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
   LIMIT 1),
  (SELECT id FROM animes
   WHERE title='Клинок, рассекающий демонов'
   LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рисовая мука'),
('Вода'),
('Сахар'),
('Ванилин'),
('Деревянные шпажки'),
('Соевый соус'),
('Сахарная пудра'),
('Картофельный крахмал');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes
   WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
   LIMIT 1),
  'Ингредиенты для данго:',
  0
),
(
  (SELECT id FROM recipes
   WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
   LIMIT 1),
  'Ингредиенты для соуса:',
  1
);

-- Ингредиенты в рецепте

-- Ингредиенты для данго:
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты для данго:'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рисовая мука'),
  'Рисовая мука',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты для данго:'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  130,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты для данго:'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты для данго:'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванилин'),
  'Ванилин',
  NULL,
  'на кончике ножа',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты для данго:'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Деревянные шпажки'),
  'Понадобятся деревянные шпажки',
  NULL,
  NULL,
  NULL
);

-- Ингредиенты для соуса:
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты для соуса:'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  50,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты для соуса:'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус (лёгкий)',
  30,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты для соуса:'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты для соуса:'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофельный крахмал'),
  'Картофельный крахмал',
  1,
  'ст. л.',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes
   WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
   LIMIT 1),
  'Приготовление шариков',
  0
),
(
  (SELECT id FROM recipes
   WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
   LIMIT 1),
  'Приготовление соуса',
  1
);

-- Шаги (Приготовление шариков)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление шариков'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  'В миске смешайте рисовую муку, воду, сахар и ванилин.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление шариков'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  'Замесите тесто, сформируйте из него шарики размером с грецкий орех (примерно 3–5 штук на одну шпажку).',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление шариков'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  'Дно пароварки застелите бумагой для запекания, выложите шарики и готовьте на пару 5 минут.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление шариков'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  'Нанижите шарики на шпажки.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление шариков'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  'Подсушите данго немного на сковороде или в духовке без масла.',
  4
);

-- Шаги (Приготовление соуса)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление соуса'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  'В небольшой кастрюле смешайте воду, соевый соус, сахарную пудру и крахмал.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление соуса'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  'Постоянно помешивая, доведите до кипения и варите пару минут, пока соус не загустеет.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление соуса'
   AND recipe_id=(
     SELECT id FROM recipes
     WHERE name='Митараши данго из «Клинок, рассекающий демонов»'
     LIMIT 1
   )
   LIMIT 1),
  'Подавайте данго тёплыми, обильно полив сверху соусом.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Овощной суп из «Последний Серафим»',
  30,
  'easy',
  3,
  'tumblr_nnajdjRKpc1t2rr2bo1_1280.jpg',
  'https://vt.tiktok.com/ZSuR3Csba/',
  'https://t.me/otakukitchen/396',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Последний Серафим', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Последний Серафим' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Вода'),
('Овощной бульон'),
('Куриный бульон'),
('Картофель'),
('Морковь'),
('Лук'),
('Растительное масло'),
('Соль');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода или лёгкий овощной/куриный бульон',
  700,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  2,
  '–3 шт',
  'крупные кубики'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  'толстые кружочки / бруски'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  0.5,
  '–1 шт',
  'крупно, по желанию'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Растительное масло'),
  'Растительное масло',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  ''
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Овощи нарежь крупно: картофель — большие кубики, морковь — толстые ломтики.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'В кастрюле разогрей масло, слегка обжарь лук до мягкости.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Добавь морковь, прогрей 1–2 минуты.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Всыпь картофель, залей водой или бульоном.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Посоли, доведи до кипения и вари 15–20 минут, пока картофель полностью мягкий.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Овощной суп из «Последний Серафим»' LIMIT 1)
   LIMIT 1),
  'Сними с огня, дай настояться 5 минут — бульон станет насыщеннее.',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Панкейки из «Твое Имя»',
  50,
  'hard',
  2,
  '1b8d72bf0f2c3555f47cc9781e87fa92.jpg',
  'https://vt.tiktok.com/ZS95PnAfn/',
  'https://t.me/otakukitchen/445',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Твое Имя', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Твое Имя' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Мука'),
('Сахар'),
('Молоко'),
('Разрыхлитель теста'),
('Ванильный сахар'),
('Соль'),
('Сахарная пудра'),
('Сливочное масло'),
('Ягоды'),
('Фрукты');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1),
  'Панкейки:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1),
  'Украшение:',
  1
);

-- Панкейки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панкейки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панкейки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  40,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панкейки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  30,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панкейки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  25,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панкейки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель теста'),
  'Разрыхлитель теста',
  0.5,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панкейки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Панкейки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  'щепотка'
);

-- Украшение
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Украшение:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Украшение:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Украшение:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ягоды'),
  'Ягоды, фрукты',
  NULL,
  NULL,
  ''
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'Яйца разделите на белки и желтки.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'Муку соедините с разрыхлителем и тщательно перемешайте.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'К сахару добавьте ванильный сахар, размешайте.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'Белки подсолите и взбейте до мягких пиков. Затем увеличивайте скорость вращения миксера и продолжайте взбивать, подсыпая сахар.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'В желтки влейте молоко и размешайте миксером. К взбитым желткам добавьте просеянную муку с разрыхлителем и перемешайте.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'Добавьте третью часть взбитых белков, разбавляя тесто. Перекладывайте тесто к остальным белкам и аккуратно размешивайте лопаткой.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'Смажьте разогретую сковороду сливочным маслом. Выложите тесто на сковороду по одной столовой ложке, постепенно наращивая толщину. На каждый оладушек на этом этапе должно уйти по 2,5 столовой ложки теста. Влейте в сковороду 1–2 чайные ложки воды для пара. Накройте крышкой и готовьте 2 минуты.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'Выложите ещё по 1 столовой ложке теста на каждый оладушек. Влейте ещё 1–2 чайные ложки воды и готовьте под крышкой ещё 4 минуты. Донышко должно зарумяниться, но не подгореть, поэтому нагрев должен быть очень умеренным.',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'Аккуратно переверните оладьи, не поднимая их на лопатке. Влейте снова 1–2 чайные ложки воды, накройте крышкой и готовьте 5–6 минут до полной готовности.',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'Протрите сковороду салфеткой, снова смажьте маслом и повторите процесс.',
  9
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Панкейки из «Твое Имя»' LIMIT 1)
   LIMIT 1),
  'Блюдо украсьте фруктами, ягодами, кусочком масла, сахарной пудрой.',
  10
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Печенье Сакуры из «Хоримия»',
  45,
  'medium',
  1,
  'photo_2026-07-15_16-17-15.jpg',
  'https://vt.tiktok.com/ZSxy8LPjM/',
  'https://t.me/otakukitchen/453',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Хоримия', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Хоримия' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Сливочное масло'),
('Сахарная пудра'),
('Желток'),
('Мука'),
('Миндальная мука'),
('Соль'),
('Ваниль'),
('Клубничная пудра'),
('Краситель'),
('Матча'),
('Какао');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1),
  'Ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1),
  'Для цветов:',
  1
);

-- Основные ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочного масла',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарной пудры',
  70,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желток'),
  'Желток',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Муки',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Миндальная мука'),
  'Миндальной муки',
  40,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Щепотка соли',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ваниль'),
  'Ванили',
  1,
  'ч. л.',
  NULL
);

-- Для цветов
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для цветов:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубничная пудра'),
  'Розовый: клубничная пудра или краситель',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для цветов:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Матча'),
  'Зелёный: матча',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для цветов:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Какао'),
  'Коричневый: какао',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Взбей мягкое масло с сахарной пудрой до крема.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Добавь желток, ваниль и соль.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Вмешай муку и миндальную муку. Должно получиться мягкое тесто.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Раздели тесто на 4 части и добавь разные вкусы/цвета.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Скатай маленькие шарики или овальные печеньки.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Выложи на пергамент и убери в холодильник на 20 минут.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Выпекай при 170°C 12–15 минут. Печенье не должно сильно зарумяниться.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Печенье Сакуры из «Хоримия»' LIMIT 1)
   LIMIT 1),
  'Остуди и сложи в бумажный пакетик/коробочку, как у Сакуры',
  7
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Пицца из Dragon Ball',
  70,
  'medium',
  3,
 'c87fe5637a7fbb3cf709e2f8874d6ee0.jpg',
  'https://vt.tiktok.com/ZS9GuPydk/',
  'https://t.me/otakukitchen/449',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Dragon Ball', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1),
  (SELECT id FROM animes WHERE title='Dragon Ball' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Тёплая вода'),
('Сухие дрожжи'),
('Сахар'),
('Соль'),
('Масло'),
('Моцарелла'),
('Сыр'),
('Соус'),
('Ветчина'),
('Бекон'),
('Зелёный болгарский перец'),
('Оливки'),
('Зелёный лук'),
('Спаржа'),
('Желток');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1),
  'Тесто:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1),
  'Начинка:',
  1
);

-- Тесто
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Муки',
  250,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тёплая вода'),
  'Тёплой воды',
  150,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухие дрожжи'),
  'Сухих дрожжей',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахара',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соли',
  0.5,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло'),
  'Масла',
  1,
  'ст. л.',
  NULL
);

-- Начинка
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Моцареллы и сыра',
  180,
  '–200 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соус'),
  'Соуса',
  '3–4',
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ветчина'),
  'Ветчины или бекона',
  70,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелёный болгарский перец'),
  'Зелёного болгарского перца',
  0.5,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Оливки'),
  'Несколько оливок',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелёный лук'),
  'Немного зелёного лука или спаржи',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Смешай воду, сахар и дрожжи, оставь на 10 минут.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Добавь муку, соль и масло, замеси тесто. Оставь на 30–40 минут.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Раскатай круг. И налепи корочки по краям',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Смажь томатным соусом, сверху выложи много моцареллы и сыра.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Добавь кусочки ветчины/бекона, зелёный перец, спаржу/зеленый лук и оливки.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Смажь желтком корочку',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из Dragon Ball' LIMIT 1)
   LIMIT 1),
  'Выпекай при 220–240°C 10–15 минут, пока края не подрумянятся, а сыр не расплавится.',
  6
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Пицца из «Одинокий рокер»',
  90,
  'medium',
  3,
  '86cd290af6416723cff2a57a30e84373.jpg',
  'https://vt.tiktok.com/ZSQ5QJ3qt/',
  'https://t.me/otakukitchen/461',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Одинокий рокер', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Одинокий рокер' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Тёплая вода'),
('Сухие дрожжи'),
('Сахар'),
('Соль'),
('Оливковое масло'),
('Томатный соус'),
('Моцарелла'),
('Сыр'),
('Пепперони'),
('Салями'),
('Зелёный болгарский перец');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1),
  'Для теста:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1),
  'Для начинки:',
  1
);

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для теста:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  250,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для теста:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тёплая вода'),
  'Тёплая вода',
  150,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для теста:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухие дрожжи'),
  'Сухие дрожжи',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для теста:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для теста:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.5,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для теста:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Оливковое масло'),
  'Оливковое масло',
  1,
  'ст. л.',
  NULL
);

-- Для начинки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для начинки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томатный соус'),
  'Томатный соус',
  '3–4',
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для начинки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Моцарелла и любой другой сыр',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для начинки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Пепперони'),
  'Пепперони или салями',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для начинки:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелёный болгарский перец'),
  'Зелёный болгарский перец',
  0.5,
  'шт.',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  'В тёплой воде растворяем сахар и дрожжи. Оставляем на 10 минут.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  'Добавляем муку, соль и оливковое масло. Замешиваем мягкое тесто.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  'Накрываем полотенцем и оставляем в тёплом месте на 1 час.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  'Раскатываем тесто в тонкий круг диаметром около 30 см и перекладываем на противень.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  'Смазываем основу томатным соусом.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  'Равномерно распределяем большую часть сыра.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  'Выкладываем кружочки пепперони и тонко нарезанный болгарский перец.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  'Выпекаем 10–15 минут при 220°C до золотистой корочки.',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Одинокий рокер»' LIMIT 1)
   LIMIT 1),
  'Даём пицце немного остыть, нарезаем на кусочки и подаём.',
  8
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Пицца из «Магическая битва»',
  110,
  'medium',
  3,
  '157547334_250805893390981_5389972619768209552_n.jpg',
  'https://vt.tiktok.com/ZSm3mDTpb/',
  'https://t.me/otakukitchen/394',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Магическая битва', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Магическая битва' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Тёплая вода'),
('Сухие дрожжи'),
('Сахар'),
('Соль'),
('Оливковое масло'),
('Томатный соус'),
('Пассата'),
('Моцарелла'),
('Пепперони'),
('Салями'),
('Шампиньон'),
('Зелёный перец'),
('Оливки');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1),
  'Тесто (на 1 пиццу ~28–30 см):',
  0
),
(
  (SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1),
  'Начинка:',
  1
);

-- Тесто
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто (на 1 пиццу ~28–30 см):'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  250,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто (на 1 пиццу ~28–30 см):'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тёплая вода'),
  'Тёплая вода',
  160,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто (на 1 пиццу ~28–30 см):'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухие дрожжи'),
  'Сухие дрожжи',
  3.5,
  'г',
  '½ пакетика'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто (на 1 пиццу ~28–30 см):'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  0.5,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто (на 1 пиццу ~28–30 см):'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.75,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто (на 1 пиццу ~28–30 см):'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Оливковое масло'),
  'Оливковое масло',
  1,
  'ст. л.',
  NULL
);

-- Начинка
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томатный соус'),
  'Томатный соус / пассата',
  4,
  '–5 ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Моцарелла'),
  'Моцарелла',
  200,
  '–250 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Пепперони'),
  'Пепперони / салями',
  80,
  '–120 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шампиньон'),
  'Шампиньон',
  1,
  'маленький',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелёный перец'),
  'Зелёный перец',
  NULL,
  NULL,
  'несколько колечек'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Оливки'),
  'Оливки',
  5,
  '–8 шт',
  'по желанию'
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1),
  'Как приготовить тесто',
  0
),
(
  (SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1),
  'Сборка и выпечка',
  1
);

-- Как приготовить тесто
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Как приготовить тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  'В тёплой воде растворить дрожжи и сахар, оставить на 5–10 минут.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Как приготовить тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  'Добавить соль и оливковое масло.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Как приготовить тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  'Всыпать муку, замесить тесто. Вымешивать 8–10 минут до гладкости и эластичности.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Как приготовить тесто'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  'Накрыть и оставить на 1–1,5 часа, пока тесто не увеличится в 2 раза.',
  3
);

-- Сборка и выпечка
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка и выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  'Разогрей духовку до 240–250°C.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка и выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  'Раскатай тесто тонко.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка и выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  'Смажь соусом, выложи сыр.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка и выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  'Добавь пепперони, грибы, перец и оливки.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка и выпечка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пицца из «Магическая битва»' LIMIT 1)
   LIMIT 1),
  'Выпекай 8–12 минут.',
  4
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Профитроли из «Магия и мускулы»',
  90,
  'hard',
  1,
  'photo_2026-07-15_16-22-10.jpg',
  'https://vt.tiktok.com/ZSXB9Bmh2/',
  'https://t.me/otakukitchen/6',
  0, 0,
  'Лучше подавать сразу после наполнения кремом.'
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Магия и мускулы', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Магия и мускулы' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Молоко'),
('Вода'),
('Масло сливочное'),
('Яйца'),
('Соль'),
('Сливки 33%'),
('Сыр творожный'),
('Сахар'),
('Сахарная пудра'),
('Шоколадная глазурь');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1),
  'Для теста',
  0
),
(
  (SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1),
  'Для крема',
  1
),
(
  (SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1),
  'Для украшения (по желанию)',
  2
);

-- Ингредиенты в рецепте

-- Для теста
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  150,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  125,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  125,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло сливочное'),
  'Масло сливочное',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца крупные',
  4,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  1,
  'щепотка',
  NULL
);

-- Для крема
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33%'),
  'Сливки 33%',
  400,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр творожный'),
  'Сыр творожный',
  250,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  100,
  'г',
  NULL
);

-- Для украшения
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения (по желанию)'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  NULL,
  'по желанию',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для украшения (по желанию)'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколадная глазурь'),
  'Шоколадная глазурь',
  NULL,
  'по желанию',
  NULL
);

-- Секции
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1),
  'Приготовление теста',
  0
),
(
  (SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1),
  'Выпекание профитролей',
  1
),
(
  (SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1),
  'Приготовление крема',
  2
),
(
  (SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1),
  'Наполнение профитролей',
  3
);

-- Шаги (Приготовление теста)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'В кастрюлю налейте воду и молоко, добавьте щепотку соли и сливочное масло',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'Поставьте кастрюлю на средний огонь и доведите смесь до кипения, чтобы масло полностью растаяло',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'Когда смесь закипит, сразу всыпьте всю муку и быстро перемешайте деревянной ложкой или лопаткой, пока тесто не станет однородным и не начнёт отставать от стенок кастрюли',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'Снимите кастрюлю с огня и дайте тесту немного остыть (до тёплого состояния), чтобы яйца не свернулись при добавлении',
  3
),

(
  (SELECT id FROM recipe_sections WHERE title='Приготовление теста'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'По одному введите яйца, каждый раз тщательно вымешивая тесто до однородной консистенции. Тесто должно стать гладким, блестящим и достаточно густым, чтобы удерживать форму',
  4
);

-- Шаги (Выпекание)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание профитролей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'Разогрейте духовку до 200°C',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание профитролей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'Переложите тесто в кондитерский мешок с круглой или звёздчатой насадкой',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание профитролей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'На противень, застеленный пергаментной бумагой, выдавите небольшие шарики теста, оставляя между ними расстояние, так как они увеличатся в размере при выпекании',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание профитролей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'Выпекайте профитроли 20-25 минут, пока они не станут золотистыми и хорошо поднимутся. Важно не открывать духовку в процессе, чтобы тесто не осело',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Выпекание профитролей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'Выньте профитроли из духовки и дайте им полностью остыть',
  3
);

-- Шаги (Крем)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'В глубокой миске взбейте сливки с сахаром до мягких пиков',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление крема'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'Добавьте творожный сыр и аккуратно взбивайте до однородности и устойчивых пиков. Крем должен быть густым и держать форму',
  1
);

-- Шаги (Наполнение)
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Наполнение профитролей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'С помощью кондитерского мешка с тонкой насадкой заполните каждую профитроль кремом. Можно также разрезать профитроли пополам и начинить кремом ложкой, если вам так удобнее',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Наполнение профитролей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'По желанию, посыпьте профитроли сахарной пудрой или украсьте шоколадной глазурью',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Наполнение профитролей'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Профитроли из «Магия и мускулы»' LIMIT 1) LIMIT 1),
  'Подавайте сразу после наполнения кремом.',
  2
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Пудинг Пурин из «86: Eighty-Six»',
  300,
  'medium',
  1,
  'TDCIrhKIuMaJicb.jpg',
  'https://vt.tiktok.com/ZSxpd6LvL/',
  'https://telegram.me/otakukitchen/457',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('86: Eighty-Six', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1),
  (SELECT id FROM animes WHERE title='86: Eighty-Six' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Сахар'),
('Вода'),
('Яйца'),
('Молоко'),
('Сливки 30–33%'),
('Ваниль');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1),
  'Для карамели:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1),
  'Для пудинга:',
  1
);

-- Для карамели
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для карамели:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для карамели:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для карамели:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Горячая вода',
  1,
  'ст. л.',
  NULL
);

-- Для пудинга
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  3,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  400,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 30–33%'),
  'Сливки 30–33%',
  100,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  70,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ваниль'),
  'Ваниль',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Сахар и воду нагреваем в сотейнике до янтарного цвета. Не мешайте ложкой — только слегка покачивайте сотейник.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Когда карамель станет золотистой — аккуратно влейте горячую воду и быстро перемешайте.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Разлейте карамель по формочкам.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Смешайте яйца с сахаром без сильного взбивания.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Подогрейте молоко со сливками и ванилью почти до горячего состояния, но не кипятите.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Медленно влейте молочную смесь к яйцам, постоянно помешивая.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Процедите смесь через сито.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Разлейте по формочкам.',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Готовьте на водяной бане: духовка 150°C — около 35–45 минут.',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Пудинг Пурин из «86: Eighty-Six»' LIMIT 1)
   LIMIT 1),
  'Остудите и уберите в холодильник минимум на 4 часа.',
  9
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Рагу с яйцом из «Семья Шпиона»',
  60,
  'medium',
  4,
  'photo_2026-07-15_16-26-53.jpg',
  'https://vt.tiktok.com/ZS9Q3yXkx/',
  'https://t.me/otakukitchen/448',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Семья Шпиона', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Семья Шпиона' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Говядина'),
('Картофель'),
('Лук'),
('Морковь'),
('Томатная паста'),
('Чеснок'),
('Паприка'),
('Соль'),
('Перец'),
('Бульон'),
('Вода'),
('Яйца'),
('Масло для жарки');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говядина'),
  'Говядина',
  400,
  '–500 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  2,
  '–3 шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Морковь',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Томатная паста'),
  'Томатная паста',
  2,
  'ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  2,
  'зубчика',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Паприка'),
  'Паприка',
  1,
  'ч.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль, перец — ‘‘',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бульон'),
  'Бульон или вода',
  500,
  'мл',
  'примерно'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло для жарки'),
  'Масло для жарки',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  'Нарежь мясо крупными кусочками и обжарь до румяности.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  'Добавь лук и морковь, жарь ещё 5 минут.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  'Добавь томатную пасту, чеснок и паприку, перемешай.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  'Закинь картофель крупными кусками и залей бульоном.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  'Туши под крышкой ~35–40 минут до мягкости мяса и картошки.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  'Отдельно пожарь яйца так, чтобы желток остался жидким.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рагу с яйцом из «Семья Шпиона»' LIMIT 1)
   LIMIT 1),
  'Подавай рагу с яйцом сверху',
  6
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Рисовая каша из «K-On!!»',
  40,
  'easy',
  3,
  '1448706718_386728828.jpg',
  'https://vt.tiktok.com/ZSmJBpp4B/',
  'https://t.me/otakukitchen/372',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('K-On!!', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1),
  (SELECT id FROM animes WHERE title='K-On!!' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рис'),
('Вода'),
('Соль'),
('Яйцо'),
('Сосиски'),
('Зелёный лук');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты рецепта
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Рис (японский / круглозёрный)',
  0.5,
  'стакана (≈90 г)',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  3,
  '–4 стакана',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  'щепотка'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сосиски'),
  'Небольшие сосиски',
  1,
  '–2 шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелёный лук'),
  'Зелёный лук / зелень',
  NULL,
  NULL,
  'немного'
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  'Рис хорошо промой, пока вода не станет почти прозрачной.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  'Переложи рис в кастрюлю, залей 3–4 стаканами воды.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая кша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  'Доведи до кипения, убавь огонь до минимума и вари 20–30 минут, иногда помешивая. Рис должен развариться и стать кашей. Посоли.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  'Пожарь сосиски 3–4 минуты. Добавь к ним рис и зелень.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Рисовая каша из «K-On!!»' LIMIT 1)
   LIMIT 1),
  'Обжарь яйцо и положи сверху на рис.',
  4
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сакэ дайкон из «Клинок рассекающий демонов»',
  60,
  'medium',
  3,
  'eb77f551e7815562cbfb10b61e610389.jpg',
  'https://vt.tiktok.com/ZSCtDjakD/',
  'https://t.me/otakukitchen/469',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Клинок рассекающий демонов', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Клинок рассекающий демонов' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Филе лосося'),
('Белая редька'),
('Зеленый лук'),
('Соевый соус'),
('Мирин'),
('Саке'),
('Сухое белое вино'),
('Сахар'),
('Вода'),
('Даси'),
('Рыбный бульон'),
('Овощной бульон');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1),
  'Ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1),
  'Для бульона',
  1
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Филе лосося'),
  'Филе лосося',
  2,
  'шт.',
  'около 300–350 г'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Белая редька'),
  'Белая редька',
  300,
  '–400 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зеленый лук'),
  'Зеленый лук',
  NULL,
  'для подачи',
  NULL
);

-- Для бульона
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мирин'),
  'Мирин',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Саке'),
  'Саке (или сухое белое вино)',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  300,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для бульона'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Даси'),
  'Даси',
  1,
  'ч. л. гранул',
  'или 300 мл рыбного/овощного бульона, если даси нет'
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  'Очисти белую редьку и нарежь крупными полукружьями толщиной около 2–3 см.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  'Переложи редьку в кастрюлю, залей холодной водой и вари 15–20 минут после закипания. Затем слей воду.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  'Лосось нарежь крупными кусками.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  'В кастрюле смешай воду, даши, соевый соус, мирин, саке, сахар. Доведи до легкого кипения.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  'Добавь редьку и готовь 10 минут.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  'Аккуратно положи сверху кусочки лосося. Убавь огонь до минимального и туши 10–12 минут. Если есть возможность, накрой блюдо кружком из пергамента. Если нет, то просто готовь под крышкой.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  'Выключи огонь и оставь блюдо на 10–15 минут, чтобы редька впитала аромат бульона.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сакэ дайкон из «Клинок рассекающий демонов»' LIMIT 1)
   LIMIT 1),
  'Подавай в глубокой миске, полив небольшим количеством бульона и посыпав мелко нарезанным зеленым луком.',
  7
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сливочный суп из Наруто',
  40,
  'medium',
  3,
  'photo_2026-07-15_17-52-39.jpg',
  'https://vt.tiktok.com/ZSCUYcDeS/',
  'https://t.me/otakukitchen/466',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Наруто', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1),
  (SELECT id FROM animes WHERE title='Наруто' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Куриное филе'),
('Морковь'),
('Луковица'),
('Свежий шпинат'),
('Сливки 20%'),
('Куриный бульон'),
('Сливочное масло'),
('Соль'),
('Чёрный перец');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриное филе'),
  'Куриное филе',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Морковь'),
  'Моркови',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Луковица'),
  'Небольшая луковица',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Свежий шпинат'),
  'Свежий шпинат',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 20%'),
  'Сливки 20%',
  200,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Куриный бульон'),
  'Куриный бульон',
  1.5,
  'л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  20,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль ‘‘',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чёрный перец'),
  'Чёрный перец ‘‘',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  'Отварите куриное филе в бульоне около 20 минут. Достаньте мясо, нарежьте небольшими кусочками и верните обратно в кастрюлю.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  'Добавьте нарезанную крупными кусочками морковь и варите 10–15 минут до мягкости.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  'На сливочном масле слегка обжарьте мелко нарезанный лук и добавьте в суп.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  'Положите шпинат и готовьте ещё 1–2 минуты, пока он слегка не уменьшится в объёме.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  'Влейте сливки, посолите и поперчите ‘‘. Прогрейте суп 2–3 минуты, не доводя до кипения.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сливочный суп из Наруто' LIMIT 1)
   LIMIT 1),
  'Подавайте горячим.',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Суп из «Обещанный Неверленд»',
  75,
  'medium',
  3,
  'photo_2026-07-15_17-55-22.jpg',
  'https://vt.tiktok.com/ZSXJoSjDL/',
  'https://t.me/otakukitchen/470',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Обещанный Неверленд', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Обещанный Неверленд' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Картофель'),
('Говядина'),
('Лук'),
('Грибы'),
('Растительное масло'),
('Лавровый лист'),
('Вода'),
('Соль');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Картофель'),
  'Картофель',
  450,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говядина'),
  'Говядина',
  300,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук'),
  'Лук',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Грибы'),
  'Грибы',
  150,
  'г',
  'лучше шиитаке или лесные грибы'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Растительное масло'),
  'Растительное масло',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лавровый лист'),
  'Лавровый лист',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  2.4,
  'л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  '',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Очисти картофель и нарежь крупными кусочками одинакового размера.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Говядину обсуши бумажным полотенцем и нарежь кубиками примерно такого же размера, как картофель.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Лук мелко нарежь.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Разогрей кастрюлю с маслом на сильном огне и обжарь говядину до красивой золотистой корочки со всех сторон. Затем переложи мясо на тарелку.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'В той же кастрюле обжарь лук на среднем огне до мягкости и грибы 5-8 минут, постоянно помешивая. Постарайся соскрести со дна все поджаристые кусочки после мяса.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Влей немного воды и хорошо перемешай, чтобы растворить все поджаренные кусочки, затем добавь оставшуюся воду.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Верни говядину вместе со всем выделившимся соком обратно в кастрюлю.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Добавь половину картофеля и лавровый лист.',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Накрой крышкой и вари 25 минут на небольшом огне.',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Достань кусочки мяса и временно переложи их на тарелку.',
  9
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Оставшийся в кастрюле картофель тщательно разомни прямо в бульоне до состояния кремового супа.Верни мясо обратно.',
  10
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Добавь вторую половину картофеля.',
  11
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Снова накрой крышкой и вари еще 20 минут, пока картофель не станет мягким.',
  12
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Посоли ‘‘ и достань лавровый лист.',
  13
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Суп из «Обещанный Неверленд»' LIMIT 1)
   LIMIT 1),
  'Разлей суп по глубоким тарелкам.',
  14
);


-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Сэндвич из «Этот замечательный мир!»',
  30,
  'easy',
  2,
  '79678d1c2a18cf7d9a0d1a6f57009852c3483686.91.9.9.3.jpeg',
  'https://vt.tiktok.com/ZSanB2AsP/',
  'https://t.me/otakukitchen/370',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Этот замечательный мир!', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Этот замечательный мир!' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Свинина'),
('Говядина'),
('Соль'),
('Чёрный перец'),
('Растительное масло'),
('Сливочное масло'),
('Майонез'),
('Соевый соус'),
('Вода'),
('Белый тостовый хлеб'),
('Листья салата');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1),
  'Мясо',
  0
),
(
  (SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1),
  'Для обжарки мяса',
  1
),
(
  (SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1),
  'Соус',
  2
),
(
  (SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1),
  'Для сборки',
  3
);

-- Мясо
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Мясо'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Свинина'),
  'Свинина (карбонад или шея)',
  250,
  '–300 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Мясо'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говядина'),
  'или говядина (тонкий край / вырезка)',
  250,
  'г',
  NULL
);

-- Для обжарки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для обжарки мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для обжарки мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чёрный перец'),
  'Чёрный перец',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для обжарки мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Растительное масло'),
  'Растительное масло',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для обжарки мяса'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  15,
  'г',
  NULL
);

-- Соус
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соус'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'Майонез',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соус'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  0.5,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соус'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  0.5,
  'ч. л.',
  NULL
);

-- Для сборки
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Белый тостовый хлеб'),
  'Белый тостовый хлеб',
  4,
  'ломтика',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата (айсберг / латук)',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Для сборки'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  NULL,
  NULL,
  'для хлеба (тонкий слой)'
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1),
  'Мясо',
  0
),
(
  (SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1),
  'Соус',
  1
),
(
  (SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1),
  'Хлеб',
  2
),
(
  (SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1),
  'Сборка',
  3
);


-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Мясо'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Нарежь мясо ломтями толщиной 1,5–2 см.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Мясо'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Посоли и поперчи с двух сторон.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Мясо'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Разогрей сковороду на среднем огне, добавь растительное масло.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Мясо'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Обжарь: свинину — 3–4 минуты с каждой стороны, говядину — 2,5–3 минуты с каждой стороны.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Мясо'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'В конце добавь сливочное масло и полей мясо.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Мясо'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Сними со сковороды, дай отдохнуть 5 минут, затем нарежь ломтиками.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Соус'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Смешай майонез, соевый соус и воду до гладкости.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Хлеб'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Срежь корочки с хлеба.',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Хлеб'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Слегка смажь хлеб сливочным маслом.',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Собери сэндвич: хлеб, тонкий слой соуса, салат, мясо, хлеб.',
  9
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Сборка'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Сэндвич из «Этот замечательный мир!»' LIMIT 1)
   LIMIT 1),
  'Аккуратно прижми и разрежь пополам.',
  10
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Тамого Какэ Гохан из «Серебряной ложки»',
  30,
  'easy',
  3,
  'silverspoon_17.jpg',
  'https://vt.tiktok.com/ZSmLyk7Pu/',
  'https://t.me/otakukitchen/373',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Серебряная ложка', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Серебряная ложка' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Круглый японский рис'),
('Вода'),
('Яйцо'),
('Соевый соус');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты рецепта
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Круглый японский рис'),
  'Круглый японский рис',
  1,
  'стакан (180 г)',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Вода'),
  'Вода',
  200,
  '–220 мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Очень свежее яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  '–2 ч. л.',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  'Насыпь рис в миску, залей холодной водой, аккуратно промой и слей воду. Повтори 3–4 раза, пока вода не станет почти прозрачной.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  'Переложи рис в кастрюлю, добавь 200–220 мл воды, накрой крышкой и доведи до кипения на среднем огне.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  'Как закипит — убавь огонь до минимума и вари 12 минут под крышкой, не открывая и не мешая.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  'Сними с огня и оставь под крышкой ещё на 10 минут.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  'Аккуратно разрыхли рис лопаткой вертикальными движениями.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  'Переложи горячий рис в миску.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  'Разбей яйцо прямо на рис.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  'Полей соевым соусом.',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тамого Какэ Гохан из «Серебряной ложки»' LIMIT 1)
   LIMIT 1),
  'Быстро перемешай до кремовой текстуры.',
  8
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Тонкацу из «Дитя погоды»',
  25,
  'medium',
  3,
  'photo_2026-07-15_18-00-26.jpg',
  'https://vt.tiktok.com/ZSQMDW1fF/',
  'https://t.me/otakukitchen/460',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Дитя погоды', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Дитя погоды' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Свиные отбивные'),
('Соль'),
('Перец'),
('Мука'),
('Яйцо'),
('Сухари панко'),
('Растительное масло'),
('Кунжутный соус'),
('Листья салата'),
('Помидоры черри');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1),
  'Тонкацу',
  0
),
(
  (SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1),
  'Кунжутный соус',
  1
);

-- Ингредиенты (Тонкацу)
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тонкацу'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Свиные отбивные'),
  'Свиные отбивные',
  2,
  'шт',
  'по 120–150 г'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тонкацу'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль и перец ‘‘',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тонкацу'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  2,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тонкацу'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Яйцо',
  1,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тонкацу'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сухари панко'),
  'Сухарей панко',
  60,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тонкацу'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Растительное масло'),
  'Растительное масло для жарки',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тонкацу'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кунжутный соус'),
  'Кунжутный соус',
  NULL,
  NULL,
  NULL
);

-- Ингредиенты (гарнир)
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Кунжутный соус'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Листья салата'),
  'Листья салата',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Кунжутный соус'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Помидоры черри'),
  'Помидоров черри',
  '4–6',
  'шт.',
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  'Свинину слегка отбить, посолить и поперчить.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  'Обвалять мясо в муке, затем в яйце и сухарях панко.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  'Обжарить в разогретом масле по 4–5 минут с каждой стороны до золотистой корочки.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  'Нарезать тонкацу крупными ломтиками и полить кунжутным соусом.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Тонкацу из «Дитя погоды»' LIMIT 1)
   LIMIT 1),
  'На тарелку выложить мясо, рядом листья салата и помидоры черри.',
  4
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Торт из «Хвост Феи»',
  120,
  'hard',
  1,
  'fdf01ca2d2e1dcc81fa7a3f5b40f1aac.jpg',
  'https://vt.tiktok.com/ZSuHwbXAj/',
  'https://t.me/otakukitchen/418',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Хвост Феи', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Хвост Феи' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйца'),
('Сахар'),
('Мука'),
('Кукурузный крахмал'),
('Растительное масло'),
('Молоко'),
('Соль'),
('Ванильный экстракт'),
('Сливки 33–35%'),
('Маскарпоне'),
('Сахарная пудра'),
('Клубника'),
('Тёмный шоколад');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1),
  'Бисквит:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1),
  'Крем:',
  1
),
(
  (SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1),
  'Начинка и декор:',
  2
);

-- Бисквит
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Бисквит:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  6,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Бисквит:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  120,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Бисквит:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  84,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Бисквит:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кукурузный крахмал'),
  'Кукурузный крахмал',
  36,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Бисквит:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Растительное масло'),
  'Растительное масло',
  72,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Бисквит:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  120,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Бисквит:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  0.5,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Бисквит:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный экстракт'),
  'Ванильный экстракт',
  1,
  'ч. л.',
  NULL
);

-- Крем
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Крем:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33–35%'),
  'Сливки 33–35%',
  400,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Крем:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Маскарпоне'),
  'Маскарпоне',
  200,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Крем:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  4,
  '–5 ст. л.',
  NULL
);

-- Начинка и декор
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Начинка и декор:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Клубника'),
  'Клубника',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Начинка и декор:' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тёмный шоколад'),
  'Тёмный шоколад',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1),
  'Бисквит',
  0
),
(
  (SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1),
  'Выпечка',
  1
),
(
  (SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1),
  'Крем',
  2
),
(
  (SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1),
  'Сборка торта',
  3
);


-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
((SELECT id FROM recipe_sections WHERE title='Бисквит' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Отделите белки от желтков.',1),
((SELECT id FROM recipe_sections WHERE title='Бисквит' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Желтки смешайте с молоком, растительным маслом и ванилью.',2),
((SELECT id FROM recipe_sections WHERE title='Бисквит' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Просейте муку, кукурузный крахмал и соль, добавьте в желтковую смесь и перемешайте до гладкости.',3),
((SELECT id FROM recipe_sections WHERE title='Бисквит' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Белки начните взбивать, постепенно добавляя сахар.',4),
((SELECT id FROM recipe_sections WHERE title='Бисквит' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Взбейте до устойчивых пиков.',5),
((SELECT id FROM recipe_sections WHERE title='Бисквит' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Добавьте небольшую часть белков в тесто и аккуратно перемешайте. Затем вмешайте остальные белки лопаткой снизу вверх, чтобы сохранить воздушность.',6),
((SELECT id FROM recipe_sections WHERE title='Выпечка' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Разлейте тесто в 2 формы по ~17 см. Или выпекайте в одной по очереди.',8),
((SELECT id FROM recipe_sections WHERE title='Выпечка' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Поставьте формы в глубокий противень. Налейте вокруг горячую воду, чтобы торт выпекался на водяной бане.',9),
((SELECT id FROM recipe_sections WHERE title='Выпечка' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Выпекать 18 минут при 150°C. Затем уменьшить температуру до 130°C и выпекать ещё 3–5 минут',10),
((SELECT id FROM recipe_sections WHERE title='Выпечка' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'После выпечки полностью остудите бисквит, только потом доставайте из формы.',11),
((SELECT id FROM recipe_sections WHERE title='Крем' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Холодные сливки взбейте до мягких пиков. Добавьте маскарпоне и сахарную пудру.',13),
((SELECT id FROM recipe_sections WHERE title='Крем' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Взбейте до густого стабильного крема.',14),
((SELECT id FROM recipe_sections WHERE title='Сборка торта' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'На первый бисквит нанесите крем. Сделайте «яму» из крема.',16),
((SELECT id FROM recipe_sections WHERE title='Сборка торта' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Добавьте кусочки клубники.',17),
((SELECT id FROM recipe_sections WHERE title='Сборка торта' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Сверху положите второй бисквит.',18),
((SELECT id FROM recipe_sections WHERE title='Сборка торта' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Украсить кремом.',19),
((SELECT id FROM recipe_sections WHERE title='Сборка торта' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Выложите клубнику по кругу сверху.',20),
((SELECT id FROM recipe_sections WHERE title='Сборка торта' AND recipe_id=(SELECT id FROM recipes WHERE name='Торт из «Хвост Феи»' LIMIT 1) LIMIT 1),'Растопленным тёмным шоколадом нарисуйте логотип на бумаге. Застудите его в морозилке (5 минут) и переложите на торт.',21);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Хрустящие спринг-роллы с тунцом',
  20,
  'medium',
  3,
  'hq720_2.jpg',
  'https://vt.tiktok.com/ZSmQ4H5gW/',
  'https://t.me/otakukitchen/390',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Какой сейчас Тамон?', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1),
  (SELECT id FROM animes WHERE title='Какой сейчас Тамон?' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рисовая бумага'),
('Тунец'),
('Кукуруза'),
('Сыр'),
('Майонез'),
('Яйцо'),
('Молоко'),
('Масло для жарки');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты рецепта
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рисовая бумага'),
  'рисовая бумага',
  4,
  '–5 листов',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тунец'),
  'тунец (консервированный)',
  80,
  'гр',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кукуруза'),
  'кукуруза',
  2,
  '-2,5 ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сыр'),
  'сыр (любой хорошо плавящийся)',
  30,
  '-40 гр',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Майонез'),
  'майонез',
  1,
  'ст.л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'молоко',
  1.5,
  '-2 ст.л',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Масло для жарки'),
  'масло для жарки',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  'Тунец слей и разомни вилкой.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  'Добавь кукурузу, тёртый сыр и майонез — перемешай до кремовой начинки.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  'В отдельной миске взбей яйцо с молоком.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  'Сухой лист рисовой бумаги быстро окуни в яично-молочную смесь.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  'Выложи начинку и сверни плотным рулетом.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  'Обжарь в разогретом масле до золотистой и хрустящей корочки.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Хрустящие спринг-роллы с тунцом' LIMIT 1)
   LIMIT 1),
  'Выложи на бумажное полотенце и разрежь пополам.',
  6
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Чахан с креветками из «Дарованный»',
  25,
  'medium',
  3,
  'photo_2026-07-15_18-10-20.jpg',
  'https://vt.tiktok.com/ZS9RRfen3/',
  'https://t.me/otakukitchen/439',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Дарованный', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Дарованный' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Рис'),
('Креветки'),
('Яйца'),
('Зелёный лук'),
('Чеснок'),
('Растительное масло'),
('Соевый соус'),
('Соль'),
('Перец');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1),
  'Ингредиенты',
  0
),
(
  (SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1),
  'Соусы:',
  1
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Рис',
  250,
  '–300 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Креветки'),
  'Креветки',
  150,
  '–200 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Зелёный лук'),
  'Зелёный лук',
  2,
  '–3 пера',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чеснок'),
  'Чеснок',
  1,
  'зубчик',
  'по желанию'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Растительное масло'),
  'Растительное масло',
  1,
  '–2 ст. л.',
  NULL
);

-- Соусы
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соусы:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соевый соус'),
  'Соевый соус',
  1,
  '–2 ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соусы:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Соусы:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Перец'),
  'Перец',
  NULL,
  NULL,
  ''
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'Взбей яйца',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'На сковороде быстро сделай мягкие кусочки. Убери в сторону',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'Обжарь креветки 1–2 минуты до розового цвета. Убери',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'В той же сковороде разогрей масло. Добавь чеснок',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'Добавь рис и хорошо разрыхли',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'Жарь на среднем/сильном огне, постоянно мешая',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'Верни креветки',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'Добавь яйца',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'Влей соевый соус',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чахан с креветками из «Дарованный»' LIMIT 1)
   LIMIT 1),
  'Добавь зелёный лук',
  9
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Чизбургер из «Баскетбол Куроко»',
  20,
  'easy',
  3,
  'wlSOX8nkiOi8x9MjWu38wW0_u295ayUeWOC-BHhZVj-cbviJUGRq2IpGkeV8zvpyraPxgJDo.jpg',
  'https://vt.tiktok.com/ZSHaTPK4Y/',
  'https://t.me/otakukitchen/433',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Баскетбол Куроко', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Баскетбол Куроко' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Булочки'),
('Говяжий фарш'),
('Плавленый сыр'),
('Маринованные огурцы'),
('Кетчуп'),
('Горчица'),
('Соль'),
('Перец');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Булочки'),
  'Булочки',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Говяжий фарш'),
  'Говяжий фарш',
  100,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Плавленый сыр'),
  'Плавленый сыр (чеддер)',
  1,
  'ломтик',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Маринованные огурцы'),
  'Маринованные огурцы',
  4,
  '-7 кружочков',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Кетчуп'),
  'Кетчуп',
  2,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Горчица'),
  'Горчица',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль, перец',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  'Сделай очень тонкие котлеты',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  'Посоли/поперчи',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  'Жарь на сильном огне по 4-6 минут с каждой стороны',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  'Поджарь внутреннюю сторону на сухой сковороде',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  'Смажьте булочки кетчупом и горчицей',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Чизбургер из «Баскетбол Куроко»' LIMIT 1)
   LIMIT 1),
  'Сборка: нижняя булочка, котлета, сыр, верхняя булочка',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Шоколадные кексы',
  35,
  'medium',
  1,
  'photo_2026-07-15_18-13-42.jpg',
  'https://vt.tiktok.com/ZSmop2ttU/',
  'https://t.me/otakukitchen/395',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Человек-невидимка и обычная девушка', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1),
  (SELECT id FROM animes WHERE title='Человек-невидимка и обычная девушка' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Яйцо'),
('Молоко'),
('Сливочное масло'),
('Сахар'),
('Мука'),
('Разрыхлитель'),
('Соль'),
('Шоколадные капли'),
('Ванильный экстракт');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты рецепта
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйцо'),
  'Яйцо',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  120,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Растопленное сливочное масло',
  60,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  180,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Разрыхлитель'),
  'Разрыхлитель',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Щепотка соли',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколадные капли'),
  'Шоколадные капли',
  80,
  '–100 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный экстракт'),
  'Ванильный экстракт',
  NULL,
  NULL,
  'по желанию'
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  'В миске смешай яйцо, сахар и ваниль — слегка взбей венчиком.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  'Добавь молоко и растопленное масло, перемешай до однородности.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  'Всыпь муку, разрыхлитель и соль — перемешай.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  'Добавь шоколад, оставив немного для верха.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  'Разложи тесто по формочкам на ¾ объёма и посыпь шоколадом сверху.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадные кексы' LIMIT 1)
   LIMIT 1),
  'Выпекай при 180°C ~20–25 минут до золотистой корочки.',
  5
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Шоколадный пудинг из «Гостиница Окко»',
  360,
  'medium',
  1,
  'b4b52b9dc6816f2aa89711cc78335715.jpg',
  'https://vt.tiktok.com/ZS9hKymHY/',
  'https://t.me/otakukitchen/444',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Гостиница Окко', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Гостиница Окко' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Молоко'),
('Сливки'),
('Яйца'),
('Желтки'),
('Сахар'),
('Какао'),
('Тёмный шоколад'),
('Ванильный сахар'),
('Соль'),
('Карамельный соус'),
('Белый шоколад'),
('Мандарины'),
('Мята');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1),
  'Для пудинга:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1),
  'Для заливки сверху:',
  1
),
(
  (SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1),
  'Украшение:',
  2
);

-- Для пудинга
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  500,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки'),
  'Сливки (20–33%)',
  150,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Желтки'),
  'Желтки',
  2,
  'шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  80,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Какао'),
  'Какао',
  25,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Тёмный шоколад'),
  'Тёмный шоколад',
  80,
  '–100 г',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Ванильный сахар'),
  'Ванильный сахар',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для пудинга:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Щепотка соли',
  NULL,
  NULL,
  NULL
);

-- Для заливки сверху
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Для заливки сверху:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Карамельный соус'),
  'Карамельный соус',
  4,
  '–5 ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Для заливки сверху:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Белый шоколад'),
  'Белый шоколад + сливки',
  60,
  'г + 80 мл',
  NULL
);

-- Украшение
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups WHERE title='Украшение:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мандарины'),
  'Мандарины',
  2,
  '–3 шт.',
  NULL
),
(
  (SELECT id FROM ingredient_groups WHERE title='Украшение:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мята'),
  'Мята (или любая зелень для вида)',
  NULL,
  NULL,
  NULL
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'В кастрюле смешай: молоко + сливки + сахар + какао + ваниль + соль',
  0
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Поставь на средний огонь и нагревай, помешивая, пока смесь станет горячей (но НЕ кипит).',
  1
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Сними с огня и добавь тёмный шоколад',
  2
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Перемешай до полностью гладкой массы без кусочков.',
  3
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'В отдельной миске слегка взбей яйца и желтки (без пены, просто перемешать).',
  4
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Влей 1–2 половника горячей смеси в яйца, быстро мешая (это чтобы они не свернулись).',
  5
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Потом вылей всё обратно в кастрюлю и перемешай.',
  6
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Перелей в форму (или маленькие формочки). Поставь форму в глубокий противень и налей горячую воду до середины формы — это водяная баня.',
  7
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Запекай при 150–160°C ~45–55 минут',
  8
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Пудинг готов, когда: края плотные, центр слегка «дрожит». Полностью остуди при комнатной температуре, потом убери в холодильник минимум на 4 часа (лучше на ночь)',
  9
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Заливка: Вариант 1: Просто полей карамелью',
  10
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Заливка: Вариант 2: Нагрей сливки и залей ими белый шоколад → перемешай до крема',
  11
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Выложи пудинг на тарелку',
  12
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Полей сверху заливкой',
  13
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Разложи дольки мандарина',
  14
),
(
  (SELECT id FROM recipe_sections WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Шоколадный пудинг из «Гостиница Окко»' LIMIT 1) LIMIT 1),
  'Добавь мяту',
  15
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Яблочное ризотто с беконом и мятой',
  40,
  'medium',
  4,
  'photo_2026-07-15_18-16-43.jpg',
  'https://vt.tiktok.com/ZSaCe8PKG/',
  'https://t.me/otakukitchen/364',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('В поисках божественного рецепта', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1),
  (SELECT id FROM animes WHERE title='В поисках божественного рецепта' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Лук репчатый'),
('Яблоко'),
('Рис'),
('Яблочный сок'),
('Сливочное масло'),
('Лимонный сок'),
('Пармезан'),
('Бекон'),
('Мята'),
('Соль'),
('Чёрный перец'),
('Курица');

-- Группа ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1),
  'Ингредиенты',
  0
);

-- Ингредиенты рецепта
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лук репчатый'),
  'Лук репчатый',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яблоко'),
  'Яблоко',
  1,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Рис'),
  'Рис короткозёрный (арборио / круглозёрный)',
  0.5,
  'стакана',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яблочный сок'),
  'Яблочный сок',
  2,
  'стакана',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Сливочное масло',
  1,
  'ст. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Лимонный сок'),
  'Лимонный сок',
  1,
  'ч. л.',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Пармезан'),
  'Пармезан',
  50,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бекон'),
  'Бекон',
  3,
  '–4 ломтика',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мята'),
  'Мята',
  5,
  '–6 листиков',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Соль',
  NULL,
  NULL,
  ''
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Ингредиенты'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Чёрный перец'),
  'Чёрный перец',
  NULL,
  NULL,
  ''
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  'Мелко нарежьте кубиками лук, яблоко и натрите пармезан.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  'Растопите сливочное масло на сковороде, обжарьте лук до мягкости и прозрачности.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  'Добавьте рис и прогрейте его 1 минуту, помешивая. Добавьте 2–3 ст. л. воды и ½ ч. л. лимонного сока, прогрейте 30 секунд.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  'Влейте ⅓ стакана яблочного сока и готовьте, постоянно помешивая, пока рис не впитает жидкость.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  'Продолжайте добавлять сок порциями, пока рис не станет мягким и кремовым (примерно 20 минут).',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  'В конце проверьте рис на мягкость, если он еще твердый, то можно добавить немного воды и потушить пару минут под крышкой до мягкости.',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  'Добавьте в ризотто перец, пармезан, яблоки и 1 ч. л. лимонного сока.',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  'Обжарьте бекон до хруста и курицу до готовности (золотистой корочки).',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Яблочное ризотто с беконом и мятой' LIMIT 1)
   LIMIT 1),
  'Выложите ризотто на тарелку, сверху — кусочки бекона. Посыпьте мелко нарезанной мятой.',
  8
);

-- Рецепт
INSERT INTO recipes (
  name, cooking_time, level, category_id,
  image_url, tiktok_url, telegram_url,
  is_favourite, is_cooked, note
) VALUES (
  'Японские крепы из «Мой братик больше не братик»',
  45,
  'medium',
  1,
  'onimai-oniichan-wa-oshimai.gif',
  'https://vt.tiktok.com/ZSuoLAAMf/',
  'https://t.me/otakukitchen/424',
  0, 0,
  NULL
);

-- Аниме
INSERT OR IGNORE INTO animes (title, scene_description, episode)
VALUES ('Мой братик больше не братик', NULL, NULL);

-- Связка рецепт-аниме
INSERT INTO recipes_in_anime (recipe_id, anime_id)
VALUES (
  (SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1),
  (SELECT id FROM animes WHERE title='Мой братик больше не братик' LIMIT 1)
);

-- Ингредиенты
INSERT OR IGNORE INTO ingredients (name) VALUES
('Мука'),
('Яйца'),
('Молоко'),
('Сахар'),
('Соль'),
('Сливочное масло'),
('Сливки 33–35%'),
('Сахарная пудра'),
('Бананы'),
('Шоколадный соус');

-- Группы ингредиентов
INSERT INTO ingredient_groups (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1),
  'Тесто:',
  0
),
(
  (SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1),
  'Начинка:',
  1
);

-- Тесто
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Мука'),
  'Мука',
  130,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Яйца'),
  'Яйца',
  2,
  'шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Молоко'),
  'Молоко',
  300,
  'мл',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахар'),
  'Сахар',
  25,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Соль'),
  'Щепотка соли',
  NULL,
  NULL,
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Тесто:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливочное масло'),
  'Растопленное сливочное масло',
  25,
  'г',
  NULL
);

-- Начинка
INSERT INTO ingredients_in_recipe (
  group_id, ingredient_id, display_name, quantity, unit, note
) VALUES
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сливки 33–35%'),
  'Сливки 33–35%',
  250,
  'мл',
  'очень холодные!'
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Сахарная пудра'),
  'Сахарная пудра',
  30,
  'г',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Бананы'),
  'Бананы',
  1,
  '–2 шт',
  NULL
),
(
  (SELECT id FROM ingredient_groups
   WHERE title='Начинка:'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  (SELECT id FROM ingredients WHERE name='Шоколадный соус'),
  'Шоколадный соус',
  NULL,
  NULL,
  ''
);

-- Секция
INSERT INTO recipe_sections (recipe_id, title, order_index) VALUES
(
  (SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1),
  'Приготовление',
  0
);

-- Шаги
INSERT INTO steps (section_id, description, order_index) VALUES
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'В миске взбей яйца + сахар + соль.',
  0
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Влей половину молока, перемешай.',
  1
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Добавь муку, размешай до гладкости.',
  2
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Влей оставшееся молоко.',
  3
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Добавь растопленное масло.',
  4
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Оставь тесто на 15–30 минут (так блины будут эластичные и не рвутся).',
  5
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Хорошо разогрей сковороду (средний огонь).',
  6
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Первый раз слегка смажь маслом.',
  7
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Наливай немного теста и быстро распределяй тонким слоем. Жарь ~40–60 секунд.',
  8
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Переверни и подержи ещё 10–20 секунд. Складывай стопкой и накрой, чтобы не пересохли.',
  9
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Холодные сливки взбивай на средней скорости.',
  10
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Когда появятся мягкие пики — добавь пудру.',
  11
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Взбей до плотных пиков. Крем должен быть густой и держать форму, иначе вытечет.',
  12
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Положи блинчик.',
  13
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Ближе к центру выложи толстую полоску сливок.',
  14
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Сверни в плотный конус.',
  15
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Добавь кружочки банана.',
  16
),
(
  (SELECT id FROM recipe_sections
   WHERE title='Приготовление'
   AND recipe_id=(SELECT id FROM recipes WHERE name='Японские крепы из «Мой братик больше не братик»' LIMIT 1)
   LIMIT 1),
  'Полей шоколадом.',
  17
);
