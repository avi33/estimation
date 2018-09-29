clc; close all; clear
%randomize numbers between [a,b]
% beta = 2; N = 10000;
% 
% x = rand(N, 1) * beta;
% 
% MeanEstimator = mean(x);
% MVUEstimator = (N+1)*max(x) / (2*N);

beta=(linspace(1,10,10))';
N_betas=size(beta,1);
N=1000;
MeanEstimator=zeros(N,N_betas);
MVUEstimator=zeros(N,N_betas);
MLEstimator=zeros(N,N_betas);
V_MeanEstimator=zeros(N_betas,1);
V_MVUEstimator=zeros(N_betas,1);
V_MLEstimator=zeros(N_betas,1);
for k=1:N_betas
   for n=1:N
        x=rand(N,1)*beta(k,1);
        MeanEstimator(n,k)=mean(x,1);        
        MVUEstimator(n,k)=(N+1)*max(x,[],1)/(2*N);
        MLEstimator(n,k)=max(x,[],1);
    end
    V_MeanEstimator(k,1)=var(MeanEstimator(:,k));
    V_MVUEstimator(k,1)=var(MVUEstimator(:,k));
    V_MLEstimator(k,1)=var(MLEstimator(:,k));
end
figure, hold on;
plot(beta,10*log10(V_MeanEstimator));
plot(beta,10*log10(V_MVUEstimator),'r.-');
plot(beta,10*log10(V_MLEstimator),'k--');
xlabel('beta'); ylabel('var[dB]');
hold off;
legend('mean','mvu','ml','location','best');
grid;