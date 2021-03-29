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
GraphvizLayoutExamples >> randomExample [
<gtExample>
| m |

	m := GtMondrian new.
	m nodes with: (1 to: 15).
	m edges connectFrom: [ :nb | 15 atRandom ].
	m layout graphviz.
	^ m
	
]
