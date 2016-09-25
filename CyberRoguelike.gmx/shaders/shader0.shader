//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
uniform vec2 in_pos;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_pos;
varying vec3 v_pixelPos;


void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;

    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_pos = in_pos;
    v_pixelPos = in_Position;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_pos;
varying vec3 v_pixelPos;

void main()
{
    float range = 256.0;
    float dist = distance(v_pixelPos.xy, v_pos);
    float light = mix(1.0, 0.2, clamp(dist,0.0,range)/range);
    vec3 finalColor = light * texture2D( gm_BaseTexture, v_vTexcoord ).rgb;
    gl_FragColor = vec4(finalColor, 1);
}

