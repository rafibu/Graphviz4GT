"
A Layout which orders the Children of a BlElement as Nodes of a Graph in random ways.

Is only used for testing
"
Class {
	#name : #BlRandomLayout,
	#superclass : #BlNodeBasedLayout,
	#category : #Graphviz4GT
}

{ #category : #accessing }
BlRandomLayout >> layout: aParentLayoutNode [
		
	"just need to compute children positions"
	aParentLayoutNode childrenDo: [ :eachChildLayoutNode |
		| aChildX aChildY |
		aChildX := (aParentLayoutNode width - eachChildLayoutNode width)
			asInteger atRandom.
		aChildY := (aParentLayoutNode height - eachChildLayoutNode height)
			asInteger atRandom.
	
		eachChildLayoutNode position: (aChildX @ aChildY) ]
]

{ #category : #accessing }
BlRandomLayout >> measure: aParentLayoutNode [
	self preMeasureChildrenNodes: aParentLayoutNode.
	self measureParentNode: aParentLayoutNode.
]

{ #category : #accessing }
BlRandomLayout >> measureParentNode: aParentLayoutNode [
	"Compute the measured extent of the parent node based on the measured bounds of the children"
	| boundingBox width height |
	boundingBox := aParentLayoutNode children boundingBox.
	width := boundingBox width + aParentLayoutNode padding width.
	height := boundingBox height + aParentLayoutNode padding height.
	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: width @ height)
]
