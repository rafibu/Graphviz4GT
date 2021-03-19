Class {
	#name : #GraphvizLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'string'
	],
	#category : #Graphviz4GT
}

{ #category : #accessing }
GraphvizLayout >> layout: aParentLayoutNode [
	self positionShapes: (aParentLayoutNode children) with: string
]

{ #category : #accessing }
GraphvizLayout >> measure: aParentLayoutNode [
	self preMeasureChildrenNodes: aParentLayoutNode.

	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: 0@0)
]

{ #category : #accessing }
GraphvizLayout >> positionShapes: elements with: aString [
	| nodeIndex |
	string ifEmpty: [ self error: 'Error in Dot converter' ].
	nodeIndex := 1.
	
	string linesDo: [ :l | 
		| line type |
		line := (' ' split: l) readStream.
		type := line next.
		type = #node ifTrue: [ 
			| x y |
			line next.
			x := 20*line next asNumber.
			y := 20*line next asNumber.
			
			(elements at: nodeIndex) position: x@y.
			nodeIndex := nodeIndex + 1.
			 ].
		"type = #edge ifTrue: [
			| points tail head edge |
			tail := line next asNumber.
			head := line next asNumber.
			tail := elements at: tail.
			head := elements at: head.
			points := self pointsFor: line.
			edge := tail connectedEdges detect: [ :ed | ed to = head ].
			edge attachPoint: (RSGraphVizAttachPoint new points: points edge: edge).
			edge propertyAt: #points put: points.
			 ]."
		 ].
]

{ #category : #accessing }
GraphvizLayout >> runningGraphvizInputFilename: filenameInput outputFilename: filenameOutput [
	"
	self new runningGraphvizInputFilename: 'hello.dot' outputFilename: 'myresult.txt'
	"
	
	^ self ffiCall: #( int runGraphviz ( char * filenameInput , char* filenameOutput) ) library: 'C:\Users\rafae\Desktop\Studium\Master\1.Semester\Seminar Software Composition\liball.lib'
]

{ #category : #accessing }
GraphvizLayout >> string: aString [
 string := aString
]
