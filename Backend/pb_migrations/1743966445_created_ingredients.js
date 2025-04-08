/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "wbaauvl48ogu765",
    "created": "2025-04-06 19:07:25.956Z",
    "updated": "2025-04-06 19:07:25.956Z",
    "name": "ingredients",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "ku2lloiy",
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
  const collection = dao.findCollectionByNameOrId("wbaauvl48ogu765");

  return dao.deleteCollection(collection);
})
