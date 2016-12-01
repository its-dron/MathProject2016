pts = rand(3,2);

figure;
scatter(pts(:,1),pts(:,2));
axis equal
hold on

p1 = pts(1,:);
p2 = pts(2,:);
p3 = pts(3,:);

[ center, radius ] = circle3pt( p1, p2, p3 );
viscircles(center,radius)