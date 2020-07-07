import personas.*
import manzanas.*
import wollok.game.*



object simulacion {
	var property diaActual = 0
	const property manzanas = []
	
	// parametros del juego
	const property chanceDePresentarSintomas = 30
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	const property personasPorManzana = 10
	const property duracionInfeccion = 20

	/*
	 * este sirve para generar un azar
	 * p.ej. si quiero que algo pase con 30% de probabilidad pongo
	 * if (simulacion.tomarChance(30)) { ... } 
	 */ 	
	 
	method tomarChance(porcentaje) = 0.randomUpTo(100) < porcentaje

	method agregarManzana(manzana) { manzanas.add(manzana) }
	
	method debeInfectarsePersona(persona, cantidadContagiadores) {
		const chanceDeContagio = if (persona.respetaCuarentena()) 
			self.chanceDeContagioConCuarentena() 
			else 
			self.chanceDeContagioSinCuarentena()
		return (1..cantidadContagiadores).any({n => self.tomarChance(chanceDeContagio) })	
	}

	method crearManzana() {
		const nuevaManzana = new Manzana(personas = [], position = game.at(0,0))
		return nuevaManzana
	}
	
	method totalDePersonas(){
		return manzanas.sum({ manzana => manzana.cuantaGenteVive()})
	}
	
	method totalDeInfectados(){
		return manzanas.sum({ manzana => manzana.cantidadContagiadores()})
	}
	
	method totalDePersonasConSintomas(){
		return manzanas.sum({ manzana => manzana.personasConSintomas()})
	}
	
	method agregarPersonaAUnaManzanaAlAzar(persona){
		if (manzanas.isEmpty()) { self.error("No hay manzanas")}
		else{
			self.unaManzanaAlAzar().add(persona)
		}
	}
		
	method unaManzanaAlAzar(){
		return manzanas.get(0.randomUpTo(manzanas.size()))
	}
	
	method llenarTodasLasManzanas(){
		manzanas.forEach({ manza =>	manza.crearPersonasEnEstaManzana()})
	}
	
	method sumarUnDia(){
		diaActual += 1
	}
	
	
}
