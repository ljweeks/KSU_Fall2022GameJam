shader_type canvas_item;

uniform float heat: hint_range(-1.0, 1.0) = 1;
uniform vec4 heat_color: hint_color = vec4(1.0);
uniform vec4 cold_color: hint_color = vec4(1.0);
uniform float heat_multiplier = 1.0;

void fragment()
{
	float speed = clamp(heat, 0.0, 1.0) * 30.0;
	float amount = clamp(heat, 0.0, 1.0)/6000.0 * heat_multiplier;
	float flash_modifier = abs(heat) * (sin(TIME * 5.0)/4.0 + 0.5);
	
	float x = sin((TIME + UV.y) * speed);
	vec2 grid_uv = UV + vec2(x * amount, 0.0);
	
	vec4 text = texture(TEXTURE, grid_uv);
	
	if (speed > 0.0)
		text.rgb = mix(text.rgb, heat_color.rgb, flash_modifier);
	else if (heat < 0.0)
		text.rgb = mix(text.rgb, cold_color.rgb, flash_modifier);
	
	if (grid_uv.x < 0.0 || grid_uv.x > 1.0) COLOR = vec4(0, 0, 0, 0);
	else COLOR = text;
}