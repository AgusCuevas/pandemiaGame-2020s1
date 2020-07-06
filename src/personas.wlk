import simulacion.*
import manzanas.*

class Persona {
	var property estaAislada = false
	var property respetaCuarentena = false
	var diaDeContagio = null
	var property estaInfectada = false
	
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
	
	method respetarCuarentena(){
		self.estaAislada(true)
		self.respetaCuarentena(true)
	}
}

class PersonaDelExterior inherits Persona{
	
    override method estaInfectada() { return true }
	
	override method tieneSintomas() { return false}
	}

