/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("sd1jud57vf2c1hn")

  // remove
  collection.schema.removeField("jbklndfh")

  // remove
  collection.schema.removeField("qpf0uxbk")

  // remove
  collection.schema.removeField("4lou2yhl")

  // remove
  collection.schema.removeField("feh1yuac")

  // remove
  collection.schema.removeField("6psqxocg")

  // remove
  collection.schema.removeField("bzetnlzb")

  // remove
  collection.schema.removeField("phrzibqo")

  // remove
  collection.schema.removeField("w23g4ru4")

  // remove
  collection.schema.removeField("yrl6m7ay")

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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("sd1jud57vf2c1hn")

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

  // add
  collection.schema.addField(new SchemaField({
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
  }))

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

  return dao.saveCollection(collection)
})
