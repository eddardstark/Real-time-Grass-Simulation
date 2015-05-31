// Perspective correction demonstration
// Vertex Shader
// Graham Sellers
// OpenGL SuperBible
#version 140

precision highp float;

// Incoming per vertex position and texture coordinate
in vec4 vVertex;
in vec4 Vertexd;
// Output varyings
out vec4 color;

uniform mat4 mvpMatrix;
uniform float time;
uniform vec3 eyepos;
uniform vec3 hover1;
uniform vec3 hover2;
uniform vec4 wind;
uniform float heightscale;
uniform sampler2D length_texture;
//uniform sampler2D orientation_texture;
uniform sampler1D grasspalette_texture;
uniform sampler2D grasscolor_texture;
uniform sampler2D bend_texture;

varying vec4 pos;
varying float alphascale;


int random(int seed, int iterations)
{
    int value = seed;
    int n;

    for (n = 0; n < iterations; n++) {
        value = ((value >> 7) ^ (value << 9)) * 15485863;
    }

    return value;
}

vec4 random_vector(int seed)
{
    int r = random(gl_InstanceID, 4);
    int g = random(r, 2);
    int b = random(g, 2);
    int a = random(b, 2);

    return vec4(float(r & 0x3FF) / 1024.0,
                float(g & 0x3FF) / 1024.0,
                float(b & 0x3FF) / 1024.0,
                float(a & 0x3FF) / 1024.0);
}

float	d          = distance ( vVertex.xyz, eyepos );
//alphaScale = 0.9 / ( 1.0 + d ) + 0.1;
//vec4 wind;

float weight1,weight2;
float dist;

float wind_velocity ;
float bottomSegmentBend = .5,bottomSegmentWeight =0.2 , bottomSegmentGreen = 0.3; 
float midSegmentBend = 0.8 ,midSegmentWeight =0.3 , midSegmentGreen = .8; 
float topSegmentBend = 1.0 ,topSegmentWeight = 0.5, topSegmentGreen = 1.2; 
vec4 v1,v2,weightdir1,weightdir2,position;

void main(void)
{

    //Generating grass-map using gl_InstanceID
    int number1 = random(gl_InstanceID, 3);				//randomize
    int number2 = random(number1, 2);
    vec4 offset = vec4(float(gl_InstanceID >> 8) - 128.0,		//offset x,z
                       0.0f,
                       float(gl_InstanceID & 0xFF) - 128.0,
                       0.0f);
    offset += vec4(float(number1 & 0xFF) / 128.0,			
                   0.0f,
                   float(number2 & 0xFF) / 128.0,
                   0.0f);
    vec2 texcoord = offset.xz / 256.0 + vec2(0.5);

    //Computing Wind velocity and direction
    wind_velocity = 0.3; //-float(random(number2, 7) & 0x3FF) / 1024.0;
    //wind =  vec4(-1.0,0.0,1.0,0.0) ;

    //Calculating a hover simulation
    v1 = vec4(hover1.x,0.0,hover1.z,0.0);
    dist = sqrt (distance(vec4(offset.x,0.0,offset.z,0.0),v1));
    weight1 =1.8/dist;

    v2 = vec4(hover2.x,0.0,hover2.z,0.0);
    dist = sqrt (distance(vec4(offset.x,0.0,offset.z,0.0),v2));
    weight2 =1.8/dist;
    
    //Distibuting weight and determing direction.
    weightdir1 = vec4(offset.x,0.0,offset.z,0.0) - v1;
    weightdir1 = normalize(weightdir1);
    weightdir2 = vec4(offset.x,0.0,offset.z,0.0) - v2;
    weightdir2 = normalize(weightdir2);
    weightdir1.z *= 10 ;weightdir2.z *= 10 ;
 
    //height =  texture(bend_texture, texcoord).r;
    float bend_factor = float(random(number2, 7) & 0x3FF) / 1024.0;
    //float angle; mat4 rot ; vec4 position ;
    //angle = texture(orientation_texture, texcoord).r * 2.0 * 3.141592;

    //Handding each segment
  bend_factor *= 1.5;
  //Base
  if(vVertex.y == 0.0f )
     { 
     position = vVertex + offset ;
     //position = (rot * (vVertex + vec4(0.0,height, bend_amount * bend_factor, 0.0))) + offset;
    color = vec4(random_vector(gl_InstanceID).xyz * vec3(0.1, bottomSegmentGreen/2, 0.1), 1.0);
     } 
  else if(vVertex.y < 3.0f )
     { 
     position = vVertex + bottomSegmentBend/30* sin(time)/10+ offset + bottomSegmentWeight* weightdir1*weight1  + bottomSegmentWeight* weightdir2*weight2;
     //position = (rot * (vVertex + vec4(0.0,height, bend_amount * bend_factor, 0.0))) + offset;
    color = vec4(random_vector(gl_InstanceID).xyz * vec3(0.1, bottomSegmentGreen, 0.1), 1.0);
    position -= vec4(wind.x,0.0f,wind.z,0.0)*bend_factor/4;  
     } 
  else  if(vVertex.y < 5.0f )
     { 
     position = vVertex + midSegmentBend/30* sin(time)/10+ offset  + midSegmentWeight *weightdir1*weight1 + midSegmentWeight *weightdir2*weight2;
     color = vec4(random_vector(gl_InstanceID).xyz * vec3(0.1, midSegmentGreen, 0.1), 1.0);
     position -= vec4(wind.x,0.0f,wind.z,0.0)*bend_factor/3;  
     }
  else
     { 
      position = vVertex +  topSegmentBend/30 *  sin(time)/10+ offset + topSegmentWeight * weightdir1*weight1  + topSegmentWeight * weightdir2*weight2;
      color = vec4(random_vector(gl_InstanceID).xyz * vec3(0.1, topSegmentGreen, 0.1), 1.0);
      position -= vec4(wind.x,0.0f,wind.z,0.0)*bend_factor/2;   
     }

    color+=texture(grasspalette_texture, texture(grasscolor_texture, texcoord).r)/3 ;
    //color*= vec4 ( 1.0, 1.0, 1.0, alphaScale*10000 );
    position *= vec4(1.0, texture(length_texture, texcoord).r * 0.6 + 0.4, 1.0, 1.0);
    position.y *= heightscale;
    pos = gl_Position =  mvpMatrix * position; 
    
    // color = texture(orientation_texture, texcoord);
    //color = texture(grasspalette_texture, texture(grasscolor_texture, texcoord).r) +vec4(random_vector(gl_InstanceID).xyz * vec3(0.1, 0.5, 0.1), 1.0);


}





