*---------------------------------------*
*      DESCARGA DE DATOS ENDES. 
*      Autor: Andrés Talavera Cuya 
*      01/03/2022
*---------------------------------------*

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

	mat MENDES[1,1]=(64,65,66,69,70,73,74)
	mat MENDES[2,1]=(64,65,66,69,70,73,74)
	mat MENDES[3,1]=(64,65,66,69,70,73,74)
	mat MENDES[4,1]=(64,65,66,69,70,73,74)
	mat MENDES[5,1]=(64,65,66,69,70,73,74)
	mat MENDES[6,1]=(64,65,66,69,70,73,74)
	mat MENDES[7,1]=(64,65,66,69,70,73,74)
	mat MENDES[8,1]=(64,65,66,69,70,73,74)
	mat MENDES[9,1]=(1629,1630,1633,1634,1638,1640,1641)
	
	}

mat list ENDES
mat list MENDES  
 


global url http://iinei.inei.gob.pe/iinei/srienaho/descarga/SPSS/


forvalues year=2012/2020{
local i=`year'+1-2012
	cd "$dataset"
	cap mkdir `year'
	cd `year'

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


*Colocar data en files 		
global Inicial "$dataset\Inicial"
cap mkdir "$Inicial"
cd "$Inicial"
global spss "$dataset\Inicial\\spss"
cap mkdir "$spss"

 
forvalues year=2012/2020{


	local i = `year'+1-2012
	
	cd "$dataset"

	cd `year'

	cd "Download"


	scalar r_endes=ENDES[`i',1]
	forvalue j=1/9{
		scalar r_mendes=MENDES[`i',`j']
		local anio=r_endes
		local mod=r_mendes		   
		display "`anio'"  " " "`mod'"	
		display "`anio'"  " " "`mod'"	
		
		cap copy "`anio'-Modulo`mod'\\RECH0.sav" "$spss\\RECH0_`year'.sav"
		cap copy "`anio'-Modulo`mod'\\RECH1.sav" "$spss\\RECH1_`year'.sav"
     	cap copy "`anio'-Modulo`mod'\\RECH23.sav" "$spss\\RECH23_`year'.sav"
		cap copy "`anio'-Modulo`mod'\\REC41.sav" "$spss\\REC41_`year'.sav"
		cap copy "`anio'-Modulo`mod'\\REC42.sav" "$spss\\REC42_`year'.sav"
		cap copy "`anio'-Modulo`mod'\\REC91.sav" "$spss\\REC91_`year'.sav"
		cap copy "`anio'-Modulo`mod'\\REC94.sav" "$spss\\REC94_`year'.sav"
		cap copy "`anio'-Modulo`mod'\\RECH6.sav" "$spss\\RECH6_`year'.sav"
        cap copy "`anio'-Modulo`mod'\\RECH5.sav" "$spss\\RECH5_`year'.sav"
		cap copy "`anio'-Modulo`mod'\\REC0111.sav" "$spss\\REC0111_`year'.sav"

				if `year'==2013 {
		cap copy "REC0111.sav" "$spss\\REC0111_2013.sav"

		}
		
		
		
		if `year'==2015 {
		cap copy "RECH0.sav" "$spss\\RECH0_2015.sav"
		cap copy "RECH1.sav" "$spss\\RECH1_2015.sav"
		
		}
		
		if `year'==2016 {
		cap copy "RECH23.SAV" "$spss\\RECH23_2016.sav"
		cap copy "REC41.SAV" "$spss\\REC41_2016.sav"
		cap copy "REC42.SAV" "$spss\\REC42_2016.sav"
		cap copy "REC94.SAV" "$spss\\REC94_2016.sav"
		}

		if `year'==2017 {
		cap copy "605-Modulo65\Modulo65\\RECH23_2017.sav" "$spss\\RECH23_2017.sav"
		cap copy "Modulo70\\REC42.SAV" "$spss\\REC42_2017.sav"	
		cap copy "Modulo69\\REC94.SAV" "$spss\\REC94_2017.sav"	
		cap copy "Modulo69\\REC41.SAV" "$spss\\REC41_2017.sav"	
		}		
	
		if `year'==2018 {
		cap copy "Modulo64\\RECH0.sav" "$spss\\RECH0_2018.sav"	
		cap copy "Modulo64\\RECH1.sav" "$spss\\RECH1_2018.sav"
		cap copy "Modulo65\\RECH23.SAV" "$spss\\RECH23_2018.sav"	
		cap copy "Modulo69\\REC94.SAV" "$spss\\REC94_2018.sav"	
		cap copy "Modulo69\\REC41.SAV" "$spss\\REC41_2018.sav"	
		}	
		
		if `year'==2019 {
		cap copy "Modulo64\\RECH0.sav" "$spss\\RECH0_2019.sav"
		cap copy "Modulo64\\RECH1.sav" "$spss\\RECH1_2019.sav"
		cap copy "Modulo65\\RECH23.SAV" "$spss\\RECH23_2019.sav"
		cap copy "Modulo69\\REC41.sav" "$spss\\REC41_2019.sav"
		cap copy "Modulo70\\REC42.sav" "$spss\\REC42_2019.sav"
		cap copy "Modulo66\\REC91.sav" "$spss\\REC91_2019.sav"
		cap copy "Modulo66\\REC0111.sav" "$spss\\REC0111_2019.sav"
		cap copy "Modulo69\\REC94.sav" "$spss\\REC94_2019.sav"
		cap copy "Modulo74\\RECH5.sav" "$spss\\RECH5_2019.sav"
		cap copy "Modulo74\\RECH6.sav" "$spss\\RECH6_2019.sav"
		

		}
			
		if `year'==2020 {
		cap copy "739-Modulo1629\Modulo1629\\\RECH0.sav" "$spss\\RECH0_2020.sav"
		cap copy "739-Modulo1629\Modulo1629\\\RECH1.sav" "$spss\\RECH1_2020.sav"
		cap copy "739-Modulo1630\Modulo1630\\\RECH23.sav" "$spss\\RECH23_2020.sav"
		cap copy "739-Modulo1634\Modulo1634\\REC42.sav" "$spss\\REC42_2020.sav"
		cap copy "739-Modulo1633\Modulo1633\\REC94.sav" "$spss\\REC94_2020.sav"
		cap copy "739-Modulo1633\Modulo1633\\REC41.sav" "$spss\\REC41_2020.sav"	
		cap copy "739-Modulo1638\Modulo1638\\RECH6.sav" "$spss\\RECH6_2020.sav"			
		cap copy "739-Modulo1638\Modulo1638\\RECH5.sav" "$spss\\RECH5_2020.sav"	
		
		}
		
		
		            }
		} 
		
*Ejecute con Stata versión 16 a más 
*---------------------------------------------------------------
*Transformar RECH0_ Caracteristicas del hogar 
*------------------------------------ ---------------------------
global RECH0 "$dataset\Inicial\\RECH0"
cap mkdir "$RECH0"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "RECH0_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","RECH0_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$RECH0\\`g3'.dta", replace
	}

}



***

*---------------------------------------------------------------
*Transformar RECH1_  Base a nivel de personas. Contiene información de cada una de las personas incluidas en la lista de miembros del hogar. Por ejemplo, relación de parentesco con el jefe del hogar, lugar de residencia, sexo, edad, estado civil, si tiene partida de nacimiento, educación
*------------------------------------ ---------------------------
global RECH1 "$dataset\Inicial\\RECH1"
cap mkdir "$RECH1"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "RECH1_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","RECH1_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$RECH1\\`g3'.dta", replace
	}
	
	}

*****




*---------------------------------------------------------------
*Transformar RECH23_ Caracteristicas de la vivienda 
*---------------------------------------------------------------
global RECH23 "$dataset\Inicial\\RECH23"
cap mkdir "$RECH23"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "RECH23_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","RECH23_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$RECH23\\`g3'.dta", replace
	}

}


*---------------------------------------------------------------
*Transformar REC42_ Seguros 
*---------------------------------------------------------------
global REC42 "$dataset\Inicial\\REC42"
cap mkdir "$REC42"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "REC42_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","REC42_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$REC42\\`g3'.dta", replace
	}

}

*---------------------------------------------------------------
*Transformar REC94_ SIS 
*---------------------------------------------------------------
global REC94 "$dataset\Inicial\\REC94"
cap mkdir "$REC94"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "REC94_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","REC94_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$REC94\\`g3'.dta", replace
	}

}


*---------------------------------------------------------------
*Transformar REC41_ SIS del bebé S425A
*---------------------------------------------------------------
global REC41 "$dataset\Inicial\\REC41"
cap mkdir "$REC41"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "REC41_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","REC41_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$REC41\\`g3'.dta", replace
	}

}

*---------------------------------------------------------------
*Transformar REC91_ Programa JUNTOS 
*---------------------------------------------------------------
global REC91 "$dataset\Inicial\\REC91"
cap mkdir "$REC91"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "REC91_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","REC91_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$REC91\\`g3'.dta", replace
	}

}


*---------------------------------------------------------------
*Transformar REC5  Madre entrevistada  Madre no entrevistada  
*---------------------------------------------------------------
global RECH5 "$dataset\Inicial\\RECH5"
cap mkdir "$RECH5"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "RECH5_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","RECH5_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$RECH5\\`g3'.dta", replace
	}

}


*---------------------------------------------------------------
*Transformar REC6 ANEMIA  
*---------------------------------------------------------------
global RECH6 "$dataset\Inicial\\RECH6"
cap mkdir "$RECH6"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "RECH6_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","RECH6_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$RECH6\\`g3'.dta", replace
	}

}



*---------------------------------------------------------------
*Transformar REC0111_ Educación  
*------------------------------------ ---------------------------
global REC0111 "$dataset\Inicial\\REC0111"
cap mkdir "$REC0111"

forvalue i =2012/2020{


cd "$spss"


	local allfiles : dir "." files "REC0111_`i'.sav"  
	foreach f of local allfiles {
		local g0=subinstr("`f'","REC0111_", "",.)
		local g1=subinstr("`g0'",".sav", "",.)
		local g2=subinstr("`g1'","  ", "",.)
		local g3=subinstr("`g2'"," `i'", "",.)
		display " ------------------Año: `g3' -----------------"			
		import spss using "`f'",case(lower) clear
		saveold "$REC0111\\`g3'.dta", replace
	}

}



