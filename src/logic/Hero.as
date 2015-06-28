/**
 * Created by mainn_000 on 6/25/2015.
 */
package logic
{
import graphic.$.IRenderable;
import graphic.Animation;

import helpers.StaticAssets;

import logic.$.IControllable;
import logic.$.IController;

import physics.HeroBody;

public class Hero extends Animation implements IRenderable, IControllable
{
	private var _body:HeroBody;
	private var _controller:IController;

	public function Hero(game:Game)
	{
		super(StaticAssets.instance().getTextures("banana_"));
		this._body = game.world.createHero();
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

	public function attachController(controller:IController):void
	{
		this._controller = controller;
	}

	public function removeController():void
	{
		this._controller = null;
	}

	public function up(active:Boolean):void
	{
		this._body.jump();
	}

	public function right(active:Boolean):void
	{
		this._body.set_input(HeroBody.INPUT_RIGHT, active);
	}

	public function left(active:Boolean):void
	{
		this._body.set_input(HeroBody.INPUT_LEFT, active);
	}

}
}
