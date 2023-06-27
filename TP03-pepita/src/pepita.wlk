import extras.*
import wollok.game.*

object pepita {

	var property energia = 100
	var property position = game.origin()

	method image() {
		if (self.estaEnElNido()) {
			return "pepita-grande.png"
		}
		if (self.atrapada()) {
			return "pepita-gris.png"
		}
		else return "pepita.png"
	}

// return if (self.estaEnElNido()) "pepita-grande.png" else "pepita.png"
	method come(comida) {
		energia = energia + comida.energiaQueOtorga()
	}

	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		self.vola(position.distance(nuevaPosicion))
		position = nuevaPosicion
	}

	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}

	method estaEnElSuelo() {
		return position.y() == 0
	}

	method atrapada() = self.position() == silvestre.position()
	method caer(){
		if(not self.estaEnElSuelo() and not self.estaEnElNido())
		position = position.down(1)
	}
}
