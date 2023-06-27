class Personaje {
	
	var estrategia
	var espiritualidad
	const listaPoderes = []
	
	method espiritualidad() = espiritualidad
	method estrategia() = estrategia
	method agregarPoder(_poder) { listaPoderes.add(_poder) }	
	method capacidadDeBatalla() = listaPoderes.sum({ poder => poder.capacidadDeBatalla(self) })
	method mejorPoder() = listaPoderes.max({ poder => poder.capacidadDeBatalla(self) })
	method manejaRadiactividad() = listaPoderes.any({ poder => poder.inmunidadRadiactiva() })
	method enfrentarPeligro(_peligro) {
		if(_peligro.puedeEnfrentarseIndividualmente(self)) {
			estrategia += _peligro.complejidad()			
		}
//		else {
//			self.error("El heroe no puede enfrentar este peligro")
//		}
	}
}

class Metahumano inherits Personaje {
	
	override method capacidadDeBatalla() = super() * 2
	override method manejaRadiactividad() = true
	override method enfrentarPeligro(_peligro) {
		if(_peligro.puedeEnfrentarseIndividualmente(self)) {
			estrategia += _peligro.complejidad()
			espiritualidad += _peligro.complejidad()	
		}
	}
}

class Mago inherits Metahumano {
	
	var poderAcumulado
	
	method poderAcumulado() = poderAcumulado
	override method capacidadDeBatalla() = super() + poderAcumulado
	override method enfrentarPeligro(_peligro) {
		if(_peligro.puedeEnfrentarseIndividualmente(self)) {
			if(poderAcumulado > 10) {
				estrategia += _peligro.complejidad()
				espiritualidad += _peligro.complejidad()
			}
			poderAcumulado -= 5
			if(poderAcumulado < 0) {poderAcumulado = 0}
		}
	}
}

class Poder {
	
	method capacidadDeBatalla(_personaje) = (self.agilidad(_personaje) + self.fuerza(_personaje)) * self.habilidadEspecial(_personaje)	
	method agilidad(_personaje)
	method fuerza(_personaje)
	method habilidadEspecial(_personaje)
}

class Velocidad inherits Poder {
	
	const rapidez	
	
	override method agilidad(_personaje) = rapidez * _personaje.estrategia()
	override method fuerza(_personaje) = rapidez * _personaje.espiritualidad()
	override method habilidadEspecial(_personaje) = _personaje.estrategia() + _personaje.espiritualidad()
	method inmunidadRadiactiva() = false
}

class Vuelo inherits Poder {
	
	const alturaMaxima
	const energiaDespegue
	
	override method agilidad(_personaje) = alturaMaxima * _personaje.estrategia() / energiaDespegue
	override method fuerza(_personaje) = alturaMaxima + _personaje.espiritualidad() - energiaDespegue
	override method habilidadEspecial(_personaje) = _personaje.estrategia() + _personaje.espiritualidad()
	method inmunidadRadiactiva() = alturaMaxima > 200
}

class PoderAmplificador inherits Poder {
	
	const poderBase
	const amplificador
	
	override method agilidad(_personaje) = poderBase.agilidad(_personaje)
	override method fuerza(_personaje) = poderBase.fuerza(_personaje)
	override method habilidadEspecial(_personaje) = poderBase.habilidadEspecial(_personaje) * amplificador
	method inmunidadRadiactiva() = true
}

class Equipo {
	
	const property integrantes = #{}
	
	method miembroMasVulnerable() = integrantes.min({ heroe => heroe.capacidadDeBatalla() })
	method calidad() = integrantes.sum({ heroe => heroe.capacidadDeBatalla() }) / integrantes.size()
	method mejoresPoderes() = integrantes.map({ heroe => heroe.mejorPoder() }).asSet()
	method enfrentarPeligro(_peligro) {
		if(integrantes.filter({ heroe => _peligro.puedeEnfrentarseIndividualmente(heroe) }).size() > _peligro.heroesEnSimultaneo()) {
			integrantes.forEach({ heroe => heroe.enfrentarPeligro(_peligro) })
		}
//		else {
//			self.error("El equipo no puede enfrentar este peligro")
//		}
	}
}

class Peligro {
	
	const capacidadDeBatalla
	const radiactivo
	const property complejidad
	const property heroesEnSimultaneo

	method puedeEnfrentarseEnEquipo(_equipo) = _equipo.integrantes().all({ heroe => self.puedeEnfrentarseIndividualmente(heroe) })
	method puedeEnfrentarseIndividualmente(_personaje) {
		if(radiactivo) { 
			return _personaje.capacidadDeBatalla() > capacidadDeBatalla	and _personaje.manejaRadiactividad()
		} else {
			return _personaje.capacidadDeBatalla() > capacidadDeBatalla
		}		
	}
}
