extends CharacterBody2D

@export var speed: float;
@export var friction: float;
@export var recoil: float;
@export var maxSpeed: float;
@export var gravity: float;
@export var rotation_speed: float;
@export var limitBounce: float;

var isOffLowerLimit: bool;
var isOffUpperLimit: bool;
var dir:Vector2;

const bulletPath = preload("res://Scripts/Bullet.tscn");

func _process(delta):
	
	dir = Vector2.from_angle(rotation - deg_to_rad(90));
	
	isOffLowerLimit = position.y > 760;
	isOffUpperLimit = position.y < -180;
	
	if(isOffLowerLimit):
		velocity.y -= limitBounce * delta;
	elif(isOffUpperLimit):
		velocity.y += limitBounce * delta;
	
	if(!isOffLowerLimit && !isOffUpperLimit):
		if(Input.is_action_pressed("Thrust")):
			velocity.y += dir.y * speed * delta;
			velocity.x += dir.x * speed * delta;
			
		if(abs(dir.y) < 0.1 && velocity.y > 0):
			velocity.y += gravity * delta * delta;
		else:
			velocity.y += gravity * delta;
			
	else:
		if(velocity.x < 0):
			velocity.x += friction * delta;
		elif(velocity.x > 0):
			velocity.x -= friction * delta;
			
		velocity.y += gravity * delta;

	velocity.x = clampf(velocity.x, maxSpeed * -1, maxSpeed);
	velocity.y = clampf(velocity.y, maxSpeed * -1, maxSpeed);
	translate(velocity * delta);
	
	if(Input.is_key_pressed(KEY_A)):
		rotate(deg_to_rad(rotation_speed * -1 * delta));
	if(Input.is_key_pressed(KEY_D)):
		rotate(deg_to_rad(rotation_speed * delta));
		
	if(Input.is_action_just_pressed("Shoot")):
		Shoot();
pass


func Shoot():
	var bullet = bulletPath.instantiate();
	
	get_parent().add_child(bullet);
	bullet.position = $Marker2D.global_position;
	
	velocity.y -= dir.y * recoil;
	velocity.x -= dir.x * recoil;

	bullet.rotation = deg_to_rad(randf_range(rad_to_deg(rotation) - 15, rad_to_deg(rotation) + 15));
pass
