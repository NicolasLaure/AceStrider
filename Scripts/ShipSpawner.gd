extends Marker2D

var playerPosition:Vector2;

@export var bigShipRespawnCoolDown:float
@export var smallShipRespawnCoolDown:float

const smallShipPath = preload("res://Scripts/small_ship.tscn");
const bigShipPath = preload("res://Scripts/big_ship.tscn");

var smallShipTimer:float = 0;
var bigShipTimer:float = 0;

func _ready():
	playerPosition = get_tree().root.get_node("LevelScene/Player").position;
	pass # Replace with function body.

func _process(delta):
	position.x = playerPosition.x;
	
	if(smallShipTimer >= smallShipRespawnCoolDown):
		var smallShip = smallShipPath.instantiate();
		get_parent().add_child(smallShip);
		smallShipTimer = 0;
	else:
		smallShipTimer+= delta;
		
	if(bigShipTimer >= bigShipRespawnCoolDown):
		var bigShip = bigShipPath.instantiate();
		get_parent().add_child(bigShip);
		bigShipTimer = 0;
	else:
		bigShipTimer+= delta;
	pass
	

