
#version 140

precision highp float;
varying float alphascale;


in vec4 color;
out vec4 output_color;

void main(void)
{

    output_color = color* vec4 ( 1.0, 1.0, 1.0, 0.0);
}



