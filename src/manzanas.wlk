import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
		// reeemplazarlo por los distintos colores de acuerdo a la cantidad de infectados
		// también vale reemplazar estos dibujos horribles por otros más lindos
		if (self.cantidadContagiadores() ==  0) {return "blanco.png"}
		if (self.cantidadContagiadores().between(1,3)) {return "amarillo.png"}	
		if (self.cantidadContagiadores().between(4,7)) {return "naranja.png"}	
		if (self.cantidadContagiadores() > 7  and self.cantidadContagiadores() < self.cuantaGenteVive()) {return "naranjaOscuro.png"}
		else { return "rojo.png"}
		}	
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}
	

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		// despues agregar la curacion 
		self.curacion()
	}
	
	method personaSeMudaA(persona, manzanaDestino) {
		self.personas().remove(persona)
		manzanaDestino.personas().add(persona)
	}
	
	method cantidadContagiadores() {
		return personas.count({ persona => persona.estaInfectada()})
	}
	
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() })
	} 	
	
	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
				}
			})
		}
	}
	
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	
	method cuantaGenteVive(){
		return personas.size()
	}
	
	method personasInfectadasYNoAisladas(){
		return self.cantidadContagiadores().count({ persona => not persona.estaAislada()})
	}
	
	method personasNoInfectadas(){
		return personas.filter({ persona => not persona.estaInfectada()})
	}
	
	method quienesDebenContagiarse(){
		return self.personasNoInfectadas().filter({ persona => simulacion.debeInfectarsePersona(persona, self.cantidadContagiadores())})
	}
	
	method contagiarAQuienesDeben(){
		self.quienesDebenContagiarse().forEach({ persona => persona.infectarse() })
	}

	method personasConSintomas(){
		return personas.count({ persona => persona.tieneSintomas()})
		}
		
	// ejecucion 2 del del agente
	method queTodosRespetenLaCuarentena(){
		personas.forEach({p => p.respetarCuarentena()}) 
	}
	
	// ejecucion 1 del del agente
	method aislarATodosLosInfectadosConSintomas(){
		self.personasInfectadasYNoAisladas().forEach({ per => per.estaAislada(true)})
	}
	
	method crearUnaPersona(){
		const nuevaPersona = new Persona()
		return nuevaPersona
	}
	
	method crearPersonasEnEstaManzana(){
		(0..simulacion.personasPorManzana() - 1).forEach({ i =>
			personas.add(self.crearUnaPersona())})
	}
	
	method curacion(){
		personas.forEach({ persona => persona.sumarUnDiaRespetado()})
		personas.filter({ persona => persona.diasRespetados() == 20}).
			forEach({ persona => persona.estaInfectada(false)})
	}
}
