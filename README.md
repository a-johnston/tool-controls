# Godot 4.x Tool Controls

This is a simple editor plugin which allows tool scripts to provide arbitrary control nodes when
selected in the inspector. Compared to other plugins or the recently added `export_tool_button`,
this offers more flexibility but is more verbose, especially compared to the built-in annotation
available in 4.4.

Please leave an issue if you have problems or suggestions.

## Installation

This is not yet available on the asset store. Clone or download this repo and copy the `addons`
folder to your own project's `addons`, and then enable the plugin within project settings.

## Usage

For any tool script, implement `get_control() -> Control` (or `Control GetControl()` for a c# script).
Using the example tool script, and the included small utility class:
```gdscript
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
```
the following is added to the inspector when the tool is selected:

<img width="284" alt="Screenshot 2025-03-03 at 7 18 13 PM" src="https://github.com/user-attachments/assets/cdf46f62-b46b-49cb-a1e9-01ab89953167" />

## Todo

- Pinnable controls active for all nodes within the tool's edited scene
- If compatible with the above, use an inspector plugin in favor of the current injected container
- Break out the example's utility class into its own addon for easier programmatic node creation and composition
