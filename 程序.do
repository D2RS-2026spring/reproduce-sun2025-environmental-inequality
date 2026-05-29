
**---------------------------------------------------------------------**
**-------------------------------正    文------------------------------**
**---------------------------------------------------------------------**
clear
cd "E:\数据"


*--------------------表1：基准回归----------------**
clear
use 数据_Metro.dta,clear
global Controls "Pop Land Eco Sec Ter Urb Emp Ind_land HHI Cul_relics"
reghdfe EI_Q Int_Time , absorb(id year) cluster(id)
reghdfe EI_Q Int_Time $Controls, absorb(id year) cluster(id)

reghdfe EI_I Int_Time , absorb(id year) cluster(id)
reghdfe EI_I Int_Time $Controls, absorb(id year) cluster(id)


*--------------------表2：直接动因----------------**
clear
use 数据_City.dta,clear
global Citycontrols "Pop Land Eco Sec Ter Urb Emp Ind"
reghdfe Scale Int_Time $Citycontrols if ifcentral==1, absorb(city year) cluster(city)
reghdfe Scale Int_Time $Citycontrols if ifcentral==0, absorb(city year) cluster(city)

reghdfe Intensity Int_Time $Citycontrols if ifcentral==1, absorb(city year) cluster(city)
reghdfe Intensity Int_Time $Citycontrols if ifcentral==0, absorb(city year) cluster(city)


*----------------表3：城市层面缓解机制------------**
***Panel A***
reghdfe FAI Int_Time $Citycontrols if ifcentral==1, absorb(city year) cluster(city)
reghdfe FAI Int_Time $Citycontrols if ifcentral==0, absorb(city year) cluster(city)

reghdfe IE_num Int_Time $Citycontrols if ifcentral==1, absorb(city year) cluster(city)
reghdfe IE_num Int_Time $Citycontrols if ifcentral==0, absorb(city year) cluster(city)

***Panel B***
reghdfe Upgrade Int_Time $Citycontrols if ifcentral==1, absorb(city year) cluster(city)
reghdfe Upgrade Int_Time $Citycontrols if ifcentral==0, absorb(city year) cluster(city)

reghdfe Patent Int_Time $Citycontrols if ifcentral==1, absorb(city year) cluster(city)
reghdfe Patent Int_Time $Citycontrols if ifcentral==0, absorb(city year) cluster(city)


*----------------表4：企业层面缓解机制------------**
clear
use 数据_Firm.dta,clear
global Firmcontrols "Size Age Lev ROA FA Flow"

***Panel A***
reghdfe Invest Int_Time $Firmcontrols if ifcentral==1, absorb(firm year industry#year) cluster(city)
reghdfe Invest Int_Time $Firmcontrols if ifcentral==0, absorb(firm year industry#year) cluster(city)

reghdfe Subcomp1 Int_Time $Firmcontrols if ifcentral==1, absorb(firm year industry#year) cluster(city)
reghdfe Subcomp2 Int_Time $Firmcontrols if ifcentral==0, absorb(firm year industry#year) cluster(city)

***Panel B***
reghdfe Service Int_Time $Firmcontrols if ifcentral==1, absorb(firm year industry#year) cluster(city)
reghdfe Service Int_Time $Firmcontrols if ifcentral==0, absorb(firm year industry#year) cluster(city)

reghdfe Digital Int_Time $Firmcontrols if ifcentral==1, absorb(firm year industry#year) cluster(city)
reghdfe Digital Int_Time $Firmcontrols if ifcentral==0, absorb(firm year industry#year) cluster(city)


*-----------------表5：发展阶段异质性-------------**
clear
use 数据_Metro.dta,clear
global Controls "Pop Land Eco Sec Ter Urb Emp Ind_land HHI Cul_relics"
reghdfe EI_Q Int_Time $Controls if stage==1, absorb(id year) cluster(id)
reghdfe EI_Q Int_Time $Controls if stage==2, absorb(id year) cluster(id)

reghdfe EI_I Int_Time $Controls if stage==1, absorb(id year) cluster(id)
reghdfe EI_I Int_Time $Controls if stage==2, absorb(id year) cluster(id)


*-----------------表6：培育型机制分析-------------**
clear
use 数据_Firm.dta,clear
global Firmcontrols "Size Age Lev ROA FA Flow"

***Panel A***
reghdfe Invest Int_Time $Firmcontrols if ifcentral==1&stage==1, absorb(firm year industry#year) cluster(city)
reghdfe Invest Int_Time $Firmcontrols if ifcentral==0&stage==1, absorb(firm year industry#year) cluster(city)

reghdfe Subcomp1 Int_Time $Firmcontrols if ifcentral==1&stage==1, absorb(firm year industry#year) cluster(city)
reghdfe Subcomp2 Int_Time $Firmcontrols if ifcentral==0&stage==1, absorb(firm year industry#year) cluster(city)

***Panel B***
reghdfe Service Int_Time $Firmcontrols if ifcentral==1&stage==1, absorb(firm year industry#year) cluster(city)
reghdfe Service Int_Time $Firmcontrols if ifcentral==0&stage==1, absorb(firm year industry#year) cluster(city)

reghdfe Digital Int_Time $Firmcontrols if ifcentral==1&stage==1, absorb(firm year industry#year) cluster(city)
reghdfe Digital Int_Time $Firmcontrols if ifcentral==0&stage==1, absorb(firm year industry#year) cluster(city)


*---------------表7：发展成熟型机制分析-----------**
***Panel A***
reghdfe Invest Int_Time $Firmcontrols if ifcentral==1&stage==2, absorb(firm year industry#year) cluster(city)
reghdfe Invest Int_Time $Firmcontrols if ifcentral==0&stage==2, absorb(firm year industry#year) cluster(city)

reghdfe Subcomp1 Int_Time $Firmcontrols if ifcentral==1&stage==2, absorb(firm year industry#year) cluster(city)
reghdfe Subcomp2 Int_Time $Firmcontrols if ifcentral==0&stage==2, absorb(firm year industry#year) cluster(city)

***Panel B***
reghdfe Service Int_Time $Firmcontrols if ifcentral==1&stage==2, absorb(firm year industry#year) cluster(city)
reghdfe Service Int_Time $Firmcontrols if ifcentral==0&stage==2, absorb(firm year industry#year) cluster(city)

reghdfe Digital Int_Time $Firmcontrols if ifcentral==1&stage==2, absorb(firm year industry#year) cluster(city)
reghdfe Digital Int_Time $Firmcontrols if ifcentral==0&stage==2, absorb(firm year industry#year) cluster(city)






**---------------------------------------------------------------------**
**-------------------------------附    录------------------------------**
**---------------------------------------------------------------------**
clear
cd "E:\数据和代码\Data"


*----------------------附图1：平行趋势检验------------------**
clear
use 数据_Metro.dta,clear
global Controls "Pop Land Eco Sec Ter Urb Emp Ind_land HHI Cul_relics"
graph set window fontface "Times New Roman"
graph set window fontfacesans "宋体"

***排污规模不平等***
reghdfe EI_Q pre_* current post_* $Controls, absorb(id year) cluster(id)

coefplot,  keep(pre_* current post_*) omitted  vertical level(90) ///
	color(black) yline(0,lp(solid) lc(black) lw(thin))  xline(4,lp(solid) lc(black) lw(thin)) ///
	ytitle("{stSans:系数}") xtitle("{stSans:相对于政策实施年份}") ///
	coeflabels(pre_3=-3  pre_2=-2 pre_1=-1 current=0 ///
     post_1=1 post_2=2 post_3=3 post_4=4 post_5=5, ///
	labsize(*1.0) angle(0) labcolor(black)) 	 ///
	ciopts(recast(rcap) lc(black) lp(solid) lw(thin)) ///
	msymbol(Oh) mcolor(black)  msize(small) ///
	addplot(line @b @at) xscale(titlegap(tiny)) ///
	plotregion(lstyle(none)) graphregion(lstyle(none) margin(zero)) scheme(s1mono)

***排污强度不平等***
reghdfe EI_I pre_* current post_*  $Controls, absorb(id year) cluster(id)

coefplot,  keep(pre_* current post_*) omitted  vertical level(90) ///
	color(black) yline(0,lp(solid) lc(black) lw(thin))  xline(4,lp(solid) lc(black) lw(thin)) ///
	ytitle("{stSans:系数}") xtitle("{stSans:相对于政策实施年份}") ///
	coeflabels(pre_3=-3  pre_2=-2 pre_1=-1 current=0 ///
     post_1=1 post_2=2 post_3=3 post_4=4 post_5=5, ///
	labsize(*1.0) angle(0) labcolor(black)) 	 ///
	ciopts(recast(rcap) lc(black) lp(solid) lw(thin)) ///
	msymbol(Oh) mcolor(black)  msize(small) ///
	addplot(line @b @at) xscale(titlegap(tiny)) ///
	plotregion(lstyle(none)) graphregion(lstyle(none) margin(zero)) scheme(s1mono)


*-----------------------附表2：内生性处理-------------------**
ivreghdfe EI_Q (Int_Time = iv1_Time) $Controls, absorb(id year) cluster(id) first savefirst
ivreghdfe EI_I (Int_Time = iv1_Time) $Controls, absorb(id year) cluster(id) first savefirst

ivreghdfe EI_Q (Int_Time = iv2_Time) $Controls, absorb(id year) cluster(id) first savefirst
ivreghdfe EI_I (Int_Time = iv2_Time) $Controls, absorb(id year) cluster(id) first savefirst


*--------------------附表3：更换变量衡量方式----------------**
reghdfe EI_Q_gdp Int_Time $Controls, absorb(id year) cluster(id)
reghdfe EI_Q Int1_Time $Controls, absorb(id year) cluster(id)
reghdfe EI_Q Int2_Time $Controls, absorb(id year) cluster(id)

reghdfe EI_I_gdp Int_Time $Controls, absorb(id year) cluster(id)
reghdfe EI_I Int1_Time $Controls, absorb(id year) cluster(id)
reghdfe EI_I Int2_Time $Controls, absorb(id year) cluster(id)


*----------------附表4：缩短样本期与剔除部分样本------------**
reghdfe EI_Q Int_Time $Controls if year<2019, absorb(id year) cluster(id)
reghdfe EI_Q Int_Time $Controls if Bigfive!=1, absorb(id year) cluster(id)

reghdfe EI_I Int_Time $Controls if year<2019, absorb(id year) cluster(id)
reghdfe EI_I Int_Time $Controls if Bigfive!=1, absorb(id year) cluster(id)


*--------------------附表5：考虑其他因素影响----------------**
reghdfe EI_Q Int_Time Int_Time_History $Controls, absorb(id year) cluster(id)
reghdfe EI_Q Int_Time Int_Time_Resource $Controls, absorb(id year) cluster(id)
reghdfe EI_Q Int_Time Int_Time_Dynamic $Controls, absorb(id year) cluster(id)

reghdfe EI_I Int_Time Int_Time_History $Controls, absorb(id year) cluster(id)
reghdfe EI_I Int_Time Int_Time_Resource $Controls, absorb(id year) cluster(id)
reghdfe EI_I Int_Time Int_Time_Dynamic $Controls, absorb(id year) cluster(id)

