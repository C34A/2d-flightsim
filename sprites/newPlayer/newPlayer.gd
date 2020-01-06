extends Node2D

const TURN_TORQUE: float = 15000.0
const ELEVATOR_POS: Vector2 = Vector2(50, 6)
const THRUST: float = 1000.0
#const BRAKE_FRIC: float = 
#const NONBRAKE_FRIC

var engine_force: Vector2
var drag_force: Vector2
var lift_force: Vector2
var controls_torque: float
var stability_torque: float

#var rigidBody

# Called when the node enters the scene tree for the first time.
func _ready():
	engine_force = Vector2.ZERO
	drag_force = Vector2.ZERO
	lift_force = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("pitch_clockwise") and not Input.is_action_pressed("pitch_down"):
		controls_torque = -TURN_TORQUE
#		$RigidBody2D.
	elif Input.is_action_pressed("pitch_cClockwise") and not Input.is_action_pressed("pitch_up"):
		controls_torque = TURN_TORQUE
	else:
		controls_torque = 0
	if Input.is_action_just_pressed("boost"):
		$RigidBody2D.apply_impulse(Vector2.ZERO, Vector2(0, -999))
#		print("pow!")
	if Input.is_action_pressed("go"):
		engine_force = (Vector2(-1, 0) * THRUST).rotated($RigidBody2D.rotation)
	else:
		engine_force = Vector2.ZERO
	
	if Input.is_action_pressed("brake"):
		$RigidBody2D.material = 
	$RigidBody2D.applied_force = engine_force + drag_force + lift_force
	$RigidBody2D.applied_torque = stability_torque + controls_torque
	
	
	
	
