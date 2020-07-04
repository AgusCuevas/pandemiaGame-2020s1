import simulacion.*
import manzanas.*

class Persona {
	var property estaAislada = false
	var property respetaLaCuarentena = false
	
	method estaInfectada() {
		return self.infectarse()
	}
	
	method infectarse() {
		//const diaDeContagio = simulacion.diaActual()
		return simulacion.debeInfectarsePersona(self, manzana.cantidadContagiadores())
	}

	method posibilidadDeContagio(){
		if (not self.respetaLaCuarentena()){
		return simulacion.tomarChance(2)
		}
		else { return simulacion.tomarChance(25)}
	}
	
	method tieneSintomas(){
		return if (self.estaInfectada()){
			simulacion.tomarChance(30) 
		}
		else {}
	}
}

