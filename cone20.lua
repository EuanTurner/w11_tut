-- Date 2023-10-13
--

config.title = "Supersonic flow over 20-deg cone"
config.dimensions = 2
config.axisymmetric = true

-- Set gas model and flow parameters
setGasModel('ideal-air.gas')
p_inf = 95.84e3 -- Pa
T_inf = 1103 -- K
V_inf = 1000.0 -- m/s
inflow = FlowState:new{p=p_inf, T=T_inf, velx=V_inf}

