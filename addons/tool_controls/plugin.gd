@tool
extends EditorPlugin

var dock: Node
var inspector: EditorInspector
var container: VBoxContainer

var check_names := [&"get_control", &"GetControl"]

func _enter_tree() -> void:
	inspector = get_editor_interface().get_inspector()
	dock = inspector.get_parent()
	container = VBoxContainer.new()
	container.add_theme_constant_override("separation", 10 * DisplayServer.screen_get_scale())
	container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	dock.add_child(container)
	inspector.reparent(container)
	inspector.edited_object_changed.connect(refresh_control)
	refresh_control()

func _exit_tree() -> void:
	if not inspector:
		return
	if inspector.edited_object_changed.is_connected(refresh_control):
		inspector.edited_object_changed.disconnect(refresh_control)
	inspector.reparent(dock)
	dock.remove_child(container)
	container.queue_free()
	container = null
	inspector = null
	dock = null

func refresh_control():
	if not inspector:
		return
	var children := container.get_children()
	for i in len(children) - 1:
		children[i].queue_free()
	var selected := inspector.get_edited_object()
	if selected and selected.get_script() and selected.get_script().is_tool():
		for name in check_names:
			if selected.has_method(name):
				var control = selected.call(name) as Control
				if control:
					container.add_child(Container.new())
					container.add_child(control)
					inspector.move_to_front()
				else:
					var script_name = selected.get_script().get_global_name()
					if script_name:
						script_name = " (%s)" % script_name
					var error_str := "%s%s: Called %s but did not get a Control"
					push_warning(error_str % [selected.name, script_name, name])
				break
