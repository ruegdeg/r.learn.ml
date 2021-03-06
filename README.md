# r.learn.ml
GRASS GIS add-on for applying machine learning to GRASS GIS spatial data

<h2>DESCRIPTION</h2>

<p><em>r.learn.ml</em> represents a front-end to the scikit learn python package. The module enables scikit-learn classification and regression models to be applied to GRASS GIS rasters that are stored as part of an imagery group <em>group</em> or specified as individual maps in the optional <em>raster</em> parameter.</p>

<p>The training component of the machine learning workflow is performed using the <em>r.learn.train</em> module. This module uses training data consisting of labelled pixels in a GRASS GIS raster map, or a GRASS GIS vector containing points, and develops a machine learning model on the rasters within a GRASS imagery group. This model needs to be saved to a file and can be automatically compressed if the .gz file extension is used.</p>

<p>After a model is training, the <em>i.learn.predict</em> module needs to be called, which will retrieve the saved and pre-fitted model and apply it to a GRASS GIS imagery group.</p>

<h2>NOTES</h2>

<p><em>r.learn.ml</em> uses the "scikit-learn" machine learning python package (version &ge; 0.20) along with the "pandas" package. These packages need to be installed within your GRASS GIS Python environment. For Linux users, these packages should be available through the linux package manager. For MS-Windows users using a 64 bit GRASS, the easiest way of installing the packages is by using the precompiled binaries from <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/">Christoph Gohlke</a> and by using the <a href="https://grass.osgeo.org/download/software/ms-windows/">OSGeo4W</a> installation method of GRASS, where the python setuptools can also be installed. You can then use 'easy_install pip' to install the pip package manager. Then, you can download the NumPy+MKL and scikit-learn .whl files and install them using 'pip install packagename.whl'. For MS-Windows with a 32 bit GRASS, scikit-learn is available in the OSGeo4W installer.</p>

<h2>EXAMPLE</h2>

<p>Here we are going to use the GRASS GIS sample North Carolina data set as a basis to perform a landsat classification. We are going to classify a Landsat 7 scene from 2000, using training information from an older (1996) land cover dataset.</p>

<p>Landsat 7 (2000) bands 7,4,2 color composite example:</p>
<center>
<img src="lsat7_2000_b742.png" alt="Landsat 7 (2000) bands 7,4,2 color composite example">
</center>

<p>Note that this example must be run in the "landsat" mapset of the North Carolina sample data set location.</p>

<p>First, we are going to generate some training pixels from an older (1996) land cover classification:</p>

```
g.region raster=landclass96 -p
r.random input=landclass96 npoints=1000 raster=landclass96_roi
```

<p>Then we can use these training pixels to perform a classification on the more recently obtained landsat 7 image:</p>

```
r.learn.train group=lsat7_2000 training_map=landclass96_roi \
	model_name=RandomForestClassifier n_estimators=500 save_model=rf_model.gz

r.learn.predict group=lsat7_2000 load_model=rf_model.gz output=rf_classification
```

<p>Now display the results:</p>

```
# copy category labels from landclass training map to result
r.category rf_classification raster=landclass96_roi

# copy color scheme from landclass training map to result
r.colors rf_classification raster=landclass96_roi
r.category rf_classification
```

<p>Random forest classification result:</p>
<center>
<img src="rfclassification.png" alt="Random forest classification result">
</center>

<h2>ACKNOWLEDGEMENTS</h2>

<p>Thanks for Paulo van Breugel and Vaclav Petras for testing.</p>

<h2>REFERENCES</h2>

<p>Brenning, A. 2012. Spatial cross-validation and bootstrap for the assessment of prediction rules in remote sensing: the R package 'sperrorest'. 2012 IEEE International Geoscience and Remote Sensing Symposium (IGARSS), 23-27 July 2012, p. 5372-5375.</p>

<p>Scikit-learn: Machine Learning in Python, Pedregosa et al., JMLR 12, pp. 2825-2830, 2011.</p>

<h2>AUTHOR</h2>

Steven Pawley

<p><em>Last changed: $Date: 2019-02-08 15:41:00 -0600 (Fri, 08 Feb 2019) $</em></p>
