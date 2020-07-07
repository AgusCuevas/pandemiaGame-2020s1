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
	
	method haceCuantoEstaInfectado(){
		return simulacion.diaActual() - diaDeContagio
	}
	
	method tieneSintomas(){
		if (self.estaInfectada()){
			return simulacion.tomarChance(30) 
		}
		else {
			return false
		}
	}
	
	method respetarCuarentena(){
		self.respetaCuarentena(true)
	}
}

class PersonaDelExterior inherits Persona{
	
    override method estaInfectada() { return true }
	
	override method tieneSintomas() { return false}
	}

