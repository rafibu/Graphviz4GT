"
This Layout calls the Graphviz Library to organize a GtMondrian Graph and return it.

The best way to use it is by calling GtMondrianLayoutBuilder graphviz 
"
Class {
	#name : #GraphvizLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'string'
	],
	#category : #Graphviz4GT
}

{ #category : #obsolete }
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
GraphvizLayout >> getDotDescriptionFrom: aParentGraphNode [
	| allNodes allEdges result |

	allNodes := aParentGraphNode children.
	allEdges := OrderedCollection new.
	allNodes do: [ :aNode | allEdges addAll: aNode outgoingEdges ].
	result := WriteStream on: String new.
	result << 'graph {'; lf.
	allNodes do: [ :aNode |
		result tab.
		result << (allNodes indexOf: aNode) asString.
		result << '[shape=box height='.
		result << (aNode height) asString.
		result << 'width='.
		result << (aNode width) asString.
		result << '];'.
	].
	allEdges
		do: [ :anEdge |
			result tab.
			result << (allNodes indexOf: anEdge fromNode) asString.
			result << ' -- '.
			result << (allNodes indexOf: anEdge toNode) asString.
			result << ';'.
			result lf ].
	result << '}'; lf.
	^ result contents
]

{ #category : #accessing }
GraphvizLayout >> layout: aParentLayoutNode [
	| fr frOutput |
 	"string := self getDotDescriptionFrom: aParentLayoutNode."
 	fr := '/tmp/description.dot' asFileReference.
 	fr exists ifTrue: [ fr delete ].

 	fr writeStream nextPutAll: ((self getDotDescriptionFrom: aParentLayoutNode withGraphNodes withGraphEdges)); close.
 	frOutput := '/tmp/result.txt' asFileReference.
 	frOutput exists ifTrue: [ frOutput delete ].
 	(self runningGraphvizInputFilename: '/tmp/description.dot' outputFilename: '/tmp/result.txt').
 	self positionShapes: (aParentLayoutNode children) with: frOutput readStream contents.
 	aParentLayoutNode children normalizePositions
]

{ #category : #accessing }
GraphvizLayout >> measure: aParentLayoutNode [
	self preMeasureChildrenNodes: aParentLayoutNode.
	"self measureParentNode: aParentLayoutNode."
]

{ #category : #accessing }
GraphvizLayout >> measureParentNode: aParentLayoutNode [
	"Compute the measured extent of the parent node based on the measured bounds of the children"
	| boundingBox width height |
	boundingBox := aParentLayoutNode children boundingBox.
	width := boundingBox width + aParentLayoutNode padding width.
	height := boundingBox height + aParentLayoutNode padding height.
	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: width @ height)
]

{ #category : #accessing }
GraphvizLayout >> positionShapes: elements with: aString [
	| nodeIndex yMax |
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

	"Graphviz uses a different Y-axis than GT. We perform a small conversion"
 	yMax := (elements collect: [ :e | e position y ]) max.
 	elements do: [ :e |
 		e position: (e position x) @ (yMax - e position y)
 	]
]

{ #category : #accessing }
GraphvizLayout >> runningGraphvizInputFilename: filenameInput outputFilename: filenameOutput [
	"
	self new runningGraphvizInputFilename: 'hello.dot' outputFilename: 'myresult.txt'
	"
	
	^ self ffiCall: #( int runGraphviz ( char * filenameInput , char* filenameOutput) ) library: GraphvizFFILibrary
]

{ #category : #obsolete }
GraphvizLayout >> string: aString [
 string := aString
]
