package langyan.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**移除所有子项*/
	public class DeleteAllSonUtil
	{
		public function DeleteAllSonUtil()
		{
		}
		
		/**
		 * 移除容器中所有元素，防止内存泄露
		 * @param     box  需要移除的容器
		 */
		public static function removeAllSon(container:DisplayObjectContainer):void
		{
			var len:int=container.numChildren;
			var num:int;
			for (var i:int=0; i < len; i++)
			{
				var display:DisplayObject=container.getChildAt(0);
				container.removeChild(display);
				if (display is Bitmap)
				{
					(display as Bitmap).bitmapData=null;
				}
				else if (display is MovieClip)
				{
					(display as MovieClip).stop();
				}
				else if (display is Sprite)
				{
					var sprite:Sprite=display as Sprite;
					num=sprite.numChildren;
					if (num > 0)
					{
						removeAllSon(sprite);
					}
				}
				display=null;
			}
			container=null;
		}
	}
}