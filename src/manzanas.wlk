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
	
	method quinesEstanContagiados(){
		return personas.filter({ persona => persona.estaInfectada()})
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
		return self.quinesEstanContagiados().filter({ persona => not persona.estaAislada()})
	}
	
	method listaDePersonasInfectadasYNoAisladas_conSintomas(){
		return self.personasInfectadasYNoAisladas().filter({ persona => persona.tieneSintomas()})
	}
	
	// ejecucion 1 del del agente
	method aislarATodosLosInfectadosConSintomas(){
		self.listaDePersonasInfectadasYNoAisladas_conSintomas().forEach({ per => per.aislar()})
	}
	
		
	method quienesDebenContagiarse(){
		return self.noInfectades().filter({ persona => simulacion.debeInfectarsePersona(persona, self.cantidadContagiadores())})
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
		self.personasQueRespetaron20().forEach({ persona => persona.estaInfectada(false)})
		self.personasQueRespetaron20().forEach({ persona => persona.diasRespetados(0)})
		self.personasQueRespetaron20().forEach({ persona => persona.estaAislada(false)})
	}

	 method personasQueRespetaron20(){
	 	return personas.filter({ persona => persona.diasRespetados() == 20})
	 }
	 
	 method respetanCuarentena(){
	 	return personas.count({persona => persona.respetaCuarentena()})
	 }
	 method estanAislados(){
	 	return personas.count({persona => persona.estaAislada()})
	 }
}