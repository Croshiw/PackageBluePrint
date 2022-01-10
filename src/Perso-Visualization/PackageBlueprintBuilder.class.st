Class {
	#name : #PackageBlueprintBuilder,
	#superclass : #Object,
	#instVars : [
		'famix_class',
		'references',
		'nb_ref'
	],
	#category : #'Perso-Visualization-Builder'
}

{ #category : #accessing }
PackageBlueprintBuilder >> famixClass: anObject [

	famix_class := anObject
]

{ #category : #accessing }
PackageBlueprintBuilder >> famix_class [

	^ famix_class
]

{ #category : #accessing }
PackageBlueprintBuilder >> nbRef [

	^ nb_ref
]

{ #category : #accessing }
PackageBlueprintBuilder >> nbRef: anObject [

	nb_ref := anObject
]

{ #category : #accessing }
PackageBlueprintBuilder >> references [

	^ references
]

{ #category : #accessing }
PackageBlueprintBuilder >> references: anObject [

	references := anObject
]
