/**** Start of imports. If edited, may not auto-convert in the playground. ****/
var geometry = /* color: #d63000 */ee.Geometry.Point([-52.93138215995296, 47.420439036599156]);
/***** End of imports. If edited, may not auto-convert in the playground. *****/
// You can search above for the image collection you want
// Each image collection has a description that you can investigate by clicking on it 
// When you select one and import it, you can see its asset id

// Get your image collection using its asset id
var images = ee.ImageCollection('LANDSAT/LC08/C01/T1_32DAY_NDVI');

// You can choose where you want to see the image collection by dropping a pin 
// On the left-hand side "Add A Marker" in St. John's 
// Scroll up in your script - under imports you will see the Lat/Long of your point

// Use Map.setCenter(lat, long, zoom); to set where you want to see your image collection
Map.setCenter(-52.93, 47.42, 5);

// Now add your image collection to the map below using Map.addLayer()
Map.addLayer(images);