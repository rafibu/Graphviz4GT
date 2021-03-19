Class {
	#name : #GraphvizLayoutExamples,
	#superclass : #Object,
	#category : #'Graphviz4GT-GraphvizLayout'
}

{ #category : #accessing }
GraphvizLayoutExamples >> helloWorld [
<gtExample>
|string aParent theChildElements layout|
string := 'graph 1 0.88464 1.5
node hello 0.44232 1.25 0.77632 0.5 hello solid ellipse black lightgrey
node world 0.44232 0.25 0.88464 0.5 world solid ellipse black lightgrey
edge hello world 4 0.44232 0.99579 0.44232 0.84509 0.44232 0.65162 0.44232 0.501
45 solid black
stop'.
	
	theChildElements := 2 timesCollect: [
		BlElement new
			size: 20@20;
			background: (Color lightGray alpha: 0.5);
			geometry: BlEllipseGeometry new
	].
	
	layout := GraphvizLayout new .
	layout string: string.
	
	aParent :=  BlElement new
		layout: layout;
		size: 400@400;
		addChildren: theChildElements.
 	
 ^ aParent
]
