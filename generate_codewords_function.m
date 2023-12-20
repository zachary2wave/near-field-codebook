
function w = generate_codewords_function(arvm, arvs)
global N
Cs=1e-4;
itern = 10;
SizeA = size(arvm);

% 
cvx_begin quiet 
cvx_solver Mosek
    variable w(N) complex;
    variable delta1;
    variable delta2
    minimize( delta1+ delta2);
    subject to
    norm(w'*arvm - 1,inf) <= delta1;   
    norm(w'*arvs, 2)/size(arvs,2) <= delta2;% norm(w'*arvm,inf)
    norm(w)<=Cs;
cvx_end

for idx=1:itern
    
    %计算期望响应
    %计算期望响应
    dres=w'*arvm;
    %取出相位
    resp=phase(dres);
    %构造新的期望响应
    resn=exp(sqrt(-1)*resp);

    %应用CVX-Tool进行波束设计
    cvx_begin quiet 
    cvx_solver Mosek
        variable w(N) complex;
        variable delta1;
        variable delta2
        minimize( delta1+ delta2);

        subject to
        norm(w'*arvm - resn,inf) <= delta1;   
        norm(w'*arvs, 2)/size(arvs,2) <= delta2;% norm(w'*arvm,inf)
        norm(w)<=Cs;
    cvx_end

% min_mainlobe = min(abs(w'*arvm))
% max_sodelobe = max(abs(w'*arvs))

end
EPS_1_1=cvx_optval;
% disp(['start:',num2str(initial),'end:',num2str(EPS_1_1)]);



end