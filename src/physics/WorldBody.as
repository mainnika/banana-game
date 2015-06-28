/**
 * Created by mainn_000 on 6/25/2015.
 */
package physics
{
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2DebugDraw;
import Box2D.Dynamics.b2World;

import flash.display.Sprite;

import physics.$.ISteppable;

public class WorldBody
{
	public static const PHYS_SCALE:int = 30;
	private static const GRAVITY:b2Vec2 = new b2Vec2(0, 30);
	private static const DO_SLEEP:Boolean = false;
	private static const FIXED_TIMESTEP:Number = 1 / 60;
	private static const VELOCITY_INTERATION:int = 8;
	private static const POSITION_INTERATION:int = 3;

	public static const CATEGORY_NONE:int = 0x00;
	public static const CATEGORY_GROUND:int = 0x01;
	public static const CATEGORY_HERO:int = 0x02;
	public static const CATEGORY_FOOTS:int = 0x03;

	private var _world:b2World;
	private var _debugDrawEnabled:Boolean;
	private var _sensor:CollideSensor;
	private var _steppable:Vector.<ISteppable>;

	public function WorldBody()
	{
		this._world = new b2World(GRAVITY, DO_SLEEP);
		this._debugDrawEnabled = false;
		this._steppable = new Vector.<ISteppable>();
		this._sensor = new CollideSensor();

		this._world.SetContactListener(this._sensor);
	}

	public function enableDebugDraw(debug_sprite:Sprite):void
	{
		this._debugDrawEnabled = true;

		var dbgDraw:b2DebugDraw = new b2DebugDraw();
		dbgDraw.SetSprite(debug_sprite);
		dbgDraw.SetDrawScale(30.0);
		dbgDraw.SetFillAlpha(0.3);
		dbgDraw.SetLineThickness(1.0);
		dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit | b2DebugDraw.e_centerOfMassBit);

		this._world.SetDebugDraw(dbgDraw);
	}

	public function createHero():HeroBody
	{
		var hero:HeroBody = new HeroBody(this);
		this._steppable.push(hero);

		return hero;
	}

	public function step():void
	{
		this._world.ClearForces();
		this._world.Step(FIXED_TIMESTEP, VELOCITY_INTERATION, POSITION_INTERATION);

		if (this._debugDrawEnabled)
			this._world.DrawDebugData();

		for (var i:int = 0; i < this._steppable.length; i++)
		{
			this._steppable[i].step();
		}
	}

	public function get body():b2World
	{
		return this._world;
	}

	public function get sensor():CollideSensor
	{
		return this._sensor;
	}
}
}
