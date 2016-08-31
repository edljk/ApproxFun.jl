using ApproxFun, Compat, Base.Test
    import Compat: view
## Check operators


S=ChebyshevDirichlet()
B=Dirichlet(S^2)
f = Fun((x,y)->exp(x)*sin(y),S^2)
@test norm((Fun((x,y)->exp(x)*sin(y),∂(domain(S^2))) - B*f).coefficients)



S=JacobiWeight(1.,1.,Jacobi(1.,1.))
Δ=Laplacian(S^2)





(Δ*u+2π^2*u).coefficients |>norm



u=chop(Fun((x,y)->sin(π*x)*sin(π*y),S^2),1000eps())
f=2π^2*u


S=JacobiWeight(1.,1.,Jacobi(1.,1.))
    Δ=Laplacian(S^2)
    QR=qrfact(Δ)
    @time linsolve(QR,f;tolerance=10000eps())  # 0.35s
    @time v=linsolve(QR,f;tolerance=10000eps())  # 0.003s




ncoefficients(v)



QR=qrfact(Δ)
    col=319
    @profile ApproxFun.resizedata!(QR.R,:,col+100)  # double the last rows


Profile.print()
Profile.clear()
@time Δ[1:(col+100),1:(col+100)]-QR.R.data[1:(col+100),1:(col+100)]|>norm


Profile.clear()


(v+u).coefficients |>norm

/10)
ncoefficients(u)

KO=Δ.op.ops[1].ops[1].op

M=ApproxFun.BandedBlockBandedMatrix(view(KO,1:4,1:4))
@test norm(ApproxFun.BandedBlockBandedMatrix(view(KO,1:4,2:4))-M[:,2:4]) < 10eps()
@test norm(ApproxFun.BandedBlockBandedMatrix(view(KO,1:4,3:4))-M[:,3:4]) < 10eps()

M=ApproxFun.BandedBlockBandedMatrix(view(KO,1:112,1:112))
@test norm(ApproxFun.BandedBlockBandedMatrix(view(KO,1:112,112:112))-M[:,112]) < 10eps()


M=ApproxFun.BandedBlockBandedMatrix(view(Δ,1:4,1:4))
@test norm(ApproxFun.BandedBlockBandedMatrix(view(Δ,1:4,2:4))-M[:,2:4]) < 10eps()
@test norm(ApproxFun.BandedBlockBandedMatrix(view(Δ,1:4,3:4))-M[:,3:4]) < 10eps()

M=ApproxFun.BandedBlockBandedMatrix(view(Δ,1:112,1:112))
@test norm(ApproxFun.BandedBlockBandedMatrix(view(Δ,1:112,112:112))-M[:,112]) < 10eps()

ApproxFun.BandedBlockBandedMatrix(view(Δ.op.ops[1],1:112,112:112))+ApproxFun.BandedBlockBandedMatrix(view(Δ.op.ops[2],1:112,112:112))



QR=qrfact(Δ)
    QR[:Q]'*[1.0]




@time ApproxFun.resizedata!(QR,:,11)
     @time ApproxFun.resizedata!(QR,:,78)
     #@which ApproxFun.resizedata!(QR,:,278)
     col=278
     if col ≤ QR.ncols
         return QR
     end

     MO=QR.R
     W=QR.H

     @which resizedata!(MO,:,col+100)  # double the last rows







S=view(KO,1:112,112:112)


kr,jr=parentindexes(S)
KO=parent(S)
l,u=blockbandinds(KO)
λ,μ=subblockbandinds(KO)

rt=rangetensorizer(KO)
dt=domaintensorizer(KO)
ret=bbbzeros(S)

J=block(dt,jr[1])
K=block(rt,kr[1])
bl_sh = J-K

ret=bbbzeros(S)


A,B=KO.ops
K=block(rt,kr[end]);J=block(dt,jr[end])
AA=A[1:K,1:J]
BB=B[1:K,1:J]


Jsh=block(dt,jr[1])-1
Ksh=block(rt,kr[1])-1


for J=1:blocksize(ret,2)
    # only first block can be shifted inside block
    jsh=J==1?jr[1]-blockstart(dt,J+Jsh):0
    for K=blockcolrange(ret,J)
        Bs=viewblock(ret,K,J)
        ksh=K==1?kr[1]-blockstart(dt,K+Ksh):0
        for j=1:size(Bs,2),k=colrange(Bs,j)
            κ,ν=subblock2tensor(rt,K+Ksh,k+ksh)
            ξ,μ=subblock2tensor(dt,J+Jsh,j+jsh)
            Bs[k,j]=AA[κ,ξ]*BB[ν,μ]
        end
    end
end

ret

KO[112,112]

A,B=KO.ops
K=block(rt,kr[end]);J=block(dt,jr[end])
AA=A[1:K,1:J]
BB=B[1:K,1:J]


Jsh=block(dt,jr[1])-1
Ksh=block(rt,kr[1])-1

J=1
# only first block can be shifted inside block
jsh=J==1?jr[1]-blockstart(dt,J+Jsh):0
K=blockcolrange(ret,J)[end]
Bs=viewblock(ret,K,J)
ksh=K==1?kr[1]-blockstart(dt,K+Ksh):0
j=1
k=colrange(Bs,j)[end]
κ,ν=subblock2tensor(rt,K+Ksh,k+ksh)
ξ,μ=subblock2tensor(dt,J+Jsh,j+jsh)
Bs[k,j]=AA[κ,ξ]*BB[ν,μ]

j+jsh

viewblock(KO[1:112,1:112],K+Ksh,J+Jsh)
kr

KO[112,112]

Δ[1:120,1:112][100:112,112]

kr[end]


KO[1:120,1:112][80:120,112]

norm(Δ[1:100,1:112][:,112])


normalize!([0.,0.,0.])
norm(MO.data[:,112])

col+100

if col ≥ MO.datasize[2]
 m = MO.datasize[2]
 resizedata!(MO,:,col+100)  # double the last rows

 # apply previous Householders to new columns of R
 for J=1:QR.ncols
     wp=view(W,1:colstop(W,J),J)
     for j=m+1:MO.datasize[2]
         kr=j:j+length(wp)-1
         v=view(MO.data,kr,j)
         dt=dot(wp,v)
         Base.axpy!(-2*dt,wp,v)
     end
 end
end

MO.datasize
MO.data[:,112]|>norm

QR.H[:,112]



5

# @time ApproxFun.resizedata!(QR,:,10)
    # @time ApproxFun.resizedata!(QR,:,20)
    # @time ApproxFun.resizedata!(QR,:,100)
    # @time ApproxFun.resizedata!(QR,:,100)
    # @time ApproxFun.resizedata!(QR,:,201)
#    @time ApproxFun.resizedata!(QR,:,1642)

A,B,tolerance,maxlength=(QR[:Q],[1.0],10eps(),1000)
    length(B) > A.QR.ncols
    if length(B) > A.QR.ncols
        # upper triangularize extra columns to prepare for \
        println("$(length(B)+size(A.QR.H,1)+10)")
        resizedata!(A.QR,:,length(B)+size(A.QR.H,1)+10)
    end

    H=A.QR.H
    M=size(H,1)
    m=length(B)
    Y=pad(B,m+M+10)

    k=1
    yp=view(Y,1:length(B))
    while (k ≤ m || norm(yp) > tolerance )
        if k > maxlength
            warn("Maximum length $maxlength reached.")
            break
        end
        if k > A.QR.ncols
            println("resize $(2*(k+M))")
            # upper triangularize extra columns to prepare for \
            resizedata!(A.QR,:,2*(k+M))
            H=A.QR.H
            M=size(H,1)
        end

        if k+M-1>length(Y)
            pad!(Y,2*(k+M))
        end

        cr=colrange(H,k)
        wp=view(H,cr,k)
        yp=view(Y,k-1+(cr))

        println("$k,$(norm(wp))")

        dt=dot(wp,yp)
        Base.axpy!(-2*dt,wp,yp)
        k+=1
    end


k=584
2*(k+M)


A.QR.ncols


Y|>norm

chop(QR[:Q]'*[1.0],10eps())
ncoefficients(chop(QR[:Q]'*[1.0],100eps()))

col=201
QR.ncols

QR[:Q]'*[1.0]


col=201
if col ≤ QR.ncols
    return QR
end

MO=QR.R
W=QR.H

]
m = MO.datasize[2]
resizedata!(MO,:,col+100)  # double the last rows

# apply previous Householders to new columns of R
for J=1:QR.ncols
    print("$J,")
    wp=view(W,1:colstop(W,J),J)
    for j=m+1:MO.datasize[2]
        kr=j:j+length(wp)-1
        v=view(MO.data,kr,j)
        dt=dot(wp,v)
        Base.axpy!(-2*dt,wp,v)
    end
end



col > size(W,2)
if col > size(W,2)
    m=size(W,2)
    resize!(W.cols,2col+1)

    for j=m+1:2col
        cs=colstop(MO,j)
        W.cols[j+1]=W.cols[j] + cs-j+1
        W.m=max(W.m,cs-j+1)
    end

    resize!(W.data,W.cols[end]-1)
end


norm(W)

for k=QR.ncols+1:col
    cs = colstop(QR.R,k)
    W[1:cs-k+1,k] = view(MO.data,k:cs,k) # diagonal and below
    wp=view(W,1:cs-k+1,k)
    W[1,k]+= flipsign(norm(wp),W[1,k])
    normalize!(wp)

    # scale rows entries
    kr=k:k+length(wp)-1
    for j=k:MO.datasize[2]
        v=view(MO.data,kr,j)
        dt=dot(wp,v)
        Base.axpy!(-2*dt,wp,v)
    end
end
QR.ncols=col
QR



QR.R.data|>norm

QR.R.datasize

QR.H |>norm
@time ApproxFun.resizedata!(QR,:,100)
    ApproxFun.resizedata!(QR,:,200)



QR[:Q]'*[1.0]




QR.ncols



QR.R.datasize
## Rectangle PDE

dx=dy=Interval()
d=dx*dy
x=Fun(identity,dx);y=Fun(identity,dy)

#dirichlet(d) is u[-1,:],u[1,:],u[:,-1],u[:,1]

G=[real(exp(-1+1.0im*y));
                        real(exp(1+1im*y));
                        real(exp(x-1im));
                        real(exp(x+1im));0.];

A=[dirichlet(d);lap(d)]
u=A\G
@test_approx_eq u(.1,.2) real(exp(0.1+0.2im))


A=[dirichlet(d);lap(d)+0.0I]
u=A\G
@test_approx_eq_eps u(.1,.2) real(exp(0.1+0.2im)) 1E-11


println("    Poisson tests")

## Poisson

f=Fun((x,y)->exp(-10(x+.2)^2-20(y-.1)^2))  #default is [-1,1]^2
d=domain(f)
OS=S=schurfact([dirichlet(d);lap(d)],10)
u=OS\[zeros(∂(d));f]
@test_approx_eq u(.1,.2) -0.042393137972085826



d=PeriodicInterval()^2
f=ProductFun((x,y)->exp(-10(sin(x/2)^2+sin(y/2)^2)),d)
A=lap(d)+.1I
u=A\f
@test (lap(u)+.1u-f)|>coefficients|>norm < 1000000eps()


println("    Kron tests")

@static if is_apple()
    ## Kron

    dx=dy=Interval()
    d=dx*dy
    x=Fun(identity,dx);y=Fun(identity,dy)

    #dirichlet(d) is u[-1,:],u[1,:],u[:,-1],u[:,1]

    G=[real(exp(-1+1.0im*y));
                            real(exp(1+1im*y));
                            real(exp(x-1im));
                            real(exp(x+1im));0.];

    A=[dirichlet(d);lap(d)]

    S=schurfact(A,40)

    uex=A\G

    nx=ny=40
    K=kronfact(A,nx,ny)

    uex2=K\G

    @test (uex-uex2|>coefficients|>norm)<10000eps()



    # dirichlet bcs

    import ApproxFun.ChebyshevDirichlet

    S=ChebyshevDirichlet()⊗ChebyshevDirichlet();
    A=[dirichlet(S);lap(S)]
    nx=ny=20;
    KD=kronfact(A,nx,ny);


    #dirichlet(d) is u[-1,:],u[1,:],u[:,-1],u[:,1]
    x=Fun(identity);y=Fun(identity);
    G=[Fun(real(exp(-1+1.0im*y)),S[2]);
        Fun(real(exp(1+1im*y)),S[2]);
        Fun(real(exp(x-1im)),S[1]);
                            Fun(real(exp(x+1im)),S[1]);0.];

    uD=KD\G;

    @test_approx_eq uD(.1,.2) real(exp(.1+.2im))



    # fourth order
    dx=dy=Interval()
    d=dx*dy
    Dx=Derivative(dx);Dy=Derivative(dy)
    L=Dx^4⊗I+2*Dx^2⊗Dy^2+I⊗Dy^4

    K=kronfact([dirichlet(d);
         neumann(d);
         L],100,100)

    x=Fun(identity,dx);y=Fun(identity,dy)

    G=[real(exp(-1+1.0im*y));
                    real(exp(1+1im*y));
                    real(exp(x-1im));
                    real(exp(x+1im));
                    real(exp(-1+1.0im*y));
                    real(exp(1+1im*y));
                    -imag(exp(x-1im));
                    -imag(exp(x+1im))
       ]
    u=K\G
    @test_approx_eq u(.1,.2) real(exp(.1+.2im))


    # mixed

    K=kronfact([(ldirichlet(dx)+lneumann(dx))⊗I;
            (rdirichlet(dx)+rneumann(dx))⊗I;
            I⊗(ldirichlet(dy)+lneumann(dy));
            I⊗(rdirichlet(dy)+rneumann(dy));
            (ldirichlet(dx)-lneumann(dx))⊗I;
            (rdirichlet(dx)-rneumann(dx))⊗I;
            I⊗(ldirichlet(dy)-lneumann(dy));
            I⊗(rdirichlet(dy)-rneumann(dy));
             L],100,100)
    G=[2real(exp(-1+1.0im*y));
                    2real(exp(1+1im*y));
                    real(exp(x-1im))-imag(exp(x-1im));
                    real(exp(x+1im))-imag(exp(x+1im));
                    0;
                    0;
                    real(exp(x-1im))+imag(exp(x-1im));
                    real(exp(x+1im))+imag(exp(x+1im))
       ]
    u=K\G

    @test_approx_eq u(.1,.2) real(exp(.1+.2im))
end



## Test periodic x interval

d=PeriodicInterval()*Interval()
g=Fun(z->real(cos(z)),∂(d))  # boundary data
u=[dirichlet(d);lap(d)]\g

@test_approx_eq u(.1,.2) real(cos(.1+.2im))



dθ=PeriodicInterval(-2.,2.);dt=Interval(0,3.)
d=dθ*dt
Dθ=Derivative(d,[1,0]);Dt=Derivative(d,[0,1])
u=[I⊗ldirichlet(dt);Dt+Dθ]\Fun(θ->exp(-20θ^2),dθ)


@test_approx_eq u(.1,.2) exp(-20(0.1-0.2)^2)


println("   Domain Decompositon tests")

## Domain Decomposition
d=Interval(0,1)^2
n,m=20,80
A=discretize([dirichlet(d);lap(d)],n)
∂d=∂(d)
g=Fun(z->real(exp(z)),∂d)
f=[Fun([zeros(k-1);1.0],∂d) for k=1:m].'
U=A\f
@test_approx_eq dot(real(g.coefficients),U[1:ncoefficients(g)])(.1,.2) real(exp(.1+.2im))



Rectangle(a,b,c,d)=Interval(a,b)*Interval(c,d)
Γ=Rectangle(0,1,0,1)∪Rectangle(1,2,0,1)
Fun(identity,∂(Γ))|>values



## Small diffusoion

dx=Interval();dt=Interval(0,1.)
d=dx*dt
Dx=Derivative(d,[1,0]);Dt=Derivative(d,[0,1])
x=Fun(identity,dx)
B=0.0
C=0.0
V=B+C*x
ε=0.001
f=Fun(x->exp(-20x^2),dx)
u=[timedirichlet(d);Dt-ε*Dx^2-V*Dx]\f
@test_approx_eq u(.1,.2) 0.8148207991358946
B=0.1
C=0.2
V=B+C*x
u=[timedirichlet(d);Dt-ε*Dx^2-V*Dx]\f
@test_approx_eq u(.1,.2) 0.7311625132209619


## Schrodinger

dx=Interval(0.,1.);dt=Interval(0.0,.1)
d=dx*dt

V=Fun(x->x^2,dx)

Dt=Derivative(d,[0,1]);Dx=Derivative(d,[1,0])

ϵ=1.
u0=Fun(x->exp(-100*(x-.5)^2)*exp(-1./(5*ϵ)*log(2cosh(5*(x-.5)))),dx)
L=ϵ*Dt+(.5im*ϵ^2*Dx^2)
ny=200;u=pdesolve([timedirichlet(d);L],u0,ny)
@test_approx_eq_eps u(.2,.1) (0.2937741918470843 + 0.22130344715160255im )  0.000001



## Periodic

d=PeriodicInterval()^2
f=Fun((θ,ϕ)->exp(-10(sin(θ/2)^2+sin(ϕ/2)^2)),d)
A=lap(d)+.1I
u=A\f
@test_approx_eq u(.1,.2) u(.2,.1)


d=PeriodicInterval()*Interval()
g=Fun(z->real(cos(z)),∂(d))  # boundary data
u=[dirichlet(d);lap(d)]\g
@test_approx_eq u(.1,.2) real(cos(.1+.2im))



dθ=PeriodicInterval(-2.,2.);dt=Interval(0,3.)
d=dθ*dt
Dθ=Derivative(d,[1,0]);Dt=Derivative(d,[0,1])
u=[I⊗ldirichlet(dt);Dt+Dθ]\Fun(θ->exp(-20θ^2),dθ)

d=dt*dθ


# Check bug in cache
CO=cache(ldirichlet(dt))
ApproxFun.resizedata!(CO,:,2)
ApproxFun.resizedata!(CO,:,4)
@test_approx_eq CO*Fun(exp,dt) 1.0



Dt=Derivative(d,[1,0]);Dθ=Derivative(d,[0,1])
A=[ldirichlet(dt)⊗I;Dt+Dθ]
f=Fun(θ->exp(-20θ^2),dθ)
ut=A\f

@test_approx_eq u(.1,.2) ut(.2,.1)




# Beam

dθ=PeriodicInterval(0.0,1.0);dt=Interval(0,0.03)
d=dθ*dt
Dθ=Derivative(d,[1,0]);Dt=Derivative(d,[0,1]);

B=[I⊗ldirichlet(dt),I⊗lneumann(dt)]
u=pdesolve([B;Dt^2+Dθ^4],Fun(θ->exp(-200(θ-.5).^2),dθ),200)

@test_approx_eq_eps u(.1,.01) -0.2479768394633227  1E-8 #empirical



## Rectangle PDEs

# Screened Poisson

d=Interval()^2
u=[neumann(d);lap(d)-100.0I]\ones(∂(d))
@test_approx_eq u(.1,.9) 0.03679861429138079

# PiecewisePDE

a=Fun([1,0.5,1],[-1.,0.,0.5,1.])
s=space(a)
dt=Interval(0,2.)
Dx=Derivative(s);Dt=Derivative(dt)
Bx=[ldirichlet(s);continuity(s,0)]


# test resize bug
CO=cache(Bx[2])
ApproxFun.resizedata!(CO,:,2)
ApproxFun.resizedata!(CO,:,4)
@test_approx_eq CO.data*collect(1:4) [3.,-1.]


u=pdesolve([I⊗ldirichlet(dt);Bx⊗I;I⊗Dt+(a*Dx)⊗I],Any[Fun(x->exp(-20(x+0.5)^2),s)],200)
@test_approx_eq_eps u(-.1,.2) exp(-20(-.2-.1+0.5)^2) 0.00001



## Test error


dx=Interval();dt=Interval(0,2.)
d=dx*dt
Dx=Derivative(d,[1,0]);Dt=Derivative(d,[0,1])
x=Fun(identity,dx)
u=[I⊗ldirichlet(dt);Dt+x*Dx]\Fun(x->exp(-20x^2),dx)

@test_approx_eq u(0.1,0.2) 0.8745340845783758  # empirical


dθ=PeriodicInterval();dt=Interval(0,10.)
d=dθ*dt
ε=.01
Dθ=Derivative(d,[1,0]);Dt=Derivative(d,[0,1])

# Parentheses are a hack to get rank 2 PDE
u=[I⊗ldirichlet(dt);Dt-ε*Dθ^2-Dθ]\Fun(θ->exp(-20θ^2),dθ)

@test_approx_eq_eps u(0.1,0.2) 0.1967278179230314 1000eps()
