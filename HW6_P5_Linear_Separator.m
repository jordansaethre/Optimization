% simple linear separator

% data generation
rand('seed',314)
x = rand(40,1);  y = rand(40,1);
class = [2*x < y + 0.5] +1
A1 = [x(find(class == 1)), y(find(class==1))];
A2 = [x(find(class == 2)), y(find(class==2))];

% plot classes 1 and 2
figure(1); hold on;
plot(A1(:,1), A1(:,2), '*', 'MarkerSize', 6);
plot(A2(:,1), A2(:,2), 'd', 'MarkerSize', 6);

% solve the qp
cvx_begin
    variables w(2) b(1)
    A1*w - b >= 1;
    A2*w- b <= -1;
    minimize(norm(w));
cvx_end

% plot the solution
t_min = min([A1(1,:),A2(1,:)]);
t_max = max([A1(1,:),A2(1,:)]);
t = linspace(t_min-1,t_max+1,100);
p = -w(1)*t/w(2) + b/w(2);
plot(t,p, '-r');
axis equal
title('Simple Linear Separator');
