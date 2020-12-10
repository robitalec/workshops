// Workshop: An Introduction to Remote Sensing with Earth Engine and R =========
// Full worked example - annotated
// Alec Robitaille, Isabella Richmond
// December 10 2020


// Functions ===================================================================
// First we are going to build some functions
// Earth Engine has several functions ready to go in the example scripts
// Functions are often dependent on the image collection you are working with

// Function to cloud mask from the pixel_qa band of Landsat 8 SR data.
// From: Examples/Cloud Masking/Landsat8 Surface Reflectance
function maskL8sr(image) {
	// Bits 3 and 5 are cloud shadow and cloud, respectively.
	var cloudShadowBitMask = 1 << 3;
	var cloudsBitMask = 1 << 5;

	// Get the pixel QA band.
	var qa = image.select('pixel_qa');

	// Both flags should be set to zero, indicating clear conditions.
	var mask = qa.bitwiseAnd(cloudShadowBitMask).eq(0)
	.and(qa.bitwiseAnd(cloudsBitMask).eq(0));

	// Return the masked image, scaled to reflectance, without the QA bands.
	return image.updateMask(mask).divide(10000)
	.select("B[0-9]*")
	.copyProperties(image, ["system:time_start"]);
}


// Function to calculate NDVI and add it as a band
function calcNDVI(im) {
	var ndvi = im.normalizedDifference(['B5','B4']).rename('ndvi');
	return im.addBands(ndvi);
}

// Function to grab date from image and add it as a band
function addDates(img) {
  var date = img.date();
  return img.addBands(ee.Image([date.getRelative('day', 'year'),
                                date.get('year')]).rename(['doy', 'year'])).float();
}


// Function to sample an image in each region of supplied geometry
function sampleregions (im) {
	return(im.reduceRegions(geometry, ee.Reducer.mean(), 30)
           .copyProperties(im));
}

// Geometry ====================================================================
// Create a polygon that outlines your area of interest
// Can also do this using the tools on the left hand side of the map pane
var geometry = ee.Geometry.MultiPoint(
        [[-60.53, 46.55],
         [-60.52, 46.55],
         [-60.55, 46.57],
         [-60.49, 46.57],
         [-60.53, 46.58]]);

// Images ======================================================================
// Now we are going to import the image collection that we want
// We can import using the image collection ID, as seen below
// To find an Image Collection's ID, search for the Image Collection you want
//   in the search bar, click on it, and look in the description
var l8 = ee.ImageCollection("LANDSAT/LC08/C01/T1_SR");


// Filter ======================================================================
// We want to filter the image collection to our area and time of interest
// Use the "Draw a Rectangle" tool in the bottom left to draw a box around your
//   "study area"

// .filterDate filters images in the image collection that are within our
//   specified timeframe
// .filterBounds filters images in the image collection that overlap with our
//   study area
l8 = l8.filterDate('2018-01-01', '2020-01-01')
       .filterBounds(geometry);


// Process images ==============================================================
// Mask clouds, add dates, and calculate NDVI
l8 = l8.map(maskL8sr)
       .map(addDates)
       .map(calcNDVI);


// Sample images ===============================================================
// Sample images using our study area geometry
var sample = l8.map(sampleregions)
               .flatten();


// Check output ================================================================
// Print results to the console
// Note: this causes the results to be passed from the Server to the Client
//   and therefore, it can take some time.
// Note 2: we use the limit function to show a subset of our results. (like head() in R)
print(sample.limit(10));


// Map =========================================================================
Map.centerObject(geometry)

// Add the processed layers to the map below to visualize your data
Map.addLayer(l8);
Map.addLayer(l8.select('ndvi'));

// After adding layers, you can use the "Layers" tool on the bottom right to adjust
// the visualization parameters to make them more appropriate - then import them
// The imported visualization parameters will appear as imageVisParam
// You can do it for both layers
// Map.addLayer(l8, imageVisParam);
// Map.addLayer(l8.select('ndvi'), imageVisParam2)


// Chart =======================================================================
// Visualize your data within Earth Engine
var ndviTimeSeries = ui.Chart.feature.byFeature({
  features: sample,
  xProperty: 'doy',
  yProperties: 'ndvi'
});

ndviTimeSeries = ndviTimeSeries.setChartType('ScatterChart')
                               .setOptions({title: 'NDVI at sample regions by julian day'});
print(ndviTimeSeries);

// Export ======================================================================
// Earth engine saves to your Google Drive
Export.table.toDrive({
  collection: sample,
  description: 'sampled-ndvi',
  folder: 'ee-workshop'
});
