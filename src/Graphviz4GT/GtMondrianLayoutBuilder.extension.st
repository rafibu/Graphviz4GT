Extension { #name : #GtMondrianLayoutBuilder }

{ #category : #'*Graphviz4GT' }
GtMondrianLayoutBuilder >> graphviz [
	| gvLayout |
	gvLayout := GraphvizLayout new.
	
	self topStep layout: (BlFitChildrenLayout new addLayout: gvLayout).
	^ gvLayout
]
