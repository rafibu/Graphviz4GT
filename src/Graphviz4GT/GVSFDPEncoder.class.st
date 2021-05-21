"
Spring force directed Layout
Well suited for bigger Graphs.
"
Class {
	#name : #GVSFDPEncoder,
	#superclass : #GVAbstractEncoder,
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVSFDPEncoder >> writeLayoutNameOn: stream [
	stream nextPutAll: 'layout = "sfdp" ;'; crlf
]
