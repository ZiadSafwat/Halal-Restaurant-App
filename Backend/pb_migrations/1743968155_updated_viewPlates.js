/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("x6g803woi94vkac")

  // remove
  collection.schema.removeField("dedjbzjl")

  // remove
  collection.schema.removeField("cyk0mxhs")

  // remove
  collection.schema.removeField("60a7gbax")

  // remove
  collection.schema.removeField("vyjtnpkz")

  // remove
  collection.schema.removeField("no7hdvbz")

  // remove
  collection.schema.removeField("nm4z6kt2")

  // remove
  collection.schema.removeField("d5l5bxhn")

  // remove
  collection.schema.removeField("72tshagj")

  // remove
  collection.schema.removeField("2w9bdsne")

  // remove
  collection.schema.removeField("sc34d3z4")

  // remove
  collection.schema.removeField("plp4v9yk")

  // remove
  collection.schema.removeField("lonr1k3i")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "jrbdqvuu",
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
    "id": "8upkgyz7",
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
    "id": "tsnwakrw",
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
    "id": "qayqhqfa",
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
    "id": "2rmyponr",
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
    "id": "ojbpjvwy",
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
    "id": "hocyyuxa",
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
    "id": "y5o1ujh2",
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
    "id": "wlreze7h",
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
    "id": "pnx3uqzy",
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
    "id": "f977itph",
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
    "id": "ppxcvnef",
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
  const collection = dao.findCollectionByNameOrId("x6g803woi94vkac")

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // remove
  collection.schema.removeField("jrbdqvuu")

  // remove
  collection.schema.removeField("8upkgyz7")

  // remove
  collection.schema.removeField("tsnwakrw")

  // remove
  collection.schema.removeField("qayqhqfa")

  // remove
  collection.schema.removeField("2rmyponr")

  // remove
  collection.schema.removeField("ojbpjvwy")

  // remove
  collection.schema.removeField("hocyyuxa")

  // remove
  collection.schema.removeField("y5o1ujh2")

  // remove
  collection.schema.removeField("wlreze7h")

  // remove
  collection.schema.removeField("pnx3uqzy")

  // remove
  collection.schema.removeField("f977itph")

  // remove
  collection.schema.removeField("ppxcvnef")

  return dao.saveCollection(collection)
})
