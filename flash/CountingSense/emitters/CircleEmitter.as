package emitters 
{
	import idv.cjcat.stardust.common.actions.Age;
	import idv.cjcat.stardust.common.actions.AlphaCurve;
	import idv.cjcat.stardust.common.actions.DeathLife;
	import idv.cjcat.stardust.common.actions.ScaleCurve;
	import idv.cjcat.stardust.common.clocks.Clock;
	import idv.cjcat.stardust.common.clocks.ImpulseClock;
	import idv.cjcat.stardust.common.clocks.SteadyClock;
	import idv.cjcat.stardust.common.initializers.Life;
	import idv.cjcat.stardust.common.initializers.Scale;
	import idv.cjcat.stardust.common.math.UniformRandom;
	import idv.cjcat.stardust.twoD.actions.Damping;
	import idv.cjcat.stardust.twoD.actions.Move;
	import idv.cjcat.stardust.twoD.emitters.Emitter2D;
	import idv.cjcat.stardust.twoD.initializers.DisplayObjectClass;
	import idv.cjcat.stardust.twoD.initializers.Position;
	import idv.cjcat.stardust.twoD.initializers.Velocity;
	import idv.cjcat.stardust.twoD.zones.CircleZone;
	import idv.cjcat.stardust.twoD.zones.Zone;
	
	/**
	 * ...
	 * @author etrex
	 */
	public class CircleEmitter extends Emitter2D 
	{
		
		public function CircleEmitter(displayObjectClass:DisplayObjectClass, number:int) 
		{
			var clock:ImpulseClock = new ImpulseClock(number);
			super(clock);
			
			addInitializer(displayObjectClass);
			addInitializer(new Position(new CircleZone(0, 0, 150)));
			addInitializer(new Velocity(new CircleZone(0, 0, 10)));
			addInitializer(new Scale(new UniformRandom(1, 0.5)));
			addInitializer(new Life(new UniformRandom(100, 20)));
			
			addAction(new Age());
			addAction(new Move());
			addAction(new DeathLife());
			//addAction(new AlphaCurve(0, 50)); 
			addAction(new ScaleCurve(0,20));
			addAction(new Damping(0.1));
			
			clock.impulse();
		}
		
	}

}