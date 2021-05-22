Class {
	#name : #GVFDPEncoder,
	#superclass : #GVAbstractEncoder,
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVFDPEncoder >> writeLayoutNameOn: stream [
	stream nextPutAll: 'layout = "fdp" ;'; crlf
]
