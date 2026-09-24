extends Control
class_name Hotbar

@export var hotbar_box_scene: PackedScene
@export var box_amount: int
#box size 64x64
var box_length := 64

var x_middle := 576
var y_middle := 324

var hotbar_arr := []

func _ready() -> void:
	create_hotbar()
	
func create_hotbar() -> void:
	for i in range(box_amount):
		var box = hotbar_box_scene.instantiate()
		@warning_ignore("integer_division")
		box.position = Vector2((x_middle - (box_length * box_amount)/2) + box_length * i, y_middle)
		add_child(box)
		hotbar_arr.append(box)
