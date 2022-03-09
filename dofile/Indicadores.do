*---------------------------------------*
*      INDICADORES DE ESTUDIO ENDES 
*      Autor: Andrés Talavera Cuya 
*      02/03/2022
*---------------------------------------*
** Descarga **
*Ejecute con Stata versión 17

*--------------------------------------------------
*          Direccion de carpeta
*--------------------------------------------------

//Set pathways
di in yellow "USUARIO:`c(username)'"

qui if "`c(username)'"=="Andres" {
	glo path	"D:\Dropbox\BASES\ENDES\Inicial\" // Base de datos
	global ubicac   "D:\ANDRES\Documentos\GitHub\IndicadoresStata\Endes\"
	
}
*Ubicación de los archivos 
glo dofile 	"${ubicac}/dofile"	
glo clean	"${ubicac}/data"

*Identificar variables:

*** ==================================================================
***		Identificar variables
*** ==================================================================


*** ==================================================================
***		De Características :
*** ==================================================================

*Mujer 

*Edad actual en años completos

*Edad: menos de 1 año 

*Edad: menos de 3 años 

*Edad actual de la madre

*Madre sin educación formal

*Madre con educación primaria completa

*Madre con educación secundaria completa

*Madre con educación superior completa

*Madre casada o conviviente 

*Cantidad de miembros en el hogar 

*SIS (al menos un miembro del hogar)

*Juntos (al menos un miembro del hogar)

*Qali Warma o Cuna más (al menos un miembro del hogar)

*Distancia promedio a un centro MINSA de atención primaria (minutos)

*Distrito CRECER

*Lima Metropolitana 

*Ambito Urbano-rural 


*** ==================================================================
***		De Salud infantil : 
*** ==================================================================

*IMC estandarizado 

*Sobrepeso 

*Obesidad 

*Baja talla para la edad 

*Bajo peso para la edad 

*Anemia leve, moderada o severa 

*Nivel de hemoglobina 

*Episodio reciente de diarrea  


*** ==================================================================
***		RECH0_  Base a nivel de hogares. 
*** ==================================================================

cd "${path}/RECH0"
use rech0_2012.dta ,clear 
des  hhid /*"Identificación Cuestionario del Hogar"*/
des  hv001 /*"Conglomerado"*/
des  hv005 /*"Factor Hogar"*/
des  hv022 /*"Estrato"*/
des  hv024 /*"Región"*/
des  hv025 /*"Area de residencia (Urb-Rur)"*/

des hv009 /*número de miembros del hogar*/ 

*variable de anemia
des hv040 /*Altitud del conglomerado en metros*/
des hv005 /*Peso de la muestra nacional (6 decimales)*/

keep hhid hv001 hv005 hv022 hv024 hv025 hv009 hv040 hv005 
save "${clean}/rech0_2012_temp.dta",replace 


*** ==================================================================
***		RECH1_  Base a nivel de personas. Contiene información de cada una de las personas incluidas en la lista de miembros del hogar. Por ejemplo, relación de parentesco con el jefe del hogar, lugar de residencia, sexo, edad, estado civil, si tiene partida de nacimiento, educación
*** ==================================================================


cd "${path}/RECH1"

use rech1_2012.dta ,clear 
des hhid  /*Identificación Cuestionario del Hogar*/
des hvidx /*Número de orden*/
des hv102 /*residente habitual*/
des hv103 /*¿Durmió aqui anoche?*/
des hv104 /*Sexo*/
des hv105 /*Edad*/
des hv106 /*Mayor nivel de educación alcanzado*/ 
des hv109 /*Nivel educativo alcanzado*/ 
des hv111 /*madre viviendo*/ 
des hv112 /*número de linea de la madre*/ 
des hv115 /*Estado marital actual*/ 
sort hhid hvidx
rename hvidx  hc0  
keep hhid hc0 hv102 hv103 hv104 hv105 hv106 hv109 hv111 hv112 hv115 
save "${clean}/rech1_2012_temp",replace 


*** ==================================================================
***		HV226 Tipo de combustible para cocinar
*** ==================================================================

*** ==================================================================
***		REC42.sav  Seguro integral de salud
*** ==================================================================

cd "${path}/REC42"
use rec42_2012.dta ,clear 
des v481 /* Cobertura de seguro de salud si no*/ 
gen seguro_sis = v481g==1 /*seguro integral de salud*/
gen seguro_essalud = v481e==1 /*ESSALUD/IPSS*/


*** ==================================================================
***		REC91 Programa JUNTOS 
*** ==================================================================

cd "${path}/REC91"
use rec91_2012.dta ,clear 
tab s484 
gen hhid = substr(caseid,1,15)
gen hc0 = substr(caseid,16,17)
keep hhid hc0 caseid s108*  s484 
destring hc0,replace 
tab s108n 
save  "${clean}/rec91_2012_temp.dta",replace  
*** ==================================================================
***  RECH5 Ausencia de la madre en el hogar   
*** ==================================================================

cd "${path}/RECH5"
use rech5_2012.dta ,clear 
des hhid  /*identificación del hogar*/ 
des ha0  /*número de línea en el listado del hogar*/ 
des ha65 /*Resultado de entrevista individual a mujer*/ 
des ha66 /*Mayor nivel de educación alcanzado por mujer*/  
des hhid ha0 ha65 ha66  ha68
br hhid ha0 ha65 ha66  ha68


keep hhid ha0 ha65 ha66 
save "${clean}/educ_madre_ausente_2012_temp",replace 
 
*** ==================================================================
***  RECH6 Contiene información sobre Antropometría/Anemia - Niños   
*** ==================================================================

cd "${path}/RECH6"
use rech6_2012.dta ,clear 

sort hhid hc0 
br hhid hc0
des hhid 
des hc0       /*Número de línea en listado del hogar */
des hc70     /*Desviación estándard Talla/edad (de acuerdo con OMS)*/
des hc53    /*Nivel de hemoglobina(g-dl - 1 decimal) */ 
des hc56   /*Nivel de Hemoglobina ajustado por  altitud (g-dl-1 decimal) */
des hc57   /* Nivel de Anemia */
des hc1   /* edad en meses*/
des hc61  /*máximo nivel de educación de la madre*/   
des hc64 /*orden de nacimiento*/
keep hhid hc0 hc70 hc53 hc56 hc57 hc1 hc61 hc64
save "${clean}/rech6_2012_temp",replace  


*** ==================================================================
***  RECH23 Base de hogares Tratamiento del agua  
*** ==================================================================
cd "${path}/RECH23"
use rech23_2012.dta ,clear 
des hhid
des sh227      /*Test de cloro*/
des sh42      /*agua potable disponible el dia entero*/
des hv270    /*indice de riqueza*/ 
des hv201   /*Fuente de agua potable*/
des hv237a /* agua hervida para tomar */ 

keep hhid sh227 sh42 hv270 hv201 hv237a hv237
save "${clean}/rech23_2012_temp",replace  


*** ==================================================================
***  REC0111 Base de personas mujeres Nivel de educación 
*** ==================================================================
cd "${path}/REC0111"
use rec0111_2012.dta ,clear 
des caseid    /*Identificacion de mujer (HHID + V003) */ 
des v001     /*número de conglomerado*/
des v002     /*Número de hogar*/
des v003   /*Número de línea de entrevistada*/ 
des v106   /*Máximo nivel de educación*/
rename v003  hc0 
gen hhid = substr(caseid,1,15)

tab  hc0 
tab v150
tab v106 
keep hhid hc0 v001 v002 v106 v150
save "${clean}/rec0111_2012_temp",replace  

*** ==================================================================
***  REC0111 Educación de la madre 
*** ==================================================================

cd "${clean} "
use rech1_2012_temp,clear 
* verificar suposiciones sobre los datos y guardar una copia
isid hhid hc0, sort
tempfile main
save "`main'"


*educación del miembro del hogar
keep hhid hc0 hv109 

* cambiar el nombre para que coincida con los códigos madre
rename hc0 hv112 
rename hv109 mother_edu

* use merge para adjuntar la educación de la madre
merge 1:m hhid hv112  using "`main'", keep(match using) nogen

keep hhid hv112  mother_edu hc0 
isid hhid hc0, sort
save "${clean}/educ_madre_temp",replace 


*** ==================================================================
***   PERÚ: PREVALENCIA DE ANEMIA EN NIÑOS DE 6 A 59 MESES DE EDAD, POR TIPO, SEGÚN CARACTERÍSTICA SELECCIONADA, 2012
*** ==================================================================

cd "${clean}"
use rech6_2012_temp,clear 
local varlist hhid  
merge 1:1 hhid hc0 using rech1_2012_temp
keep if _merge==3
drop _merge 
merge m:1 hhid using rech0_2012_temp
keep if _merge==3
drop _merge 
merge m:1 hhid using rech23_2012_temp
keep if _merge==3
drop _merge  
merge 1:1 hhid hc0 using educ_madre_temp
keep if _merge==3
drop _merge 


recode hc1 (0/5=1) (6/8=2) (9/11=3) (12/17=4) (18/23=5) (24/35=6) (36/47=7) (48/59=8), gen(edadm)
label define edadm 1"0-5" 2"6-8" 3"9-11" 4"12-17" 5"18-23" 6"24-35" 7"36-47" 8"48-59"
label val edadm edadm 


recode hv025 (1=1 "urbano") (0=2 "rural"), gen(area) 
la var area "Tipo de lugar de residencia"

recode  hv104 (2=1 "Mujer") (1=0 "Hombre"), gen(sexo)
la var sexo "Sexo"

recode hc64 (1=1 "1") (2/3=2 "2-3") (4/5=3 "4-5") (6/max=4 "6+") , gen(orden)
la var orden "Orden de nacimiento" 

fre sh227
fre hv201

gen rt_1=.
replace  rt_1=1 if sh227==1 
la def rt_1 1 "Con Cloro residual 3/" 
la val rt_1 rt_1 
la var rt_1 "Tratamiento de agua" 

gen rt_2=.
replace rt_2=1 if hv237a==1 & (hv201==11|hv201==12|hv201==13) & rt_1==.
replace rt_2=0 if hv237a==1 & (hv201>=14) & rt_1==.
la def rt_2 1 "Red pública" 0 "Otra fuente"
la val rt_2 rt_2 
la var rt_2 "La hierven:"

gen rt_3=. 
replace rt_3=1 if sh227==5 & rt_2==. & rt_1==.
la def  rt_3 1 "Toma agua embotellada" 
la val rt_3 rt_3  
la var rt_3 "Toma agua embotellada" 
**revisar sin tratamiento ** 
gen rt_4=.
replace rt_4=1 if sh227>=2 & sh227<=4 & rt_2==. & rt_1==. & rt_3==. 
la def  rt_4 1 "Sin tratamiento" 
la val rt_4 rt_4  
la var rt_4 "Sin tratamiento" 
 

gen peso=hv005/1000000

gen alt=(hv040/1000)*3.3
gen HAj= hc53/10 -(-0.032*alt+0.022*alt*alt)

gen     anemia=1 if (HAj>  1 & HAj<11) & hv103==1
replace anemia=0 if (HAj>=11 & HAj<30) & hv103==1
label def anemia 1"Tiene" 0 "No tiene"
label val anemia anemia
label var anemia "Anemia"

fre hc57 
recode hc57 (1=3 "Anemia Leve") (2=2 "Anemia Moderada") (3=1 "Anemia Severa") (4=0 "No anemia") , gen(Hc57)

gen nv_anemia=Hc57 if hv103==1 & hc1>5 & hc1<60 
replace nv_anemia=. if HAj==.
la def nv_anemia 0 "No anemia" 1 "Anemia Leve" 2 "Anemia Moderada" 3 "Anemia Severa" 
la val nv_anemia nv_anemia
la var nv_anemia "tipo de anemia"

tab area anemia [iw=peso], row 
tab edadm anemia [iw=peso], row nofreq
tab sexo anemia [iw=peso], row nofreq
tab orden anemia [iw=peso], row nofreq
tab area  nv_anemia [iw=peso] , row nofreq
tab edadm nv_anemia [iw=peso] , row nofreq
tab sexo  nv_anemia [iw=peso] , row nofreq
tab orden nv_anemia [iw=peso], row nofreq
tab sh42 anemia [iw=peso], row nofreq
tab rt_1 anemia [iw=peso], row nofreq
tab rt_2 anemia [iw=peso], row nofreq
tab rt_3 anemia [iw=peso], row nofreq

tab hc61 anemia [iw=peso], row nofreq

fre nv_anemia


*nivel de educacion de la madre 

recode mother_edu (0=0 "Sin educación") (1/2=1 "Primaria") (3/4=2 "Secundaria") (5=3 "Superior") , gen(rmother_edu) 
replace rmother_edu=hv109 if rmother_edu==. 
la var  rmother_edu  "Nivel de educación"
 
tab rmother_edu anemia,m 
tab rmother_edu anemia  [iw=peso],  row nofreq


exit 

****************************************************.

*video explicativo: *
*https://www.youtube.com/watch?v=VCsAoaoOL10

/*compute alt=(hv040/1000)*3.3.
compute HAj= hc53/10 -(-0.032*alt+0.022*alt*alt) .
do if hv103=1.
IF (HAJ>1 & HAJ<11 ) ANEMIA=1.
IF (HAJ>=11 & HAJ<30 ) ANEMIA=2.
end if.
val lab anemia 1 'anemia' 2 'sin anemia'.
*/
