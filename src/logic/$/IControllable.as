/**
 * Created by mainn_000 on 6/28/2015.
 */
package logic.$
{
public interface IControllable
{
	function attachController(controller:IController):void;

	function removeController():void;

	function up(down:Boolean):void;

	function right(down:Boolean):void;

	function left(down:Boolean):void;
}
}
