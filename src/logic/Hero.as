/**
 * Created by mainn_000 on 6/25/2015.
 */
package logic
{
import physics.HeroBody;

public class Hero
{
	private var _body:HeroBody;

	public function Hero(game:Game)
	{
		this._body = new HeroBody(game.world.body);
	}

	public function get body():HeroBody
	{
		return _body;
	}

	public function setPosition(x:int, y:int):void
	{
		this._body.setPosition(x, y);
	}
	public function jump():void{

	}
}
}
