Class {
	#name : #BaselineOfGraphviz4GT,
	#superclass : #BaselineOf,
	#category : #BaselineOfGraphviz4GT
}

{ #category : #accessing }
BaselineOfGraphviz4GT >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: #Graphviz4GT ]
]
