/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "34y7v6avgpee7g1",
    "created": "2025-04-06 19:14:52.058Z",
    "updated": "2025-04-06 19:14:52.058Z",
    "name": "Meals",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "xazzkdx8",
        "name": "plates",
        "type": "relation",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "k7x6ce1bwf9lj6m",
          "cascadeDelete": false,
          "minSelect": 2,
          "maxSelect": null,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "q2jyvgwd",
        "name": "Image",
        "type": "url",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "exceptDomains": [],
          "onlyDomains": []
        }
      },
      {
        "system": false,
        "id": "zq8scykc",
        "name": "discount",
        "type": "number",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": 0,
          "max": null,
          "noDecimal": true
        }
      },
      {
        "system": false,
        "id": "n3r1pc0y",
        "name": "discount_last_date",
        "type": "date",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "min": "",
          "max": ""
        }
      },
      {
        "system": false,
        "id": "g7pabjg9",
        "name": "name",
        "type": "text",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "wfuadcxc",
        "name": "description",
        "type": "text",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("34y7v6avgpee7g1");

  return dao.deleteCollection(collection);
})
