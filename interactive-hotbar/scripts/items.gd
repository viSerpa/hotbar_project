extends Control
class_name Items

signal sword_selected
signal bow_selected
signal shield_selected

@export var sword_button: Button
@export var bow_button: Button
@export var shield_button: Button

var active_items := []

func _on_sword_button_pressed() -> void:
	for i in active_items:
		if active_items.has(sword_button):
			sword_selected.emit()
			return
	sword_selected.emit()
	active_items.append(sword_button)

func _on_bow_button_pressed() -> void:
	for i in active_items:
		if active_items.has(bow_button):
			bow_selected.emit()
			return
	bow_selected.emit()
	active_items.append(bow_button)


func _on_shield_button_pressed() -> void:
	for i in active_items:
		if active_items.has(shield_button):
			shield_selected.emit()
			return
	shield_selected.emit()
	active_items.append(shield_button)
