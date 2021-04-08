# Installation #

##  Prerequisites ## 
If not already installed on your machine, first install graphviz as described here: https://graphviz.org/download/
If you are using `brew` as it may happen if you are a mac user, you can simple execute in a terminal `brew install graphviz`. In case you are using a M1-based machine, you could try: `arch -x86_64 brew install graphviz`

## Cloning the repository ##
Run the following code in your GToolkit:

```Smalltalk
Metacello new
  baseline: 'Graphviz4GT';
  repository: 'github://rafibu/Graphviz4GT/src';
  load.
```

## Add Libraries ##
For the GraphvizLayout to work we first have to add the libraries to GT.

### Linux ###
Take the file called 'liball.so' from the libraries folder in your git repo. Add it to the lib folder of GToolkit.

### MacOS ###

## FAQ ##
**How to start using the graphviz layout for GT?** The class `GraphvizLayoutExamples` contains many simple and short examples. Look at this class is probably a good start.

**When running the example, I obtain the error External module not found** Our extension rely on a plugin used by the virtual machine. If you get this error, this means that the virtual machine is not able to find the our plugin module. In particular, you should make sure that graphviz is installed on your machine, and you have installed the library in the correct folder.
