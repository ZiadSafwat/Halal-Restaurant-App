 
routerAdd("GET", "/api/plateso/:userId", async (c) => {
  const userId =  c.pathParam("userId") ;
  console.log("➡️ Received request for userId:", userId);
  // Query parameters from the URL like ?search=pizza&filters=spicy,vegan
  const search = c.queryParam("search") || "";
  const rawFilters = c.queryParam("filters") || "";
  const favoritesOnly = c.queryParam("favoritesOnly") === "true";
 
  const filters = rawFilters
    ? rawFilters.split(",").map((f) => f.trim().toLowerCase())
    : [];
  console.log("➡️ Received request for userId:", userId, "| Search:", search, "| Filters:", filters);

 
  try {
    // Fetch plates from the database
    const rows = arrayOf(new DynamicModel({
       "id": "",
       "plate_name": "JSON",
       "plate_description": "JSON",
       "plate_price":-0,
       "plate_image_url_1": "JSON",
       "plate_image_url_2": "JSON",
       "plate_image_url_3": "JSON",
       "plate_buyNumber": -0,
       "plate_evaluation": -0,
       "plate_category": "JSON",
       "is_fav": false,       "fav_id": "",

       "ingredients_details": []
    }));
  
    // Execute the query with the given userId
    const queryResult = await $app.db()
      .newQuery(`
      WITH expanded_plates AS (
        SELECT
          plates.id AS plate_id,
          plates.buyNumber AS plate_buyNumber,
          plates.evaluation AS plate_evaluation,   
          plates.category AS plate_category,
          plates.name AS plate_name,
          plates.description AS plate_description,
          plates.price AS plate_price,
          plates.image_url_1 AS plate_image_url_1,
          plates.image_url_2 AS plate_image_url_2,
          plates.image_url_3 AS plate_image_url_3,
          plates.ingredients  -- Assuming ingredients is a JSON array
        FROM plates
      ),
      expanded_ingredients AS (
        SELECT
          plate_id,
          json_each.value AS ingredient_id  -- Expanding the ingredients list
        FROM expanded_plates,
        json_each(expanded_plates.ingredients)  -- Expanding the JSON array of ingredient IDs
      ),
      ingredient_details AS (
        SELECT
          ingredients.id AS ingredient_id,
          ingredients.name AS ingredient_name
        FROM ingredients  -- Assuming a table named "ingredients" exists with id and name
      ),
    
      favorites AS (
        SELECT
          My_Favorites.id AS fav_id,
          json_each.value AS plate_id
        FROM My_Favorites,
        json_each(My_Favorites.plates)
        WHERE My_Favorites.user = {:userId}
      )
      
      SELECT 
        plates.plate_id as id,
        plates.plate_name,
        plates.plate_description,
        plates.plate_buyNumber,
        plates.plate_evaluation,
        plates.plate_category,
        plates.plate_price,
        plates.plate_image_url_1,
        plates.plate_image_url_2,
        plates.plate_image_url_3,
        plates.ingredients,
        (fav.plate_id IS NOT NULL) AS is_fav,
        IFNULL(fav.fav_id, '') AS fav_id,        json_group_array(json_object(  -- Expanding the ingredients
            'ingredient_id', ingredient_details.ingredient_id,
            'ingredient_name', ingredient_details.ingredient_name
        )) AS ingredients_details
      FROM expanded_plates AS plates
      LEFT JOIN expanded_ingredients AS ing ON plates.plate_id = ing.plate_id
      LEFT JOIN ingredient_details AS ingredient_details ON ing.ingredient_id = ingredient_details.ingredient_id
      LEFT JOIN favorites AS fav ON fav.plate_id = plates.plate_id
      GROUP BY plates.plate_id, plates.plate_name, plates.plate_description, plates.plate_price, plates.plate_image_url_1, plates.plate_image_url_2, plates.plate_image_url_3, plates.ingredients;
          
      `) .bind({
         "userId":userId
      
    }).all(rows);  // Fetch all the rows based on the query

    console.log("📦 Plates fetched:", rows);  // Log the result
  // Manual filtering
 
  const filteredRows = rows.filter(row => {
    const name = row.plate_name?.toLowerCase() || "";
    const desc = row.plate_description?.toLowerCase() || "";
    const category = row.plate_category?.toLowerCase() || "";
    const ingredientNames = (row.ingredients_details || []).map(i => (i.ingredient_name || "").toLowerCase());
  
    const matchesSearch =
      !search ||
      name.includes(search.toLowerCase()) ||
      desc.includes(search.toLowerCase());
  
    const matchesFilters = filters.length === 0 || filters.some(f =>
      category.includes(f) || ingredientNames.some(i => i.includes(f))
    );
  
    const matchesFav = !favoritesOnly || row.is_fav === true;
  
    return matchesSearch && matchesFilters && matchesFav;
  });
  
    // Return the result as a JSON response
  return c.json(200, filteredRows);

 

  } catch (err) {
    console.log("❌ ERROR in route:", err);
    // Send error response with detailed message
    return c.json(500, {
      error: "Internal server error",
      message: err.message || err,
    });
  }
},  $apis.activityLogger($app),
  $apis.requireRecordAuth("users"));  // Ensure the user is authenticated








// routerAdd("GET", "/api/plateso/{userId}", async (c) => {
//   const userId = c.request.pathValue("userId");

//   // Clean and parse query parameters
//   const filters = (c.requestInfo().query["filters"] || "")
//     .split(",")
//     .map(f => f.trim())
//     .filter(f => f); // Remove empty strings

//   const search = c.requestInfo().query["search"] || "";

//   console.log("➡️ Received request for userId:", userId);
//   console.log("🔍 Filters:", filters);
//   console.log("🔍 Search text:", search);

//   try {
//     const rows = arrayOf(new DynamicModel({
//       "id": "",
//       "plate_name": "JSON",
//       "plate_description": "JSON",
//       "plate_price": -0,
//       "plate_image_url_1": "JSON",
//       "plate_image_url_2": "JSON",
//       "plate_image_url_3": "JSON",
//       "plate_buyNumber": -0,
//       "plate_evaluation": -0,
//       "plate_category": "JSON",
//       "is_fav": true,
//       "ingredients_details": []
//     }));

//     const filterConditions = [];
//     const params = {
//       userId: userId,
//     };

//     filters.forEach((f, i) => {
//       filterConditions.push(`
//         LOWER(plates.category) LIKE LOWER(@f${i}) OR
//         EXISTS (
//           SELECT 1 FROM ingredients ing
//           WHERE ing.id IN (SELECT value FROM json_each(plates.ingredients))
//           AND LOWER(ing.name) LIKE LOWER(@f${i})
//         )
//       `);
//       params[`f${i}`] = `%${f}%`;
//     });

//     if (search) {
//       filterConditions.push(`
//         LOWER(plates.name) LIKE LOWER(@search) OR
//         LOWER(plates.description) LIKE LOWER(@search)
//       `);
//       params["search"] = `%${search}%`;
//     }

//     const whereClause = filterConditions.length > 0 ? `WHERE ${filterConditions.join(" OR ")}` : "";

//     const queryResult = await $app.db()
//       .newQuery(`
//         WITH expanded_plates AS (
//           SELECT
//             plates.id AS plate_id,
//             plates.buyNumber AS plate_buyNumber,
//             plates.evaluation AS plate_evaluation,   
//             plates.category AS plate_category,
//             plates.name AS plate_name,
//             plates.description AS plate_description,
//             plates.price AS plate_price,
//             plates.image_url_1 AS plate_image_url_1,
//             plates.image_url_2 AS plate_image_url_2,
//             plates.image_url_3 AS plate_image_url_3,
//             plates.ingredients
//           FROM plates
//           ${whereClause}
//         ),
//         expanded_ingredients AS (
//           SELECT
//             plate_id,
//             json_each.value AS ingredient_id
//           FROM expanded_plates,
//           json_each(expanded_plates.ingredients)
//         ),
//         ingredient_details AS (
//           SELECT
//             ingredients.id AS ingredient_id,
//             ingredients.name AS ingredient_name
//           FROM ingredients
//         ),
//         favorites AS (
//           SELECT
//             value AS plate_id
//           FROM My_Favorites,
//           json_each(My_Favorites.plates)
//           WHERE My_Favorites.user = @userId
//         )
//         SELECT 
//           plates.plate_id as id,
//           plates.plate_name,
//           plates.plate_description,
//           plates.plate_buyNumber,
//           plates.plate_evaluation,
//           plates.plate_category,
//           plates.plate_price,
//           plates.plate_image_url_1,
//           plates.plate_image_url_2,
//           plates.plate_image_url_3,
//           plates.ingredients,
//           (fav.plate_id IS NOT NULL) AS is_fav,
//           json_group_array(json_object(
//               'ingredient_id', ingredient_details.ingredient_id,
//               'ingredient_name', ingredient_details.ingredient_name
//           )) AS ingredients_details
//         FROM expanded_plates AS plates
//         LEFT JOIN expanded_ingredients AS ing ON plates.plate_id = ing.plate_id
//         LEFT JOIN ingredient_details AS ingredient_details ON ing.ingredient_id = ingredient_details.ingredient_id
//         LEFT JOIN favorites AS fav ON fav.plate_id = plates.plate_id
//         GROUP BY plates.plate_id;
//       `)
//       .bind(params)
//       .all(rows);

//     return c.json(200, rows);

//   } catch (err) {
//     console.log("❌ ERROR in route:", err);
//     return c.json(500, {
//       error: "Internal server error",
//       message: err.message || err,
//     });
//   }
// }, $apis.requireAuth("users"));
