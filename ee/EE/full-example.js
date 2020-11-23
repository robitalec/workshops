// functions
// Function to cloud mask from the pixel_qa band of Landsat 8 SR data.
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


//function to calculate NDVI and add it as a band
function calcNDVI(image) {
	var ndvi = image.normalizedDifference(['B4','B3']).rename('ndvi')
	return image.addBands(ndvi);
}


// import

var l8 = ee.ImageCollection("LANDSAT/LC08/C01/T1_SR");


// filter

l8 = l8.filterDate('2018-01-01', '2019-01-01')
.filterBounds(geometry)
.map(maskL8sr)
.map(calcNDVI)
.limit(7);


// sample
var sampleregions = function(im) {
	return(im.reduceRegions(geometry,
													ee.Reducer.mean(),
													30));
};


var sample = l8.map(sampleregions);

print(sample)
// chart + map

Map.addLayer(l8.limit(2), imageVisParam);

Map.addLayer(l8.select('ndvi'), imageVisParam2)
