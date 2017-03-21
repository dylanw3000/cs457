surface
ovals( float
		Diam = 0.10, // dot diameter
		Ad = 0.025,
		Bd = 0.10,
		Ks = 0.5,
		Kd = 0.5,
		Ka = .1,
		roughness = 0.1;
	color specularColor = color( 1, 1, 1 )
)

{
	float up = 2. * u;
	float vp = v;
	float numinu = floor( up / Ad );
	float numinv = floor( vp / Bd );
	color dotColor = Cs;
	Oi = .7;
	if( mod( numinu+numinv, 2 ) == 0 )
	{
		float uc = numinu*Ad + Ad/2.;
		float vc = numinv*Bd + Bd/2.;
		up = (up - uc)/Ad/2;
		vp = (vp - vc)/Bd/2;
		float d = up*up + vp*vp;

		if(d < .05)
		{
			dotColor = color( abs(sin(vp*30))*.8, .5+sin(vp*30)/2, cos(vp*30) ); // beaver orange?
			Oi = 1.;
		}
	}
	varying vector Nf = faceforward( normalize( N ), I );
	vector V = normalize( -I );
	//Oi = 1.;
	Ci = Oi * ( dotColor * ( Ka * ambient() + Kd * diffuse(Nf) ) +
				specularColor * Ks * specular( Nf, V, roughness ) );
}