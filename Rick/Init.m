function [ constants,params,net ] = Init( image,n )
%INIT 
%   n
constants = Init_constants(image);
params = Init_params(image,n);
net = Init_net(image,n);


end

function [ constants ] = Init_constants(image)
%INIT 
%   P,F,y
%   struct constants
if size(image,1)~=size(image,2)
    return
end
constants = struct;
vec_len = size(image,1)^2;
constants.P = eye(vec_len);
constants.F = dftmtx(vec_len);
x = reshape(image,[],1);
constants.y =  constants.P * constants.F * double(x);
end

function [ params ] = Init_params(image,n)
%INIT 
%   q,D,H,rho,eta
%  struct params

if size(image,1)~=size(image,2)
    return
end
params = struct;
vec_len = size(image,1)^2;
lambda = 0.01;

params.q = cell(n,1);
params.D = cell(n,1);
params.H = cell(n,1);
params.rho = cell(n,1);
params.eta = cell(n,1);

for i = 1:n
   params.rho(i,1) = {0.01};
   params.q(i,1) = {sft_threshold_func(10,lambda,params.rho{i,1})};
   params.D(i,1) = {dctmtx(vec_len)};
   params.H(i,1) = {dctmtx(vec_len)};
   params.eta(i,1) = {0.01};
end
end

function [ net ] = Init_net(image,n)
vec_len = size(image,1)^2;
net = struct;

net.beta = cell(n,1);
net.c = cell(n,1);
net.z = cell(n,1);
net.x = cell(n,1);
for i = 1:n
    net.beta(i,1) = {zeros(vec_len,1)};
    net.c(i,1) = {zeros(vec_len,1)};
    net.z(i,1) = {zeros(vec_len,1)};
    net.x = reshape(image,[],1);
end

end