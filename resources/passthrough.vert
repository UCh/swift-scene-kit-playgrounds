//precision mediump float;
//precision lowp int;

uniform mat4        u_mvpMatrix;
attribute vec4        a_vertex;

varying vec4 v_color;

void main()
{
    v_color = a_vertex;
    gl_Position = u_mvpMatrix * a_vertex;
}