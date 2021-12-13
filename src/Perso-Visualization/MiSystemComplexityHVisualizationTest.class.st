Class {
	#name : #MiSystemComplexityHVisualizationTest,
	#superclass : #TestCase,
	#category : #'Perso-Visualization-Tests'
}

{ #category : #tests }
MiSystemComplexityHVisualizationTest >> testInitializationRunnedVisualization [

	| visualization  |
	visualization := MiSystemComplexityHVisualization new.
	self assert: visualization runned equals: false.
	visualization run.
	self assert: visualization runned equals: true
]

{ #category : #tests }
MiSystemComplexityHVisualizationTest >> testRunVisualizationOnEmptyPackage [

	| visualization anEntity |
	anEntity := FamixStPackage new.
	visualization := MiSystemComplexityHVisualization new.
	visualization entities: anEntity asMooseGroup.
	visualization run
]
