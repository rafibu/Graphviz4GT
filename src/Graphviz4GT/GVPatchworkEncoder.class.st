"
An implementation of squarified treemaps
"
Class {
	#name : #GVPatchworkEncoder,
	#superclass : #GVAbstractEncoder,
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVPatchworkEncoder >> writeLayoutNameOn: stream [
	stream nextPutAll: 'layout = "patchwork" ;'; crlf
]
