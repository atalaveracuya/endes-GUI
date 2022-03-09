clear 
input idcode hhcode hhmember str30 relation_to_hh str3 mother_in_hh mothercode edu
1010101  10101   1 "Jefe de hogar"  "No" . 15
1010102  10101   2 "Conyuge"  "No" . 13
1010103  10101   3 "Niño"  "Yes" 2 14
1010201  10102   1 "Jefe de hogar"  "No" . 12
1010202  10102   2 "Conyuge"  "No" . 10
1010301  10103   1 "Conyuge"  "No" . 11
1010302  10103   2 "Jefe de hogar"  "No" . 12
1010303  10103   3 "Niño"  "Yes" 1 14
end

* verificar suposiciones sobre los datos y guardar una copia
isid hhcode hhmember, sort
tempfile main
save "`main'"

*educación del miembro del hogar
keep hhcode hhmember edu

* cambiar el nombre para que coincida con los códigos madre
rename hhmember mothercode
rename edu mother_edu

* use merge para adjuntar la educación de la madre
merge 1:m hhcode mothercode using "`main'", keep(match using) nogen

isid hhcode hhmember, sort
list, sepby(hhcode) noobs