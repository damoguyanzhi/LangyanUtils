////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2005-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package langyan.utils
{
	
	/**
	 *  The StringUtil utility class is an all-static class with methods for
	 *  working with String objects within Flex.
	 *  You do not create instances of StringUtil;
	 *  instead you call methods such as 
	 *  the <code>StringUtil.substitute()</code> method.  
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public class StringUtil
	{
		
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Removes all whitespace characters from the beginning and end
		 *  of the specified string.
		 *
		 *  @param str The String whose whitespace should be trimmed. 
		 *
		 *  @return Updated String where whitespace was removed from the 
		 *  beginning and end. 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function trim(str:String):String
		{
			if (str == null) return '';
			
			var startIndex:int = 0;
			while (isWhitespace(str.charAt(startIndex)))
				++startIndex;
			
			var endIndex:int = str.length - 1;
			while (isWhitespace(str.charAt(endIndex)))
				--endIndex;
			
			if (endIndex >= startIndex)
				return str.slice(startIndex, endIndex + 1);
			else
				return "";
		}
		
		/**
		 *  Removes all whitespace characters from the beginning and end
		 *  of each element in an Array, where the Array is stored as a String. 
		 *
		 *  @param value The String whose whitespace should be trimmed. 
		 *
		 *  @param separator The String that delimits each Array element in the string.
		 *
		 *  @return Updated String where whitespace was removed from the 
		 *  beginning and end of each element. 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function trimArrayElements(value:String, delimiter:String):String
		{
			if (value != "" && value != null)
			{
				var items:Array = value.split(delimiter);
				
				var len:int = items.length;
				for (var i:int = 0; i < len; i++)
				{
					items[i] = StringUtil.trim(items[i]);
				}
				
				if (len > 0)
				{
					value = items.join(delimiter);
				}
			}
			
			return value;
		}
		
		/**
		 *  Returns <code>true</code> if the specified string is
		 *  a single space, tab, carriage return, newline, or formfeed character.
		 *
		 *  @param str The String that is is being queried. 
		 *
		 *  @return <code>true</code> if the specified string is
		 *  a single space, tab, carriage return, newline, or formfeed character.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function isWhitespace(character:String):Boolean
		{
			switch (character)
			{
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
					
				default:
					return false;
			}
		}
		
		/**
		 *  Substitutes "{n}" tokens within the specified string
		 *  with the respective arguments passed in.
		 *
		 *  @param str The string to make substitutions in.
		 *  This string can contain special tokens of the form
		 *  <code>{n}</code>, where <code>n</code> is a zero based index,
		 *  that will be replaced with the additional parameters
		 *  found at that index if specified.
		 *
		 *  @param rest Additional parameters that can be substituted
		 *  in the <code>str</code> parameter at each <code>{n}</code>
		 *  location, where <code>n</code> is an integer (zero based)
		 *  index value into the array of values specified.
		 *  If the first parameter is an array this array will be used as
		 *  a parameter list.
		 *  This allows reuse of this routine in other methods that want to
		 *  use the ... rest signature.
		 *  For example <pre>
		 *     public function myTracer(str:String, ... rest):void
		 *     { 
		 *         label.text += StringUtil.substitute(str, rest) + "\n";
		 *     } </pre>
		 *
		 *  @return New string with all of the <code>{n}</code> tokens
		 *  replaced with the respective arguments specified.
		 *
		 *  @example
		 *
		 *  var str:String = "here is some info '{0}' and {1}";
		 *  trace(StringUtil.substitute(str, 15.4, true));
		 *
		 *  // this will output the following string:
		 *  // "here is some info '15.4' and true"
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function substitute(str:String, ... rest):String
		{
			if (str == null) return '';
			
			// Replace all of the parameters in the msg string.
			var len:uint = rest.length;
			var args:Array;
			if (len == 1 && rest[0] is Array)
			{
				args = rest[0] as Array;
				len = args.length;
			}
			else
			{
				args = rest;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				str = str.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
			
			return str;
		}
		
		/**
		 *  Returns a string consisting of a specified string
		 *  concatenated with itself a specified number of times.
		 *
		 *  @param str The string to be repeated.
		 *
		 *  @param n The repeat count.
		 *
		 *  @return The repeated string.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4.1
		 */
		public static function repeat(str:String, n:int):String
		{
			if (n == 0)
				return "";
			
			var s:String = str;
			for (var i:int = 1; i < n; i++)
			{
				s += str;
			}
			return s;
		}
		
		/**
		 *  Removes "unallowed" characters from a string.
		 *  A "restriction string" such as <code>"A-Z0-9"</code>
		 *  is used to specify which characters are allowed.
		 *  This method uses the same logic as the <code>restrict</code>
		 *  property of TextField.
		 *
		 *  @param str The input string.
		 *
		 *  @param restrict The restriction string.
		 *
		 *  @return The input string, minus any characters
		 *  that are not allowed by the restriction string.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4.1
		 */
		public static function restrict(str:String, restrict:String):String
		{
			// A null 'restrict' string means all characters are allowed.
			if (restrict == null)
				return str;
			
			// An empty 'restrict' string means no characters are allowed.
			if (restrict == "")
				return "";
			
			// Otherwise, we need to test each character in 'str'
			// to determine whether the 'restrict' string allows it.
			var charCodes:Array = [];
			
			var n:int = str.length;
			for (var i:int = 0; i < n; i++)
			{
				var charCode:uint = str.charCodeAt(i);
				if (testCharacter(charCode, restrict))
					charCodes.push(charCode);
			}
			
			return String.fromCharCode.apply(null, charCodes);
		}
		
		/**
		 *  @private
		 *  Helper method used by restrict() to test each character
		 *  in the input string against the restriction string.
		 *  The logic in this method implements the same algorithm
		 *  as in TextField's 'restrict' property (which is quirky,
		 *  such as how it handles a '-' at the beginning of the
		 *  restriction string).
		 */
		private static function testCharacter(charCode:uint,
											  restrict:String):Boolean
		{
			var allowIt:Boolean = false;
			
			var inBackSlash:Boolean = false;
			var inRange:Boolean = false;
			var setFlag:Boolean = true;
			var lastCode:uint = 0;
			
			var n:int = restrict.length;
			var code:uint;
			
			if (n > 0)
			{
				code = restrict.charCodeAt(0);
				if (code == 94) // caret
					allowIt = true;
			}
			
			for (var i:int = 0; i < n; i++)
			{
				code = restrict.charCodeAt(i)
				
				var acceptCode:Boolean = false;
				if (!inBackSlash)
				{
					if (code == 45) // hyphen
						inRange = true;
					else if (code == 94) // caret
						setFlag = !setFlag;
					else if (code == 92) // backslash
						inBackSlash = true;
					else
						acceptCode = true;
				}
				else
				{
					acceptCode = true;
					inBackSlash = false;
				}
				
				if (acceptCode)
				{
					if (inRange)
					{
						if (lastCode <= charCode && charCode <= code)
							allowIt = setFlag;
						inRange = false;
						lastCode = 0;
					}
					else
					{
						if (charCode == code)
							allowIt = setFlag;
						lastCode = code;
					}
				}
			}
			return allowIt;
		}
		
		/**
		 * 最后一个字符若是指定的字符，就删掉该字符
		 * @param msg   字符串
		 * @param code  要删除的字符
		 * @return msg
		 */
		public static function deleteLastCharacter(msg:String,code:String):String
		{
			var len:int=msg.length;
			var curCode:String;
			curCode=msg.charAt(len-1);
			if(curCode==code)
			{
				msg=msg.substr(0,len-1);
			}
			return msg;
		}
		
		/**
		 * 去掉字符串两端所有连续的不可见字符。
		 * 注意：若目标字符串为null或不含有任何可见字符,将输出空字符串""。
		 * @param str 要格式化的字符串
		 */		
		public static  function trimAll(str:String):String
		{
			return trimLeft(trimRight(str));
		}
		/**
		 * 去除字符串左边所有连续的不可见字符。
		 * @param str 要格式化的字符串
		 */		
		public static function trimLeft(str:String):String
		{
			if(str==""||str==null)
				return "";
			var char:String = str.charAt(0);
			while(str.length>0&&
				(char==" "||char=="\t"||char=="\n"||char=="\r"||char=="\f"))
			{
				str = str.substr(1);
				char = str.charAt(0);
			}
			return str;
		}
		/**
		 * 去除字符串右边所有连续的不可见字符。
		 * @param str 要格式化的字符串
		 */
		public static function trimRight(str:String):String
		{
			if(str==""||str==null)
				return "";
			var char:String = str.charAt(str.length-1);
			while(str.length>0&&
				(char==" "||char=="\t"||char=="\n"||char=="\r"||char=="\f"))
			{
				str = str.substr(0,str.length-1);
				char = str.charAt(str.length-1);
			}
			return str;
		}
		
		/**
		 * 替换指定的字符串里所有的p为rep
		 */		
		public static function replaceStr(targetStr:String,p:String,rep:String):String
		{
			if(!targetStr)
				return "";
			var arr:Array = targetStr.split(p);
			return arr.join(rep);
		}
		/**
		 * 将颜色数字代码转换为字符串。
		 */		
		public static function toColorString(color:uint):String
		{
			var str:String = color.toString(16).toUpperCase();
			var num:int = 6-str.length;
			for(var i:int=0;i<num;i++)
			{
				str = "0"+str;
			}
			return "0x"+str;
		}
		/**
		 * 格式化文件长度为带单位的字符串
		 * @param length 文件长度,单位:字节。
		 * @param fractionDigits 要近似保留的小数位数,若为-1，则输出完整的大小。
		 */		
		public static function toSizeString(length:Number,fractionDigits:int=-1):String
		{
			var sizeStr:String = "";
			if(fractionDigits==-1)
			{
				if(length>1073741824)
				{
					sizeStr += int(length/1073741824).toString()+"GB";
					length = length%1073741824;
				}
				if(length>1048576)
				{
					if(sizeStr)
						sizeStr += ",";
					sizeStr += int(length/1048576).toString()+"MB";
					length = length%1048576;
				}
				if(length>1204)
				{
					if(sizeStr)
						sizeStr += ",";
					sizeStr += int(length/1204).toString()+"KB";
					length = length%1204;
				}
				if(length>0)
				{
					if(sizeStr)
						sizeStr += ",";
					sizeStr += length.toString()+"B";
				}
			}
			else
			{
				if(length>1073741824)
				{
					sizeStr = Number(length/1073741824).toFixed(fractionDigits)+"GB";
				}
				else if(length>1048576)
				{
					sizeStr = Number(length/1048576).toFixed(fractionDigits)+"MB";
				}
				else if(length>1204)
				{
					sizeStr = Number(length/1204).toFixed(fractionDigits)+"KB";
				}
				else
				{
					sizeStr = length.toString()+"B";
				}
			}
			return sizeStr;
		}
		
		private static var htmlEntities:Array = [["&","&amp;"],["<","&lt;"],[">","&gt;"],["\"","&quot;"],["'","&apos;"]];
		/**
		 * 转换为HTML实体字符
		 */		
		public static function escapeHTMLEntity(str:String):String
		{
			if(!str)
				return "";
			var list:Array = htmlEntities;
			for each(var arr:Array in list)
			{
				var key:String = arr[0];
				var value:String = arr[1];
				str = str.split(key).join(value);
			}
			return str;
		}
		/**
		 * 转换HTML实体字符为普通字符
		 */		
		public static function unescapeHTMLEntity(str:String):String
		{
			if(!str)
				return "";
			var list:Array = htmlEntities;
			for each(var arr:Array in list)
			{
				var key:String = arr[0];
				var value:String = arr[1];
				str = str.split(value).join(key);
			}
			return str;
		}
		
	}
}
