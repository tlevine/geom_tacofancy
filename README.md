# Install 

```r
library("devtools")
install_github("geomtacofancy", "tlevine")
```

Windows users also must first install
[Rtools](http://cran.rstudio.com/bin/windows/Rtools/).
 
# Example


```r
options(width = 200)
library(geomtacofancy)
ggplot(mpg) + aes(label = paste(manufacturer, model), base_layer = manufacturer, 
    condiments = trans) + geom_tacofancy()
```

```
## Error: 'where' is missing
```


# For added dimensionality

After you make the taco place it on the appropriate label in the `geom_taco` scatterplot
