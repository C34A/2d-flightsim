extends Node2D

var mass = 1
const THRUST = 1000
const DRAG_COEF = .05
const LIFT_COEF = .01
const TURN_SPEED = 120
const FUEL_BURN = 0.01
const GRAVITY = 500

var velocity: Vector2
var direction: float


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	velocity = drag(velocity, direction, delta)
	apply_force(Vector2(0, -1), GRAVITY, delta)
	if Input.is_action_pressed("go_left") and not Input.is_action_pressed("go_right"):
		apply_force(Vector2(-1, 0), THRUST, delta)
#		velocity.x -= (THRUST * delta) / mass
		mass -= FUEL_BURN * delta
	elif Input.is_action_pressed("go_right") and not Input.is_action_pressed("go_left"):
		apply_force(Vector2(1, 0), THRUST, delta)
#		velocity.x += (THRUST * delta) / mass
		mass -= FUEL_BURN * delta
	if Input.is_action_pressed("pitch_up") and not Input.is_action_pressed("pitch_down"):
		direction += deg2rad(TURN_SPEED) * delta
	elif Input.is_action_pressed("pitch_down") and not Input.is_action_pressed("pitch_up"):
		direction -= deg2rad(TURN_SPEED) * delta

	direction = clamp(direction, PI / -2, PI / 2)
	
	
	apply_force(Vector2(0,1), lift(velocity, direction, delta), delta)
	
#	print("dir ", direction)
	print("vel ", velocity)
#	print("mass ", mass)
	global_translate(Vector2(velocity.x, -velocity.y) * delta)
	if(velocity.x < 0):
		set_global_rotation(direction)
		scale.y = 1
	else:
		set_global_rotation(PI - direction)
		scale.y = -1


func drag(velocity: Vector2, direction: float, delta: float) -> Vector2:
#	return velocity * (DRAG_COEF * 1velocity.length())
	return velocity - velocity * pow(velocity.length() + 1, 1) * delta * DRAG_COEF

func lift(velocity: Vector2, direction: float, delta: float) -> float:
	var AoA: float
	if(velocity.x < 0):
		AoA = direction - atan2(velocity.y, abs(velocity.x))
	else:
		AoA = direction - atan2(velocity.y, abs(velocity.x))
	print("AoA ", AoA)
	var lift: float = LIFT_COEF * velocity.length() * velocity.length() * (AoA - pow(1.1, AoA) + 1)
	print("lift ", lift)
	return lift

func apply_force(direction: Vector2, force: float, delta: float) -> void:
	var acceleration: float = force / mass
	velocity += (direction * acceleration * delta)