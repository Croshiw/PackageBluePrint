Class {
	#name : #MiPackageBlueprintVisualization,
	#superclass : #MiAbstractVisualization,
	#instVars : [
		'classes',
		'holders'
	],
	#category : #'Perso-Visualization-Visualization'
}

{ #category : #accessing }
MiPackageBlueprintVisualization >> boxCompositeFor: cls [

	| label box |
	box := self newBox.
	label := self newLabel: cls name.
	RSLocation new
		above;
		move: box on: label.
	^ RSComposite new
		  shapes: { 
				  label.
				  box };
		  model: cls;
		  @ RSDraggable;
		  addInteraction:
			  (MiSelection on: [ :entity | self owner model selected: entity ]);
		  yourself
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> boxCompositeFor: cls withColor: col [

	| label box |
	box := self newBox: col.
	label := self newLabel: cls name.
	RSLocation new
		above;
		move: box on: label.
	^ RSComposite new
		  shapes: { 
				  label.
				  box };
		  model: cls;
		  @ RSDraggable;
		  addInteraction:
			  (MiSelection on: [ :entity | self owner model selected: entity ]);
		  yourself
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> classes [

	^ classes
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> classes: anObject [

	classes := anObject
]

{ #category : #running }
MiPackageBlueprintVisualization >> createClassHolders [

	self holders: Set new.
	self classes do: [ :cls | 
		| holder refs |
		refs := self getReferences: cls.
		holder := PackageBlueprintClassHolder new
			          famixClass: cls;
			          references: refs asSet;
			          nbRef: refs size.
		self holders add: holder ]
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> getReferences: aFamixClass [

	"TODO: test this -> aFamixClass query incoming object dependenciesOfType: FamixTReference.
 "

	^ aFamixClass queryOutgoingReferences collect: [ :ref | 
		  ref referredType ]
]

{ #category : #highlighting }
MiPackageBlueprintVisualization >> highlightShapes [


]

{ #category : #accessing }
MiPackageBlueprintVisualization >> holders [

	^ holders
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> holders: anObject [

	holders := anObject
]

{ #category : #running }
MiPackageBlueprintVisualization >> newBox [

	^ RSBox new
		  size: 100;
		  color: self theme selectionColor;
		  yourself
]

{ #category : #running }
MiPackageBlueprintVisualization >> newBox: col [

	^ RSBox new
		  size: 100;
		  color: col;
		  yourself
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> newLabel: name [

	^ RSLabel new
		  text: name;
		  color: self theme textColor;
		  yourself
]

{ #category : #running }
MiPackageBlueprintVisualization >> run [

	"TODO: For each class in classes, create a new Holder that contains the famixclass, a Collection of its outgoing  references and the number of outgoing references(nb_ref >= references size).
Then we should sort the objects by nb_ref descending.
Then we can start building our visualization
"

	| boxes1 boxes2 |
	super run.
	self createClassHolders.
	self sortHolders.
	boxes1 := RSGroup new.
	boxes1 addAll: (holders collect: [ :h | 
			 self boxCompositeFor: h famixClass withColor: Color lightGreen ]).
	boxes2 := RSGroup new.
	boxes2 addAll: (self holders collect: [ :h | 
			           self
				           boxCompositeFor: h famixClass
				           withColor: Color lightRed ]).
	self showVerticalClasses: boxes1 inCanvas: self canvas.
	self showHorizontalClasses: boxes2 inCanvas: self canvas.
	RSLocation new
		above;
		right;
		move: boxes2 on: boxes1

	"Ici 2 idées : colonne par colonne ou ligne par ligne
	reste à savoir comment les positionner sur le canvas"
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> showHorizontalClasses: boxes inCanvas: canvas [

	self canvas addAll: boxes.
	RSEdgeBuilder line
		canvas: canvas;
		withVerticalAttachPoint.
	RSHorizontalLineLayout on: boxes.
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> showVerticalClasses: boxes inCanvas: canvas [

	self canvas addAll: boxes.
	RSEdgeBuilder line
		canvas: canvas;
		withVerticalAttachPoint.
	RSVerticalLineLayout on: boxes
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> sortHolders [

	self holders:
		(self holders sorted: [ :h1 :h2 | h1 nbRef > h2 nbRef ])
]
