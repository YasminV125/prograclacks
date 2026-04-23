extends Ball
 
# Esta es la bola que se teletransporta sola cada ciertos segundos
 
var vida = 5  # Cuántos golpes aguanta antes de morir
var tiempo_para_saltar = 10.0  # Cada cuántos segundos se teletransporta
var nueva_posicion = null


func teletransportar():
	# Elige una posición al azar dentro de la pantalla
	nueva_posicion = Vector2(0,0)
	nueva_posicion.x = randf_range(-260,260)
	nueva_posicion.y = randf_range(-260,260)
 
func _integrate_forces(_state):
	if nueva_posicion:
		position = nueva_posicion
		nueva_posicion = null

func recibir_golpe():
	vida = vida - 1
	if vida <= 0:
		queue_free()  # Borra la bola de la escena
