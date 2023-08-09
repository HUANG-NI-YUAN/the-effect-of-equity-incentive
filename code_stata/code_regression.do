
clear
use "panal3.dta"

xtset id Year

replace OperatingProfit = OperatingProfit/10000
replace TotalProfit = TotalProfit/10000
replace NetProfit = NetProfit/10000
replace EI_amount = EI_amount/1000
replace RS1_amount = RS1_amount/1000
replace RS2_amount = RS2_amount/1000
replace SAR_amount = SAR_amount/1000
replace Option_amount = Option_amount/1000

**# Bookmark #1 描述性统计
outreg2 using Describe.doc, replace sum(detail) keep( ROA ROE GPR NPR OperatingProfit TotalProfit NetProfit EPS EPSadjust EI EI_amount EI_percent RS1 RS1_amount RS1_percent RS2 RS2_amount RS2_percent SAR SAR_amount SAR_percent Option Option_amount Option_percent SIZE LEV ATO NATION TOP10 ) eqkeep(N mean sd min max p1 p25 p50 p75 p99) title(Decriptive statistics)


**# Bookmark #2 画图
//股权激励总额较时间上涨趋势
bysort Year: egen EI_amount_sum = sum(EI_amount)
bysort Year: egen RS1_amount_sum = sum(RS1_amount)
bysort Year: egen RS2_amount_sum = sum(RS2_amount)
bysort Year: egen SAR_amount_sum = sum(SAR_amount)
bysort Year: egen Option_amount_sum = sum(Option_amount)

bysort Year: egen EI_sum = sum(RS1+RS2+SAR+Option)
bysort Year: egen RS1_sum = sum(RS1)
bysort Year: egen RS2_sum = sum(RS2)
bysort Year: egen SAR_sum = sum(SAR)
bysort Year: egen Option_sum = sum(Option)

bysort Year: egen EI_ssum = sum(EI)

**# Bookmark #3 主回归
xtreg ROA EI SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg1.doc,replace tstat bdec(3) tdec(2) ctitle(ROA) addtext(Industry FE, YES,Year FE, YES) keep(ROA EI SIZE LEV ATO NATION TOP10)
xtreg ROA EI_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg1.doc,append tstat bdec(3) tdec(2) ctitle(ROA) addtext(Industry FE, YES,Year FE, YES) keep(ROA EI_amount SIZE LEV ATO NATION TOP10)
xtreg ROA EI_percent SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg1.doc,append tstat bdec(3) tdec(2) ctitle(ROA) addtext(Industry FE, YES,Year FE, YES) keep(ROA EI_percent SIZE LEV ATO NATION TOP10)

xtreg ROE EI SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg1.doc,append tstat bdec(3) tdec(2) ctitle(ROE) addtext(Industry FE, YES,Year FE, YES) keep(ROE EI SIZE LEV ATO NATION TOP10)
xtreg ROE EI_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg1.doc,append tstat bdec(3) tdec(2) ctitle(ROE) addtext(Industry FE, YES,Year FE, YES) keep(ROE EI_amount SIZE LEV ATO NATION TOP10)
xtreg ROE EI_percent SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg1.doc,append tstat bdec(3) tdec(2) ctitle(ROE) addtext(Industry FE, YES,Year FE, YES) keep(ROE EI_percent SIZE LEV ATO NATION TOP10)


**# Bookmark #3 稳健性检验：对利润率进行回归
xtreg GPR EI SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg2.doc,replace tstat bdec(3) tdec(2) ctitle(GPR) addtext(Industry FE, YES,Year FE, YES) keep(GPR EI SIZE LEV ATO NATION TOP10)
xtreg GPR EI_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg2.doc,append tstat bdec(3) tdec(2) ctitle(GPR) addtext(Industry FE, YES,Year FE, YES) keep(GPR EI_amount SIZE LEV ATO NATION TOP10)
xtreg GPR EI_percent SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg2.doc,append tstat bdec(3) tdec(2) ctitle(GPR) addtext(Industry FE, YES,Year FE, YES) keep(GPR EI_percent SIZE LEV ATO NATION TOP10)

xtreg NPR EI SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg2.doc,append tstat bdec(3) tdec(2) ctitle(NPR) addtext(Industry FE, YES,Year FE, YES) keep(NPR EI SIZE LEV ATO NATION TOP10)
xtreg NPR EI_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg2.doc,append tstat bdec(3) tdec(2) ctitle(NPR) addtext(Industry FE, YES,Year FE, YES) keep(NPR EI_amount SIZE LEV ATO NATION TOP10)
xtreg NPR EI_percent SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg2.doc,append tstat bdec(3) tdec(2) ctitle(NPR) addtext(Industry FE, YES,Year FE, YES) keep(NPR EI_percent SIZE LEV ATO NATION TOP10)

**# Bookmark #4 对利润总额的影响——正效用
xtreg OperatingProfit EI_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg3.doc,replace tstat bdec(3) tdec(2) ctitle(OperatingProfit) addtext(Industry FE, YES,Year FE, YES) keep(OperatingProfit EI_amount SIZE LEV ATO NATION TOP10)
xtreg TotalProfit EI_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg3.doc,append tstat bdec(3) tdec(2) ctitle(TotalProfit) addtext(Industry FE, YES,Year FE, YES) keep(TotalProfit EI_amount SIZE LEV ATO NATION TOP10)
xtreg NetProfit EI_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
outreg2 using reg3.doc,append tstat bdec(3) tdec(2) ctitle(NetProfit) addtext(Industry FE, YES,Year FE, YES) keep(NetProfit EI_amount SIZE LEV ATO NATION TOP10)

**# Bookmark #5 对每股收益的影响——成本
xtreg EPS EI_percent SIZE LEV ATO NATION i.id_industry i.Year,r
outreg2 using reg4.doc,replace tstat bdec(3) tdec(2) ctitle(EPS) addtext(Industry FE, YES,Year FE, YES) keep(EPS EI_percent SIZE LEV ATO NATION)
xtreg EPSadjust EI_percent SIZE LEV ATO NATION i.id_industry i.Year,r
outreg2 using reg4.doc,append tstat bdec(3) tdec(2) ctitle(EPSadjust) addtext(Industry FE, YES,Year FE, YES) keep(EPSadjust EI_percent SIZE LEV ATO NATION)

**# Bookmark #6 不同股权激励方式研究
xtreg OperatingProfit RS1_amount RS2_amount SAR_amount Option_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
test  RS1_amount-RS2_amount=0
test  RS1_amount-SAR_amount=0
test  RS1_amount-Option_amount=0
test  RS2_amount-SAR_amount=0
test  RS2_amount-Option_amount=0
test  SAR_amount-Option_amount=0
outreg2 using reg5.doc,append tstat bdec(3) tdec(2) ctitle(OperatingProfit) addtext(Industry FE, YES,Year FE, YES,P{RS1-RS2}, 0.024**, P{RS1-SAR}, 0.001***, P{RS1-Option}, 0.931, P{RS2-SAR}, 0.006***, P{RS2-Option}, 0.058*, P{SAR-Option}, 0.007) keep(OperatingProfit EI_amount SIZE LEV ATO NATION TOP10)

xtreg TotalProfit RS1_amount RS2_amount SAR_amount Option_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
test  RS1_amount-RS2_amount=0
test  RS1_amount-SAR_amount=0
test  RS1_amount-Option_amount=0
test  RS2_amount-SAR_amount=0
test  RS2_amount-Option_amount=0
test  SAR_amount-Option_amount=0
outreg2 using reg5.doc,append tstat bdec(3) tdec(2) ctitle(TotalProfit) addtext(Industry FE, YES,Year FE, YES,P{RS1-RS2}, 0.025**, P{RS1-SAR}, 0.008***, P{RS1-Option}, 0.939, P{RS2-SAR}, 0.005***, P{RS2-Option}, 0.059*, P{SAR-Option}, 0.006***) keep(OperatingProfit EI_amount SIZE LEV ATO NATION TOP10)

xtreg NetProfit RS1_amount RS2_amount SAR_amount Option_amount SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
test  RS1_amount-RS2_amount=0
test  RS1_amount-SAR_amount=0
test  RS1_amount-Option_amount=0
test  RS2_amount-SAR_amount=0
test  RS2_amount-Option_amount=0
test  SAR_amount-Option_amount=0
outreg2 using reg5.doc,append tstat bdec(3) tdec(2) ctitle(NetProfit) addtext(Industry FE, YES,Year FE, YES,P{RS1-RS2}, 0.038**, P{RS1-SAR}, 0.002***, P{RS1-Option}, 0.941, P{RS2-SAR}, 0.001***, P{RS2-Option}, 0.068*, P{SAR-Option}, 0.002***) keep(NetProfit EI_amount SIZE LEV ATO NATION TOP10)

**# Bookmark #6 交互作用 (效果不好，算了)
gen EI_SIZE = EI * SIZE
gen EI_LEV = EI * LEV
gen EI_ATO = EI * ATO
gen EI_NATION = EI * NATION
gen EI_TOP10 = EI * TOP10

gen EI_amount_SIZE = EI_amount * SIZE
gen EI_amount_LEV = EI_amount * LEV
gen EI_amount_ATO = EI_amount * ATO
gen EI_amount_NATION = EI_amount * NATION
gen EI_amount_TOP10 = EI_amount * TOP10

xtreg ROA EI_amount EI_amount_SIZE EI_amount_LEV EI_amount_ATO EI_amount_NATION EI_amount_TOP10 SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
xtreg ROE EI_amount EI_amount_SIZE EI_amount_LEV EI_amount_ATO EI_amount_NATION EI_amount_TOP10 SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
xtreg GPR EI_amount EI_amount_SIZE EI_amount_LEV EI_amount_ATO EI_amount_NATION EI_amount_TOP10 SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
xtreg NPR EI_amount EI_amount_SIZE EI_amount_LEV EI_amount_ATO EI_amount_NATION EI_amount_TOP10 SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r


xtreg ROA EI_amount EI_amount_ATO SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
xtreg ROE EI_amount EI_amount_ATO SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
xtreg GPR EI_amount EI_amount_ATO SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r
xtreg NPR EI_amount EI_amount_ATO SIZE LEV ATO NATION TOP10 i.id_industry i.Year,r






