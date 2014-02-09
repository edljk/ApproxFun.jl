export pdesolve

toarray{T<:RowOperator}(B::Array{T},n)=Float64[    B[k][j] for  k=1:length(B),j=1:n];
toarray{T<:IFun}(B::Array{T},n)=Float64[    j<=length(B[k])?B[k].coefficients[j]:0 for  k=1:length(B),j=1:n];


function nonsingular_permute(B)
    K = size(B,1)
    
    k = 1
    
    while rank(B[:,k:K+k-1]) < K
        k= k+1
    end
    
    P = eye(size(B,2))
    
    P = P[:,[k:K+k-1,1:k-1,K+k:end]]
end


function regularize_bcs(B, G, L, M)
    P = nonsingular_permute(B)
    
    B = B*P
    
    L = L*P
    M = M*P
    
    Q,R = qr(B)
    Q=Q[:,1:size(B,1)]
    
    K = size(B,1)
    
    G = inv(R[:,1:K])*Q*G
    R = inv(R[:,1:K])*R
    
    R,G, L, M, P
end


function reduce_dofs( R,G, Mx, My, F )
    GM = G*My.'
    for k = 1:size(R,1)
            F = F - Mx[:,k]*GM[k,:]
            Mx = Mx - Mx[:,k]*R[k,:]
    end
        
    Mx, F
end



function lyapdiag!(A::Vector,B::Vector,F)
    for i=1:size(F,1),j=1:size(F,2)
        F[i,j] *= 1./(A[i]+B[j])
    end
    
    F
end

function lyap(A,B,F)
  Λ,V=eig(A)
  Ω,W=eig(B)
    
    F=inv(V)*F*W
    
    Y=lyapdiag!(Λ,Ω,F)
    
    V*Y*inv(W)
end



constrained_lyap(B,L,M,F)=constrained_lyap(B[1,1],B[1,2],B[2,1],B[2,2],L[1],L[2],M[1],M[2],F)

function constrained_lyap(Bx,Gx,By,Gy,Lx,Ly,Mx,My,F)
     Rx,Gx,Lx,Mx,Px=regularize_bcs(Bx,Gx,Lx,Mx);
    Ry,Gy,Ly,My,Py=regularize_bcs(By,Gy,Ly,My);

    Lx,F = reduce_dofs(Rx,Gx,Lx,Ly,F);
    Mx,F = reduce_dofs(Rx,Gx,Mx,My,F);
    Ly,F = reduce_dofs(Rx,Gx,Ly,Lx,F.');    F = F.';
    My,F = reduce_dofs(Rx,Gx,My,Mx,F.');    F = F.';       

    Kx = size(Bx,1); Ky = size(By,1);
    A=Lx[:,Kx+1:end];B=Ly[:,Ky+1:end];
    C=Mx[:,Kx+1:end];D=My[:,Ky+1:end];

    X22=lyap(C\A,(B\D).',inv(C)*F*inv(B).');


    X12 = Gx[:,Ky+1:end] - Rx[:,Kx+1:end]*X22;
    X21 = Gy[:,Kx+1:end].' - X22*Ry[:,Ky+1:end].';
    X11 = Gx[:,1:Ky] - Rx[:,Kx+1:end]*X21;
    X11a= Gy[:,1:Kx].' - X12*Ry[:,Ky+1:end].';
    
    
    tol = 1e-13;
    bcerr = norm(X11 - X11a);

    if bcerr>tol
       warn("Boundary conditions differ by " * string(bcerr));
    end
    

    X = [X11 X12; X21 X22];

    X = Px*X*Py.';
    
end




function pdesolve(Bxin,Byin,Lin,Min,Fin,n)

    Xop=promotespaces([Lin[1],Min[1]])
    Yop=promotespaces([Lin[2],Min[2]])
    
    Xsp=rangespace(Xop[1])
    Ysp=rangespace(Yop[1])    
    
    Bx=toarray(Bxin[1],n);By=toarray(Byin[1],n)
    Gx=toarray(Bxin[2],n);Gy=toarray(Byin[2],n)    
    
    Lx=Xop[1][1:n-2,1:n];Ly=Yop[1][1:n-2,1:n]
    Mx=Xop[2][1:n-2,1:n];My=Yop[2][1:n-2,1:n]    
    
    if typeof(Fin)<:Fun2D
        F=pad(coefficients(Fin,Xsp,Ysp),n-2,n-2)
    elseif typeof(Fin) <:Number
        F=zeros(n-2,n-2)
        F[1,1]=Fin
    end
    
    X=constrained_lyap({Bx Gx; By Gy},{Lx,Ly},{Mx,My},F)

    U,Σ,V=svd(X)


    A=IFun[IFun(U[:,k].*sqrt(Σ[k])) for k=1:size(X,2)]
    B=IFun[IFun(V[:,k].*sqrt(Σ[k])) for k=1:size(X,1)]

    Fun2D(A,B)
end

