/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("sd1jud57vf2c1hn")

  collection.options = {
    "query": "   WITH expanded_plates AS (\n        SELECT\n          plates.id AS plate_id,\n          plates.buyNumber AS plate_buyNumber,\n          plates.evaluation AS plate_evaluation,   \n          plates.category AS plate_category,\n          plates.name AS plate_name,\n          plates.description AS plate_description,\n          plates.price AS plate_price,\n          plates.image_url_1 AS plate_image_url_1,\n          plates.image_url_2 AS plate_image_url_2,\n          plates.image_url_3 AS plate_image_url_3,\n          plates.ingredients  -- Assuming ingredients is a JSON array\n        FROM plates\n      ),\n      expanded_ingredients AS (\n        SELECT\n          plate_id,\n          json_each.value AS ingredient_id  -- Expanding the ingredients list\n        FROM expanded_plates,\n        json_each(expanded_plates.ingredients)  -- Expanding the JSON array of ingredient IDs\n      ),\n      ingredient_details AS (\n        SELECT\n          ingredients.id AS ingredient_id,\n          ingredients.name AS ingredient_name\n        FROM ingredients  -- Assuming a table named \"ingredients\" exists with id and name\n      ),\n    \n      favorites AS (\n        SELECT\n          My_Favorites.id AS fav_id,\n          json_each.value AS plate_id\n        FROM My_Favorites,\n        json_each(My_Favorites.plates)\n        WHERE My_Favorites.user = \"96nm7214q9u301e\"\n      )\n      \n      SELECT \n        plates.plate_id as id,\n        plates.plate_name,\n        plates.plate_description,\n        plates.plate_buyNumber,\n        plates.plate_evaluation,\n        plates.plate_category,\n        plates.plate_price,\n        plates.plate_image_url_1,\n        plates.plate_image_url_2,\n        plates.plate_image_url_3,\n        plates.ingredients,\n        (fav.plate_id IS NOT NULL) AS is_fav,\n        IFNULL(fav.fav_id, '') AS fav_id,        json_group_array(json_object(  -- Expanding the ingredients\n            'ingredient_id', ingredient_details.ingredient_id,\n            'ingredient_name', ingredient_details.ingredient_name\n        )) AS ingredients_details\n      FROM expanded_plates AS plates\n      LEFT JOIN expanded_ingredients AS ing ON plates.plate_id = ing.plate_id\n      LEFT JOIN ingredient_details AS ingredient_details ON ing.ingredient_id = ingredient_details.ingredient_id\n      LEFT JOIN favorites AS fav ON fav.plate_id = plates.plate_id\n      GROUP BY plates.plate_id, plates.plate_name, plates.plate_description, plates.plate_price, plates.plate_image_url_1, plates.plate_image_url_2, plates.plate_image_url_3, plates.ingredients;\n          "
  }

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

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "djb6pdy9",
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
    "id": "xl3wtl5w",
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
    "id": "e3uvcmny",
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
    "id": "nvjisny8",
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
    "id": "nksstb3l",
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
    "id": "fco7qtwd",
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
    "id": "5ooj27yp",
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
    "id": "6fbfjisc",
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
    "id": "eyx3g3dr",
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
    "id": "sfvoyymi",
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
    "id": "14npfg40",
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
    "id": "dmxtibkm",
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
    "id": "iombwvfb",
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
    "query": "   WITH expanded_plates AS (\n        SELECT\n          plates.id AS plate_id,\n          plates.buyNumber AS plate_buyNumber,\n          plates.evaluation AS plate_evaluation,   \n          plates.category AS plate_category,\n          plates.name AS plate_name,\n          plates.description AS plate_description,\n          plates.price AS plate_price,\n          plates.image_url_1 AS plate_image_url_1,\n          plates.image_url_2 AS plate_image_url_2,\n          plates.image_url_3 AS plate_image_url_3,\n          plates.ingredients  -- Assuming ingredients is a JSON array\n        FROM plates\n      ),\n      expanded_ingredients AS (\n        SELECT\n          plate_id,\n          json_each.value AS ingredient_id  -- Expanding the ingredients list\n        FROM expanded_plates,\n        json_each(expanded_plates.ingredients)  -- Expanding the JSON array of ingredient IDs\n      ),\n      ingredient_details AS (\n        SELECT\n          ingredients.id AS ingredient_id,\n          ingredients.name AS ingredient_name\n        FROM ingredients  -- Assuming a table named \"ingredients\" exists with id and name\n      ),\n    \n      favorites AS (\n        SELECT\n          My_Favorites.id AS fav_id,\n          json_each.value AS plate_id\n        FROM My_Favorites,\n        json_each(My_Favorites.plates)\n        WHERE My_Favorites.user = \"\"\n      )\n      \n      SELECT \n        plates.plate_id as id,\n        plates.plate_name,\n        plates.plate_description,\n        plates.plate_buyNumber,\n        plates.plate_evaluation,\n        plates.plate_category,\n        plates.plate_price,\n        plates.plate_image_url_1,\n        plates.plate_image_url_2,\n        plates.plate_image_url_3,\n        plates.ingredients,\n        (fav.plate_id IS NOT NULL) AS is_fav,\n        IFNULL(fav.fav_id, '') AS fav_id,        json_group_array(json_object(  -- Expanding the ingredients\n            'ingredient_id', ingredient_details.ingredient_id,\n            'ingredient_name', ingredient_details.ingredient_name\n        )) AS ingredients_details\n      FROM expanded_plates AS plates\n      LEFT JOIN expanded_ingredients AS ing ON plates.plate_id = ing.plate_id\n      LEFT JOIN ingredient_details AS ingredient_details ON ing.ingredient_id = ingredient_details.ingredient_id\n      LEFT JOIN favorites AS fav ON fav.plate_id = plates.plate_id\n      GROUP BY plates.plate_id, plates.plate_name, plates.plate_description, plates.plate_price, plates.plate_image_url_1, plates.plate_image_url_2, plates.plate_image_url_3, plates.ingredients;\n          "
  }

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

  // remove
  collection.schema.removeField("djb6pdy9")

  // remove
  collection.schema.removeField("xl3wtl5w")

  // remove
  collection.schema.removeField("e3uvcmny")

  // remove
  collection.schema.removeField("nvjisny8")

  // remove
  collection.schema.removeField("nksstb3l")

  // remove
  collection.schema.removeField("fco7qtwd")

  // remove
  collection.schema.removeField("5ooj27yp")

  // remove
  collection.schema.removeField("6fbfjisc")

  // remove
  collection.schema.removeField("eyx3g3dr")

  // remove
  collection.schema.removeField("sfvoyymi")

  // remove
  collection.schema.removeField("14npfg40")

  // remove
  collection.schema.removeField("dmxtibkm")

  // remove
  collection.schema.removeField("iombwvfb")

  return dao.saveCollection(collection)
})
