/**
 * Created by mainn_000 on 6/28/2015.
 */
package
{
import logic.Game;

import starling.display.Sprite;

public class Root extends Sprite
{

	private var _game:Game;

	public function Root()
	{
	}

	public function create():void
	{
		this._game = new Game();
		this._game.createMap("[[[100,500], [700,500], [700, 550], [100, 550]]]");
		this._game.createHero().setPosition(400, 300);

		this.addChild(this._game);
	}
}
}
