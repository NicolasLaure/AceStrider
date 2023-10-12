extends CharacterBody2D

@export var speed: float;
@export var friction: float;
@export var maxSpeed: float;
@export var gravity: float;
@export var rotation_speed: float;
var dir:Vector2;

const bulletPath = preload("res://Scripts/Bullet.tscn");

func _process(delta):
	
	dir = Vector2.from_angle(rotation - deg_to_rad(90));
	
	velocity.y += gravity * delta;
	
	if(Input.is_action_pressed("Thrust")):
		velocity.y += dir.y * speed * delta;
		velocity.x += dir.x * speed * delta;
	else:
		if(velocity.x < 0):
			velocity.x += friction * delta;
		elif(velocity.x > 0):
			velocity.x -= friction * delta;
	
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
	bullet.dir = dir;
pass
