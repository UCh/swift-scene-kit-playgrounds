//precision mediump float;
//precision lowp int;

varying vec4 v_color;

void main()
{
    gl_FragColor.rgba = v_color; //vec4(1.0,0.0,0.0,1.0);
}