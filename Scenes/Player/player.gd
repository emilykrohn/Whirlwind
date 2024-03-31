extends Entity

const JUMP_VELOCITY = -400.0
var is_jumping = false
var screen_center_y = 0

@onready var tilemap = get_node("../TileMap")

func _ready():
	var screen_height = get_viewport_rect().size.y
	screen_center_y = screen_height / 2

func _physics_process(delta):
	global_position.y = screen_center_y
	if not is_on_floor():
		tilemap.position.y -= 150 * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		is_jumping = true
		$Jump.start()
	
	if is_jumping:
		tilemap.position.y += 8

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * entity_resource.speed
	else:
		velocity.x = move_toward(velocity.x, 0, entity_resource.speed)

	move_and_slide()

func _on_jump_timeout():
	is_jumping = false
