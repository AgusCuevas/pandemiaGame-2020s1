import simulacion.*
import manzanas.*

class Persona {
	var property estaAislada = false
	var property respetaLaCuarentena = false
	
	method estaInfectada() {

	}
	
	method infectarse() {
 
	}
	
	method tieneSintomas(){
		return if (self.estaInfectada()){
			simulacion.tomarChance(30) 
		}
		else {}
	}
}

