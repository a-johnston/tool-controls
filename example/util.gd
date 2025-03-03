@tool
class_name Controls

# Handful of helpers for building/composing control nodes in code

static func fill(control: Control) -> Control:
	control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	return control

static func vbox(children: Array[Node] = []) -> VBoxContainer:
	var container := VBoxContainer.new()
	container.add_theme_constant_override("separation", 10 * DisplayServer.screen_get_scale())
	for child in children:
		container.add_child(child)
	return container

static func hbox(children: Array[Node] = []) -> HBoxContainer:
	var container := HBoxContainer.new()
	container.add_theme_constant_override("separation", 10 * DisplayServer.screen_get_scale())
	for child in children:
		container.add_child(child)
	return container

static func button(text: String, callback: Callable) -> Button:
	var button := Button.new()
	button.text = text
	button.pressed.connect(callback)
	return button

static func label(text: String) -> Label:
	var label := Label.new()
	label.text = text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	return label
