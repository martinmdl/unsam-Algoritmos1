object roberto {
	const peso = 90
	var transporte = camion

	method peso() = peso + transporte.peso()

	method transporte(vehiculo) {
		transporte = vehiculo
	}

	method tieneCredito() = false
}

object chuck {
	const peso = 900
	
	method tieneCredito() = true
	
} 

object neo {
	var property credito = 200
	
	method tieneCredito() = credito > 50
}

object camion {
	var acoplados = 2

	method peso() = acoplados * 500
	
	method acoplados(cantAcoplados) {
		acoplados = cantAcoplados
	}

}

object bicicleta {

	method peso() = 1
}

object brooklyn {

	method dejarPasar(mensajero) {
		return mensajero.peso() < 1000
	}
}

object matrix {
	
	method dejarPasar(mensajero) {
		return mensajero.tieneCredito()
	}
}

object paquete {
	var pago = false
	var destino = brooklyn

	method pagar() {
		pago = true
	}

	method estaPago() {
		return pago
	}

	method destino(lugar) {
		destino = lugar
	}

	method puedeSerEntregadoPor(mensajero) {
		return destino.dejarPasar(mensajero) and self.estaPago()
	}
}