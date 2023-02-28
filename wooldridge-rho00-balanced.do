cap log close

local rho1 = 0

cap log close

log using "${path}balanced.log", replace

set more off

tempname simulation

postfile simulation estimator replication ytlag_coef x1_coef   cons_coef using "${path}wooldridge-balanced.dta", replace

quietly{

forvalues num = 1/1000{

noisily display `num'



clear

use	"${path}data`num'", clear

noisily xtprobit y ylag x1 x1m ic  , i(idcode)

post simulation (2) (`num') (_b[ylag]) (_b[x1])	 	(_b[_cons]) 	


}


}

postclose simulation

log close




