/**
 * Created by mainn_000 on 6/25/2015.
 */
package helpers
{
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Collision.Shapes.b2Shape;
import Box2D.Dynamics.b2Fixture;
import Box2D.Dynamics.b2FixtureDef;

public class MapCreator
{
	public function MapCreator()
	{}

	public static function parse(data:String):Vector.<b2FixtureDef>
	{
		var some:Object = JSON.parse(data);

		trace(some);

		return null;
	}
}
}
