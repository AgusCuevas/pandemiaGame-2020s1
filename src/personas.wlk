import simulacion.*
import manzanas.*

class Persona {
	var property estaAislada = false
	var property respetaCuarentena = false
	var diaDeContagio = null
	var property estaInfectada
	
	method estaInfectada() {
		return estaInfectada
	}
	
	method infectarse() {
		diaDeContagio = simulacion.diaActual()
		estaInfectada = true
	}
	
	method tieneSintomas(){
		return if (self.estaInfectada()){
			simulacion.tomarChance(30) 
		}
		else {}
	}
}


