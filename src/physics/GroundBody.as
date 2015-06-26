/**
 * Created by mainn_000 on 6/25/2015.
 */
package physics
{
import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Collision.Shapes.b2Shape;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2FixtureDef;
import Box2D.Dynamics.b2World;

public class GroundBody
{
	private static const GROUND_DEFENITION:b2BodyDef = new b2BodyDef();
	{
		GROUND_DEFENITION.type = b2Body.b2_staticBody;
	}

	private var _body:b2Body;

	public function GroundBody(world:b2World, fixture:b2FixtureDef)
	{
		this._body = world.CreateBody(GROUND_DEFENITION);
		this._body.CreateFixture(fixture);
	}
}
}
