Class {
	#name : #GraphvizLayoutExamples,
	#superclass : #Object,
	#category : #'Graphviz4GT-GraphvizLayout'
}

{ #category : #accessing }
GraphvizLayoutExamples >> basicExample [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: (1 to: 10).
	m edges connectFrom: [ :nb | nb // 2 ].
	m layout graphviz.
	^ m
]

{ #category : #accessing }
GraphvizLayoutExamples >> initialExample [
<gtExample>
| csvString lines previous proConTable phases artifacts producers consumers proConCluster clusters proCluster clusterCon view |
"The input is a table of producer - artifact - consumer entries."

csvString := 'SDLC phase(s) of origin	Artifacts	SDLC phase(s) of use
Requirements	User stories	Design
	User stories	Development and Testing
Requirements	Story cards	Design
	Story cards	Development and Testing
Requirements	Storyboards	Design
Requirements	Kanban board	Development and Testing
Design	Kanban board	
Design	User journey	Design
	User journey	Development and Testing
Requirements	Pin board	Requirements
	Pin board	Design
	Pin board	Development and Testing
Requirements	Index cards	Requirements
	Index cards	Design
	Index cards	Development and Testing
Requirements	Release plan	Development and Testing
Design	Release plan	
Requirements	Status board	Development and Testing
Design	Status board	
Requirements	Story estimates	Development and Testing
Design	Story estimates	
Requirements	Post-it notes	Requirements
	Post-it notes	Design
	Post-it notes	Development and Testing
Requirements	Design concept	Design
Design	Design concept	
Design	Prototype	Requirements
Development and Testing	Prototype	Design
Design	Mockups	Requirements
	Mockups	Design
	Mockups	Development and Testing
Design	Wireframes	Requirements
	Wireframes	Design
	Wireframes	Development and Testing
Design	Interaction scenarios	Design
Requirements	Pictures	Requirements
Design	Pictures	Design
Development and Testing	Pictures	Development and Testing
Deployment and Maintenance	Pictures	Deployment and Maintenance
Requirements	Videos	Requirements
Design	Videos	Design
Development and Testing	Videos	Development and Testing
Deployment and Maintenance	Videos	Deployment and Maintenance
Requirements	Sketches	Design
Requirements	Screenshots	Requirements
Design	Screenshots	Design
Development and Testing	Screenshots	Development and Testing
Deployment and Maintenance	Screenshots	Deployment and Maintenance
Design	MVP	Deployment and Maintenance
Design	UML diagrams	Development and Testing
Development and Testing	EMF models	Development and Testing
Requirements	Domain models	Requirements
	Domain models	Development and Testing
Design	Process models	Design
Requirements	User interface model	Design
Design	System model	Design
	System model	Development and Testing
Design	Process model	Design
Design	Data model	Development and Testing
Requirements	Goal models	Requirements
	Goal models	Design
Design	Role model	Design
Requirements	User model	Design
	User model	Development and Testing
Design	Ontological models	Design
Requirements	Business Process Models	Requirements
	Business Process Models	Design
Requirements	Task model	Design
Design	Task model	
	Node and edge models	
Requirements	Test specifications	Development and Testing
Design	Test specifications	
Design	Integration tests	Development and Testing
Development and Testing	Integration tests	
Design	Regression tests	Development and Testing
Development and Testing	Regression tests	
Design	Unit tests	Development and Testing
Development and Testing	Unit tests	
Design	Test plan	Design
	Test plan	Development and Testing
Requirements	Mind maps	Design
Requirements	Roadmap	Development and Testing
Design	Roadmap	
Requirements	Impact map	Requirements
Requirements	Effect maps	Requirements
Requirements	Story map	Development and Testing
Design	Story map	
Requirements	Vision	Requirements
	Vision	Design
Requirements	Tasks	Design
	Tasks	Development and Testing
Design	Scenarios	Design
Design	Personas	Design
Development and Testing	Issues	Development and Testing
Design	Product backlog	Design
	Product backlog	Development and Testing
Requirements	Burn down chart	Development and Testing
Design	Burn down chart	
Design	Epic	Design
	Epic	Development and Testing
Development and Testing	Features	Requirements
Deployment and Maintenance	Features	
Requirements	Use-cases	Design
	Use-cases	Development and Testing
Requirements	Use-case description	Design
	Use-case description	Development and Testing
Requirements	User wish list	Design
Design	Feature diagram	Development and Testing
Design	Tags	Design
	Tags	Development and Testing
Requirements	Business rules	Requirements
	Business rules	Design
Requirements	DSL	Design
	DSL	Development and Testing
Requirements	Excel reports	Requirements
Design	Excel reports	Design
Development and Testing	Excel reports	Development and Testing
Deployment and Maintenance	Excel reports	Deployment and Maintenance'.

"Convert the csv to a table, and extract the phases and artifacts."

lines := (Character lf split: csvString) collect: [ :line | Character tab split: line].
previous := lines first.
lines allButFirst do: [ : line | 
	line first isEmpty ifTrue: [ line at: 1 put: previous first ].
	line third isEmpty ifTrue: [ line at: 3 put: previous third ].
	previous := line ].
proConTable := lines allButFirst.
proConTable.

phases := (proConTable flatCollect: [ : each | { each first . each third } ]) asSet.
artifacts := (proConTable collect: #second) asSet.



"Extract clusters of artifacts with the same sets of producers and consumers."

"Build dictionaries mapping each artifact to its set of producers, respectively consumers."
producers := Dictionary new.
consumers := Dictionary new.

proConTable do: [ :l |
	(producers at: l second ifAbsentPut: Set new) add: l first.
	(consumers at: l second ifAbsentPut: Set new) add: l third ].

producers values asSet.
consumers values asSet.

"Cluster the artifacts by building a dictionary from producer -> consumer associations to the corresponding sets of artifacts."

proConCluster := Dictionary new.

artifacts do: [ : a | | pro con |
	pro := producers at: a ifAbsent: Set new.
	con := producers at: a ifAbsent: Set new.
	(proConCluster at: pro -> con ifAbsentPut: Set new) add: a ].

proConCluster.
clusters := proConCluster values.

"Extract the edges from producer to cluster and cluster to consumer."
proCluster := OrderedCollection new.
clusterCon := OrderedCollection new.
proConCluster keysAndValuesDo: [ :proCon :artifact |
	proCon key do: [ :pro | proCluster add: pro->artifact ].
	proCon value do: [ :con | clusterCon add: artifact->con ] ].

"show a graph of the phases and clusters of artifacts with the same producers and consumers."

view := GtMondrian new.
view nodes
	shape: [ :x |
		BlTextElement new
			text: (x asRopedText fontSize: 1.2 fontEm);
			border: (BlBorder paint: Color blue width: 1);
			background: Color white;
			padding: (BlInsets all: 5) ];
	with: phases.
view nodes
	shape: [ :x |
		BrEditor new
			beReadOnlyWithoutSelection;
			text: ((Character cr join: x) asRopedText );
			look: (BrGlamorousRegularEditorLook new fontSize: 0.6 fontEm);
			background: Color white;
			border: (BlBorder paint: Color gray width: 1);
			padding: (BlInsets all: 5) ];
	with: clusters.
view edges
	connect: proCluster from: #key to: #value.

view layout graphviz.
^ view.
]

{ #category : #accessing }
GraphvizLayoutExamples >> libraryIsFound [
	<gtExample>
	"Should not raise an error"
	^ GraphvizFFILibrary uniqueInstance macModuleName
]

{ #category : #accessing }
GraphvizLayoutExamples >> randomExample [
<gtExample>
| m |

	m := GtMondrian new.
	m nodes with: (1 to: 15).
	m edges connectFrom: [ :nb | 15 atRandom ].
	m layout graphviz.
	^ m
	
]
