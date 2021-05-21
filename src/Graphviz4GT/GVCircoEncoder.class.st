"
circular layout, after Six and Tollis 99, Kauffman and Wiese 02. 
This is suitable for certain diagrams of multiple cyclic structures, such as certain telecommunications networks.
"
Class {
	#name : #GVCircoEncoder,
	#superclass : #GVAbstractEncoder,
	#category : #'Graphviz4GT-Graphviz4GT'
}

{ #category : #accessing }
GVCircoEncoder >> writeLayoutNameOn: stream [
	stream nextPutAll: 'layout = "circo" ;'; crlf
]
