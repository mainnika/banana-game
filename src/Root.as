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

		this._game.createMap("[[[100,500], [700,300], [700, 550], [100, 550]]]");

		var hero:Hero = this._game.createHero();

		this._controller.pairHero(hero);
		hero.setPosition(400, 300);

		this.addChild(this._game);
	}
}
}
