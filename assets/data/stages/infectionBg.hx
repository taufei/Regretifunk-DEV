import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

var egg:Float;
var shader1 = new CustomShader("fisheye");
var shader2 = new CustomShader("bloom");

function create(){
    var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0xFF000000, 0xFFeb34e1));
    grid.velocity.set(180, 180);
    grid.scrollFactor.set(0,0);
}