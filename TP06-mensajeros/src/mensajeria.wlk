import mensajeros.*

object mensajeria {
	
	var property mensajeros = []
	
	method contratar(nombre) {
		mensajeros.add(nombre)	
	}
	
	method despedir(nombre) {
		mensajeros.remove(nombre)
	}
	
	method despedirATodos() {
		mensajeros.removeAll(mensajeros)
	}
	
	method esGrande() {
		return mensajeros.size() > 2
	}
	
	method listoParaEntregar() {
		return paquete.puedeSerEntregadoPor(mensajeros.first())
	}
	
	method pesoUltimoEmpleado() {
		return mensajeros.last().peso()
	}
}
