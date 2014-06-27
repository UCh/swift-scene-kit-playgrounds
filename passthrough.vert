//precision mediump float;
//precision lowp int;

uniform mat4        u_mvpMatrix;

attribute vec4        a_vertex;
//attribute vec2        a_texture;

//varying vec2        v_texture;
//varying vec4        v_color;
varying vec4 v_color;

void main()
{
    // Pass the texture coordinate attribute to a varying.
//    v_texture = a_texture;
    
    // Here we set the final position to this vertex.
    v_color = a_vertex;
    gl_Position = u_mvpMatrix * a_vertex;

//    v_color = vec4(1.0,0.0,0.0,1.0);
}

