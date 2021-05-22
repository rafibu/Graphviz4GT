"
The Encoder keeps track of the settings for Graphviz
"
Class {
	#name : #GVAbstractEncoder,
	#superclass : #Object,
	#instVars : [
		'rankdir',
		'rotation'
	],
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVAbstractEncoder >> rankdirLR [
	rankdir := 'rankdir="LR";'
]

{ #category : #accessing }
GVAbstractEncoder >> rankdirTB [
	rankdir := 'rankdir="TB";'
]

{ #category : #accessing }
GVAbstractEncoder >> writeEncoderOptionsOn: stream [
	self writeLayoutNameOn: stream.
	self writeRankdirOn: stream.
	
]

{ #category : #accessing }
GVAbstractEncoder >> writeLayoutNameOn: stream [
	self subclassResponsibilities
]

{ #category : #accessing }
GVAbstractEncoder >> writeRankdirOn: stream [
	rankdir notNil ifTrue: [
		stream nextPutAll: rankdir; crlf
	].
]
