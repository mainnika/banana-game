/**
 * Created by mainn_000 on 6/25/2015.
 */
package physics
{
import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2FixtureDef;
import Box2D.Dynamics.b2World;

public class HeroBody
{

	private static const HERO_RADIUS:Number = 10 / WorldBody.PHYS_SCALE;
	private static const HERO_DEFENITION:b2BodyDef = new b2BodyDef();
	{
		HERO_DEFENITION.type = b2Body.b2_dynamicBody;
	}

	private static const HERO_SHAPE:b2PolygonShape = new b2PolygonShape();
	{
		HERO_SHAPE.SetAsBox(HERO_RADIUS, HERO_RADIUS);
	}

	private static const HERO_FIXTURE:b2FixtureDef = new b2FixtureDef();
	{
		HERO_FIXTURE.shape = HERO_SHAPE;
	}

	private var _body:b2Body;

	public function HeroBody(world:b2World)
	{
		this._body = world.CreateBody(HERO_DEFENITION);
		this._body.CreateFixture(HERO_FIXTURE);
	}

	public function setPosition(x:int, y:int):void
	{
		this._body.SetPosition(new b2Vec2(x / WorldBody.PHYS_SCALE, y / WorldBody.PHYS_SCALE));
	}
}
}
