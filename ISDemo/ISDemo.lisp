(ISDemo
	(navigator "UINavigationController")
	(scene "type-list" title: "Entities"
		controller: ((ListController) representedObject: (app fetch:"Entities")))
		cell: (cell title: representedObject.name navigate: 'hierarchy)
	)
	(scene "entity-list" title: (representedObject.name pluralize)
		controller: ((ListController) editable: YES representedObject:(app fetch:representedObject)))
		cell: (cell title: (template 'summary representedObject navigate: 'detail)
	)
	(scene "entity-detail" title: representedObject.name
		controller: ((FormController) editable: YES representedObject:(app fetch:representedObject)))
		cell: (cell title: representedObject.type.name value: representedObject)
)