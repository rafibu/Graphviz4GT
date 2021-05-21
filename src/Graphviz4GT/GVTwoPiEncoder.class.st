"
Radial layouts, after Wills ‘97. 
The nodes are placed on concentric circles depending on their distance from a given root node. 
The algorithm is designed to handle not only small graphs, but also very large ones.
"
Class {
	#name : #GVTwoPiEncoder,
	#superclass : #GVAbstractEncoder,
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVTwoPiEncoder >> writeLayoutNameOn: stream [
	stream nextPutAll: 'layout = "twopi" ;'; crlf
]
