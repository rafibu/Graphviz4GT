Class {
	#name : #GVNeatoEncoder,
	#superclass : #GVAbstractEncoder,
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVNeatoEncoder >> writeLayoutNameOn: stream [
	stream nextPutAll: 'layout = "neato" ;'; crlf
]
