/**
 * Created by mainn_000 on 6/28/2015.
 */
package helpers
{
public class EmbeddedAssets
{
	[Embed(source="../../res/banana.xml", mimeType="application/octet-stream")]
	public static const bananaXml:Class;

	[Embed(source="../../res/banana.png")]
	public static const banana:Class;
}
}
