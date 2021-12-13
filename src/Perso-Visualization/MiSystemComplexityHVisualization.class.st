Class {
	#name : #MiSystemComplexityHVisualization,
	#superclass : #MiAbstractVisualization,
	#instVars : [
		'rootNode',
		'builder',
		'entities',
		'metric',
		'runned'
	],
	#category : #'Perso-Visualization-Visualization'
}

{ #category : #running }
MiSystemComplexityHVisualization >> dropList [

	^ (SpDropListPresenter new
		   help: 'Select the presenter.';
		   items:
			   (((entities anyOne allToScope: FamixStClass) anyOne class 
				     famePropertiesOfType: FM3Number) collect: [ :property | 
					    property implementingSelector ]);
		   display: [ :aSymbol | aSymbol asString ];
		   whenSelectedItemChangedDo: [ :aSymbol | aSymbol crTrace ];
		   openWithSpec)
		  extent: 400 @ 295;
		  yourself
]

{ #category : #accessing }
MiSystemComplexityHVisualization >> entities [

	^entities
]

{ #category : #accessing }
MiSystemComplexityHVisualization >> entities: anEntity [

	entities := anEntity
]

{ #category : #highlighting }
MiSystemComplexityHVisualization >> highlightShapes [

]

{ #category : #accessing }
MiSystemComplexityHVisualization >> initialize [

	super initialize.
	runned := false
]

{ #category : #accessing }
MiSystemComplexityHVisualization >> metric [
	^metric
]

{ #category : #accessing }
MiSystemComplexityHVisualization >> metric: aSymbol [

	metric := aSymbol
]

{ #category : #running }
MiSystemComplexityHVisualization >> run [

	"
The builder is going to create the nodes for the entities (the package)
We then send the message openInCanvas: to the rootNode so that we can show what we built in our canvas
"

	super run.
	self runned: true.
	builder := HSystemComplexityBuilder new
		           entities: entities;
		           metric: self metric.
	builder build.

	builder rootNode openInCanvas: self canvas.
	self canvas zoomToFit
]

{ #category : #accessing }
MiSystemComplexityHVisualization >> runned [ 
^runned
]

{ #category : #accessing }
MiSystemComplexityHVisualization >> runned: aBool [
runned := aBool
]
