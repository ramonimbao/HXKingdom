package ;

import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.FlxGame;

class CameraTarget extends FlxObject
{
	public var lead:Float;
	public var speed:FlxPoint;
	public var maxSpeed:FlxPoint;
	public var offset:FlxPoint;

	private var _target:FlxSprite;
	private var _targetX:Float;
	private var _targetY:Float;


	public function new()
	{
		lead = 48;

		super(0, 0, 1, 1);

		speed = new FlxPoint(0.1, 0.1);
		maxSpeed = new FlxPoint(20, 20);
		offset = new FlxPoint(0, 0);
	}

	public var target(get, set):FlxSprite;

	public function set_target(object:FlxSprite):FlxSprite
	{
		_target = object;
		return null;
	}

	public function get_target():FlxSprite
	{
		return _target;
	}

	/**
	* Snap to location to target immediately, i.e. no tweening
	*/

	public function snap():Void
	{
		x = _target.x + _target.width / 2 + offset.x;
		y = _target.y + _target.height / 2 + offset.y;
	}

	override public function update(elapsed):Void
	{
		if (_target == null)
			return;
		// Basic target position
		_targetX = _target.x + _target.width / 2 + offset.x;
		_targetY = _target.y + _target.height / 2 + offset.y;
		// Incorporate the lead
		if (_target.facing == FlxObject.RIGHT)
		{
			_targetX += lead;
		}
		else if (_target.facing == FlxObject.LEFT)
		{
			_targetX -= lead;
		}
		else if (_target.facing == FlxObject.UP)
		{
			_targetY -= lead;
		}
		else if (target.facing == FlxObject.DOWN)
		{
			_targetY += lead;
		}

		// Compute relative movement
		_targetX = (_targetX - x) * speed.x;
		_targetY = (_targetX - y) * speed.y;

		// Cap the speeds
		if (_targetX >= 1.0)
		{
			x += Math.min(maxSpeed.x, _targetX);
		}
		else if (_targetX <= -1.0)
		{
			x += Math.max( -maxSpeed.x, _targetX);
		}
		if (_targetY >= 1.0)
		{
			y += Math.min(maxSpeed.y, _targetY);
		}
		else if (_targetY <= 1.0)
		{
			y += Math.max( -maxSpeed.y, _targetY);
		}
	}

	override public function draw():Void
	{
	}

}
