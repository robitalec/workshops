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


//Function to calculate NDVI and add it as a band
function calcNDVI(image) {
	var ndvi = image.normalizedDifference(['B4','B3']).rename('ndvi')
	return image.addBands(ndvi);
}

// Now we are going to import the image collection that we want
// We can import using the image collection ID, as seen below
// To find an Image Collection's ID, search for the Image Collection you want
// in the search bar, click on it, and look in the description
var l8 = ee.ImageCollection("LANDSAT/LC08/C01/T1_SR");


// We want to filter the image collection to our area and time of interest
// Use the "Draw a Rectangle" tool in the bottom left to draw a box around your "study area"
// .filterDate will choose the images in the image collection that are within our specified timeframe
// .filterBounds will choose the images in the image collection that overlap with our study area
// We are also going to use our cloud masking and NDVI functions
// Limit provides a max number of images to be used
l8 = l8.filterDate('2018-01-01', '2019-01-01')
.filterBounds(geometry)
.map(maskL8sr)
.map(calcNDVI)
.limit(7);


// Here, we are creating another function. This function will sample our collection
// After sampling, it will calculate the mean at the scale that you specify (30)
var sampleregions = function(im) {
	return(im.reduceRegions(geometry,
													ee.Reducer.mean(),
													30));
};

// Here, we use the function to sample our collection
var sample = l8.map(sampleregions);

// The print function causes our collection to pop up in the console panel on the right
print(sample)

// chart + map

// Add the processed layers to the map below to visualize your data
Map.addLayer(l8.limit(2));
Map.addLayer(l8.select('ndvi'))

// After adding layers, you can use the "Layers" tool on the bottom right to adjust
// the visualization parameters to make them more appropriate - then import them
// The imported visualization parameters will appear as imageVisParam
// You can do it for both layers
Map.addLayer(l8.limit(2), imageVisParam);
Map.addLayer(l8.select('ndvi'), imageVisParam2)
