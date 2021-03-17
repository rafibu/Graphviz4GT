Class {
	#name : #BlRandomLayoutExamples,
	#superclass : #Object,
	#category : #'Graphviz4GT-Bloc-RandomLayout'
}

{ #category : #accessing }
BlRandomLayoutExamples >> withManyChildElements [
	<gtExample>
	| aParent theChildElements |
	
	theChildElements := 100 timesCollect: [
		BlElement new
			size: 20@20;
			background: (Color lightGray alpha: 0.5);
			geometry: BlEllipseGeometry new
	].
	
	aParent :=  BlElement new
		layout: BlRandomLayout new;
		size: 400@400;
		addChildren: theChildElements.
		
	^ aParent
]

{ #category : #accessing }
BlRandomLayoutExamples >> withManyChildren [
	<gtExample>
	| aParentNode theChildNodes aLayout |
	
	theChildNodes := 100 timesCollect:[
		BlLayoutChildNode new
		constraints: (BlLayoutCommonConstraints new);
		measurement: (BlLayoutNodeResizerMeasurement new);
		hExact: 20;
		vExact: 20 ].
		
	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlMeasurementSpec exact: 400)@(BlMeasurementSpec exact: 400);
		children: theChildNodes.
		
	aLayout := BlRandomLayout new.
	aLayout measure: aParentNode.
	aLayout layout: aParentNode.
		
	^ aParentNode
]

{ #category : #accessing }
BlRandomLayoutExamples >> withOneChild [
	<gtExample>
	| aParentNode aChildNode aLayout |
	
	aChildNode := BlLayoutChildNode new
		constraints: (BlLayoutCommonConstraints new);
		measurement: (BlLayoutNodeResizerMeasurement new);
		hExact: 50;
		vExact: 50.
		
	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlMeasurementSpec exact: 200)@(BlMeasurementSpec exact: 200);
		children: {aChildNode}.
		
	aLayout := BlRandomLayout new.
	aLayout measure: aParentNode.
	aLayout layout: aParentNode.
		
	^ aParentNode
]
