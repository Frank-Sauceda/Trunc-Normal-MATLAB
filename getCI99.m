function ci99 = GetCI99( data )

mu = median( data );
sigma = std( data );
fprintf( 1, 'initial sigma = %.1f\n', sigma );
sigma = var_truncNormal( mu-3000, mu+3000, mu, sigma, data );
fprintf( 1, 'updated sigma = %.1f\n', sigma );
sigma = var_truncNormal( mu-3000, mu+3000, mu, sigma, data );
fprintf( 1, 'updated sigma = %.1f\n', sigma );

ci99 = 2*mu-norminv( 0.01, mu, sigma );

figure( 'visible', 'off' );
hist( data, 5000:200:20000 );
axis( [5000 20000 0 180] );

hold;
[n2, xx] = ksdensity( data, 'npoints', 100 );
plot( xx, n2*length(data)*200, 'r' );

hdl = plot( xx, normpdf( xx, mu, sigma )*length(data)*200, 'k' );
set( hdl, 'linewidth', 2 );

line( [ci99 ci99], [0 180] );

print( '-dpdf', 'testFigure' );
close;

return;