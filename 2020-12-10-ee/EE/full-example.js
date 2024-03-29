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
	// Bits 2, 4 and 5 are cirrus, cloud shadow and cloud, respectively.
	var cloudShadowBitMask = 1 << 4;
	var cloudsBitMask = 1 << 3;
	var cirrusBitMask = 1 << 2;

	// Get the pixel QA band.
	var qa = image.select('QA_PIXEL');

	// Both flags should be set to zero, indicating clear conditions.
	var mask = qa.bitwiseAnd(cloudShadowBitMask).eq(0)
	              .and(qa.bitwiseAnd(cloudsBitMask).eq(0))
	              .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

	// Return the masked image, scaled to reflectance, without the QA bands.
	return image.updateMask(mask)
	.copyProperties(image, ["system:time_start"]);
}

// Applies scaling factors.
function applyScaleFactors(image) {
  var opticalBands = image.select('SR_B.').multiply(0.0000275).add(-0.2);
  var thermalBands = image.select('ST_B.*').multiply(0.00341802).add(149.0);
  return image.addBands(opticalBands, null, true)
              .addBands(thermalBands, null, true);
}


// Function to calculate NDVI and add it as a band
function calcNDVI(im) {
	var ndvi = im.normalizedDifference(['SR_B5','SR_B4']).rename('ndvi');
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
var l8 = ee.ImageCollection("LANDSAT/LC08/C02/T1_L2");


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
// Mask clouds and calculate NDVI
l8 = l8.map(maskL8sr)
       .map(applyScaleFactors)
       .map(addDates)
       .map(calcNDVI);


// Sample images ===============================================================
// Sample images using our geometry
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
var ndviTimeSeries = ui.Chart.feature.byFeature({
  features: sample,
  xProperty: 'doy',
  yProperties: 'ndvi'
});

ndviTimeSeries = ndviTimeSeries.setChartType('ScatterChart')
                               .setOptions({title: 'NDVI at sample regions by julian day'});
print(ndviTimeSeries);

// Export ======================================================================
Export.table.toDrive({
  collection: sample,
  description: 'sampled-ndvi',
  folder: 'ee-workshop'
});
