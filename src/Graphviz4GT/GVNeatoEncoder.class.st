"
spring model - attempts to minimize a global energy function, which is equivalent to statistical multi-dimensional scaling
"
Class {
	#name : #GVNeatoEncoder,
	#superclass : #GVAbstractEncoder,
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVNeatoEncoder >> writeLayoutNameOn: stream [
	stream nextPutAll: 'layout = "neato" ;'; crlf
]
