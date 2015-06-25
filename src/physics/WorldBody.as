/**
 * Created by mainn_000 on 6/25/2015.
 */
package physics
{
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2DebugDraw;
import Box2D.Dynamics.b2World;

import flash.display.Sprite;

public class WorldBody
{
	public static const PHYS_SCALE:int = 30;
	private static const GRAVITY:b2Vec2 = new b2Vec2(0, 10);
	private static const DO_SLEEP:Boolean = true;
	private static const FIXED_TIMESTEP:Number = 1 / 60;
	private static const VELOCITY_INTERATION:int = 8;
	private static const POSITION_INTERATION:int = 3;

	private var _world:b2World;
	private var debugDrawEnabled:Boolean;

	public function WorldBody()
	{
		this._world = new b2World(GRAVITY, DO_SLEEP);
		this.debugDrawEnabled = false;
	}

	public function enableDebugDraw(debug_sprite:Sprite):void
	{
		this.debugDrawEnabled = true;

		var dbgDraw:b2DebugDraw = new b2DebugDraw();
		dbgDraw.SetSprite(debug_sprite);
		dbgDraw.SetDrawScale(30.0);
		dbgDraw.SetFillAlpha(0.3);
		dbgDraw.SetLineThickness(1.0);
		dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);

		this._world.SetDebugDraw(dbgDraw);
	}

	public function createHero():HeroBody
	{
		var hero:HeroBody = new HeroBody(this._world);

		return hero;
	}

	public function step():void
	{
		this._world.ClearForces();
		this._world.Step(FIXED_TIMESTEP, VELOCITY_INTERATION, POSITION_INTERATION);

		if (this.debugDrawEnabled)
			this._world.DrawDebugData();
	}

	public function get body():b2World
	{
		return this._world;
	}
}
}
