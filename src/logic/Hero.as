/**
 * Created by mainn_000 on 6/25/2015.
 */
package logic
{
import graphic.$.IRenderable;

import graphic.Animation;

import helpers.StaticAssets;

import physics.HeroBody;

public class Hero extends Animation implements IRenderable
{
	private var _body:HeroBody;

	public function Hero(game:Game)
	{
		super(StaticAssets.instance().getTextures("banana_"));
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

	public function draw():void
	{
		this.x = this._body.x;
		this.y = this._body.y;
		this.rotation = this._body.angle;
	}

}
}
