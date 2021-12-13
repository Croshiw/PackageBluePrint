Class {
	#name : #BaselineOfPersoVisualization,
	#superclass : #BaselineOf,
	#category : #BaselineOfPersoVisualization
}

{ #category : #baselines }
BaselineOfPersoVisualization >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: 'Perso-Visualization'
			with: [ spec requires: #( 'MooseIDE' ) ].
			spec baseline: 'MooseIDE' with: [ 
		spec repository: 'github://moosetechnology/MooseIDE:development/src' ] ]
]
