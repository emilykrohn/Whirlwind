extends CharacterBody2D

class_name Entity

@export var entity_resource: EntityResource

func damage(target: Entity, amount):
	target.entity_resource.health -= amount

func die():
	if entity_resource.health <= 0:
		print("died")
		queue_free()
