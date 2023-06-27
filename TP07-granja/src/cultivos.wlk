import hector.*
import wollok.game.*
import config.*

// colliders 
class Maiz {
	
	var image = "corn_baby.png"
	
	// GETTER y SETTER
	method image() = image
	method image(png) {
		image = png
	} 
	
	// method image() = "corn_baby.png"
	
	method regarse() {
		if(self.image() == "corn_baby.png") {
			self.image("corn_adult.png")
		} else {
			game.say(hector,"no tengo nada para regar")
		} 
	}
}

class Trigo {
	method image() = "wheat_0.png"
}

class Tomaco {
	method image() = "tomaco.png"
}
