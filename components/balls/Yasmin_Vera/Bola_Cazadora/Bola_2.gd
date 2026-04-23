extends Ball

# Esta es la bola que persigue a la presa y le hace daño al tocarla
 
var velocidad = 350
var vida = 5
var puede_golpear = true
var presa

func _ready():
	presa = get_tree().get_first_node_in_group("presa")

func _process(delta):
	if not presa or not is_instance_valid(presa):
		presa = get_tree().get_first_node_in_group(presa)
	
	if puede_golpear:
		var direccion = (presa.position - position).normalized()
		position += direccion * velocidad * delta
	
	var distancia = position.distance_to(presa.position)
	if distancia < 30 and puede_golpear:
		golpear()

func golpear():
	puede_golpear = false
	
	presa.recibir_golpe()
	
	vida -= 1
	if vida <= 0:
		queue_free()
		return
	
	await get_tree().create_timer(1.0).timeout
	puede_golpear = true
 
