extends Node

@export var hotbar: Hotbar
@export var arrow: Sprite2D
@export var items: Items

#item images
@export var sword_img: PackedScene
@export var bow_img: PackedScene
@export var shield_img: PackedScene

var offset := Vector2(32, -32)
var current_index: int

var active_sword_img: Node
var active_bow_img: Node
var active_shield_img: Node

var item_positions := []

var item_dict = {
	"sword": -1,
	"bow": -1,
	"shield": -1
}

func _ready() -> void:
	arrow.visible = true
	var start = hotbar.hotbar_arr[0]
	arrow.position = start.position + offset

func _process(_delta: float) -> void:
	for i in range(hotbar.box_amount):
		if Input.is_action_just_pressed("hotbar_" + str(i + 1)):
			var current_box = hotbar.hotbar_arr[i]
			current_index = i
			arrow.position = current_box.position + offset
			
	if Input.is_action_just_pressed("use_item"):
		if current_index == item_dict["sword"]:
			print("sword used")
		elif current_index == item_dict["bow"]:
			print("bow used")
		elif current_index == item_dict["shield"]:
			print("shield used")
			
	if Input.is_action_just_pressed("scroll_up"):
		var max_index = hotbar.box_amount - 1
		if current_index == max_index:
			current_index = -1
		current_index += 1
		var current_box = hotbar.hotbar_arr[current_index]
		arrow.position = current_box.position + offset
	elif Input.is_action_just_pressed("scroll_down"):
		var max_index = hotbar.box_amount - 1
		if current_index <= 0:
			current_index = max_index + 1
		current_index -= 1
		var current_box = hotbar.hotbar_arr[current_index]
		arrow.position = current_box.position + offset

func _on_items_bow_selected() -> void:
	var bow_pos = hotbar.hotbar_arr[current_index]
	
	if check_if_box_occupied(current_index):
		print("box occupied")
		return
		
	if is_instance_valid(active_bow_img) and is_inside_tree():
		check_if_item_in_same_pos("bow", active_bow_img, bow_pos)
		return
		
	active_bow_img = bow_img.instantiate()
	item_dict["bow"] = current_index
	
	active_bow_img.position = bow_pos.position
	add_child(active_bow_img)

func _on_items_shield_selected() -> void:
	var shield_pos = hotbar.hotbar_arr[current_index]
	
	if check_if_box_occupied(current_index):
		print("box occupied")
		return
	
	if is_instance_valid(active_shield_img) and is_inside_tree():
		check_if_item_in_same_pos("shield", active_shield_img, shield_pos)
		return
		
	active_shield_img = shield_img.instantiate()
	item_dict["shield"] = current_index
	
	active_shield_img.position = shield_pos.position
	add_child(active_shield_img)

func _on_items_sword_selected() -> void:
	var sword_pos = hotbar.hotbar_arr[current_index]
	
	if check_if_box_occupied(current_index):
		print("box occupied")
		return
	
	if is_instance_valid(active_sword_img) and is_inside_tree():
		check_if_item_in_same_pos("sword", active_sword_img, sword_pos)
		return
		
	active_sword_img = sword_img.instantiate()
	item_dict["sword"] = current_index
	
	active_sword_img.position = sword_pos.position
	add_child(active_sword_img)

func check_if_item_in_same_pos(item_type, img, item_pos) -> void:
	if item_dict[str(item_type)] == current_index:
		print("box occupied")
		return
	else:
		img.position = item_pos.position
		item_dict[str(item_type)] = current_index
		return

func check_if_box_occupied(target_slot: int) -> bool:
	for item_names in item_dict:
		var slot = item_dict[item_names]
		#check if each item == current_index
		if slot == target_slot:
			return true
	return false
