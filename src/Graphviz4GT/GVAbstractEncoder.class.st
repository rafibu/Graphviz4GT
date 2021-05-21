"
The Encoder keeps track of the settings for Graphviz
"
Class {
	#name : #GVAbstractEncoder,
	#superclass : #Object,
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVAbstractEncoder >> writeLayoutNameOn: stream [
	self subclassResponsibilities
]
