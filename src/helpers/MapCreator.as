/**
 * Created by mainn_000 on 6/25/2015.
 */
package helpers
{
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2FixtureDef;

import physics.WorldBody;

public class MapCreator
{
	public function MapCreator()
	{
	}

	public static function parse(data:String):Vector.<b2FixtureDef>
	{
		var i:uint = 0;
		var j:uint = 0;
		var some:Object = JSON.parse(data);
		var fixtures_def:Vector.<b2FixtureDef> = new Vector.<b2FixtureDef>();

		for (i = 0; i < some.length; i++)
		{
			var fd:b2FixtureDef = new b2FixtureDef();
			var sd:b2PolygonShape = new b2PolygonShape();
			var vxs:Array = [];
			for (j = 0; j < some[i].length; j++)
			{
				vxs.push(new b2Vec2(some[i][j][0] / WorldBody.PHYS_SCALE, some[i][j][1] / WorldBody.PHYS_SCALE));
			}
			sd.SetAsArray(vxs, vxs.length);
			fd.shape = sd;
			fixtures_def.push(fd);

		}

		return fixtures_def;
	}
}
}
