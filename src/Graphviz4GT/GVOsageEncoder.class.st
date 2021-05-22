"
A layout algorithm for clustered graphs based on user specifications
"
Class {
	#name : #GVOsageEncoder,
	#superclass : #GVAbstractEncoder,
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVOsageEncoder >> writeLayoutNameOn: stream [
	stream nextPutAll: 'layout = "osage" ;'; crlf
]
