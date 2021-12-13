Class {
	#name : #PackageBlueprintClassHolder,
	#superclass : #Object,
	#instVars : [
		'famix_class',
		'references',
		'nb_ref'
	],
	#category : #'Perso-Visualization-Holder'
}

{ #category : #accessing }
PackageBlueprintClassHolder >> famix_class [

	^ famix_class
]

{ #category : #accessing }
PackageBlueprintClassHolder >> famix_class: anObject [

	famix_class := anObject
]

{ #category : #accessing }
PackageBlueprintClassHolder >> nb_ref [

	^ nb_ref
]

{ #category : #accessing }
PackageBlueprintClassHolder >> nb_ref: anObject [

	nb_ref := anObject
]

{ #category : #accessing }
PackageBlueprintClassHolder >> references [

	^ references
]

{ #category : #accessing }
PackageBlueprintClassHolder >> references: anObject [

	references := anObject
]
