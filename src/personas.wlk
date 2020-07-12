import simulacion.*
import manzanas.*

class Persona {
	var property estaAislada = false
	var property respetaCuarentena = false
	var diaDeContagio = null
	var property estaInfectada = false
	var property diasRespetados = 0
	
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
	
	method sumarUnDiaRespetado(){
		if (self.respetaCuarentena() and self.estaInfectada()){
				diasRespetados += 1
			}
	}
	
	method aislar(){
		self.estaAislada(true)
	}
}

class PersonaDelExterior inherits Persona{
	
	override method estaInfectada(){ return true}
	
	override method tieneSintomas() { return false}
}

