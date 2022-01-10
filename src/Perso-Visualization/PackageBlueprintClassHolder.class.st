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
