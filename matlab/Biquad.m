%% Transfer function and Pole Zero plots for Biquad filter

%% Variables
 Gl1 = 4320/(4320+4990);
 Gb1 = 4990/255000;
 Gi1 = 4990/264000;

 Gl2 = 8660/(8660+4990);
 Gb2 = 4990/255000;
 Gi2 = 4990/115000;


 H1 = tf([-Gi1 0],[1 Gb1 Gl1]);

 H2 = tf([-Gi2],[1 Gb2 Gl2]);

 H = H1*H2;

 figure(1)

 bp = bodeplot(H1,H2,H);
 bp.FrequencyUnit = "Hz";
 grid on
 figure(2)
 rlocus(H)