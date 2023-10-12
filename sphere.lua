-- Generate the sphere geometry 
R = 10e-3

a = {x=0.0, y=0.0}
b = {x=-R, y=0.0}
c = {x=0.0, y=R}
d = {{x=-1.5*R,y=0.0}, {x=-1.5*R,y=R}, {x=-R,y=2*R}, {x=0.0,y=3*R}}

psurf = CoonsPatch:new{
    north=Line:new{p0=d[#d], p1=c}, east=Arc:new{p0=b, p1=c, centre=a},
    south=Line:new{p0=d[1], p1=b}, west=Bezier:new{points=d}   
}

ni = 124; nj=256
grid = StructuredGrid:new{psurface=psurf, niv=ni+1, njv=nj+1}

grid:write_to_vtk_file('sphere.vtk')
