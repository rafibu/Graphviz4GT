Class {
	#name : #GraphvizLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'string'
	],
	#category : #Graphviz4GT
}

{ #category : #accessing }
GraphvizLayout >> createGraphFor: aGtMondrian [
	self createStringFor: aGtMondrian
	"create temp Dot file with string"
	"runningGraphvizInputFilename: temp.dot outputFilename: result.txt"
	"positionShapes: aGtMondrian asElement (?) with: result.txt asByteStream (?)"
]

{ #category : #accessing }
GraphvizLayout >> createStringFor: aMondrian [
| allNodes allLines stream |
	allNodes := OrderedCollection new.
aMondrian root graph allNodeChildrenDo: [ :aNode |
	allNodes add: aNode.
].
allLines := Set new.
allNodes do: [ :aNode | 
	allLines addAll: (aNode graph connectedEdges).
	 ].
allLines := allLines asOrderedCollection.
stream := WriteStream on: String new.
stream << 'graph GraphvizGT'; crlf; << '{'.
allLines do: [ :aLine |
	| fromElement toElement |
	fromElement := aLine fromElement.
	toElement := aLine toElement.
	stream << (allNodes indexOf: fromElement) asString.
	stream << ' -- '.
	stream << (allNodes indexOf: toElement) asString.
	stream << ';'.
	stream lf
].
stream << '}'.
self string: (stream contents)
]

{ #category : #accessing }
GraphvizLayout >> layout: aParentLayoutNode [
	self createStringFor: aParentLayoutNode.
	self positionShapes: aParentLayoutNode.
]

{ #category : #accessing }
GraphvizLayout >> measure: aParentLayoutNode [
	self preMeasureChildrenNodes: aParentLayoutNode.

	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: 0@0)
]

{ #category : #accessing }
GraphvizLayout >> positionShapes: elements with: aString [
	| nodeIndex |
	aString ifEmpty: [ self error: 'Error in Dot converter' ].
	nodeIndex := 1.
	
	aString linesDo: [ :l | 
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
	
	^ self ffiCall: #( int runGraphviz ( char * filenameInput , char* filenameOutput) ) library: '/home/rafi/Desktop/SCC/liball.so'
]

{ #category : #accessing }
GraphvizLayout >> string: aString [
 string := aString
]
