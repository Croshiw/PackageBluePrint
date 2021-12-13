Class {
	#name : #HSystemComplexityBuilderTest,
	#superclass : #TestCase,
	#category : #'Perso-Visualization-Tests'
}

{ #category : #tests }
HSystemComplexityBuilderTest >> testBuildEmptyPackage [

	| package builder |
	package := FamixStPackage new.
	builder := HSystemComplexityBuilder new entities: package asMooseGroup.
	builder build
]

{ #category : #tests }
HSystemComplexityBuilderTest >> testBuildPackageContainingASubClassAndSuperClass [

	| package class1 class2 class3 inheritance1 inheritance2 builder |
	package := FamixStPackage new name: 'package1'.
	class1 := FamixStClass new name: 'class1'.
	class2 := FamixStClass new name: 'class2'.
	class3 := FamixStClass new name: 'class3'.
	inheritance1 := FamixStInheritance new.
	inheritance1
		superclass: class2;
		subclass: class3.
	inheritance2 := FamixStInheritance new.
	inheritance2
		superclass: class1;
		subclass: class2.
	class1 addSubInheritance: inheritance2.
	class2 addSuperInheritance: inheritance2.
	class2 addSubInheritance: inheritance1.
	class3 addSuperInheritance: inheritance1.
	package addChildEntity: class2.
	package addChildEntity: class3.
	builder := HSystemComplexityBuilder new entities:
		           package asMooseGroup; metric: #numberOfChildren.
	builder build.
	^ builder rootNode
]

{ #category : #tests }
HSystemComplexityBuilderTest >> testBuildPackageContainingEmptyClass [

	| package class1 class2 inheritance builder |
	package := FamixStPackage new.
	class1 := FamixStClass new.
	class2 := FamixStClass new.
	inheritance := FamixStInheritance new.
	inheritance
		superclass: class1;
		subclass: class2.
	class1 addSubInheritance: inheritance.
	class2 addSuperInheritance: inheritance.
	package addChildEntity: class2.
	builder := HSystemComplexityBuilder new entities:
		           package asMooseGroup;
		           metric: #numberOfChildren.
	builder build.
	^ builder rootNode
]

{ #category : #tests }
HSystemComplexityBuilderTest >> testDependenciesOfTwoClassesInPackage [

	| rootNode package superclass dependencies link|
	rootNode := self testBuildPackageContainingASubClassAndSuperClass.
	package := rootNode children first.
	superclass := package children first.
	dependencies := superclass dependencies.
	self assert: dependencies size equals: 1.
	link := dependencies first.
	self assert: link from equals: superclass.
]

{ #category : #tests }
HSystemComplexityBuilderTest >> testExistenceOfTwoClassesInPackage [

	| rootNode package |
	rootNode := self testBuildPackageContainingASubClassAndSuperClass.
	self assert: rootNode children size equals: 1.
	package := rootNode children first.
	self assert: package children size equals: 2
]
