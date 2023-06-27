class Vendedor {
	
	const property certificaciones = #{}
	
	method esVersatil() {
		return certificaciones.size() >= 3
			and certificaciones.any({ certif => certif.sobreProductos() })
			and self.esGenerico()
 	}
	
	method esFirme() = certificaciones.sum({ certif => certif.puntos() }) >= 30
	method agregarCertificacion(_certificacion) {
		if(not certificaciones.contains(_certificacion)) {
			certificaciones.add(_certificacion)	
		} else {
			self.error("La certificacion ya estaba registrada")
		}
	}
	
	method tieneAfinidad(_centro) = self.puedeTrabajar(_centro.ciudad())
	method esGenerico() = certificaciones.any({ certif => not certif.sobreProductos() })
	method puedeTrabajar(_ciudad)
}

class VendedorFijo inherits Vendedor {
	
	const ciudad
	
	override method puedeTrabajar(_ciudad) = ciudad == _ciudad
	method esInfluyente() = false
	method esPersonaFisica() = true
}

class VendedorViajante inherits Vendedor {
	
	const provincias = #{}
	
	method agregarProvincia(_provincia) {
		if(not provincias.contains(_provincia)) {
			provincias.add(_provincia)	
		} else {
			self.error("La provincia ya estaba registrada")
		}
	}
	override method puedeTrabajar(_ciudad) = provincias.any({ provincia => provincia == _ciudad.provincia() })
	method esInfluyente() = provincias.sum({ prov => prov.poblacion() }) >= 10000000
	method esPersonaFisica() = true
}

class ComercioCorresponsal inherits Vendedor {
	
	const ciudades = #{}
	
	method agregarSucursal(_ciudad) {
		if(not ciudades.contains(_ciudad)) {
			ciudades.add(_ciudad)	
		} else {
			self.error("La sucursal ya estaba registrada")
		}
	}
	override method puedeTrabajar(_ciudad) = ciudades.any({ ciudad => ciudad == _ciudad })
	method esInfluyente() = ciudades.size() >= 5 or ciudades.map({ ciudad => ciudad.provincia() }).asSet().size() >= 3
	override method tieneAfinidad(_centro) = super(_centro) and ciudades.any({ ciudad => not _centro.puedeCubrir(ciudad) })
	method esPersonaFisica() = false
}

class Provincia {
	const property poblacion
}

class Ciudad {
	const property provincia
}

class Certificacion {
	const property sobreProductos
	const property puntos
}

class CentroDeDistribucion {
	
	const property ciudad
	const property vendedores = []
	
	method agregarVendedor(_vendedor) {
		if(not vendedores.contains(_vendedor)) {
			vendedores.add(_vendedor)	
		} else {
			self.error("El vendedor ya estaba registrado")
		}
	}
	
	method vendedorEstrella() = vendedores.max({ vendedor => vendedor.certificaciones().sum({ certif => certif.puntos() }) })
	method puedeCubrir(_ciudad) = vendedores.any({ vendedor => vendedor.puedeTrabajar(_ciudad) })
	method vendedoresGenericos() = vendedores.filter({ vendedor => vendedor.certificaciones().any({ certif => not certif.sobreProductos() }) })
	method esRobusto() = vendedores.count({ vendedor => vendedor.esFirme() }) >= 3
	method repartirCertificacion(_certificacion) {
		vendedores.forEach({ vendedor => vendedor.agregarCertificacion(_certificacion) })
	}
	method esCandidato(_vendedor) = _vendedor.esVersatil() and _vendedor.tieneAfinidad(self)	
}

class ClienteInseguro {
	method puedeSerAtendido(_vendedor) =_vendedor.esVersatil() and _vendedor.esFirme()
}

class ClienteDetallista {	
	method puedeSerAtendido(_vendedor) = _vendedor.certificaciones().count({ certif => certif.sobreProductos() }) >= 3
}

class ClienteHumanista {	
	method puedeSerAtendido(_vendedor) = _vendedor.esPersonaFisica()
}




















