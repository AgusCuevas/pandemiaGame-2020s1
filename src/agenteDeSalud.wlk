import wollok.game.*
import simulacion.*
import manzanas.*
import personas.*


object agenteSalud {
	var property position = game.at(0,0)
	var property image = "agenteDeSalud.png"
	
	method respetarLaCuarentena(persona){
		persona.respetarCuarentena()
	}
	

	// 1.aislar a todes les infectades con síntomas.
	method aislarATodesDeEstaManzana(){
		var manzanaEnLaQueEstoy = game.colliders(self)
		if (manzanaEnLaQueEstoy.personasInfectadasYNoAisladas()>0){
			manzanaEnLaQueEstoy.aislarATodosLosInfectadosConSintomas()
		}
	}
	// 2.convencer a todes a que respeten la cuarentena.
	method respetarCuarentena(){
		var manzanaEnLaQueEstoy = game.colliders(self)
		manzanaEnLaQueEstoy.queTodosRespetenLaCuarentena() 
	}

	// muevo al agente
	method moverseALaDerecha() {self.position(self.position().right(1))}
	method moverseALaIzq() {self.position(self.position().left(1))}
	method moverseArriba() {self.position(self.position().up(1))}
	method moverseAbajo() {self.position(self.position().down(1))}
	
}
