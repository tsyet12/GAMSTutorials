function s = barrelsurface(r,v)
%
% returns the surface of a barrel for given
% volume (v) and radius (r)
%
h = v/(pi*r*r);
s = 2*pi*(r*r + r*h);
