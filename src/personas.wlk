import simulacion.*
import manzanas.*

class Persona {
	var property estaAislada = false
	var property respetaLaCuarentena = false
	
	method estaInfectada() {
		return self.infectarse()
	}
	
	method infectarse() {
		return  
	}
	
	method tieneSintomas(){
		return if (self.estaInfectada()){
			simulacion.tomarChance(30) 
		}
		else {}
	}
}

