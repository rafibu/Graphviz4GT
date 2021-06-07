"
The Encoder keeps track of the settings for Graphviz
"
Class {
	#name : #GVAbstractEncoder,
	#superclass : #Object,
	#instVars : [
		'rankdir',
		'rotation',
		'rank',
		'clusters',
		'subgraphs'
	],
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVAbstractEncoder >> addCluster: aCollection [
"Adds a Cluster of nodes"
clusters notNil ifFalse: [
	clusters := Set new.
].
clusters add: aCollection.
]

{ #category : #accessing }
GVAbstractEncoder >> addSubgraph: aCollection [
"Adds a Subgraph of nodes"
subgraphs notNil ifFalse: [
	subgraphs := Set new.
].
subgraphs add: aCollection.
]

{ #category : #accessing }
GVAbstractEncoder >> rank: aString [
aString = 'same' ifTrue: [
	rank := 'rank="same";'.
].
aString = 'min' ifTrue: [
	rank := 'rank="min";'.
].
aString = 'source' ifTrue: [
	rank := 'rank="source";'.
].
aString = 'max' ifTrue: [
	rank := 'rank="max";'.
].
aString = 'sink' ifTrue: [
	rank := 'rank="sink";'.
].
]

{ #category : #accessing }
GVAbstractEncoder >> rankdirLR [
	rankdir := 'rankdir="LR";'
]

{ #category : #accessing }
GVAbstractEncoder >> rankdirTB [
	rankdir := 'rankdir="TB";'
]

{ #category : #accessing }
GVAbstractEncoder >> writeClustersOn: stream [
clusters do: [ :cluster |
	stream << 'cluster {'; lf.
	(self writeRankOn: stream).
	cluster do: [ :aNode |
		stream << aNode asString. 
		stream << ';'; lf.
	].
	stream << '}'; lf.
].
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
GVAbstractEncoder >> writeRankOn: stream [
rank notNil ifTrue: [
		stream nextPutAll: rank; crlf
	].
]

{ #category : #accessing }
GVAbstractEncoder >> writeRankdirOn: stream [
rankdir notNil ifTrue: [
		stream nextPutAll: rankdir; crlf
	].
]

{ #category : #accessing }
GVAbstractEncoder >> writeSubgraphsOn: stream [
subgraphs notNil ifTrue: [
	subgraphs do: [ :subgraph |
		stream << 'subgraph {'; lf.
		(self writeRankOn: stream).
		subgraph do: [ :aNode |
			stream << aNode asString. 
			stream << ';'; lf.
		].
		stream << '}'; lf.
	].
].
]
