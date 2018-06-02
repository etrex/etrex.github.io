package idv.etrex.color 
{
	/**
	 * ...
	 * @author etrex
	 */
	public class Hue 
	{
		private static var hueColorTable:Array =   [{R:0xFF,G:0x00,B:0x00},
													{R:0xFF,G:0xFF,B:0x00},
													{R:0x00,G:0xFF,B:0x00},
													{R:0x00,G:0xFF,B:0xFF},
													{R:0x00,G:0x00,B:0xFF},
													{R:0xFF,G:0x00,B:0xFF}];
		
		public var h:Number;
		public function Hue(h:Number = 0) 
		{
			this.h = h;
		}
		
		public function getColor():uint
		{
			var i:int = int(h*hueColorTable.length);
			var t:Number = (h*hueColorTable.length)-i;
			
			var c1:Object = hueColorTable[i%hueColorTable.length];
			var c2:Object = hueColorTable[(i+1)%hueColorTable.length];
			var R:int = (1-t) * c1.R + t * c2.R;
			var G:int = (1-t) * c1.G + t * c2.G;
			var B:int = (1-t) * c1.B + t * c2.B;
			return R*0x10000 + G* 0x100 + B;
		}
	}

}