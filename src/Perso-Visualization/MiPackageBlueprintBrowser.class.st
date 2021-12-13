Class {
	#name : #MiPackageBlueprintBrowser,
	#superclass : #MiAbstractBrowser,
	#instVars : [
		'visualization'
	],
	#category : #'Perso-Visualization-Browser'
}

{ #category : #'instance creation' }
MiPackageBlueprintBrowser class >> defaultSpec [

	^ super defaultSpec
		  add: #visualization;
	
		  yourself
]

{ #category : #'instance creation' }
MiPackageBlueprintBrowser class >> open [

	<script>
	super open
]

{ #category : #'instance creation' }
MiPackageBlueprintBrowser class >> title [

	^ 'Package Blueprint Visualization'
]

{ #category : #testing }
MiPackageBlueprintBrowser >> canReceiveEntity: anObject [

	"The entity should be a package that is not stub so we can access its source code"

	^ anObject isMooseObject and: [ 
		  anObject asMooseSpecializedGroup allSatisfy: [ :entity | 
			  (entity isOfType: FamixTPackage) and: [ entity isStub not ] ] ]
]

{ #category : #actions }
MiPackageBlueprintBrowser >> followEntity: aPackage [

	visualization classes: (aPackage allToScope: FamixTClass).
	visualization run
]

{ #category : #actions }
MiPackageBlueprintBrowser >> initializePresenters [

	super initializePresenters.

	visualization := self instantiate: MiPackageBlueprintVisualization 
]
