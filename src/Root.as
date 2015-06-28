/**
 * Created by mainn_000 on 6/28/2015.
 */
package
{
import logic.Game;
import logic.Hero;
import logic.KeyboardController;

import starling.display.Sprite;

public class Root extends Sprite
{
	private var _game:Game;
	private var _controller:KeyboardController;

	public function Root()
	{
	}

	public function create():void
	{
		this._game = new Game();
		this._controller = new KeyboardController(this);

		this._game.createMap("[" +
			"[[300,500], [700,300], [700, 550]]," +
			"[[400,160], [700,160], [550, 300]]," +
			"[[100,100], [400,100], [100, 200]]" +
		"]");

		var hero:Hero = this._game.createHero();

		this._controller.pairHero(hero);
		this._game.heroRespawn(hero);

		this.addChild(this._game);
	}
}
}
