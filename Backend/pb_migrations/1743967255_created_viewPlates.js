/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "x6g803woi94vkac",
    "created": "2025-04-06 19:20:55.445Z",
    "updated": "2025-04-06 19:20:55.445Z",
    "name": "viewPlates",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "dedjbzjl",
        "name": "plate_name",
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
        "id": "cyk0mxhs",
        "name": "plate_description",
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
        "id": "60a7gbax",
        "name": "plate_buyNumber",
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
        "id": "vyjtnpkz",
        "name": "plate_evaluation",
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
        "id": "no7hdvbz",
        "name": "plate_category",
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
        "id": "nm4z6kt2",
        "name": "plate_price",
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
        "id": "d5l5bxhn",
        "name": "plate_image_url_1",
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
        "id": "72tshagj",
        "name": "plate_image_url_2",
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
        "id": "2w9bdsne",
        "name": "plate_image_url_3",
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
        "id": "sc34d3z4",
        "name": "ingredients",
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
        "id": "plp4v9yk",
        "name": "is_fav",
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
        "id": "lonr1k3i",
        "name": "ingredients_details",
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
      "query": "WITH expanded_plates AS (\n  SELECT\n    plates.id AS plate_id,\n    plates.buyNumber AS plate_buyNumber,\n    plates.evaluation AS plate_evaluation,   \n    plates.category AS plate_category,\n    plates.name AS plate_name,\n    plates.description AS plate_description,\n    plates.price AS plate_price,\n    plates.image_url_1 AS plate_image_url_1,\n    plates.image_url_2 AS plate_image_url_2,\n    plates.image_url_3 AS plate_image_url_3,\n    plates.ingredients  -- Assuming ingredients is a JSON array\n  FROM plates\n),\nexpanded_ingredients AS (\n  SELECT\n    plate_id,\n    json_each.value AS ingredient_id  -- Expanding the ingredients list\n  FROM expanded_plates,\n  json_each(expanded_plates.ingredients)  -- Expanding the JSON array of ingredient IDs\n),\ningredient_details AS (\n  SELECT\n    ingredients.id AS ingredient_id,\n    ingredients.name AS ingredient_name\n  FROM ingredients  -- Assuming a table named \"ingredients\" exists with id and name\n),\nfavorites AS (\n  SELECT\n    value AS plate_id\n  FROM My_Favorites,\n  json_each(My_Favorites.plates)\n  WHERE My_Favorites.user = \"96nm7214q9u301e\"  -- Favorite plates for user\n)\nSELECT \n  plates.plate_id as id,\n  plates.plate_name,\n  plates.plate_description,\n  plates.plate_buyNumber,\n  plates.plate_evaluation,\n  plates.plate_category,\n  plates.plate_price,\n  plates.plate_image_url_1,\n  plates.plate_image_url_2,\n  plates.plate_image_url_3,\n  plates.ingredients,\n  (fav.plate_id IS NOT NULL) AS is_fav,  -- Whether the plate is a favorite\n  json_group_array(json_object(  -- Expanding the ingredients\n      'ingredient_id', ingredient_details.ingredient_id,\n      'ingredient_name', ingredient_details.ingredient_name\n  )) AS ingredients_details\nFROM expanded_plates AS plates\nLEFT JOIN expanded_ingredients AS ing ON plates.plate_id = ing.plate_id\nLEFT JOIN ingredient_details AS ingredient_details ON ing.ingredient_id = ingredient_details.ingredient_id\nLEFT JOIN favorites AS fav ON fav.plate_id = plates.plate_id\nGROUP BY plates.plate_id, plates.plate_name, plates.plate_description, plates.plate_price, plates.plate_image_url_1, plates.plate_image_url_2, plates.plate_image_url_3, plates.ingredients;\n"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("x6g803woi94vkac");

  return dao.deleteCollection(collection);
})
