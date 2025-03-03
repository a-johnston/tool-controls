@tool
extends Node

@export var data: Dictionary[String, Color]

func get_control() -> Control:
	var color := ColorPickerButton.new()
	var edit := LineEdit.new()
	return Controls.vbox([
		Controls.hbox([Controls.label("Color"), Controls.fill(color)]),
		Controls.hbox([Controls.label("Name"), Controls.fill(edit)]),
		Controls.hbox([
			Controls.fill(Controls.button("Add Entry", on_submit.bind(edit, color))),
			Controls.fill(Controls.button("Clear", on_clear))
		]),
	])

func on_submit(edit: LineEdit, color: ColorPickerButton) -> void:
	if edit.text:
		var new_data = data.merged({edit.text: color.color})
		_set_data("Add '%s' to data" % edit.text, new_data)
		edit.clear()

func on_clear() -> void:
	_set_data("Cleared data", {})

func _set_data(message: String, new_data: Dictionary[String, Color]) -> void:
	var undo_redo := EditorInterface.get_editor_undo_redo()
	undo_redo.create_action(message)
	undo_redo.add_do_property(self, &"data", new_data)
	undo_redo.add_undo_property(self, &"data", data)
	undo_redo.commit_action()
