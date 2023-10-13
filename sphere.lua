-- Date 2023-10-13
--

config.title = "Supersonic flow around sphere"
config.dimensions = 2

--Gas model & Flow conditions
setGasModel('ideal-air-sphere.gas')
initial = FlowState:new{p=10e3, T=300.0} -- need to obtain speed of sound for velx
inflow = FlowState:new{p=10e3, T=300.0, velx=6*initial.a, vely=0.0}

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

-- define fluid blocks
-- default slip wall boundary conditions (gas cannot penetrate and instead slip alongside it)
blk0 = FluidBlock:new{
    grid=grid, initialState=inflow,
    bcList={west=InFlowBC_Supersonic:new{flowState=inflow},
            north=OutFlowBC_Simple:new{}}
}

-- Set some solver settings
config.max_time = 5.0e-3 -- s
config.max_step = 3000
config.dt_init = 1.0e-6 -- s
config.flux_calculator = "ausmdv"
config.dt_plot = 0.5e-3

-- re prep after changes made to the file
