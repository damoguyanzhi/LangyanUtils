
package langyan.utils
{
	import flash.text.engine.ContentElement;
	
	/**
	 *  The ArrayUtil utility class is an all-static class
	 *  with methods for working with arrays within Flex.
	 *  You do not create instances of ArrayUtil;
	 *  instead you call static methods such as the 
	 *  <code>ArrayUtil.toArray()</code> method.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public class ArrayUtil
	{
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Ensures that an Object can be used as an Array.
		 *
		 *  <p>If the Object is already an Array, it returns the object. 
		 *  If the object is not an Array, it returns an Array
		 *  in which the only element is the Object.
		 *  As a special case, if the Object is null,
		 *  it returns an empty Array.</p>
		 *
		 *  @param obj Object that you want to ensure is an array.
		 *
		 *  @return An Array. If the original Object is already an Array, 
		 *  the original Array is returned. Otherwise, a new Array whose
		 *  only element is the Object is returned or an empty Array if 
		 *  the Object was null. 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function toArray(obj:Object):Array
		{
			if (obj == null) 
				return [];
				
			else if (obj is Array)
				return obj as Array;
				
			else
				return [ obj ];
		}
		
		/**
		 *  Returns the index of the item in the Array.
		 * 
		 *  @param item The item to find in the Array. 
		 *
		 *  @param source The Array to search for the item.
		 * 
		 *  @return The index of the item, and -1 if the item is not in the list.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function getItemIndex(item:Object, source:Array):int
		{
			var n:int = source.length;
			for (var i:int = 0; i < n; i++)
			{
				if (source[i] === item)
					return i;
			}
			
			return -1;           
		}
		
		/**
		 * 该数组里是否存在该值
		 * @param arr 数组
		 * @param msg 比对的值
		 * @return 比对结果
		 * */
		public static function isExist(arr:Array,msg:Object):Boolean
		{
			var bol:Boolean;
			for each(var value:Object in arr)
			{
				if(value==msg)
				{
					bol=true;
				}
			}
			return bol;
		}
		
		private static var  _newArr:Array;
		private static var _newContent:String;
		/**添加内容
		 * @param arr 需要添加内容的数组
		 * @param newContent 添加内容
		 * @return 返回添加内容的数组 
		 * */
		public static function addContent(arr:Array,newContent:String):Array
		{
			_newContent=newContent;
			_newArr=new Array;
			arr.forEach(addMsg);
			return _newArr;
		}
		
		private static function addMsg(element:*, index:int, arr:Array):void
		{
			var newElement:String=element+_newContent;
			_newArr.push(newElement);
		}
	}
}

