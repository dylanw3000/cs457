surface
ovals( float
		Diam = 0.10, // dot diameter
		Ad = .025,
		Bd = .05,
		Ks = 0.5,
		Kd = 0.5,
		Ka = .1,
		roughness = 0.1,
		NoiseAmp = 1.00,       // noise amplitude
        DispAmp = 0.10;          // displacement amplitude
	color specularColor = color( 1, 1, 1 )
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
	
	float Ar = Ad/2;
	float Br = Bd/2;
	
	float up = 2. * u;
	float vp = v;
	
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


	float d = (du/Ar)*(du/Ar)+(dv/Br)*(dv/Br);
	color TheColor = Cs;
	
	//float disp = 1 - d * DispAmp;
	
	if( d <= 1. )
	{
		TheColor = color( 1., .5, 0. );
		//disp = 1 - d * NoiseAmp;
	}
	
	varying vector Nf = faceforward( normalize( N ), I );
	vector V = normalize( -I );
	Ci = Oi * ( TheColor * ( Ka * ambient() + Kd * diffuse(Nf) ) +
				specularColor * Ks * specular( Nf, V, roughness ) );
	
}