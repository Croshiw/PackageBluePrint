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
MiPackageBlueprintVisualization >> run [

	"TODO: For each class in classes, create a new Holder that contains the famixclass, a Collection of its outgoing  references and the number of outgoing references(nb_ref >= references size).
Then we should sort the objects by nb_ref descending.
Then we can start building our visualization
"

	self createClassHolders.
	self sortHolders.
]

{ #category : #accessing }
MiPackageBlueprintVisualization >> sortHolders [
	self holders sorted: [ :h1 :h2 | h1 nbRef > h2 nbRef ]
]
