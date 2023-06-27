class Academia {
	
	const property muebles = []
	
	method estaGuardado(cosa) = muebles.any({ mueble =>
		mueble.cosas().contains(cosa)
	})
	
	method dondeEstaGuardado(cosa) = muebles.find({ mueble =>
		mueble.cosas().contains(cosa)
	})
	
	method puedoGuardar(cosa) =
		not self.estaGuardado(cosa)
		and muebles.any({ mueble =>
			mueble.puedeGuardar(cosa)
		})
	
	method dondePuedoGuardar(cosa) = muebles.filter({ mueble => 
		mueble.puedeGuardar(cosa)
	})
	
	method guardar(cosa) {
		if(self.puedoGuardar(cosa)) { self.dondePuedoGuardar(cosa).anyOne().guardar(cosa) }
		else { self.error("No se puede guardar") }
	}
	
	method menosUtiles() = muebles.map({ mueble => mueble.cosaMenosUtil() }).asSet()
	
	method cosaMenosUtil() = self.menosUtiles().min({ cosa => cosa.utilidad() })
	
	method marcaMenosUtil() = self.cosaMenosUtil().marca()
		
	method cosasInutiles() = self.menosUtiles().filter({ cosa => not cosa.esMagico() })
	
	method removerCosasInutiles() {
		if(muebles.size() >= 3) {
			self.cosasInutiles().forEach({ cosa => 
				self.dondeEstaGuardado(cosa).remover(cosa)
			})
		} else {
			self.error("No hay nada para remover")
		}
	}
}

class Cosa {
	
	const marca
	const property volumen
	const property esMagico
	const property esReliquia
	
	method marca() = marca
	method utilidadMagia() {
		 if(esMagico) {
			return 3.0
		} else {
			return 0.0
		}		
	}
	method utilidadReliquia() {
		 if(esReliquia) {
			return 5.0
		} else {
			return 0.0
		}		
	}
	
	method utilidad() =
		volumen
		+ self.utilidadMagia()
		+ self.utilidadReliquia()
		+ marca.utilidad(self)
}

class Mueble {
	
	const property cosas = #{}
	
	method puedeGuardar(cosa)
	method precio()
	
	method utilidad() = cosas.sum({ cosa => cosa.utilidad() }) / self.precio()
	method cosaMenosUtil() = cosas.min({ cosa => cosa.utilidad() })
	method remover(cosa) {
		cosas.remove(cosa)
	}
	method guardar(cosa) {
		cosas.add(cosa)
	}
}

class Armario inherits Mueble {
	
	var property cantMax
	
	override method puedeGuardar(cosa) = cosas.size() < cantMax
	override method precio() = cantMax * 5
}

class Gabinete inherits Mueble {
	
	const precio
	
	override method puedeGuardar(cosa) = cosa.esMagico()
	override method precio() = precio
}

class Baul inherits Mueble {
	
	const property volMax
	
	method volumenUsado() = cosas.sum({ cosa => cosa.volumen() })
	
	override method puedeGuardar(cosa) = self.volumenUsado() + cosa.volumen() <= volMax
	override method precio() = volMax + 2
	method sonTodasReliquias() = cosas.all({ cosa => cosa.esReliquia() })
	method utlidadTodasReliquias() {
		if(self.sonTodasReliquias()) {
			return 2.0
		} else {
			return 0.0
		}
	}
	override method utilidad() = super() + self.utlidadTodasReliquias()
}

class BaulMagico inherits Baul {
	
	method cantMagicos() = cosas.count({ cosa => cosa.esMagico() })
	override method utilidad() = super() + self.cantMagicos()
	override method precio() = super() * 2
}

class Marca {
	method utilidad(cosa)
}

object acme inherits Marca {
	override method utilidad(cosa) = cosa.volumen() / 2.0
}

object fenix inherits Marca {
	override method utilidad(cosa) {
		 if(cosa.esReliquia()) {
			return 3.0
		} else {
			return 0.0
		}
	}
}

object cuchuflito inherits Marca {
	override method utilidad(cosa) = 0.0
}

















