"
Keeps track of the external Libraries which are used in GraphvizLayout
"
Class {
	#name : #GraphvizFFILibrary,
	#superclass : #FFILibrary,
	#category : #Graphviz4GT
}

{ #category : #accessing }
GraphvizFFILibrary >> macModuleName [
^ 'liball.dylib'
]

{ #category : #accessing }
GraphvizFFILibrary >> unixModuleName [
^ 'liball.so'
]
