displacement
ovalnoised( float
                Ad = 0.10,              // u diameter
                Bd = 0.10,              // v diameter
                NoiseAmp = 0.00,        // noise amplitude
                DispAmp = 0.10          // displacement amplitude
)
{
	
	point PP = point "shader" P;
	float magnitude = .5;
	float size = 1.;
	float i;
	for( i = 0.; i < 6.0; i += 1.0 )
	{
		magnitude += ( noise( size * PP ) - 0.5 ) / size;
		size *= 2.0;
	}

	//. . .
	
	
	
		float up = 2. * u;
		float vp = v;
		
		float Ar = Ad/2;
	float Br = Bd/2;

        float numinu = floor( up / Ad );
        float numinv = floor( vp / Bd );

        float uc = numinu * Ad  +  Ar;  // center of this box
        float vc = numinv * Bd  +  Br;
        float du = up - uc;
        float dv = vp - vc;
        float oldrad = sqrt( du*du + dv*dv );
        float newrad = magnitude+oldrad;
		float factor = newrad/oldrad;
        du *= factor;
        dv *= factor;

        float d = (du/(Ad/2))*(du/(Ad/2))+(dv/(Bd/2))*(dv/(Bd/2));

		float Height = 1.0;
		float t = smoothstep( 0., 0.8, (1-d) );	   // 0. if dist <= 0., 1. if dist >= Ramp
		float TheHeight = t*Height;			   // apply the blending
		
        float disp = t*0.16;
	if( disp != 0. )
	{
		normal n = normalize(N);
        	//P = P + disp * n;
        	//N = calculatenormal(P);
			N = calculatenormal( P + disp * n );
	}
}