import wollok.game.*
import cultivos.*
import config.*

object hector {
	
	var property position = new Position(x = 3, y = 3)
	
	var property currentPos = game.origin()
	
	const property image = "player.png"
	
	method regar() {
		game.whenKeyPressedDo( self, {cultivo => cultivo.regarse()})
	}
		
}