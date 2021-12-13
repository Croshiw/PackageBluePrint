Class {
	#name : #MiSystemComplexityHBrowserTest,
	#superclass : #MiAbstractBrowserTest,
	#category : #'Perso-Visualization-Tests'
}

{ #category : #running }
MiSystemComplexityHBrowserTest >> browserClass [

	^ MiSystemComplexityHBrowser
]

{ #category : #running }
MiSystemComplexityHBrowserTest >> testBuildPackageContainingEmptyClass [

	| package class1 class2 inheritance |
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
	^package
]

{ #category : #running }
MiSystemComplexityHBrowserTest >> testDropListNotEmptyForPackageWithClass [

	| newBrowser |
	self bus globallySelect: self testBuildPackageContainingEmptyClass.
	self
		shouldnt: [ 
			newBrowser := self browserClass openForTests.
			self assert: newBrowser dropList items isNotEmpty equals: true.
			newBrowser window close ]
		raise: Error
]
