/**
 * Created by mainn_000 on 6/28/2015.
 */
package graphic
{
import graphic.$.IRenderable;

import starling.display.Sprite;

public class RenderableScene extends Sprite
{
	private var _renderables:Vector.<IRenderable>;

	public function RenderableScene()
	{
		this._renderables = new Vector.<IRenderable>();
	}

	public function addRenderableObject(renderable:IRenderable):void
	{
		this._renderables.push(renderable);
	}

	public function renderScene():void
	{
		for (var i:int = 0; i < this._renderables.length; i++)
		{
			this._renderables[i].draw();
		}
	}
}
}
