function ci99 = GetCI99( data )

mu = median( data );
sigma = std( data );
fprintf( 1, 'initial sigma = %.1f\n', sigma );
sigma = var_truncNormal( mu-3000, mu+3000, mu, sigma, data );
fprintf( 1, 'updated sigma = %.1f\n', sigma );
sigma = var_truncNormal( mu-3000, mu+3000, mu, sigma, data );
fprintf( 1, 'updated sigma = %.1f\n', sigma );

ci99 = 2*mu-norminv( 0.01, mu, sigma );

step = 1000;
figure( 'visible', 'on' );
hist( data, 5000:step:40000 );
[nh, xi] = hist( data, 5000:step:40000);

hold;
[n2, xx] = ksdensity( data, 'npoints', 100 );
plot( xx, n2*length(data)*step, 'r' );

hdl = plot( xx, normpdf( xx, mu, sigma )*length(data)*step, 'k' );
set( hdl, 'linewidth', 2 );

line( [ci99 ci99], [0 ceil( max(nh))+10] );
axis( [5000 40000 0 ceil( max(normpdf( xx, mu, sigma )*length(data)*step))+10] );

hold;

print( '-dpdf', 'testFigure' );

hold;


return;