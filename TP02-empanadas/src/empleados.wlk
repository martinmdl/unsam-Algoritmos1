object gimenez {
	
	var property fondos = 300000
	
	method pagarSueldo(empleado) {
		empleado.diaDePago()
		fondos -= empleado.sueldo()
	}
}

object galvan {
	
	var property sueldo = 15000
	var property dinero = 0
	var property deuda = 0
	
	method diaDePago() {
		dinero += sueldo
		self.pagarDeuda()
	}
	
	method pagarDeuda() {
		
		deuda -= dinero
		
		if (deuda < 0) {
			dinero = -deuda
			deuda = 0
		} else {
			dinero = 0
		}
	}
	
	method aumento(aumento) {
		sueldo += aumento
	}
	
	method gastar(monto) {
				
		if (dinero - monto < 0) {
			deuda = deuda - (dinero - monto)
			dinero = 0
		} else {
			dinero -= monto
		}
	}
}

object baigorria {
	
	var property sueldo = 0
	var totalCobrado = 0
	
	method diaDePago() {
		totalCobrado += sueldo		
		sueldo = 0
	}
	
	method vender(empanadasVendidas) {
		sueldo += empanadasVendidas * 15
	}
	
	method totalCobrado() = totalCobrado
}