object bombon {

	var property peso = 15

	method precio() {
		return 5
	}

	method peso() {
		return peso
	}

	method mordisco() {
		if (peso > 0) {
			peso = peso * 0.8 - 1
		}
	}

	method gusto() {
		return "frutilla"
	}

	method libreGluten() {
		return true
	}
}

object bombonesDuros {
	
	var property peso = 15
	
	method precio() {
		return 5
	}
	
	method gusto() {
		return "frutilla"
	}
	
	method mordisco() {
		if (peso > 0) {
			peso = peso * 0.9
		}
	}
}

object alfajor {

	var property peso = 300

	method precio() {
		return 12
	}

	method peso() {
		return peso
	}

	method mordisco() {
		if (peso > 0) {
			peso = peso * 0.8
		}
	}

	method gusto() {
		return "chocolate"
	}

	method libreGluten() {
		return false
	}

}

object caramelo {

	var property peso = 5
	var property sabor = ""

	method precio() {
		return 1
	}

	method peso() {
		return peso
	}

	method mordisco() {
		if (peso > 0) {
			peso = peso - 1
		}
	}

	method gusto(gusto) {
		sabor = gusto
		return sabor
	}

	method libreGluten() {
		return true
	}

}

object chupetin {

	var property peso = 7

	method precio() {
		return 0
	}

	method peso() {
		return peso
	}

	method mordisco() {
		if (peso > 0) {
			if (peso < 2) {
				peso = peso * 0.9
			}
		}
	}

	method gusto() {
		return "naranja"
	}

	method libreGluten() {
		return true
	}

}

object oblea {

	var property peso = 250

	method precio() {
		return 5
	}

	method peso() {
		return peso
	}

	method mordisco() {
		if (peso > 0) {
			if (peso > 70) {
				peso = peso * 0.5
			} else peso = peso * 0.75
		}
	}

	method gusto() {
		return "naranja"
	}

	method libreGluten() {
		return false
	}

}

object chocolatin {

	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var pesoActual
	var property precio
	var property peso = pesoInicial

	/* al principio, el peso actual coincide con el inicial */
	method pesoInicial(cuanto) {
		pesoInicial = cuanto
		pesoActual = cuanto
		self.precio(cuanto)
	}

	method precio(valor) {
		precio = pesoInicial * (1 / 2)
	}

	method libreGluten() {
		return false
	}

	method gusto() {
		return "chocolate"
	}

	method mordisco() {
		if (pesoActual > 0) {
			if (pesoActual == pesoInicial) {
				pesoActual = pesoInicial - 2
			} else pesoActual = pesoActual - 2
		}
	}

}

object golosinaBaniada {

	var golosinaInterior
	var pesoBanio = 4
	var property peso
	var property precio

	method baniaA(unaGolosina) {
		golosinaInterior = unaGolosina
		self.precio(unaGolosina)
		self.peso(unaGolosina)
		return unaGolosina
	}

	method precio(unaGolosina) {
		precio = unaGolosina.precio() + 2
	}

	method peso(unaGolosina) {
		peso = unaGolosina.peso() + 4
	}

	method mordisco() {
		golosinaInterior.mordisco()
		if (pesoBanio >= 0) {
			pesoBanio -= 2
		}
	}

	method gusto() {
		return golosinaInterior.gusto()
	}

	method libreGluten() {
		return golosinaInterior.libreGluten()
	}

}

object tuttifrutti {

	var property peso = 5
	var property precio
	var property libreGluten = false
	var property sabor = "frutilla"
	var c = 0

	method libreGluten() = libreGluten

	method libreGluten(bool) {
		libreGluten = bool
		if (bool) {
			self.precio(7)
		} else self.precio(10)
	}

	method mordisco() {
		if (c == 0) {
			sabor = "chocolate"
			c = 1
		}
		if (c == 1) {
			sabor = "naranja"
			c = 2
		}
		if (c == 2) {
			sabor = "frutilla"
			c = 0
		}
	}

	method gusto() {
		return sabor
	}
}

object mariano {
	
	var bolsa = []
	
	method comprar(unaGolosina) {
		bolsa.add(unaGolosina)
	}
	
	method desechar(unaGolosina) {
		bolsa.remove(unaGolosina)
	}
	
	method probarGolosinas() {
		bolsa.forEach({ golosina => golosina.mordisco() })
	}
	
	method hayGolosinasSinTACC() {
		return bolsa.any({ golosina => golosina.libreGluten() })
	}
	
	method preciosCuidados() {
		return bolsa.all({ golosina => golosina.precio() <= 10 })
	}
	
	method golosinaDeSabor(unSabor) {
		return bolsa.map({ golosina => golosina.gusto() }).find({ sabor => sabor == unSabor }).first()
	}
	
	method golosinasDeSabor(unSabor) {
		return bolsa.map({ golosina => golosina.gusto() }).find({ gusto => gusto == unSabor })
	}
	
	method sabores() = bolsa.map({ golosina => golosina.gusto() }).asSet()
	
	method golosinaMasCara() = bolsa.max({ golosina => golosina.precio() })
	
	method pesoGolosinas() = bolsa.sum({ golosina => golosina.peso() })
	
	method golosinasFaltantes(golosinasDeseadas) {
		return golosinasDeseadas.difference(bolsa.asSet())
	}
	
	method gustosFaltantes(gustosDeseados) {
		return gustosDeseados.difference(bolsa.map({ golosinas => golosinas.gusto() }).asSet())
	}
	
	method baniar(unaGolosina) {
		bolsa.add(golosinaBaniada.baniaA(unaGolosina))
	}
	
		
	
}

