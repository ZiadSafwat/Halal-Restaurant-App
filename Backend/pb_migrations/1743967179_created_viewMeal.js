/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "sd1jud57vf2c1hn",
    "created": "2025-04-06 19:19:39.122Z",
    "updated": "2025-04-06 19:19:39.122Z",
    "name": "viewMeal",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "jbklndfh",
        "name": "meal_id",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      },
      {
        "system": false,
        "id": "qpf0uxbk",
        "name": "meal_description",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      },
      {
        "system": false,
        "id": "4lou2yhl",
        "name": "meal_name",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      },
      {
        "system": false,
        "id": "feh1yuac",
        "name": "meal_created",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      },
      {
        "system": false,
        "id": "6psqxocg",
        "name": "discount",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      },
      {
        "system": false,
        "id": "bzetnlzb",
        "name": "image",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      },
      {
        "system": false,
        "id": "phrzibqo",
        "name": "discount_last_date",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      },
      {
        "system": false,
        "id": "w23g4ru4",
        "name": "discounted_price",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      },
      {
        "system": false,
        "id": "yrl6m7ay",
        "name": "plates",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 1
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "WITH expanded_plates AS (\n    SELECT\n        meals.id AS meal_id,\n        meals.name AS meal_name,        meals.description AS meal_description,  -- ✅ Added meal description\n        meals.image AS meal_image,\n        meals.discount,\n        meals.image,\n        meals.discount_last_date,\n        meals.created AS meal_created, \n        plates.id AS plate_id,\n        plates.buyNumber AS plate_buyNumber,\n        plates.name AS plate_name,\n        plates.description AS plate_description,\n        plates.price AS plate_price,\n        plates.ingredients  -- ✅ Added ingredients\n    FROM meals\n    CROSS JOIN json_each(meals.plates)\n    JOIN plates ON plates.id = json_each.value\n),\nexpanded_ingredients AS (\n    SELECT\n        plate_id,\n        json_each.value AS ingredient_id\n    FROM expanded_plates,\n    json_each(expanded_plates.ingredients)  -- ✅ Expand the ingredients JSON array\n),\ningredient_details AS (\n    SELECT\n        ingredients.id AS ingredient_id,\n        ingredients.name AS ingredient_name\n    FROM ingredients  -- ✅ Assuming a table named \"ingredients\" exists with id and name\n),\nmeal_totals AS (\n    SELECT\n        meal_id,\n        meal_name,        meal_description,  -- ✅ Included meal description\n        meal_created,\n        SUM(plate_price) AS total_price,\n        discount,\n        image,\n        discount_last_date,\n        (SUM(plate_price) * (1 - discount / 100)) AS discounted_price\n    FROM expanded_plates\n    WHERE discount_last_date >= DATE('now') \n    GROUP BY meal_id, meal_name, meal_created, discount, discount_last_date\n)\n\nSELECT \n    (meal_totals.meal_id || '_' || meal_totals.discount_last_date) AS id,\n    meal_totals.meal_id,    meal_totals.meal_description,  -- ✅ Added meal description in final SELECT\n    meal_totals.meal_name,\n    meal_totals.meal_created,\n    meal_totals.discount,\n    meal_totals.image,\n    meal_totals.discount_last_date,\n    meal_totals.discounted_price,\n    json_group_array(json_object(\n        'plate_id', expanded_plates.plate_id,\n        'plate_name', expanded_plates.plate_name,\n        'plate_description', expanded_plates.plate_description,\n        'plate_price', expanded_plates.plate_price,\n        'plate_buyNumber', expanded_plates.plate_buyNumber,\n        'ingredients', (\n            SELECT json_group_array(json_object(\n                'ingredient_id', ingredient_details.ingredient_id,\n                'ingredient_name', ingredient_details.ingredient_name\n            ))\n            FROM expanded_ingredients\n            LEFT JOIN ingredient_details ON expanded_ingredients.ingredient_id = ingredient_details.ingredient_id\n            WHERE expanded_ingredients.plate_id = expanded_plates.plate_id\n        )\n    )) AS plates\nFROM meal_totals\nJOIN expanded_plates ON meal_totals.meal_id = expanded_plates.meal_id\nGROUP BY meal_totals.meal_id, meal_totals.meal_name, meal_totals.meal_description, meal_totals.meal_created, meal_totals.discount, meal_totals.discount_last_date, meal_totals.discounted_price;\n"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("sd1jud57vf2c1hn");

  return dao.deleteCollection(collection);
})
