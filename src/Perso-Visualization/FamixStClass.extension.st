Extension { #name : #FamixStClass }

{ #category : #'*Perso-Visualization' }
FamixStClass >> attributeNodes [ 

	^ self attributes collect: [ :att | 
		(HNode new
				 name: att name;
				 rawModel: att;
				 yourself) ]
]

{ #category : #'*Perso-Visualization' }
FamixStClass >> buildNodeIn: aPackageNode [

	| classNode |
	classNode := HNode new
		             name: self name;
		             rawModel: self;
		             collapse;
		             yourself.

	classNode addAll: self methodNodes.
	classNode addAll: self attributeNodes.
	aPackageNode add: classNode.
	^ classNode
]

{ #category : #'*Perso-Visualization' }
FamixStClass >> buildNodeWithSubclassesIn: aPackageNode [

	| classNode subclasses |
	
	classNode := self buildNodeIn: aPackageNode.

	subclasses := self directSubclasses select: [ :cls | 
		              cls parentPackage = self parentPackage ].

	subclasses do: [ :subCls | 
		| subClsNode |
		subClsNode := subCls buildNodeWithSubclassesIn: aPackageNode.
		classNode dependencyTo: subClsNode ].
	^ classNode
]

{ #category : #'*Perso-Visualization' }
FamixStClass >> buildNodesIn: aPackageNode [

	self superclass parentPackage = self parentPackage ifTrue: [ 
		^ self ].

	self buildNodeWithSubclassesIn: aPackageNode
]

{ #category : #'*Perso-Visualization' }
FamixStClass >> methodNodes [

	^self localMethods collect: [ :method | 
		 (HNode new
				 name: method name;
				 rawModel: method;
				 yourself) ]
]
