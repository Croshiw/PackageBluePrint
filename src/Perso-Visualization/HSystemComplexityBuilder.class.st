"
TODO
"
Class {
	#name : #HSystemComplexityBuilder,
	#superclass : #HNodeBuilder,
	#instVars : [
		'entities',
		'colorPalette',
		'metric'
	],
	#category : #'Perso-Visualization-Builder'
}

{ #category : #building }
HSystemComplexityBuilder >> build [

	"Create a rootNode, add all the sub nodes (classes) and then update the colors with the shades wanted"

	rootNode := HNode new name: 'Root'.
	rootNode addAll:
		(self entities asMooseGroup collect: [ :pkg | self buildNodeFromPackage: pkg ]).
	self setColorPalette.
	rootNode children do: [ :aNode | self updateNode: aNode ]
]

{ #category : #building }
HSystemComplexityBuilder >> buildNodeFromPackage: aPackage [

	"Create the package Node and add the classes Nodes"

	| aPackageNode |
	aPackageNode := HNode new
		        name: aPackage name;
		        rawModel: aPackage;
		        yourself.
	(aPackage allToScope: FamixTClass) do: [ :aClass | 
		(self buildNodesFromHierarchyOf: aClass in: aPackageNode) ].
	aPackageNode collapse.
	^ aPackageNode
]

{ #category : #building }
HSystemComplexityBuilder >> buildNodesFromHierarchyOf: aClass in: aPackageNode [

	^ aClass buildNodesIn: aPackageNode 
]

{ #category : #accessing }
HSystemComplexityBuilder >> colorPalette [

	^colorPalette
]

{ #category : #accessing }
HSystemComplexityBuilder >> colorPalette: aColor [

	colorPalette := aColor
]

{ #category : #accessing }
HSystemComplexityBuilder >> entities [
	^entities
]

{ #category : #accessing }
HSystemComplexityBuilder >> entities: anObject [
 entities := anObject
]

{ #category : #initialization }
HSystemComplexityBuilder >> initialize [

	"TODO: instead of setting the colorPalette here it should be done at the end of the build because the number of shades generated is related to the number of methods of the classes
	generate = max num methods - min num methods"

	super initialize.
	
]

{ #category : #accessing }
HSystemComplexityBuilder >> metric [
	^metric
]

{ #category : #accessing }
HSystemComplexityBuilder >> metric: aSymbol [

	metric := aSymbol 
]

{ #category : #building }
HSystemComplexityBuilder >> setColorPalette [

	| classGroup range |
	classGroup := entities asMooseGroup flatCollect: [ :pck | 
		              pck allToScope: FamixTClass ].
	range := classGroup ifEmpty: [ 1 ] ifNotEmpty: [ 
		         | max min |
		         max := classGroup max: self metric.
		         min := classGroup min: self metric.
		         max - min max: 1 ].
	self colorPalette:
		(NSScale ordinal range: (ClpSequentialPaletteGenerator new
				  startColor: Color lightGreen endColor: Color red;
				  generate: range) asCollection)
]

{ #category : #updating }
HSystemComplexityBuilder >> updateNode: node [

	"the color of a node is determined by how many children does it have if its not a class (Package,method,attribute..)but if its a class then we use the defined metric in the dropList"

	| scale |
	scale := (node rawModel isOfType: FamixTClass)
		         ifTrue: [ self metric value: node rawModel ]
		         ifFalse: [ node children ].
	node color: (self colorPalette scale: scale).
	node children do: [ :child | self updateNode: child ]
]
