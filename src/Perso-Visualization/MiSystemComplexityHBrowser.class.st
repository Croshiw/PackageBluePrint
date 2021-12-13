"
Shows the SystemComplexity for a group of packages using the HierarchicalVisualization Framework.
It can also let you normalise the color of nodes with the metric of your choice

- Follow: Receives StPackages or JavaPackages.
- Highlight: <TODO>.
- Propagate: <TODO>.
"
Class {
	#name : #MiSystemComplexityHBrowser,
	#superclass : #MiAbstractBrowser,
	#instVars : [
		'visualization',
		'dropList'
	],
	#category : #'Perso-Visualization-Browser'
}

{ #category : #'instance creation' }
MiSystemComplexityHBrowser class >> defaultSpec [

	^ super defaultSpec
		  add: #visualization;
		  add: (SpGridLayout new
				   add: 'Select metric for color:' at: 1 @ 1;
				   add: #dropList at: 2 @ 1;
				   yourself)
		  height: 60;
		  yourself
]

{ #category : #'world menu' }
MiSystemComplexityHBrowser class >> menuCommandOn: aBuilder [

	<worldMenu>
	<miBrowsers>
	(aBuilder item: #SystemComplexityHierarchical)
		parent: #Moose;
		label: self title;
		icon: (self iconNamed: #smallExport);
		order: 6;
		help: self helpMessage;
		action: [ self open ]
]

{ #category : #'instance creation' }
MiSystemComplexityHBrowser class >> open [

	<script>
	super open
]

{ #category : #'instance creation' }
MiSystemComplexityHBrowser class >> title [

	^ 'System Complexity Hierarchical Visualization'
]

{ #category : #testing }
MiSystemComplexityHBrowser >> canFollowEntity: anObject [

	"The entity should be a package that is not stub so we can access its source code"

	^ anObject isMooseObject and: [ 
		  anObject asMooseSpecializedGroup allSatisfy: [ :entity | 
			  (entity isOfType: FamixTPackage) and: [ entity isStub not ] ] ]
]

{ #category : #accessing }
MiSystemComplexityHBrowser >> dropList [

	^ dropList
]

{ #category : #actions }
MiSystemComplexityHBrowser >> followEntity: anEntity [

	visualization entities: anEntity.
	
	visualization runned
		ifFalse: [ dropList items: self retrieveMetrics ]
		ifTrue: [ dropList selectIndex: dropList selectedIndex ]
]

{ #category : #initialization }
MiSystemComplexityHBrowser >> initializePresenters [

	super initializePresenters.

	visualization := self instantiate: MiSystemComplexityHVisualization.
	dropList := self instantiate: SpDropListPresenter.
	dropList
		help: 'Select the metric';
		display: [ :aSymbol | aSymbol asString ];
		whenSelectedItemChangedDo: [ :aSymbol | 
			
			visualization metric: aSymbol.
			visualization run ]
]

{ #category : #actions }
MiSystemComplexityHBrowser >> retrieveMetrics [

	^ visualization entities asMooseGroup
		  ifEmpty: [ #(  ) ]
		  ifNotEmpty: [ :ent | 
			  (((ent anyOne allToScope: FamixTClass) anyOne class 
				   famePropertiesOfType: FM3Number) collect: [ :property | 
				  property implementingSelector ]) sorted: #yourself ascending  ]
]
