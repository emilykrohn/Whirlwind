extends Entity

const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var tilemap = get_node("../TileMap")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		tilemap.position.y += 10

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * entity_resource.speed
	else:
		velocity.x = move_toward(velocity.x, 0, entity_resource.speed)

	move_and_slide()
