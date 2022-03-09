*DESCARGA DE DATOS ENDES. 
*Autor: Andrés Talavera Cuya 
*01/03/2022
*-------------------------------------------*

** Descarga **
*Ejecute con Stata versión 17

clear all
set more off 
global ubicac   "D:\Dropbox\BASES\ENDES\"
global dataset  "$ubicac" 
global dofile   "$ubicac\dofile"

*codigo de departamentos
clear 
input int codenc str20 año
323	2012
407 2013
441 2014
504 2015
548 2016
605 2017
638 2018
691 2019
739 2020
end

**matrix codigo de ENDES 
mkmat codenc, mat(ENDES)
mat list ENDES
 

if 1==1{
	mat MENDES=J(9,13,0)

	mat MENDES[1,1]=(64,65,66,67,69,70,71,72,73,74,0,0)
	mat MENDES[2,1]=(64,65,66,67,69,70,71,72,73,74,413,414)
	mat MENDES[3,1]=(64,65,66,67,69,70,71,72,73,74,413,414,569)
	mat MENDES[4,1]=(64,65,66,67,69,70,71,72,73,74,413,414,569)
	mat MENDES[5,1]=(64,65,66,67,69,70,71,72,73,74,413,414,569)
	mat MENDES[6,1]=(64,65,66,67,69,70,71,72,73,74,413,414,569)
	mat MENDES[7,1]=(64,65,66,67,69,70,71,72,73,74,413,414,569)
	mat MENDES[8,1]=(64,65,66,67,69,70,71,72,73,74,413,414,569)
	mat MENDES[9,1]=(1629,1630,1631,1632,1633,1634,1635,1636,1637,1638,1639,1640,1641)
	
	}

mat list ENDES
mat list MENDES  
 


global url http://iinei.inei.gob.pe/iinei/srienaho/descarga/SPSS/


forvalues i=2012/2020{
local i=i+1-2012
	cd "$dataset"
	cap mkdir `i'
	cd `i'

	cap mkdir "Download"
	cd "Download"

	scalar r_endes=ENDES[`i',1]
		
		forvalue j=1/11{
		scalar r_mendes=MENDES[`i',`j']
		local anio=r_endes
		local mod=r_mendes 		   
		display "anio'"  " " "`mod'"			   
		
		cap copy "$url/`anio'-Modulo`mod'.zip" `anio'-Modulo`mod'.zip 
		cap unzipfile `anio'-Modulo`mod'.zip, replace
		cap erase `anio'-Modulo`mod'.zip
		
					   }
		
		} 
 ext

*Colocar data en files 		
global Inicial "$dataset\Inicial"
cap mkdir "$Inicial"
cd "$Inicial"
global spss "$dataset\Inicial\\spss"
cap mkdir "$spss"
exit 

forvalues i=337/361{


	local i = `i'+1-337
	
	cd "$dataset"

	cd `i'

	cd "Download"


	scalar r_cenagro=CENAGRO[`i',1]
	forvalue j=1/11{
		scalar r_mcenagro=MCENAGRO[`i',`j']
		local dep=r_cenagro
		local mod=r_mcenagro		   
		display "`dep'"  " " "`mod'"	
		display "`dep'"  " " "`mod'"	
		
		cap copy "`dep'-Modulo`mod'\\01_IVCENAGRO_REC01.sav" "$spss\\rec01_`dep'.sav"
		cap copy "`dep'-Modulo`mod'\\02_IVCENAGRO_REC01A.sav" "$spss\\rec01a_`dep'.sav"
		cap copy "`dep'-Modulo`mod'\\03_IVCENAGRO_REC02.sav" "$spss\\rec02_`dep'.sav"	
		cap copy "`dep'-Modulo`mod'\\07_IVCENAGRO_REC04.sav" "$spss\\rec04_`dep'.sav"
		cap copy "`dep'-Modulo`mod'\\09_IVCENAGRO_REC04B.sav" "$spss\\rec04b_`dep'.sav"		
			
		
		            }
		} 
 
*Ejecute con Stata versión 16 a más 
*---------------------------------------------------------------
*Transformar REC 01 
*---------------------------------------------------------------
global rec01 "$dataset\Inicial\\rec01"
cap mkdir "$rec01"

forvalue i =337/361{


cd "$spss"


	local allfiles : dir "." files "*`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","rec01_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$rec01\\`g3'.dta", replace
	}

}

cd "$rec01"
use 337,clear 
forvalues dep=338/361 {
append using  `dep'.dta
}
save rec01,replace 

forvalues dep=337/361 {
erase `dep'.dta
}
 

***
*---------------------------------------------------------------
*Transformar REC 04
*---------------------------------------------------------------
global rec04 "$dataset\Inicial\\rec04"
cap mkdir "$rec04"

forvalue i =337/361{


cd "$spss"


	local allfiles : dir "." files "rec04_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","rec04_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$rec04\\`g3'.dta", replace
	}

}

cd "$rec04"
use 337,clear 
forvalues dep=338/361 {
append using  `dep'.dta
}
save rec04,replace 

forvalues dep=337/361 {
erase `dep'.dta
}




***
*---------------------------------------------------------------
*Transformar REC 04 B
*---------------------------------------------------------------
global rec04b "$dataset\Inicial\\rec04b"
cap mkdir "$rec04b"

forvalue i =337/361{


cd "$spss"


	local allfiles : dir "." files "rec04b_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","rec04b_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$rec04b\\`g3'.dta", replace
	}

}

cd "$rec04b"
use 337,clear 
forvalues dep=338/361 {
append using  `dep'.dta
}
save rec04b,replace 

forvalues dep=337/361 {
erase `dep'.dta
}


*---------------------------------------------------------------
*Transformar REC 01A 
*---------------------------------------------------------------
global rec01a "$dataset\Inicial\\rec01a"
cap mkdir "$rec01a"

forvalue i =337/361{


cd "$spss"


	local allfiles : dir "." files "*`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","rec01a_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$rec01\\`g3'.dta", replace
	}

}

cd "$rec01a"
use 337,clear 
forvalues dep=338/361 {
append using  `dep'.dta
}
save rec01a,replace 

forvalues dep=337/361 {
erase `dep'.dta
}

*---------------------------------------------------------------
*Transformar REC 02 
*---------------------------------------------------------------
global rec02 "$dataset\Inicial\\rec02"
cap mkdir "$rec02"

forvalue i =337/361{


cd "$spss"


	local allfiles : dir "." files "rec02_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","rec02_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$rec02\\`g3'.dta", replace
	}

}

cd "$rec02"
use 337,clear 
forvalues dep=338/361 {
append using  `dep'.dta
}
save rec02,replace 

forvalues dep=337/361 {
erase `dep'.dta
}
 