Extension { #name : #HNode }

{ #category : #'*Perso-Visualization' }
HNode >> openInCanvas: aCanvas [

	^ HSimpleVisualizationBuilder new
		  rootNode: self;
		  container: aCanvas;
		  build
]
