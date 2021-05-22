"
This Layout calls the Graphviz Library to organize a GtMondrian Graph and return it.

The best way to use it is by calling GtMondrianLayoutBuilder graphviz 

Arguments about the Graphviz settings can be given in the following way:

GraphvizLayout new {layout} {direction}
Example: GraphvizLayout new dot rankdirTB

with the following layout options:
- dot (default)
- neato
- circo
- sfdp
- fdp
- twopi
- osage
- patchwork

For direction (Note: only the dot layout can understand different rankdir options):
- rankdirTB (Top to Bottom, default)
- rankdirLR (Left to Right)
"
Class {
	#name : #GraphvizLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'string',
		'encoder'
	],
	#category : #Graphviz4GT
}

{ #category : #accessing }
GraphvizLayout >> circo [
	encoder := GVCircoEncoder new
]

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
GraphvizLayout >> digraph [
	encoder := GVCircoEncoder new
]

{ #category : #accessing }
GraphvizLayout >> dot [
	"Do nothing as this is the default layout"
]

{ #category : #accessing }
GraphvizLayout >> fdp [
	encoder := GVFDPEncoder new
]

{ #category : #accessing }
GraphvizLayout >> getDotDescriptionFrom: aParentGraphNode [
	| allNodes allEdges result |

	allNodes := aParentGraphNode children.
	allEdges := OrderedCollection new.
	allNodes do: [ :aNode | allEdges addAll: aNode outgoingEdges ].
	result := WriteStream on: String new.
	result << 'graph {'; lf.
	encoder writeLayoutNameOn: result.
	encoder writeRankdirOn: result.
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
GraphvizLayout >> initialize [
	super initialize.
	encoder := GVDefaultEncoder new
]

{ #category : #accessing }
GraphvizLayout >> layout: aParentLayoutNode [
	| fr frOutput |
 	"string := self getDotDescriptionFrom: aParentLayoutNode."
 	fr := '/tmp/description.dot' asFileReference.
 	fr exists ifTrue: [ fr delete ].

 	fr writeStream nextPutAll: ((self getDotDescriptionFrom: aParentLayoutNode withGraphNodes withGraphEdges)); close.
 	frOutput := '/tmp/result.txt' asFileReference.
 	"frOutput exists ifTrue: [ frOutput delete ]."
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
GraphvizLayout >> neato [
	encoder := GVNeatoEncoder new
]

{ #category : #accessing }
GraphvizLayout >> osage [
	encoder := GVOsageEncoder new
]

{ #category : #accessing }
GraphvizLayout >> patchwork [
	encoder := GVPatchworkEncoder new
]

{ #category : #accessing }
GraphvizLayout >> positionShapes: elements with: aString [
	| nodeIndex yMax maxX maxY xFactor yFactor b|
	aString ifEmpty: [ self error: 'Error in Dot converter' ].
	nodeIndex := 1.
	maxX := 0.
	maxY := 0.
	
	aString linesDo: [ :l | 
		| line type |
		line := (' ' split: l) readStream.
		type := line next.
		type = #node ifTrue: [ 
			| x y |
			line next.
			x := line next asNumber.
			y := line next asNumber.
			
			x > maxX ifTrue: [
				maxX := x
			].
			
			y > maxY ifTrue: [
				maxY := y
			].
			nodeIndex := nodeIndex + 1.
			 ].
		 ].
		 
	xFactor := ((elements at: 1) parent extent x)/maxX.
	yFactor := ((elements at: 1) parent extent y)/maxY.
		 
	nodeIndex := 1.
	
	aString linesDo: [ :l | 
		| line type |
		line := (' ' split: l) readStream.
		type := line next.
		type = #node ifTrue: [ 
			| x y |
			line next.
			x := xFactor * line next asNumber.
			y := yFactor * line next asNumber.
			
			(elements at: nodeIndex) position: x@y.
			nodeIndex := nodeIndex + 1.
			 ].
		 ].

	"Graphviz uses a different Y-axis than GT. We perform a small conversion"
 	yMax := (elements collect: [ :e | e position y ]) max.
 	elements do: [ :e |
 		e position: (e position x) @ (yMax - e position y)
 	]
]

{ #category : #accessing }
GraphvizLayout >> rankdirLR [
	encoder rankdirLR
]

{ #category : #accessing }
GraphvizLayout >> rankdirTB [
	encoder rankdirTB
]

{ #category : #accessing }
GraphvizLayout >> rotate: int [
	encoder rotation: int
]

{ #category : #accessing }
GraphvizLayout >> runningGraphvizInputFilename: filenameInput outputFilename: filenameOutput [
	"
	self new runningGraphvizInputFilename: 'hello.dot' outputFilename: 'myresult.txt'
	"
	
	^ self ffiCall: #( int runGraphviz ( char * filenameInput , char* filenameOutput) ) library: GraphvizFFILibrary
]

{ #category : #accessing }
GraphvizLayout >> sfdp [
	encoder := GVSFDPEncoder new
]

{ #category : #obsolete }
GraphvizLayout >> string: aString [
 string := aString
]

{ #category : #accessing }
GraphvizLayout >> twopi [
	encoder := GVTwoPiEncoder new
]
