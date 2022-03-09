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
*Adress files origin 
glo Dofile 	"${ubicac}/dofile"	
glo Imagen	"${ubicac}/Imagen"		// Imagen
glo Tablas	"${ubicac}/Tablas"		// Tablas
glo clean	"${ubicac}/Data"

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
***		Identificación o construcción de variables de interés  
*** ==================================================================


cd "${path}/RECH0"

use rech0_2012.dta ,clear 
des hhid  /*Identificación Cuestionario del Hogar*/
des hv104 /*Sexo*/





*** ==================================================================
***		HV226 Tipo de combustible para cocinar
*** ==================================================================

*** ==================================================================
***		Número de afiliados al seguro de salud
*** ==================================================================

*SH11A Seguro de salud: ESSALUD/IPSS
*SH11B Seguro de salud: militar
*SH11C Seguro de salud: integral
*SH11D Seguro de salud: compañía de seguros
*SH11E Seguro de salud: seguro privado
*SH11Y Seguro de salud: no sé
*SH11Z Seguro médico: no tengo

*** ==================================================================
***		Bienes de riqueza
*** ==================================================================

V190


Educación del jefe de hogar