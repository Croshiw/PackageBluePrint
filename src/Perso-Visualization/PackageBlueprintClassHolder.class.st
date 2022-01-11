"
I represent the holder of a Famix Class.
I hold the Class, its outgoing references and the number of outgoing references
(nbRef >= references because it could refere to the same class twice)
"
Class {
	#name : #PackageBlueprintClassHolder,
	#superclass : #Object,
	#instVars : [
		'famixClass',
		'references',
		'nbRef'
	],
	#category : #'Perso-Visualization-Holder'
}

{ #category : #accessing }
PackageBlueprintClassHolder >> famixClass [
	^famixClass
]

{ #category : #accessing }
PackageBlueprintClassHolder >> famixClass: anObject [

	famixClass := anObject
]

{ #category : #accessing }
PackageBlueprintClassHolder >> nbRef [

	^ nbRef
]

{ #category : #accessing }
PackageBlueprintClassHolder >> nbRef: anObject [

	nbRef := anObject
]

{ #category : #accessing }
PackageBlueprintClassHolder >> references [

	^ references
]

{ #category : #accessing }
PackageBlueprintClassHolder >> references: anObject [

	references := anObject
]
