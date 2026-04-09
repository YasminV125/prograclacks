extends CharacterBody2D

# Esta es la bola que persigue a la presa y le hace daño al tocarla

var velocidad = 150          # Qué tan rápido se mueve
var vida = 3                 # Cuántos golpes aguanta antes de morir
var puede_golpear = true     # Evita que haga daño múltiples veces seguidas
 
var presa  # guardar la referencia a la bola presa
 
func _ready():
	# Busca la bola presa en la escena (debe estar en el grupo "presa")
	presa = get_tree().get_first_node_in_group("presa")
 
func _process(delta):
	# Si la presa no existe, no hace nada
	if presa == null:
		return
 
	# MOVIMIENTO: se mueve hacia donde está la presa 
	var direccion = (presa.position - position).normalized()
	position += direccion * velocidad * delta
 
	# COLISIÓN: si está muy cerca de la presa, le hace daño 
	var distancia = position.distance_to(presa.position)
	if distancia < 50 and puede_golpear:
		golpear()
 
func golpear():
	puede_golpear = false  # Desactiva el golpe para no repetirlo
 
	# Le hace daño a la presa
	presa.recibir_golpe()
 
	# La cazadora también recibe daño
	vida = vida - 1
	if vida <= 0:
		queue_free()
 
	# Espera 1 segundo antes de poder golpear de nuevo
	await get_tree().create_timer(1.0).timeout
	puede_golpear = true
