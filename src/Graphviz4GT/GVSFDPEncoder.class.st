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
GVSFDPEncoder >> rotation: int [
	rotation := 'rotation=', int asString
]

{ #category : #accessing }
GVSFDPEncoder >> writeEncoderOptionsOn: stream [
	super writeEncoderOptionsOn: stream.
	self writeRotationOn: stream
]

{ #category : #accessing }
GVSFDPEncoder >> writeLayoutNameOn: stream [
	stream nextPutAll: 'layout = "sfdp" ;'; crlf
]

{ #category : #accessing }
GVSFDPEncoder >> writeRotationOn: stream [
	rotation notNil ifTrue: [
		stream nextPutAll: rotation; crlf
	].
]
