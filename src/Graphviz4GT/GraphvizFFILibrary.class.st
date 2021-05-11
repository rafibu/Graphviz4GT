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
	{ 
		'liball.dylib' .
		(Smalltalk imageDirectory fullName, '/pharo-local/iceberg/rafibu/Graphviz4GT/libraries/liball.dylib')
	} do: [:path | 
		path asFileReference exists ifTrue: [^ path ] ].
	self error: 'Cannot locate the liball library.'


]

{ #category : #accessing }
GraphvizFFILibrary >> unixModuleName [
^ 'liball.so'
]
