Extension { #name : #GtMondrianLayoutBuilder }

{ #category : #'*Graphviz4GT' }
GtMondrianLayoutBuilder >> graphviz [
	^ self topStep layout: (BlFitChildrenLayout new addLayout: GraphvizLayout new)
]
