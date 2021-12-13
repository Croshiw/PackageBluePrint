Class {
	#name : #BaselineOfPersoVisualization,
	#superclass : #BaselineOf,
	#category : #BaselineOfPersoVisualization
}

{ #category : #baselines }
BaselineOfPersoVisualization >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		 spec package: 'Perso-Visualization'].
	spec for: #NeedsMooseIDE do: [ 
		spec
			package: 'Perso-Visualization'
			with: [ spec requires: #( 'MooseIDE' ) ].
		spec baseline: 'MooseIDE' with: [ 
			spec repository:
				'github://moosetechnology/MooseIDE:development/src' ] ]
]

{ #category : #baselines }
BaselineOfPersoVisualization >> customProjectAttributes [

	^ RPackageOrganizer default packages
		  detect: [ :package | package name = 'BaselineOfMooseIDE' ]
		  ifFound: [ #(  ) ]
		  ifNone: [ #( #NeedsMooseIDE ) ]
]
