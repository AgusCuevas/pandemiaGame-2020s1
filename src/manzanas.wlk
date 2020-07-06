import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
		// reeemplazarlo por los distintos colores de acuerdo a la cantidad de infectados
		// también vale reemplazar estos dibujos horribles por otros más lindos
		return "blanco.png"
	}
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		// despues agregar la curacion
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
	
	// aisla a todos en esta manzana 
	method queTodosRespetenLaCuarentena(){
		personas.forEach({p => p.respetarCuarentena()}) // adaotar el codigo segun nico R
	}
}
