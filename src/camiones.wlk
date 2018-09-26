//Nicolas A. Dorado Soria.
// TODO Nicooooooo, separame en archivos!


object laEmpresa {

	var deposito = []
	var property transporte = camion

	// TODO por el addAll, algo debería ser una coleccion
	// de ser así (lo cuál es correctísimo), debería tener un nombre acorde!
	method cargarDepositoConCosas(algo) {
		deposito.addAll(algo)
	}

	method descargarDeposito(algo) {
		deposito.remove(algo)
	}
	
	// TODO como resolves el caso de la motoneta?
	// me parece que lo mejor sería que el transporte a cargar venga por parámetro
	// así podes mandar uno, o el otro
	method cargar() {
		deposito.forEach{ carga => 
			 if (transporte.puedeCargar(carga)) 
			 	transporte.cargar(carga)
			// TODO esto debería estar ADENTRO del test, sino hace esto SIEMPRE
			// y sólo debería descargar en el caso de que se pudo cargar en el transporte
			self.descargarDeposito(carga)
		}
	}

}

object camion {

	var carga = []
	var property capacidadMaxima = 15

	method cargar(algo) {
		if (self.puedeCargar(algo)) {
			carga.add(algo)
		}
	}

	method descargar(algo) {
		carga.remove(algo)
	}

	method tieneCargado(algo) {
		return carga.contains(algo)
	}

	method pesoTotal() {
		return carga.sum({ cargas => cargas.peso() })
	}

	method cargaDisponible() {
		return capacidadMaxima - self.pesoTotal()
	}

	method puedeCargar(algo) {
		return self.cargaDisponible() > algo.peso()
	}

	method cargaMasPeligrosa() {
		return carga.max({ cargas => cargas.nivelPeligrosidad() })
	}

	method saberSiPuedePorRuta() {
		return ruta.peligrosidadRuta() > self.cargaMasPeligrosa().nivelPeligrosidad()
	}

}

object motoneta {

	var property capacidadMaxima = 100
	var carga = []

	method cargar(algo) {
		if (self.puedeCargar(algo)) {
			carga.add(algo)
		}
	}

	method puedeCargar(algo) {
		return algo.peso() < 100
	}

}

object ruta {

	var property peligrosidadRuta = 15

}

object robot {

	const peligrosidadRobot = 30

	method peligrosidad() {
		return peligrosidadRobot
	}

}

object auto {

	const peligrosidadAuto = 15

	method peligrosidad() {
		return peligrosidadAuto
	}

}

object contenedor {

	// TODO nico OJO con los nombres
	// si es una colección, debería llamarse cargas, en lugar de carga
	var carga = []

	method cargar(algo) {
		carga.add(algo)
	}

	method peso() {
		return 100 + carga.sum({ cargas => cargas.peso() })
	}

	method nivelPeligrosidad() {
		if (carga == []) return 0 else return carga.max({ cargas => cargas.nivelPeligrosidad() })
	}

}

object embalaje {
	
	// TODO acá NO es una lista sino que el embalaje embala una sola cosa
	// el enunciado dice:
	// Es una cobertura que envuelve a cualquier otra *cosa*. El peso es el peso de *la cosa* que tenga adentro.
	var carga = []

	method cargar(algo) {
		carga.add(algo)
	}

	method peso() {
		return carga.sum({ cargas => cargas.peso() })
	}

	method nivelPeligrosidad() {
		return carga.max({ cargas => cargas.nivelPeligrosidad() }) / 2
	}

}

object knightRider {

	const pesoKnightRider = 500
	const peligrosidadKnightRider = 10

	method peso() {
		return pesoKnightRider
	}

	method nivelPeligrosidad() {
		return peligrosidadKnightRider
	}

}

object bumblebee {

	const pesoBumblebee = 800
	const peligrosidadBumblebee = 0
	var property transformacionDeBumblebee = robot

	method peso() {
		return pesoBumblebee
	}

	method nivelPeligrosidad() {
		return transformacionDeBumblebee.peligrosidad()
	}

	method transformarEn(algo) {
		transformacionDeBumblebee = algo
	}

}

object paqueteDeLadrillos {

	const pesoLadrillo = 2
	var property cantidadLadrillos = 2
	const peligrosidadLadrillos = 2

	method peso() {
		return pesoLadrillo * self.cantidadLadrillos()
	}

	method nivelPeligrosidad() {
		return peligrosidadLadrillos
	}

}


