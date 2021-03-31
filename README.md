# Installation #

##  Prerequisites ## 
If not already installed on your machine, first install graphviz as described here: https://graphviz.org/download/

## Cloning the repository ##
Run the following code in your GToolkit:

```
Metacello new
  baseline: 'Graphviz4GT';
  repository: 'github://rafibu/Graphviz4GT/src';
  load.
```

## Add Libraries ##
For the GraphvizLayout to work we first have to add the libraries to GT.

### Linux ###
Take the file called 'liball.so' from the libraries folder in your git repo. Add it to the lib folder of GToolkit.
