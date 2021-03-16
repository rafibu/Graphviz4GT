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

	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: 0@0)
]
