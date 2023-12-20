
function w = generate_LastLayercodewords_functionV0602(w, arvm1, arvm2)
global N
itern = 10;
cs = 1; 

winit = w;
for idx=1:itern

    %计算期望响应
    dres=w'*arvm1;
    %取出相位
    resp=phase(dres);
    %构造新的期望响应
    resn=sqrt(N)*exp(sqrt(-1)*resp);
    %应用CVX-Tool进行波束设计
    cvx_begin quiet
    cvx_solver Mosek
        variable w(N) complex;
        variable delta1;
        variable delta2;
        variable delta3;
%         minimize( delta1 + delta3  );
        minimize( delta1 );
        subject to
            norm(w'*arvm1 - resn, inf) <= delta1;
%             norm(w'*arvm2 - resn, 2)/size(arvm2,2) <= delta1;
%             norm(w'*arvs,  2)/sizeARVS(2)  <= delta2;            
%             norm(w'*arvss, 2)/sizeARVSS(2) <= delta3;
            
            
            norm(w, 2)<=cs;
           
    cvx_end


    
end

end




