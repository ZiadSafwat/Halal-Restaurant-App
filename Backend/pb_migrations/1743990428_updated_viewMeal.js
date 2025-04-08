/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("sd1jud57vf2c1hn")

  collection.options = {
    "query": "   WITH expanded_plates AS (\n        SELECT\n          plates.id AS plate_id,\n          plates.buyNumber AS plate_buyNumber,\n          plates.evaluation AS plate_evaluation,   \n          plates.category AS plate_category,\n          plates.name AS plate_name,\n          plates.description AS plate_description,\n          plates.price AS plate_price,\n          plates.image_url_1 AS plate_image_url_1,\n          plates.image_url_2 AS plate_image_url_2,\n          plates.image_url_3 AS plate_image_url_3,\n          plates.ingredients  -- Assuming ingredients is a JSON array\n        FROM plates\n      ),\n      expanded_ingredients AS (\n        SELECT\n          plate_id,\n          json_each.value AS ingredient_id  -- Expanding the ingredients list\n        FROM expanded_plates,\n        json_each(expanded_plates.ingredients)  -- Expanding the JSON array of ingredient IDs\n      ),\n      ingredient_details AS (\n        SELECT\n          ingredients.id AS ingredient_id,\n          ingredients.name AS ingredient_name\n        FROM ingredients  -- Assuming a table named \"ingredients\" exists with id and name\n      ),\n    \n      favorites AS (\n        SELECT\n          My_Favorites.id AS fav_id,\n          json_each.value AS plate_id\n        FROM My_Favorites,\n        json_each(My_Favorites.plates)\n        WHERE My_Favorites.user = \"\"\n      )\n      \n      SELECT \n        plates.plate_id as id,\n        plates.plate_name,\n        plates.plate_description,\n        plates.plate_buyNumber,\n        plates.plate_evaluation,\n        plates.plate_category,\n        plates.plate_price,\n        plates.plate_image_url_1,\n        plates.plate_image_url_2,\n        plates.plate_image_url_3,\n        plates.ingredients,\n        (fav.plate_id IS NOT NULL) AS is_fav,\n        IFNULL(fav.fav_id, '') AS fav_id,        json_group_array(json_object(  -- Expanding the ingredients\n            'ingredient_id', ingredient_details.ingredient_id,\n            'ingredient_name', ingredient_details.ingredient_name\n        )) AS ingredients_details\n      FROM expanded_plates AS plates\n      LEFT JOIN expanded_ingredients AS ing ON plates.plate_id = ing.plate_id\n      LEFT JOIN ingredient_details AS ingredient_details ON ing.ingredient_id = ingredient_details.ingredient_id\n      LEFT JOIN favorites AS fav ON fav.plate_id = plates.plate_id\n      GROUP BY plates.plate_id, plates.plate_name, plates.plate_description, plates.plate_price, plates.plate_image_url_1, plates.plate_image_url_2, plates.plate_image_url_3, plates.ingredients;\n          "
  }

  // remove
  collection.schema.removeField("eoabqdod")

  // remove
  collection.schema.removeField("u5lq7aku")

  // remove
  collection.schema.removeField("hxsbby46")

  // remove
  collection.schema.removeField("ilhcatgd")

  // remove
  collection.schema.removeField("ezf1efv8")

  // remove
  collection.schema.removeField("qbupizsk")

  // remove
  collection.schema.removeField("k4kyraxo")

  // remove
  collection.schema.removeField("ossaicrv")

  // remove
  collection.schema.removeField("2im1tbav")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "1d73svcl",
    "name": "plate_name",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "hphgrycg",
    "name": "plate_description",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "howuy2zo",
    "name": "plate_buyNumber",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "f4kdy1al",
    "name": "plate_evaluation",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "iatbzxup",
    "name": "plate_category",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "9bqeeolb",
    "name": "plate_price",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "k4h4bufy",
    "name": "plate_image_url_1",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "q8jqwppb",
    "name": "plate_image_url_2",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "tctbeedi",
    "name": "plate_image_url_3",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "nww5vavz",
    "name": "ingredients",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "w8ifuo12",
    "name": "is_fav",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ude7haf1",
    "name": "fav_id",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ros88qlh",
    "name": "ingredients_details",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("sd1jud57vf2c1hn")

  collection.options = {
    "query": "WITH expanded_plates AS (\n    SELECT\n        meals.id AS meal_id,\n        meals.name AS meal_name,        meals.description AS meal_description,  -- ✅ Added meal description\n        meals.image AS meal_image,\n        meals.discount,\n        meals.image,\n        meals.discount_last_date,\n        meals.created AS meal_created, \n        plates.id AS plate_id,\n        plates.buyNumber AS plate_buyNumber,\n        plates.name AS plate_name,\n        plates.description AS plate_description,\n        plates.price AS plate_price,\n        plates.ingredients  -- ✅ Added ingredients\n    FROM meals\n    CROSS JOIN json_each(meals.plates)\n    JOIN plates ON plates.id = json_each.value\n),\nexpanded_ingredients AS (\n    SELECT\n        plate_id,\n        json_each.value AS ingredient_id\n    FROM expanded_plates,\n    json_each(expanded_plates.ingredients)  -- ✅ Expand the ingredients JSON array\n),\ningredient_details AS (\n    SELECT\n        ingredients.id AS ingredient_id,\n        ingredients.name AS ingredient_name\n    FROM ingredients  -- ✅ Assuming a table named \"ingredients\" exists with id and name\n),\nmeal_totals AS (\n    SELECT\n        meal_id,\n        meal_name,        meal_description,  -- ✅ Included meal description\n        meal_created,\n        SUM(plate_price) AS total_price,\n        discount,\n        image,\n        discount_last_date,\n        (SUM(plate_price) * (1 - discount / 100)) AS discounted_price\n    FROM expanded_plates\n    WHERE discount_last_date >= DATE('now') \n    GROUP BY meal_id, meal_name, meal_created, discount, discount_last_date\n)\n\nSELECT \n    (meal_totals.meal_id || '_' || meal_totals.discount_last_date) AS id,\n    meal_totals.meal_id,    meal_totals.meal_description,  -- ✅ Added meal description in final SELECT\n    meal_totals.meal_name,\n    meal_totals.meal_created,\n    meal_totals.discount,\n    meal_totals.image,\n    meal_totals.discount_last_date,\n    meal_totals.discounted_price,\n    json_group_array(json_object(\n        'plate_id', expanded_plates.plate_id,\n        'plate_name', expanded_plates.plate_name,\n        'plate_description', expanded_plates.plate_description,\n        'plate_price', expanded_plates.plate_price,\n        'plate_buyNumber', expanded_plates.plate_buyNumber,\n        'ingredients', (\n            SELECT json_group_array(json_object(\n                'ingredient_id', ingredient_details.ingredient_id,\n                'ingredient_name', ingredient_details.ingredient_name\n            ))\n            FROM expanded_ingredients\n            LEFT JOIN ingredient_details ON expanded_ingredients.ingredient_id = ingredient_details.ingredient_id\n            WHERE expanded_ingredients.plate_id = expanded_plates.plate_id\n        )\n    )) AS plates\nFROM meal_totals\nJOIN expanded_plates ON meal_totals.meal_id = expanded_plates.meal_id\nGROUP BY meal_totals.meal_id, meal_totals.meal_name, meal_totals.meal_description, meal_totals.meal_created, meal_totals.discount, meal_totals.discount_last_date, meal_totals.discounted_price;\n"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "eoabqdod",
    "name": "meal_id",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "u5lq7aku",
    "name": "meal_description",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "hxsbby46",
    "name": "meal_name",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ilhcatgd",
    "name": "meal_created",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ezf1efv8",
    "name": "discount",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "qbupizsk",
    "name": "image",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "k4kyraxo",
    "name": "discount_last_date",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ossaicrv",
    "name": "discounted_price",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "2im1tbav",
    "name": "plates",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // remove
  collection.schema.removeField("1d73svcl")

  // remove
  collection.schema.removeField("hphgrycg")

  // remove
  collection.schema.removeField("howuy2zo")

  // remove
  collection.schema.removeField("f4kdy1al")

  // remove
  collection.schema.removeField("iatbzxup")

  // remove
  collection.schema.removeField("9bqeeolb")

  // remove
  collection.schema.removeField("k4h4bufy")

  // remove
  collection.schema.removeField("q8jqwppb")

  // remove
  collection.schema.removeField("tctbeedi")

  // remove
  collection.schema.removeField("nww5vavz")

  // remove
  collection.schema.removeField("w8ifuo12")

  // remove
  collection.schema.removeField("ude7haf1")

  // remove
  collection.schema.removeField("ros88qlh")

  return dao.saveCollection(collection)
})
