extends Entity

const JUMP_VELOCITY = -400.0
var is_jumping = false
var previous_tile
var collider_radius
var is_on_floor = true

@onready var tilemap = get_node("../TileMap")

func _ready():
	previous_tile = tilemap.global_position
	collider_radius = $CollisionShape2D.get_shape().get_size().y

func _physics_process(delta):
	#print("first: " + str(previous_tile.y))
	#print("second: " + str(floor(tilemap.global_position.y)))
	print("player: " + str(global_position))

	if Input.is_action_just_pressed("ui_accept") and is_on_floor:
		is_jumping = true
		$Jump.start()
	
	if is_jumping:
		var tilemap_movement = (tilemap.global_position.y - previous_tile.y) - 50
		tilemap.global_position.y -= tilemap_movement
		#tilemap.global_position.y -= 50 * delta

	if not is_on_floor:
		tilemap.global_position.y -= 150 * delta

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * entity_resource.speed
	else:
		velocity.x = move_toward(velocity.x, 0, entity_resource.speed)

	move_and_slide()

func _on_jump_timeout():
	is_jumping = false

func _on_area_2d_body_entered(body):
	if body is TileMap:
		previous_tile = tilemap.local_to_map(global_position + Vector2(0, collider_radius))
		is_on_floor = true

func _on_area_2d_body_exited(body):
	if body is TileMap:
		is_on_floor = false
