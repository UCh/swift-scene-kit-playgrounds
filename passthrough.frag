//precision mediump float;
//precision lowp int;

//uniform sampler2D    u_maps[2];

//varying vec2        v_texture;

void main()
{
    // Here we set the diffuse color to the fragment.
//    gl_FragColor = texture2D(u_maps[0], v_texture);
    
    // Now we use the second texture to create an ambient color.
    // Ambient color doesn't affect the alpha channel and changes
    // less than half the natural color of the fragment.
//    gl_FragColor.rgb += texture2D(u_maps[1], v_texture).rgb * .4;
    gl_FragColor.rgba = vec4(1.0,0.0,0.0,1.0);
}