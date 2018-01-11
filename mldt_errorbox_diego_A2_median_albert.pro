pro check_feos

common trace_sampled,rad_v,lat_v,lon_v,s_v,Ne_v,Tm_v,WT_v,Er_v,scoreR_v,midcell_v,Npts_v,str_v,stth_v,stph_v,radstart,enrad_v,enlon_v,enlat_v,npar,DEMc_v,lambda_v,L,Tmin,Tmax
common quemierda,alturas
common B_sampled,B_v,Br_v,Bth_v,Bph_v
common opclstatus,opcls,loopL,WTc

common statistic_loops,Nlegs,Nemean,Tmmean,WTmean,Nestddev,Tmstddev,WTstddev,loop_length,betamean,betaapex,Bmean,Br0
common statistic_loops2,opclstat,lambda_N,lambda_p,Ne0,p0,Tefit,gradT,r2N,r2P,r2T,indexloop,leg_status,Tm0,Tm0s,tm0_2,tm0_3,tm0_4,gradt_2,gradt_3,gradt_4,r2T_2,f_t,f_ne
common statistic_loops3,Eh,sH,r2sH,Phir,Fcb
common statistic_loops4,r2Tcuadr,Acuadr_a, s_r0_a,dTmds,r2Ts
common starttrace,strad,stlat,stlon,footrad,footlat,footlon,Rp_rad,Rp_lat,Rp_lon

common stat_filter,Nlegs_c,Nemean_c,Tmmean_c,WTmean_c,Nestddev_c,Tmstddev_c,WTstddev_c,loop_length_c,betamean_c,betaapex_c,Bmean_c,Br0_c
common stat_filter2,opclstat_c,lambda_N_c,lambda_p_c,Ne0_c,p0_c,Tefit_c,gradT_c,r2N_c,r2P_c,r2T_c,indexloop_c,leg_status_c,Tm0_c,Tm0s_c,Nebasal_c,Tbasal_c
common stat_filter3,Eh_c,sH_c,r2sH_c,Phir_c,Fcb_c
common stat_filter4,r2Tcuadr_c,Acuadr_a_c, s_r0_a_c,dTmds_c,r2Ts_c
common stat_filter5,strad_c,stlat_c,stlon_c,footrad_c,footlat_c,footlon_c,Rp_rad_c,Rp_lat_c,Rp_lon_c

common loops,Phir_loop,rad1_loop,rad2_loop,lat1_loop,lat2_loop,lon1_loop,lon2_loop,L_loop,opclstat_loop,r2Er1_loop,r2Er2_loop,Tmmean_loop,Fcb_loop,dTmds1_loop,dTmds2_loop,r2Tcuadr1_loop,r2Tcuadr2_loop,r2T1_loop,r2T2_loop,Ner01_loop,Ner02_loop,Ner11_loop,Ner12_loop,Ner21_loop,Ner22_loop,Ner31_loop,Ner32_loop,Rp_rad1_loop,Rp_lat1_loop,Rp_lon1_loop,Rp_rad2_loop,Rp_lat2_loop,Rp_lon2_loop,TmR11_loop,TmR12_loop,NR11_loop,NR12_loop
common loops_filter,Phir_loop_c,rad1_loop_c,rad2_loop_c,lat1_loop_c,lat2_loop_c,lon1_loop_c,lon2_loop_c,L_loop_c,opclstat_loop_c,r2Er1_loop_c,r2Er2_loop_c,Tmmean_loop_c,Fcb_loop_c,dTmds1_loop_c,dTmds2_loop_c,r2Tcuadr1_loop_c,r2Tcuadr2_loop_c,r2T1_loop_c,r2T2_loop_c,Ner01_loop_c,Ner02_loop_c,Ner11_loop_c,Ner12_loop_c,Ner21_loop_c,Ner22_loop_c,Ner31_loop_c,Ner32_loop_c,Rp_rad1_loop_c,Rp_lat1_loop_c,Rp_lon1_loop_c,Rp_rad2_loop_c,Rp_lat2_loop_c,Rp_lon2_loop_c,TmR11_loop_c,TmR12_loop_c,NR11_loop_c,NR12_loop_c


filesT= ['traceLDEM_CR2081_euviA-NODECON_reg0.75_safety0.5_errorbox_base_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat']
rstart      = 1.035+0.02*findgen(10)
alturas = n_elements(rstart)
read_trace_sampled,filesT,alturas
statloop,filesT,rloopmin=1.05,/linear,/FITCUAdr,/altura

stop
feos=where(r2t lt 0.5)
verde = 25
azul =100
rojo =200
negro=  0
stop
ileg=feos(0)
window,0

plot, rad_l, tm_l, psym=4
f1= tm0  (ileg) + gradt  (ileg)*rad_l
f2= tm0_2(ileg) + gradt_2(ileg)*rad_l
;f3= tm0_3(ileg) + gradt_3(ileg)*rad_l
;f4= tm0_4(ileg) + gradt_4(ileg)*rad_l

xyouts,.98-[.2,.1],0.24*[1,1],['r2','absdev_lf'],/normal,charthick=3,Font=0  
xyouts,.98-[.2,.1],0.14*[1,1],[r2t(ileg),error_ladfit(ileg)],/normal,charthick=3,Font=0


oplot, rad_l,f1  ,thick=2
oplot, rad_l,f2  ,thick=2,color=rojo
stop

;oplot, rad_l,f3  ,thick=2,color=azul
;oplot, rad_l,f4  ,thick=2,color=verde

return
end

pro stats_errorbox,filelabel=filelabel,altura=altura,euvi_full=euvi_full,euvi_base=euvi_base,eit_full=eit_full,eit_base=eit_base,check=check,Rpoint_base=Rpoint_base,footpoint_base=footpoint_base,euvi_decon=euvi_decon,EHI=EHI

common trace_sampled,rad_v,lat_v,lon_v,s_v,Ne_v,Tm_v,WT_v,Er_v,scoreR_v,midcell_v,Npts_v,str_v,stth_v,stph_v,radstart,enrad_v,enlon_v,enlat_v,npar,DEMc_v,lambda_v,L,Tmin,Tmax
common quemierda,alturas
common B_sampled,B_v,Br_v,Bth_v,Bph_v
common opclstatus,opcls,loopL,WTc

common statistic_loops,Nlegs,Nemean,Tmmean,WTmean,Nestddev,Tmstddev,WTstddev,loop_length,betamean,betaapex,Bmean,Br0
common statistic_loops2,opclstat,lambda_N,lambda_p,Ne0,p0,Tefit,gradT,r2N,r2P,r2T,indexloop,leg_status,Tm0,Tm0s,tm0_2,tm0_3,tm0_4,gradt_2,gradt_3,gradt_4,r2T_2,f_t,f_ne
common statistic_loops3,Eh,sH,r2sH,Phir,Fcb
common statistic_loops4,r2Tcuadr,Acuadr_a, s_r0_a,dTmds,r2Ts
common starttrace,strad,stlat,stlon,footrad,footlat,footlon,Rp_rad,Rp_lat,Rp_lon

common stat_filter,Nlegs_c,Nemean_c,Tmmean_c,WTmean_c,Nestddev_c,Tmstddev_c,WTstddev_c,loop_length_c,betamean_c,betaapex_c,Bmean_c,Br0_c
common stat_filter2,opclstat_c,lambda_N_c,lambda_p_c,Ne0_c,p0_c,Tefit_c,gradT_c,r2N_c,r2P_c,r2T_c,indexloop_c,leg_status_c,Tm0_c,Tm0s_c,Nebasal_c,Tbasal_c
common stat_filter3,Eh_c,sH_c,r2sH_c,Phir_c,Fcb_c
common stat_filter4,r2Tcuadr_c,Acuadr_a_c, s_r0_a_c,dTmds_c,r2Ts_c
common stat_filter5,strad_c,stlat_c,stlon_c,footrad_c,footlat_c,footlon_c,Rp_rad_c,Rp_lat_c,Rp_lon_c

common loops,Phir_loop,rad1_loop,rad2_loop,lat1_loop,lat2_loop,lon1_loop,lon2_loop,L_loop,opclstat_loop,r2Er1_loop,r2Er2_loop,Tmmean_loop,Fcb_loop,dTmds1_loop,dTmds2_loop,r2Tcuadr1_loop,r2Tcuadr2_loop,r2T1_loop,r2T2_loop,Ner01_loop,Ner02_loop,Ner11_loop,Ner12_loop,Ner21_loop,Ner22_loop,Ner31_loop,Ner32_loop,Rp_rad1_loop,Rp_lat1_loop,Rp_lon1_loop,Rp_rad2_loop,Rp_lat2_loop,Rp_lon2_loop,TmR11_loop,TmR12_loop,NR11_loop,NR12_loop
common loops_filter,Phir_loop_c,rad1_loop_c,rad2_loop_c,lat1_loop_c,lat2_loop_c,lon1_loop_c,lon2_loop_c,L_loop_c,opclstat_loop_c,r2Er1_loop_c,r2Er2_loop_c,Tmmean_loop_c,Fcb_loop_c,dTmds1_loop_c,dTmds2_loop_c,r2Tcuadr1_loop_c,r2Tcuadr2_loop_c,r2T1_loop_c,r2T2_loop_c,Ner01_loop_c,Ner02_loop_c,Ner11_loop_c,Ner12_loop_c,Ner21_loop_c,Ner22_loop_c,Ner31_loop_c,Ner32_loop_c,Rp_rad1_loop_c,Rp_lat1_loop_c,Rp_lon1_loop_c,Rp_rad2_loop_c,Rp_lat2_loop_c,Rp_lon2_loop_c,TmR11_loop_c,TmR12_loop_c,NR11_loop_c,NR12_loop_c

if keyword_set (EHI) then goto, directoEHI

if keyword_set (euvi_decon) then begin
 instrumento='euvi_decon'
 filesT= ['traceLDEM_CR2081_euviA-DECON_reg0.75_safety0.5_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.ALBERT.dat']
 lonmax=360.
 lowlatmax=30.
endif

if keyword_set (euvi_base) then begin
 instrumento='euvi_base'
 filesT= ['traceLDEM_CR2081_euviA-NODECON_reg0.75_safety0.5_errorbox_base_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat']
endif

if keyword_set (euvi_full) then begin
 instrumento='euvi_full'
 filesT= ['traceLDEM_CR2081_euviA-NODECON_reg0.75_safety0.5_errorbox_base_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_HLH_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_HHL_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_HLL_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_LLH_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_LHL_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_LHH_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_HLH_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_HHL_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_HLL_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_LLH_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_LHL_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR2081_euviA_reg0.75_safety0.5_errorbox_LHH_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat']
endif


if keyword_set (eit_base)  then begin
 instrumento='eit_base' 
 filesT= ['traceLDEM_CR1915_reg0.75_safety0.5_errorbox_base_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat']
endif


if keyword_set (eit_full)  then begin
 instrumento='eit_full' 
 filesT= ['traceLDEM_CR1915_reg0.75_safety0.5_errorbox_base_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_HHL_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_LHL_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_LHH_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_HHL_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_HLL_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_LHL_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
	  'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_LHH_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
          'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_HLH_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
          'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_HLH_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
          'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_LLH_oreg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
          'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_LLH_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
          'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_HLL_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat']
endif

;defino variables que involucran datos de todos los trazados

Nf = n_elements(filesT)
  
  Ne_basal_m_lowlat   = fltarr(Nf)
  Ne_basal_sdv_lowlat = fltarr(Nf)
  lambdaN_m_lowlat    = fltarr(Nf)
  lambdaN_sdv_lowlat  = fltarr(Nf)

  Ne_basal_m_midlat_N   = fltarr(Nf)
  Ne_basal_sdv_midlat_N = fltarr(Nf)
  lambdaN_m_midlat_N    = fltarr(Nf)
  lambdaN_sdv_midlat_N  = fltarr(Nf)

  Ne_basal_m_midlat_S   = fltarr(Nf)
  Ne_basal_sdv_midlat_S = fltarr(Nf)
  lambdaN_m_midlat_S    = fltarr(Nf)
  lambdaN_sdv_midlat_S  = fltarr(Nf)

  Ne_basal_m_large_OCN   = fltarr(Nf)
  Ne_basal_sdv_large_OCN = fltarr(Nf)
  lambdaN_m_large_OCN    = fltarr(Nf)
  lambdaN_sdv_large_OCN  = fltarr(Nf)

  Ne_basal_m_large_OCS   = fltarr(Nf)
  Ne_basal_sdv_large_OCS = fltarr(Nf)
  lambdaN_m_large_OCS    = fltarr(Nf)
  lambdaN_sdv_large_OCS  = fltarr(Nf)

  Ne_basal_m_open_N_L   = fltarr(Nf)
  Ne_basal_sdv_open_N_L = fltarr(Nf)
  lambdaN_m_open_N_L    = fltarr(Nf)
  lambdaN_sdv_open_N_L  = fltarr(Nf)

  Ne_basal_m_open_S_L   = fltarr(Nf)
  Ne_basal_sdv_open_S_L = fltarr(Nf)
  lambdaN_m_open_S_L    = fltarr(Nf)
  lambdaN_sdv_open_S_L  = fltarr(Nf)

  Ne_basal_m_open_N_H   = fltarr(Nf)
  Ne_basal_sdv_open_N_H = fltarr(Nf)
  lambdaN_m_open_N_H    = fltarr(Nf)
  lambdaN_sdv_open_N_H  = fltarr(Nf)

  Ne_basal_m_open_S_H   = fltarr(Nf)
  Ne_basal_sdv_open_S_H = fltarr(Nf)
  lambdaN_m_open_S_H    = fltarr(Nf)
  lambdaN_sdv_open_S_H  = fltarr(Nf)

  Te_basal_m_lowlat_gp     = fltarr(Nf)
  Te_basal_sdv_lowlat_gp   = fltarr(Nf)
  Te_median_m_lowlat_gp    = fltarr(Nf)
  Te_median_sdv_lowlat_gp  = fltarr(Nf)

  Te_basal_m_midlat_N_gp     = fltarr(Nf)
  Te_basal_sdv_midlat_N_gp   = fltarr(Nf)
  Te_median_m_midlat_N_gp    = fltarr(Nf)
  Te_median_sdv_midlat_N_gp  = fltarr(Nf)

  Te_basal_m_midlat_S_gp     = fltarr(Nf)
  Te_basal_sdv_midlat_S_gp   = fltarr(Nf)
  Te_median_m_midlat_S_gp    = fltarr(Nf)
  Te_median_sdv_midlat_S_gp  = fltarr(Nf)

  Te_basal_m_large_OCN_gp     = fltarr(Nf)
  Te_basal_sdv_large_OCN_gp   = fltarr(Nf)
  Te_median_m_large_OCN_gp    = fltarr(Nf)
  Te_median_sdv_large_OCN_gp  = fltarr(Nf)

  Te_basal_m_large_OCS_gp     = fltarr(Nf)
  Te_basal_sdv_large_OCS_gp   = fltarr(Nf)
  Te_median_m_large_OCS_gp    = fltarr(Nf)
  Te_median_sdv_large_OCS_gp  = fltarr(Nf)

  Te_basal_m_open_N_gp_L     = fltarr(Nf)
  Te_basal_sdv_open_N_gp_L   = fltarr(Nf)
  Te_median_m_open_N_gp_L    = fltarr(Nf)
  Te_median_sdv_open_N_gp_L  = fltarr(Nf)

  Te_basal_m_open_S_gp_L     = fltarr(Nf)
  Te_basal_sdv_open_S_gp_L   = fltarr(Nf)
  Te_median_m_open_S_gp_L    = fltarr(Nf)
  Te_median_sdv_open_S_gp_L  = fltarr(Nf)

  Te_basal_m_open_N_gp_H     = fltarr(Nf)
  Te_basal_sdv_open_N_gp_H   = fltarr(Nf)
  Te_median_m_open_N_gp_H    = fltarr(Nf)
  Te_median_sdv_open_N_gp_H  = fltarr(Nf)

  Te_basal_m_open_S_gp_H     = fltarr(Nf)
  Te_basal_sdv_open_S_gp_H   = fltarr(Nf)
  Te_median_m_open_S_gp_H    = fltarr(Nf)
  Te_median_sdv_open_S_gp_H  = fltarr(Nf)

  Te_basal_m_lowlat_gn     = fltarr(Nf)
  Te_basal_sdv_lowlat_gn   = fltarr(Nf)
  Te_median_m_lowlat_gn    = fltarr(Nf)
  Te_median_sdv_lowlat_gn  = fltarr(Nf)

  Te_basal_m_midlat_N_gn     = fltarr(Nf)
  Te_basal_sdv_midlat_N_gn   = fltarr(Nf)
  Te_median_m_midlat_N_gn    = fltarr(Nf)
  Te_median_sdv_midlat_N_gn  = fltarr(Nf)

  Te_basal_m_midlat_S_gn     = fltarr(Nf)
  Te_basal_sdv_midlat_S_gn   = fltarr(Nf)
  Te_median_m_midlat_S_gn    = fltarr(Nf)
  Te_median_sdv_midlat_S_gn  = fltarr(Nf)

  Te_basal_m_large_OCN_gn     = fltarr(Nf)
  Te_basal_sdv_large_OCN_gn   = fltarr(Nf)
  Te_median_m_large_OCN_gn    = fltarr(Nf)
  Te_median_sdv_large_OCN_gn  = fltarr(Nf)

  Te_basal_m_large_OCS_gn     = fltarr(Nf)
  Te_basal_sdv_large_OCS_gn   = fltarr(Nf)
  Te_median_m_large_OCS_gn    = fltarr(Nf)
  Te_median_sdv_large_OCS_gn  = fltarr(Nf)

  Te_basal_m_open_N_gn     = fltarr(Nf)
  Te_basal_sdv_open_N_gn   = fltarr(Nf)
  Te_median_m_open_N_gn    = fltarr(Nf)
  Te_median_sdv_open_N_gn  = fltarr(Nf)

  Te_basal_m_open_S_gn     = fltarr(Nf)
  Te_basal_sdv_open_S_gn   = fltarr(Nf)
  Te_median_m_open_S_gn    = fltarr(Nf)
  Te_median_sdv_open_S_gn  = fltarr(Nf)


rstart  = 1.035+0.02*findgen(10)
alturas = n_elements(rstart)

;defino las cantidades

cant_lowlat      = 0
cant_midlat_N    = 0
cant_midlat_S    = 0
cant_large_OCN   = 0
cant_large_OCS   = 0
cant_open_N_L    = 0
cant_open_S_L    = 0
cant_open_N_H    = 0
cant_open_S_H    = 0


cant_lowlat_gp       = 0
cant_midlat_N_gp     = 0
cant_midlat_S_gp     = 0
cant_large_OCN_gp    = 0
cant_large_OCS_gp    = 0
cant_open_N_gp_L     = 0
cant_open_S_gp_L     = 0
cant_open_N_gp_H     = 0
cant_open_S_gp_H     = 0


cant_lowlat_gn     = 0
cant_midlat_N_gn   = 0
cant_midlat_S_gn   = 0
cant_large_OCN_gn  = 0
cant_large_OCS_gn  = 0
cant_open_N_gn     = 0
cant_open_S_gn     = 0


for i=0,Nf-1 do begin

;read_trace_sampled,filesT(i),alturas
statloop,filesT(i),rloopmin=1.05,/linear,/FITCUAdr,/altura
stop
;defino donde voy a utilizar los filtros

 r2crit_N  = 0.8
 r2crit_T  = 0.5
  fcrit_t  = 0.75

if keyword_set (eit_full)  then begin
    lonmax=180.
    lowlatmax =20.
 endif

if keyword_set (eit_base)  then begin
    lonmax=180.
    lowlatmax =20.
 endif

if keyword_set (euvi_full) then begin
    lonmax=360.
    lowlatmax=30.
endif

if keyword_set (euvi_base) then begin
    lonmax=360.
    lowlatmax=30.
endif
;stop
;footpoint_map2,footlat,footlon,opclstat,r2T,r2N,r2crit_T,r2crit_N,lowlatmax,lonmax,gradT,filelabel='_5colores_full'+instrumento,/full
;footpoint_map2,footlat,footlon,opclstat,f_t,r2N,fcrit_t,r2crit_N,lowlatmax,lonmax,gradT,filelabel='_5colores_full'+instrumento+'theil_sen',/full
;stop

f_t=r2t ;PROVIORIO!!!!


; piernas de loops chicos con pie en el rango de latitud [-30,+30]                                                                          
i_lowlat         = where(gradT ne -555. AND opclstat eq 2. and r2N gt r2crit_N and abs(footlat) le lowlatmax and footlon le lonmax)
; pendiente positiva en Temp                                                                                
i_lowlat_gradpos = where(gradT ne -555. AND opclstat eq 2. and f_t gt fcrit_t and abs(footlat) le lowlatmax and gradT ge 0. and footlon le lonmax)
; pendiente negativa en Temp
i_lowlat_gradneg = where(gradT ne -555. AND opclstat eq 2. and f_t gt fcrit_t and abs(footlat) le lowlatmax and gradT le 0. and footlon le lonmax)


; piernas de loops chicos con pie en el rango de latitud >30 (North)       
i_midlat_small_norte         = where(gradT ne -555. AND opclstat eq 2. and r2N gt r2crit_N and footlat gt 30. and footlon le lonmax)
; pendiente positiva en Temp                                                     
i_midlat_small_norte_gradpos = where(gradT ne -555. AND opclstat eq 2. and f_t gt fcrit_t and footlat gt 30. and gradT ge 0. and footlon le lonmax)
; pendiente negativa de Temp
i_midlat_small_norte_gradneg = where(gradT ne -555. AND opclstat eq 2. and f_t gt fcrit_t and footlat gt 30. and gradT le 0. and footlon le lonmax)


; piernas de loops chicos con pie en el rango de latitud < -30 (South)  
i_midlat_small_sur         = where(gradT ne -555. AND opclstat eq 2. and r2N gt r2crit_N and footlat lt -30. and footlon le lonmax)
; pendiente positiva en Temperatura                                                                              
i_midlat_small_sur_gradpos = where(gradT ne -555. AND opclstat eq 2. and f_t gt fcrit_t and footlat lt -30. and gradT ge 0. and footlon le lonmax)
; pendiente neagtiva de Temp
i_midlat_small_sur_gradneg = where(gradT ne -555. AND opclstat eq 2. and f_t gt fcrit_t and footlat lt -30. and gradT le 0. and footlon le lonmax)


; piernas de loops grandes de la O/C boundary norte                      
i_large_OCN         = where(gradT ne -555. AND opclstat eq 1. and r2N ge r2crit_N and footlat ge +40. and footlon le lonmax)
; positiva en Temp                                                                                  
i_large_OCN_gradpos = where(gradT ne -555. AND opclstat eq 1. and f_t ge fcrit_t and footlat ge +40. and gradT ge 0. and footlon le lonmax)
; grad negtivo en Temp
i_large_OCN_gradneg = where(gradT ne -555. AND opclstat eq 1. and f_t ge fcrit_t and footlat ge +40. and gradT le 0. and footlon le lonmax)


; piernas de loops grandes de la O/C boundary sur                                                                                               
i_large_OCS         = where(gradT ne -555. AND opclstat eq 1. and r2N ge r2crit_N and footlat le -40. and footlon le lonmax)
; pendiente positiva en Temp                                                
i_large_OCS_gradpos = where(gradT ne -555. AND opclstat eq 1. and f_t ge fcrit_t and footlat le -40. and footlat ge -80. and gradT ge 0. and footlon le lonmax)
; pendiente negativa en Temp
i_large_OCS_gradneg = where(gradT ne -555. AND opclstat eq 1. and f_t ge fcrit_t and footlat le -40. and footlat ge -80. and gradT le 0. and footlon le lonmax)


; piernas de lineas abiertas del polo norte                                                                        
;i_open_norte = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat gt +50. and footlat lt +80. and footlon le lonmax)
; lineas abiertas norte, pend pos Temp
;i_open_norte_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T6 and footlat gt +50. and footlat lt 80. and gradT gt 0. and footlon le lonmax)
; lineas abiertas norte, pend neg Temp
i_open_norte_gradneg = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and footlat gt +50. and footlat lt 80. and gradT le 0. and footlon le lonmax)

; piernas de lineas abiertas del polo sur                                              
;i_open_sur = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat lt -50. and footlat gt -80. and footlon le lonmax)
; lineas abiertas sur, pend pos Temp                                                
;i_open_sur_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T7 and footlat lt -50. and footlat gt -80. and gradT gt 0. and footlon le lonmax)
; lineas abiertas sur, pend neg Temp
i_open_sur_gradneg = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and footlat lt -50. and footlat gt -80. and gradT le 0. and footlon le lonmax)


i_open_norte_L         = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat le 68. and footlat ge 0.                 and footlon le lonmax)
i_open_norte_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and f_t ge fcrit_t  and footlat le 68. and footlat ge 0. and gradT gt 0. and footlon le lonmax)

i_open_norte_H         = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat ge 72. and footlat le 80.                 and footlon le lonmax)
i_open_norte_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and f_t ge fcrit_t  and footlat ge 72. and footlat le 80. and gradT gt 0. and footlon le lonmax)

i_open_sur_L           = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat ge -68. and footlat le 0.                 and footlon le lonmax)
i_open_sur_gradpos_L   = where(gradT ne -555. AND opclstat eq 0. and f_t ge fcrit_t  and footlat ge -68. and footlat le 0. and gradT gt 0. and footlon le lonmax)

i_open_sur_H           = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat le -72. and footlat ge -80.                 and footlon le lonmax)
i_open_sur_gradpos_H   = where(gradT ne -555. AND opclstat eq 0. and f_t ge fcrit_t  and footlat le -72. and footlat ge -80. and gradT gt 0. and footlon le lonmax)



if keyword_set(Rpoint_base)    then    Rpoint_map2,Rp_lat,Rp_lon,  opclstat,f_t,r2N,fcrit_t,r2crit_N,lowlatmax,lonmax,gradT,filelabel='_5colores_ts1'+instrumento
if keyword_set(footpoint_base) then footpoint_map2,footlat,footlon,opclstat,f_t,r2N,fcrit_t,r2crit_N,lowlatmax,lonmax,gradT,filelabel='_5colores_ts2'+instrumento


;chequeando si las regiones son representativas

if keyword_set(check) then begin
;altura fijada 1.075 ---> Proximamente altura variable

;numero=i
iii='test_distrib_new_1pto'
;iii='theil_sen'

;filter, i_lowlat_gradpos
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='lowlat_gradpos_'+instrumento+iii,indexloop_c,rotacion

filter, i_lowlat_gradneg
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='lowlat_gradneg_'+instrumento+iii,indexloop_c,rotacion

filter, i_midlat_small_norte_gradpos
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='midlat_N_gradpos_'+instrumento+iii,indexloop_c,rotacion

;filter, i_midlat_small_norte_gradneg
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='midlat_N_gradneg_'+instrumento+iii,indexloop_c,rotacion

filter, i_midlat_small_sur_gradpos
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='midlat_S_gradpos_'+instrumento+iii,indexloop_c,rotacion

;filter, i_midlat_small_sur_gradneg
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='midlat_S_gradneg_'+instrumento+iii,indexloop_c,rotacion

filter, i_large_OCN_gradpos
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='OCN_gradpos_'+instrumento+iii,indexloop_c,rotacion

;filter, i_large_OCN_gradneg
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='OCN_gradneg_'+instrumento+iii,indexloop_c,rotacion

filter, i_large_OCS_gradpos
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='OCS_gradpos_'+instrumento+iii,indexloop_c,rotacion

;filter, i_large_OCS_gradneg
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='OCS_gradneg_'+instrumento+iii,indexloop_c,rotacion

filter, i_open_norte_gradpos_L
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_N_Lgradpos_'+instrumento+iii,indexloop_c,rotacion

;filter, i_open_norte_gradneg
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_N_gradneg_'+instrumento+iii,indexloop_c,rotacion

filter, i_open_sur_gradpos_L
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_S_Lgradpos_'+instrumento+iii,indexloop_c,rotacion

;filter, i_open_sur_gradneg
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_S_gradneg_'+instrumento+iii,indexloop_c,rotacion

filter, i_open_norte_gradpos_H
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_N_Hgradpos_'+instrumento+iii,indexloop_c,rotacion

filter, i_open_sur_gradpos_H
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_S_Hgradpos_'+instrumento+iii,indexloop_c,rotacion

stop
endif


;defino un struct donde van alojados los valores
w1_N     ={vec0:fltarr(n_elements(i_lowlat)), vec1:fltarr(n_elements(i_midlat_small_norte)), vec2:fltarr(n_elements(i_midlat_small_sur)), $
           vec3:fltarr(n_elements(i_large_OCN)), vec4:fltarr(n_elements(i_large_OCS)),vec5:fltarr(n_elements(i_open_norte_L)),vec6:fltarr(n_elements(i_open_sur_L)), $ 
           vec7:fltarr(n_elements(i_open_norte_H)),vec8:fltarr(n_elements(i_open_sur_H))}

w1_lambda={vec0:fltarr(n_elements(i_lowlat)), vec1:fltarr(n_elements(i_midlat_small_norte)), vec2:fltarr(n_elements(i_midlat_small_sur)), $
           vec3:fltarr(n_elements(i_large_OCN)), vec4:fltarr(n_elements(i_large_OCS)),vec5:fltarr(n_elements(i_open_norte_L)),vec6:fltarr(n_elements(i_open_sur_L)), $ 
           vec7:fltarr(n_elements(i_open_norte_H)),vec8:fltarr(n_elements(i_open_sur_H))}

;arrancamos con los 21 filtros....

filter, i_lowlat 
cant_lowlat = cant_lowlat + n_elements (i_lowlat)
w1_N.vec0      = Nebasal_c/1.e8
w1_lambda.vec0 = lambda_N_c

filter, i_midlat_small_norte
cant_midlat_N = cant_midlat_N + n_elements (i_midlat_small_norte)
w1_N.vec1      = Nebasal_c/1.e8
w1_lambda.vec1 = lambda_N_c

filter, i_midlat_small_sur
cant_midlat_S = cant_midlat_S + n_elements (i_midlat_small_sur)
w1_N.vec2      = Nebasal_c/1.e8
w1_lambda.vec2 = lambda_N_c

filter, i_large_OCN
cant_large_OCN = cant_large_OCN + n_elements (i_large_OCN)
w1_N.vec3      = Nebasal_c/1.e8
w1_lambda.vec3 = lambda_N_c

filter, i_large_OCS
cant_large_OCS = cant_large_OCS + n_elements (i_large_OCS)
w1_N.vec4      = Nebasal_c/1.e8
w1_lambda.vec4 = lambda_N_c

filter, i_open_norte_L
cant_open_N_L = cant_open_N_L + n_elements (i_open_norte_L)
w1_N.vec5      = Nebasal_c/1.e8
w1_lambda.vec5 = lambda_N_c

filter, i_open_sur_L
cant_open_S_L = cant_open_S_L + n_elements (i_open_sur_L)
w1_N.vec6      = Nebasal_c/1.e8
w1_lambda.vec6 = lambda_N_c

filter, i_open_norte_H
cant_open_N_H = cant_open_N_H + n_elements (i_open_norte_H)
w1_N.vec7      = Nebasal_c/1.e8
w1_lambda.vec7 = lambda_N_c

filter, i_open_sur_H
cant_open_S_H = cant_open_S_H + n_elements (i_open_sur_H)
w1_N.vec8      = Nebasal_c/1.e8
w1_lambda.vec8 = lambda_N_c



  Ne_basal_m_lowlat  (i) = median(w1_N.vec0)
  Ne_basal_sdv_lowlat(i) = stdev(w1_N.vec0)
  lambdaN_m_lowlat   (i) = median(w1_lambda.vec0)
  lambdaN_sdv_lowlat (i) = stdev(w1_lambda.vec0)

  Ne_basal_m_midlat_N  (i) = median(w1_N.vec1)
  Ne_basal_sdv_midlat_N (i)= stdev(w1_N.vec1)
  lambdaN_m_midlat_N   (i) = median(w1_lambda.vec1)
  lambdaN_sdv_midlat_N (i) = stdev(w1_lambda.vec1)

  Ne_basal_m_midlat_S (i)  = median(w1_N.vec2)
  Ne_basal_sdv_midlat_S (i)= stdev(w1_N.vec2)
  lambdaN_m_midlat_S   (i) = median(w1_lambda.vec2)
  lambdaN_sdv_midlat_S (i) = stdev(w1_lambda.vec2)

  Ne_basal_m_large_OCN  (i) = median(w1_N.vec3)
  Ne_basal_sdv_large_OCN(i) = stdev(w1_N.vec3)
  lambdaN_m_large_OCN   (i) = median(w1_lambda.vec3)
  lambdaN_sdv_large_OCN (i) = stdev(w1_lambda.vec3)

  Ne_basal_m_large_OCS  (i) = median(w1_N.vec4)
  Ne_basal_sdv_large_OCS(i) = stdev(w1_N.vec4)
  lambdaN_m_large_OCS   (i) = median(w1_lambda.vec4)
  lambdaN_sdv_large_OCS (i) = stdev(w1_lambda.vec4)

  Ne_basal_m_open_N_L  (i) = median(w1_N.vec5)
  Ne_basal_sdv_open_N_L(i) = stdev(w1_N.vec5)
  lambdaN_m_open_N_L   (i) = median(w1_lambda.vec5)
  lambdaN_sdv_open_N_L (i) = stdev(w1_lambda.vec5)

  Ne_basal_m_open_S_L  (i) = median(w1_N.vec6)
  Ne_basal_sdv_open_S_L(i) = stdev(w1_N.vec6)
  lambdaN_m_open_S_L   (i) = median(w1_lambda.vec6)
  lambdaN_sdv_open_S_L (i) = stdev(w1_lambda.vec6)

  Ne_basal_m_open_N_H  (i) = median(w1_N.vec7)
  Ne_basal_sdv_open_N_H(i) = stdev(w1_N.vec7)
  lambdaN_m_open_N_H   (i) = median(w1_lambda.vec7)
  lambdaN_sdv_open_N_H (i) = stdev(w1_lambda.vec7)

  Ne_basal_m_open_S_H  (i) = median(w1_N.vec8)
  Ne_basal_sdv_open_S_H(i) = stdev(w1_N.vec8)
  lambdaN_m_open_S_H   (i) = median(w1_lambda.vec8)
  lambdaN_sdv_open_S_H (i) = stdev(w1_lambda.vec8)


w2_Tbasal   ={vec0:fltarr(n_elements(i_lowlat_gradpos)), vec1:fltarr(n_elements(i_midlat_small_norte_gradpos)), vec2:fltarr(n_elements(i_midlat_small_sur_gradpos)), $
              vec3:fltarr(n_elements(i_large_OCN_gradpos)), vec4:fltarr(n_elements(i_large_OCS_gradpos)),vec5:fltarr(n_elements(i_open_norte_gradpos_L)),vec6:fltarr(n_elements(i_open_sur_gradpos_L)), $
              vec7:fltarr(n_elements(i_open_norte_gradpos_H)), vec8:fltarr(n_elements(i_open_sur_gradpos_H))}

w2_Tmean     ={vec0:fltarr(n_elements(i_lowlat_gradpos)), vec1:fltarr(n_elements(i_midlat_small_norte_gradpos)), vec2:fltarr(n_elements(i_midlat_small_sur_gradpos)), $
               vec3:fltarr(n_elements(i_large_OCN_gradpos)), vec4:fltarr(n_elements(i_large_OCS_gradpos)),vec5:fltarr(n_elements(i_open_norte_gradpos_L)),vec6:fltarr(n_elements(i_open_sur_gradpos_L)), $
               vec7:fltarr(n_elements(i_open_norte_gradpos_H)), vec8:fltarr(n_elements(i_open_sur_gradpos_H))}

w2_Tmdv     ={vec0:fltarr(n_elements(i_lowlat_gradpos)), vec1:fltarr(n_elements(i_midlat_small_norte_gradpos)), vec2:fltarr(n_elements(i_midlat_small_sur_gradpos)), $
              vec3:fltarr(n_elements(i_large_OCN_gradpos)), vec4:fltarr(n_elements(i_large_OCS_gradpos)),vec5:fltarr(n_elements(i_open_norte_gradpos_L)),vec6:fltarr(n_elements(i_open_sur_gradpos_L)), $
              vec7:fltarr(n_elements(i_open_norte_gradpos_H)), vec8:fltarr(n_elements(i_open_sur_gradpos_H))}

w2_THS      ={vec0:fltarr(n_elements(i_lowlat_gradpos)), vec1:fltarr(n_elements(i_midlat_small_norte_gradpos)), vec2:fltarr(n_elements(i_midlat_small_sur_gradpos)), $
              vec3:fltarr(n_elements(i_large_OCN_gradpos)), vec4:fltarr(n_elements(i_large_OCS_gradpos)),vec5:fltarr(n_elements(i_open_norte_gradpos_L)),vec6:fltarr(n_elements(i_open_sur_gradpos_L)),$ 
              vec7:fltarr(n_elements(i_open_norte_gradpos_H)), vec8:fltarr(n_elements(i_open_sur_gradpos_H))}


filter, i_lowlat_gradpos
cant_lowlat_gp       = cant_lowlat_gp  + n_elements (i_lowlat_gradpos)
w2_Tbasal.vec0       = Tbasal_c/1.e6
w2_Tmean.vec0         = Tmmean_c/1.e6
w2_Tmdv.vec0         = Tmstddev_c/1.e6
w2_THS.vec0          = Tefit_c/1.e6

filter, i_midlat_small_norte_gradpos
cant_midlat_N_gp     = cant_midlat_N_gp  + n_elements (i_midlat_small_norte_gradpos)
w2_Tbasal.vec1       = Tbasal_c/1.e6
w2_Tmean.vec1         = Tmmean_c/1.e6
w2_Tmdv.vec1         = Tmstddev_c/1.e6
w2_THS.vec1          = Tefit_c/1.e6

filter, i_midlat_small_sur_gradpos
cant_midlat_S_gp     = cant_midlat_S_gp  + n_elements (i_midlat_small_sur_gradpos)
w2_Tbasal.vec2       = Tbasal_c/1.e6
w2_Tmean.vec2         = Tmmean_c/1.e6
w2_Tmdv.vec2         = Tmstddev_c/1.e6
w2_THS.vec2          = Tefit_c/1.e6

filter, i_large_OCN_gradpos
cant_large_OCN_gp    = cant_large_OCN_gp  + n_elements (i_large_OCN_gradpos)
w2_Tbasal.vec3       = Tbasal_c/1.e6
w2_Tmean.vec3         = Tmmean_c/1.e6
w2_Tmdv.vec3         = Tmstddev_c/1.e6
w2_THS.vec3          = Tefit_c/1.e6

filter, i_large_OCS_gradpos
cant_large_OCS_gp    = cant_large_OCS_gp  + n_elements (i_large_OCS_gradpos)
w2_Tbasal.vec4       = Tbasal_c/1.e6
w2_Tmean.vec4         = Tmmean_c/1.e6
w2_Tmdv.vec4         = Tmstddev_c/1.e6
w2_THS.vec4          = Tefit_c/1.e6

filter, i_open_norte_gradpos_L
cant_open_N_gp_L       = cant_open_N_gp_L  + n_elements (i_open_norte_gradpos_L)
w2_Tbasal.vec5       = Tbasal_c/1.e6
w2_Tmean.vec5         = Tmmean_c/1.e6
w2_Tmdv.vec5         = Tmstddev_c/1.e6
w2_THS.vec5          = Tefit_c/1.e6

filter, i_open_sur_gradpos_L
cant_open_S_gp_L       = cant_open_S_gp_L  + n_elements (i_open_sur_gradpos_L)
w2_Tbasal.vec6       = Tbasal_c/1.e6
w2_Tmean.vec6         = Tmmean_c/1.e6
w2_Tmdv.vec6         = Tmstddev_c/1.e6
w2_THS.vec6          = Tefit_c/1.e6

filter, i_open_norte_gradpos_H
cant_open_N_gp_H       = cant_open_N_gp_H  + n_elements (i_open_norte_gradpos_H)
w2_Tbasal.vec7       = Tbasal_c/1.e6
w2_Tmean.vec7         = Tmmean_c/1.e6
w2_Tmdv.vec7         = Tmstddev_c/1.e6
w2_THS.vec7          = Tefit_c/1.e6

filter, i_open_sur_gradpos_H
cant_open_S_gp_H       = cant_open_S_gp_H  + n_elements (i_open_sur_gradpos_H)
w2_Tbasal.vec8       = Tbasal_c/1.e6
w2_Tmean.vec8         = Tmmean_c/1.e6
w2_Tmdv.vec8         = Tmstddev_c/1.e6
w2_THS.vec8          = Tefit_c/1.e6


  Te_basal_m_lowlat_gp  (i) = median(w2_Tbasal.vec0)
  Te_basal_sdv_lowlat_gp (i) = stdev(w2_Tbasal.vec0)
  Te_median_m_lowlat_gp    (i) = median(w2_Tmean.vec0)
  Te_median_sdv_lowlat_gp  (i) = stdev(w2_Tmean.vec0)

  Te_basal_m_midlat_N_gp   (i) = median(w2_Tbasal.vec1)
  Te_basal_sdv_midlat_N_gp (i) = stdev(w2_Tbasal.vec1)
  Te_median_m_midlat_N_gp    (i) = median(w2_Tmean.vec1)
  Te_median_sdv_midlat_N_gp  (i) = stdev(w2_Tmean.vec1)

  Te_basal_m_midlat_S_gp   (i) = median(w2_Tbasal.vec2)
  Te_basal_sdv_midlat_S_gp (i) = stdev(w2_Tbasal.vec2)
  Te_median_m_midlat_S_gp    (i) = median(w2_Tmean.vec2)
  Te_median_sdv_midlat_S_gp  (i) = stdev(w2_Tmean.vec2)

  Te_basal_m_large_OCN_gp   (i) = median(w2_Tbasal.vec3)
  Te_basal_sdv_large_OCN_gp (i) = stdev(w2_Tbasal.vec3)
  Te_median_m_large_OCN_gp    (i) = median(w2_Tmean.vec3)
  Te_median_sdv_large_OCN_gp  (i) = stdev(w2_Tmean.vec3)

  Te_basal_m_large_OCS_gp   (i) = median(w2_Tbasal.vec4)
  Te_basal_sdv_large_OCS_gp (i) = stdev(w2_Tbasal.vec4)
  Te_median_m_large_OCS_gp    (i) = median(w2_Tmean.vec4)
  Te_median_sdv_large_OCS_gp  (i) = stdev(w2_Tmean.vec4)

  Te_basal_m_open_N_gp_L   (i) = median(w2_Tbasal.vec5)
  Te_basal_sdv_open_N_gp_L (i) = stdev(w2_Tbasal.vec5)
  Te_median_m_open_N_gp_L    (i) = median(w2_Tmean.vec5)
  Te_median_sdv_open_N_gp_L  (i) = stdev(w2_Tmean.vec5)

  Te_basal_m_open_S_gp_L   (i) = median(w2_Tbasal.vec6)
  Te_basal_sdv_open_S_gp_L (i) = stdev(w2_Tbasal.vec6)
  Te_median_m_open_S_gp_L    (i) = median(w2_Tmean.vec6)
  Te_median_sdv_open_S_gp_L  (i) = stdev(w2_Tmean.vec6)

  Te_basal_m_open_N_gp_H   (i) = median(w2_Tbasal.vec7)
  Te_basal_sdv_open_N_gp_H (i) = stdev(w2_Tbasal.vec7)
  Te_median_m_open_N_gp_H    (i) = median(w2_Tmean.vec7)
  Te_median_sdv_open_N_gp_H  (i) = stdev(w2_Tmean.vec7)

  Te_basal_m_open_S_gp_H   (i) = median(w2_Tbasal.vec8)
  Te_basal_sdv_open_S_gp_H (i) = stdev(w2_Tbasal.vec8)
  Te_median_m_open_S_gp_H    (i) = median(w2_Tmean.vec8)
  Te_median_sdv_open_S_gp_H  (i) = stdev(w2_Tmean.vec8)



w3_Tbasal ={vec0:fltarr(n_elements(i_lowlat_gradneg)), vec1:fltarr(n_elements(i_midlat_small_norte_gradneg)), vec2:fltarr(n_elements(i_midlat_small_sur_gradneg)), $
            vec3:fltarr(n_elements(i_large_OCN_gradneg)), vec4:fltarr(n_elements(i_large_OCS_gradneg)),vec5:fltarr(n_elements(i_open_norte_gradneg)),vec6:fltarr(n_elements(i_open_sur_gradneg))}

w3_Tmean  ={vec0:fltarr(n_elements(i_lowlat_gradneg)), vec1:fltarr(n_elements(i_midlat_small_norte_gradneg)), vec2:fltarr(n_elements(i_midlat_small_sur_gradneg)), $
            vec3:fltarr(n_elements(i_large_OCN_gradneg)), vec4:fltarr(n_elements(i_large_OCS_gradneg)),vec5:fltarr(n_elements(i_open_norte_gradneg)),vec6:fltarr(n_elements(i_open_sur_gradneg))}

w3_Tmdv   ={vec0:fltarr(n_elements(i_lowlat_gradneg)), vec1:fltarr(n_elements(i_midlat_small_norte_gradneg)), vec2:fltarr(n_elements(i_midlat_small_sur_gradneg)), $
            vec3:fltarr(n_elements(i_large_OCN_gradneg)), vec4:fltarr(n_elements(i_large_OCS_gradneg)),vec5:fltarr(n_elements(i_open_norte_gradneg)),vec6:fltarr(n_elements(i_open_sur_gradneg))}

w3_THS    ={vec0:fltarr(n_elements(i_lowlat_gradneg)), vec1:fltarr(n_elements(i_midlat_small_norte_gradneg)), vec2:fltarr(n_elements(i_midlat_small_sur_gradneg)), $
            vec3:fltarr(n_elements(i_large_OCN_gradneg)), vec4:fltarr(n_elements(i_large_OCS_gradneg)),vec5:fltarr(n_elements(i_open_norte_gradneg)),vec6:fltarr(n_elements(i_open_sur_gradneg))}


filter, i_lowlat_gradneg
cant_lowlat_gn       = cant_lowlat_gn  + n_elements (i_lowlat_gradneg)
w3_Tbasal.vec0       = Tbasal_c/1.e6
w3_Tmean.vec0        = Tmmean_c/1.e6
w3_Tmdv.vec0         = Tmstddev_c/1.e6
w3_THS.vec0          = Tefit_c/1.e6

filter, i_midlat_small_norte_gradneg
cant_midlat_N_gn     = cant_midlat_N_gn  + n_elements (i_midlat_small_norte_gradneg)
w3_Tbasal.vec1       = Tbasal_c/1.e6
w3_Tmean.vec1        = Tmmean_c/1.e6
w3_Tmdv.vec1         = Tmstddev_c/1.e6
w3_THS.vec1          = Tefit_c/1.e6

filter, i_midlat_small_sur_gradneg
cant_midlat_S_gn     = cant_midlat_S_gn  + n_elements (i_midlat_small_sur_gradneg)
w3_Tbasal.vec2       = Tbasal_c/1.e6
w3_Tmean.vec2        = Tmmean_c/1.e6
w3_Tmdv.vec2         = Tmstddev_c/1.e6
w3_THS.vec2          = Tefit_c/1.e6

filter, i_large_OCN_gradneg
cant_large_OCN_gn    = cant_large_OCN_gn  + n_elements (i_large_OCN_gradneg)
w3_Tbasal.vec3       = Tbasal_c/1.e6
w3_Tmean.vec3        = Tmmean_c/1.e6
w3_Tmdv.vec3         = Tmstddev_c/1.e6
w3_THS.vec3          = Tefit_c/1.e6

filter, i_large_OCS_gradneg
cant_large_OCS_gn    = cant_large_OCS_gn  + n_elements (i_large_OCS_gradneg)
w3_Tbasal.vec4       = Tbasal_c/1.e6
w3_Tmean.vec4        = Tmmean_c/1.e6
w3_Tmdv.vec4         = Tmstddev_c/1.e6
w3_THS.vec4          = Tefit_c/1.e6

filter, i_open_norte_gradneg
cant_open_N_gn       = cant_open_N_gn  + n_elements (i_open_norte_gradneg)
w3_Tbasal.vec5       = Tbasal_c/1.e6
w3_Tmean.vec5        = Tmmean_c/1.e6
w3_Tmdv.vec5         = Tmstddev_c/1.e6
w3_THS.vec5          = Tefit_c/1.e6

filter, i_open_sur_gradneg
cant_open_S_gn       = cant_open_S_gn  + n_elements (i_open_sur_gradneg)
w3_Tbasal.vec6       = Tbasal_c/1.e6
w3_Tmean.vec6        = Tmmean_c/1.e6
w3_Tmdv.vec6         = Tmstddev_c/1.e6
w3_THS.vec6          = Tefit_c/1.e6

  Te_basal_m_lowlat_gn   (i) = median(w3_Tbasal.vec0)
  Te_basal_sdv_lowlat_gn (i) = stdev(w3_Tbasal.vec0)
  Te_median_m_lowlat_gn    (i) = median(w3_Tmean.vec0)
  Te_median_sdv_lowlat_gn  (i) = stdev(w3_Tmean.vec0)

  Te_basal_m_midlat_N_gn   (i) = median(w3_Tbasal.vec1)
  Te_basal_sdv_midlat_N_gn (i) = stdev(w3_Tbasal.vec1)
  Te_median_m_midlat_N_gn    (i) = median(w3_Tmean.vec1)
  Te_median_sdv_midlat_N_gn  (i) = stdev(w3_Tmean.vec1)

  Te_basal_m_midlat_S_gn   (i) = median(w3_Tbasal.vec2)
  Te_basal_sdv_midlat_S_gn (i) = stdev(w3_Tbasal.vec2)
  Te_median_m_midlat_S_gn    (i) = median(w3_Tmean.vec2)
  Te_median_sdv_midlat_S_gn  (i) = stdev(w3_Tmean.vec2)

  Te_basal_m_large_OCN_gn   (i) = median(w3_Tbasal.vec3)
  Te_basal_sdv_large_OCN_gn (i) = stdev(w3_Tbasal.vec3)
  Te_median_m_large_OCN_gn    (i) = median(w3_Tmean.vec3)
  Te_median_sdv_large_OCN_gn  (i) = stdev(w3_Tmean.vec3)

  Te_basal_m_large_OCS_gn   (i) = median(w3_Tbasal.vec4)
  Te_basal_sdv_large_OCS_gn (i) = stdev(w3_Tbasal.vec4)
  Te_median_m_large_OCS_gn    (i) = median(w3_Tmean.vec4)
  Te_median_sdv_large_OCS_gn  (i) = stdev(w3_Tmean.vec4)

  Te_basal_m_open_N_gn   (i) = median(w3_Tbasal.vec5)
  Te_basal_sdv_open_N_gn (i) = stdev(w3_Tbasal.vec5)
  Te_median_m_open_N_gn    (i) = median(w3_Tmean.vec5)
  Te_median_sdv_open_N_gn  (i) = stdev(w3_Tmean.vec5)

  Te_basal_m_open_S_gn   (i) = median(w3_Tbasal.vec6)
  Te_basal_sdv_open_S_gn (i) = stdev(w3_Tbasal.vec6)
  Te_median_m_open_S_gn    (i) = median(w3_Tmean.vec6)
  Te_median_sdv_open_S_gn  (i) = stdev(w3_Tmean.vec6)

print, 'Termina loop' ,i

endfor
  
;llegado a este punto tengo vectores de 13 componentes.
;Si lo que quiero mostrar es el valor medio y la desviacion estandar
;de eso, es facil de aplicar. Solo quedaria ver exactamente que es lo
;que queremos y como escribirlo para que me saque directamente una tabla.

;Notar que ahora puedo obtener los datos mean y stdev de los vectores (no de los structs) y listo el pollo. ---> camino corto
;El camino largo ---> seria hacer un struct para cada trazado que contenga los 4 structs "w*" definidos mas arriba. Esto esta bueno
;si quiero correr una sola vez todo y me quedo con todas los datos importantes (luego de filtrar) en 1 ùnico struct.
;Luego esto lo muestro en una tabla para latex (creadno un tex) como hizo fede y listo!

;goto, skiptablas
openw,1,'Tablas_comparacion_'+instrumento+'_mediana_theilsen_rcerrado_grande_nuevo.txt'

        printf,1,'==========================================================================================='
        printf,1,'------------------------------ '+instrumento+'---------------------------------------------'
        printf,1,'==========================================================================================='
        printf,1,'-------------------------------------------------------------------------------------------'
        printf,1,' region    mean(Ne_basal_m)    mean(Ne_b_sdv/Ne_b_m)   mean(lambda_N_m)  mean(lambda_sdv/lambda_m) Cant. piernas'
        printf,1,''
        printf,1, format='("lowlat   ",4(f8.3),I9)',$
                   mean(Ne_basal_m_lowlat),    mean(Ne_basal_sdv_lowlat/Ne_basal_m_lowlat),      mean(lambdaN_m_lowlat),    mean(lambdaN_sdv_lowlat/lambdaN_m_lowlat)      ,cant_lowlat
        printf,1, format='("midlat(N)",4(f8.3),I9)',$
                  mean(Ne_basal_m_midlat_N),  mean(Ne_basal_sdv_midlat_N/Ne_basal_m_midlat_N),  mean(lambdaN_m_midlat_N),  mean(lambdaN_sdv_midlat_N/lambdaN_m_midlat_N)  ,cant_midlat_N
        printf,1, format='("midlat(S)",4(f8.3),I9)',$
                  mean(Ne_basal_m_midlat_S),  mean(Ne_basal_sdv_midlat_S/Ne_basal_m_midlat_S),  mean(lambdaN_m_midlat_S),  mean(lambdaN_sdv_midlat_S/lambdaN_m_midlat_S)  ,cant_midlat_S
        printf,1, format='("large_OCN",4(f8.3),I9)',$
                  mean(Ne_basal_m_large_OCN), mean(Ne_basal_sdv_large_OCN/Ne_basal_m_large_OCN),mean(lambdaN_m_large_OCN), mean(lambdaN_sdv_large_OCN/lambdaN_m_large_OCN),cant_large_OCN
        printf,1, format='("large_OCS",4(f8.3),I9)',$
                  mean(Ne_basal_m_large_OCS), mean(Ne_basal_sdv_large_OCS/Ne_basal_m_large_OCS),mean(lambdaN_m_large_OCS), mean(lambdaN_sdv_large_OCS/lambdaN_m_large_OCS),cant_large_OCS
        printf,1, format='("openNL   ",4(f8.3),I9)',$
                  mean(Ne_basal_m_open_N_L),    mean(Ne_basal_sdv_open_N_L/Ne_basal_m_open_N_L),      mean(lambdaN_m_open_N_L),    mean(lambdaN_sdv_open_N_L/lambdaN_m_open_N_L)      ,cant_open_N_L
        printf,1, format='("openSL   ",4(f8.3),I9)',$
                  mean(Ne_basal_m_open_S_L),    mean(Ne_basal_sdv_open_S_L/Ne_basal_m_open_S_L),      mean(lambdaN_m_open_S_L),    mean(lambdaN_sdv_open_S_L/lambdaN_m_open_S_L)      ,cant_open_S_L
        printf,1, format='("openNH   ",4(f8.3),I9)',$
                  mean(Ne_basal_m_open_N_H),    mean(Ne_basal_sdv_open_N_H/Ne_basal_m_open_N_H),      mean(lambdaN_m_open_N_H),    mean(lambdaN_sdv_open_N_H/lambdaN_m_open_N_H)      ,cant_open_N_H
        printf,1, format='("openSH   ",4(f8.3),I9)',$
                  mean(Ne_basal_m_open_S_H),    mean(Ne_basal_sdv_open_S_H/Ne_basal_m_open_S_H),      mean(lambdaN_m_open_S_H),    mean(lambdaN_sdv_open_S_H/lambdaN_m_open_S_H)      ,cant_open_S_H
       
        printf,1,''
        printf,1,' region(GP)    mean(Te_basal_m)    mean(Te_b_sdv/Te_b_m)   mean(Te_medio_m)  mean(Te_medio_sdv/Te_medio_m) Cant. piernas'
        printf,1, format='("lowlat   ",4(f8.3),I9)',$
                  mean(Te_basal_m_lowlat_gp),    mean(Te_basal_sdv_lowlat_gp/Te_basal_m_lowlat_gp),      mean(Te_median_m_lowlat_gp),    mean(Te_median_sdv_lowlat_gp/Te_median_m_lowlat_gp)      ,cant_lowlat_gp
        printf,1, format='("midlat(N)",4(f8.3),I9)',$
                  mean(Te_basal_m_midlat_N_gp),  mean(Te_basal_sdv_midlat_N_gp/Te_basal_m_midlat_N_gp),  mean(Te_median_m_midlat_N_gp),  mean(Te_median_sdv_midlat_N_gp/Te_median_m_midlat_N_gp)  ,cant_midlat_N_gp
        printf,1, format='("midlat(S)",4(f8.3),I9)',$
                  mean(Te_basal_m_midlat_S_gp),  mean(Te_basal_sdv_midlat_S_gp/Te_basal_m_midlat_S_gp),  mean(Te_median_m_midlat_S_gp),  mean(Te_median_sdv_midlat_S_gp/Te_median_m_midlat_S_gp)  ,cant_midlat_S_gp
        printf,1, format='("large_OCN",4(f8.3),I9)',$
                  mean(Te_basal_m_large_OCN_gp), mean(Te_basal_sdv_large_OCN_gp/Te_basal_m_large_OCN_gp),mean(Te_median_m_large_OCN_gp), mean(Te_median_sdv_large_OCN_gp/Te_median_m_large_OCN_gp),cant_large_OCN_gp
        printf,1, format='("large_OCS",4(f8.3),I9)',$
                  mean(Te_basal_m_large_OCS_gp), mean(Te_basal_sdv_large_OCS_gp/Te_basal_m_large_OCS_gp),mean(Te_median_m_large_OCS_gp), mean(Te_median_sdv_large_OCS_gp/Te_median_m_large_OCS_gp),cant_large_OCS_gp
        printf,1, format='("open(NL)  ",4(f8.3),I9)',$
                  mean(Te_basal_m_open_N_gp_L),    mean(Te_basal_sdv_open_N_gp_L/Te_basal_m_open_N_gp_L),      mean(Te_median_m_open_N_gp_L),    mean(Te_median_sdv_open_N_gp_L/Te_median_m_open_N_gp_L)      ,cant_open_N_gp_L
        printf,1, format='("open(SL)  ",4(f8.3),I9)',$
                  mean(Te_basal_m_open_S_gp_L),    mean(Te_basal_sdv_open_S_gp_L/Te_basal_m_open_S_gp_L),      mean(Te_median_m_open_S_gp_L),    mean(Te_median_sdv_open_S_gp_L/Te_median_m_open_S_gp_L)      ,cant_open_S_gp_L
       printf,1, format='("open(NH)  ",4(f8.3),I9)',$
                  mean(Te_basal_m_open_N_gp_H),    mean(Te_basal_sdv_open_N_gp_H/Te_basal_m_open_N_gp_H),      mean(Te_median_m_open_N_gp_H),    mean(Te_median_sdv_open_N_gp_H/Te_median_m_open_N_gp_H)      ,cant_open_N_gp_H
        printf,1, format='("open(SH)  ",4(f8.3),I9)',$
                  mean(Te_basal_m_open_S_gp_H),    mean(Te_basal_sdv_open_S_gp_H/Te_basal_m_open_S_gp_H),      mean(Te_median_m_open_S_gp_H),    mean(Te_median_sdv_open_S_gp_H/Te_median_m_open_S_gp_H)      ,cant_open_S_gp_H

        printf,1,''
        printf,1,' region(GN)    mean(Te_basal_m)    mean(Te_b_sdv/Te_b_m)   mean(Te_medio_m)  mean(Te_medio_sdv/Te_medio_m) Cant. Piernas'
        printf,1, format='("lowlat   ",4(f8.3),I9)',$
                  mean(Te_basal_m_lowlat_gn),    mean(Te_basal_sdv_lowlat_gn/Te_basal_m_lowlat_gn),      mean(Te_median_m_lowlat_gn),    mean(Te_median_sdv_lowlat_gn/Te_median_m_lowlat_gn)      ,cant_lowlat_gn
        printf,1, format='("midlat(N)",4(f8.3),I9)',$
                  mean(Te_basal_m_midlat_N_gn),  mean(Te_basal_sdv_midlat_N_gn/Te_basal_m_midlat_N_gn),  mean(Te_median_m_midlat_N_gn),  mean(Te_median_sdv_midlat_N_gn/Te_median_m_midlat_N_gn)  ,cant_midlat_N_gn
        printf,1, format='("midlat(S)",4(f8.3),I9)',$
                  mean(Te_basal_m_midlat_S_gn),  mean(Te_basal_sdv_midlat_S_gn/Te_basal_m_midlat_S_gn),  mean(Te_median_m_midlat_S_gn),  mean(Te_median_sdv_midlat_S_gn/Te_median_m_midlat_S_gn)  ,cant_midlat_S_gn
        printf,1, format='("large_OCN",4(f8.3),I9)',$
                  mean(Te_basal_m_large_OCN_gn), mean(Te_basal_sdv_large_OCN_gn/Te_basal_m_large_OCN_gn),mean(Te_median_m_large_OCN_gn), mean(Te_median_sdv_large_OCN_gn/Te_median_m_large_OCN_gn),cant_large_OCN_gn
        printf,1, format='("large_OCS",4(f8.3),I9)',$
                  mean(Te_basal_m_large_OCS_gn), mean(Te_basal_sdv_large_OCS_gn/Te_basal_m_large_OCS_gn),mean(Te_median_m_large_OCS_gn), mean(Te_median_sdv_large_OCS_gn/Te_median_m_large_OCS_gn),cant_large_OCS_gn
        printf,1, format='("open(N)  ",4(f8.3),I9)',$
                  mean(Te_basal_m_open_N_gn),    mean(Te_basal_sdv_open_N_gn/Te_basal_m_open_N_gn),      mean(Te_median_m_open_N_gn),    mean(Te_median_sdv_open_N_gn/Te_median_m_open_N_gn)      ,cant_open_N_gn
        printf,1, format='("open(S)  ",4(f8.3),I9)',$
                  mean(Te_basal_m_open_S_gn),    mean(Te_basal_sdv_open_S_gn/Te_basal_m_open_S_gn),      mean(Te_median_m_open_S_gn),    mean(Te_median_sdv_open_S_gn/Te_median_m_open_S_gn)      ,cant_open_S_gn
        printf,1,''
        if Nf gt 1 then begin


           printf,1,'==========================================================================================='
           printf,1,'------------------------------ '+instrumento+'---------------------------------------------'
           printf,1,'==========================================================================================='
           printf,1,'-------------------------------------------------------------------------------------------'
           printf,1,' region    error(Ne_basal)    error(Ne_b_sdv/Ne_b_m)   error(lambda_N)  error(lambda_N_sdv/lambda_N_m) '
           printf,1,''
           printf,1, format='("lowlat   ",4(f7.3))',$
                  stdev(Ne_basal_m_lowlat)/mean(Ne_basal_m_lowlat),      stdev(Ne_basal_sdv_lowlat/Ne_basal_m_lowlat)/mean(Ne_basal_sdv_lowlat/Ne_basal_m_lowlat),      stdev(lambdaN_m_lowlat)/mean(lambdaN_m_lowlat),      stdev(lambdaN_sdv_lowlat/lambdaN_m_lowlat)/mean(lambdaN_sdv_lowlat/lambdaN_m_lowlat)
           printf,1, format='("midlat_N ",4(f7.3))',$
                  stdev(Ne_basal_m_midlat_N)/mean(Ne_basal_m_midlat_N),  stdev(Ne_basal_sdv_midlat_N/Ne_basal_m_midlat_N)/mean(Ne_basal_sdv_midlat_N/Ne_basal_m_midlat_N),  stdev(lambdaN_m_midlat_N)/mean(lambdaN_m_midlat_N),  stdev(lambdaN_sdv_midlat_N/lambdaN_m_midlat_N)/mean(lambdaN_sdv_midlat_N/lambdaN_m_midlat_N)
           printf,1, format='("midlat_S ",4(f7.3))',$
                  stdev(Ne_basal_m_midlat_S)/mean(Ne_basal_m_midlat_S),  stdev(Ne_basal_sdv_midlat_S/Ne_basal_m_midlat_S)/mean(Ne_basal_sdv_midlat_S/Ne_basal_m_midlat_S),  stdev(lambdaN_m_midlat_S)/mean(lambdaN_m_midlat_S),  stdev(lambdaN_sdv_midlat_S/lambdaN_m_midlat_S)/mean(lambdaN_sdv_midlat_S/lambdaN_m_midlat_S)
           printf,1, format='("large_OCN",4(f7.3))',$
                  stdev(Ne_basal_m_large_OCN)/mean(Ne_basal_m_large_OCN),stdev(Ne_basal_sdv_large_OCN/Ne_basal_m_large_OCN)/mean(Ne_basal_sdv_large_OCN/Ne_basal_m_large_OCN),stdev(lambdaN_m_large_OCN)/mean(lambdaN_m_large_OCN),stdev(lambdaN_sdv_large_OCN/lambdaN_m_large_OCN)/mean(lambdaN_sdv_large_OCN/lambdaN_m_large_OCN)

           printf,1, format='("large_OCS",4(f7.3))',$
                  stdev(Ne_basal_m_large_OCS)/mean(Ne_basal_m_large_OCS),stdev(Ne_basal_sdv_large_OCS/Ne_basal_m_large_OCS)/mean(Ne_basal_sdv_large_OCS/Ne_basal_m_large_OCS),stdev(lambdaN_m_large_OCS)/mean(lambdaN_m_large_OCS),stdev(lambdaN_sdv_large_OCS/lambdaN_m_large_OCS)/mean(lambdaN_sdv_large_OCS/lambdaN_m_large_OCS)
           printf,1, format='("openNL   ",4(f7.3))',$
                  stdev(Ne_basal_m_open_N_L)/mean(Ne_basal_m_open_N_L),      stdev(Ne_basal_sdv_open_N_L/Ne_basal_m_open_N_L)/mean(Ne_basal_sdv_open_N_L/Ne_basal_m_open_N_L),      stdev(lambdaN_m_open_N_L)/mean(lambdaN_m_open_N_L),      stdev(lambdaN_sdv_open_N_L/lambdaN_m_open_N_L)/mean(lambdaN_sdv_open_N_L/lambdaN_m_open_N_L)
           printf,1, format='("openSL   ",4(f7.3))',$
                  stdev(Ne_basal_m_open_S_L)/mean(Ne_basal_m_open_S_L),      stdev(Ne_basal_sdv_open_S_L/Ne_basal_m_open_S_L)/mean(Ne_basal_sdv_open_S_L/Ne_basal_m_open_S_L),      stdev(lambdaN_m_open_S_L)/mean(lambdaN_m_open_S_L),      stdev(lambdaN_sdv_open_S_L/lambdaN_m_open_S_L)/mean(lambdaN_sdv_open_S_L/lambdaN_m_open_S_L)
           printf,1, format='("openNH   ",4(f7.3))',$
                  stdev(Ne_basal_m_open_N_H)/mean(Ne_basal_m_open_N_H),      stdev(Ne_basal_sdv_open_N_H/Ne_basal_m_open_N_H)/mean(Ne_basal_sdv_open_N_H/Ne_basal_m_open_N_H),      stdev(lambdaN_m_open_N_H)/mean(lambdaN_m_open_N_H),      stdev(lambdaN_sdv_open_N_H/lambdaN_m_open_N_H)/mean(lambdaN_sdv_open_N_H/lambdaN_m_open_N_H)
           printf,1, format='("openSH   ",4(f7.3))',$
                  stdev(Ne_basal_m_open_S_H)/mean(Ne_basal_m_open_S_H),      stdev(Ne_basal_sdv_open_S_H/Ne_basal_m_open_S_H)/mean(Ne_basal_sdv_open_S_H/Ne_basal_m_open_S_H),      stdev(lambdaN_m_open_S_H)/mean(lambdaN_m_open_S_H),      stdev(lambdaN_sdv_open_S_H/lambdaN_m_open_S_H)/mean(lambdaN_sdv_open_S_H/lambdaN_m_open_S_H)

           printf,1,''
           printf,1,' region(GP)    error(Te_basal)    error(Te_b_sdv/Te_b_m)   error(Te_medio)  error(Te_medio_sdv/Te_medio_m) '
           printf,1, format='("lowlat   ",4(f7.3))',$
                  stdev(Te_basal_m_lowlat_gp)/mean(Te_basal_m_lowlat_gp),      stdev(Te_basal_sdv_lowlat_gp/Te_basal_m_lowlat_gp)/mean(Te_basal_sdv_lowlat_gp/Te_basal_m_lowlat_gp),      stdev(Te_median_m_lowlat_gp)/mean(Te_median_m_lowlat_gp),      stdev(Te_median_sdv_lowlat_gp/Te_median_m_lowlat_gp)/mean(Te_median_sdv_lowlat_gp/Te_median_m_lowlat_gp)
           printf,1, format='("midlat(N)",4(f7.3))',$
                  stdev(Te_basal_m_midlat_N_gp)/mean(Te_basal_m_midlat_N_gp),  stdev(Te_basal_sdv_midlat_N_gp/Te_basal_m_midlat_N_gp)/mean(Te_basal_sdv_midlat_N_gp/Te_basal_m_midlat_N_gp),  stdev(Te_median_m_midlat_N_gp)/mean(Te_median_m_midlat_N_gp),  stdev(Te_median_sdv_midlat_N_gp/Te_median_m_midlat_N_gp)/mean(Te_median_sdv_midlat_N_gp/Te_median_m_midlat_N_gp)
           printf,1, format='("midlat(S)",4(f7.3))',$
                  stdev(Te_basal_m_midlat_S_gp)/mean(Te_basal_m_midlat_S_gp),  stdev(Te_basal_sdv_midlat_S_gp/Te_basal_m_midlat_S_gp)/mean(Te_basal_sdv_midlat_S_gp/Te_basal_m_midlat_S_gp),  stdev(Te_median_m_midlat_S_gp)/mean(Te_median_m_midlat_S_gp),  stdev(Te_median_sdv_midlat_S_gp/Te_median_m_midlat_S_gp)/mean(Te_median_sdv_midlat_S_gp/Te_median_m_midlat_S_gp)
           printf,1, format='("large_OCN",4(f7.3))',$
                  stdev(Te_basal_m_large_OCN_gp)/mean(Te_basal_m_large_OCN_gp),stdev(Te_basal_sdv_large_OCN_gp/Te_basal_m_large_OCN_gp)/mean(Te_basal_sdv_large_OCN_gp/Te_basal_m_large_OCN_gp),stdev(Te_median_m_large_OCN_gp)/mean(Te_median_m_large_OCN_gp),stdev(Te_median_sdv_large_OCN_gp/Te_median_m_large_OCN_gp)/mean(Te_median_sdv_large_OCN_gp/Te_median_m_large_OCN_gp)
           printf,1, format='("large_OCS",4(f7.3))',$
                  stdev(Te_basal_m_large_OCS_gp)/mean(Te_basal_m_large_OCS_gp),stdev(Te_basal_sdv_large_OCS_gp/Te_basal_m_large_OCS_gp)/mean(Te_basal_sdv_large_OCS_gp/Te_basal_m_large_OCS_gp),stdev(Te_median_m_large_OCS_gp)/mean(Te_median_m_large_OCS_gp),stdev(Te_median_sdv_large_OCS_gp/Te_median_m_large_OCS_gp)/mean(Te_median_sdv_large_OCS_gp/Te_median_m_large_OCS_gp)
           printf,1, format='("open(NL) ",4(f7.3))',$
                  stdev(Te_basal_m_open_N_gp_L)/mean(Te_basal_m_open_N_gp_L),      stdev(Te_basal_sdv_open_N_gp_L/Te_basal_m_open_N_gp_L)/mean(Te_basal_sdv_open_N_gp_L/Te_basal_m_open_N_gp_L),      stdev(Te_median_m_open_N_gp_L)/mean(Te_median_m_open_N_gp_L),      stdev(Te_median_sdv_open_N_gp_L/Te_median_m_open_N_gp_L)/mean(Te_median_sdv_open_N_gp_L/Te_median_m_open_N_gp_L)
           printf,1, format='("open(SL) ",4(f7.3))',$
                  stdev(Te_basal_m_open_S_gp_L)/mean(Te_basal_m_open_S_gp_L),      stdev(Te_basal_sdv_open_S_gp_L/Te_basal_m_open_S_gp_L)/mean(Te_basal_sdv_open_S_gp_L/Te_basal_m_open_S_gp_L),      stdev(Te_median_m_open_S_gp_L)/mean(Te_median_m_open_S_gp_L),      stdev(Te_median_sdv_open_S_gp_L/Te_median_m_open_S_gp_L)/mean(Te_median_sdv_open_S_gp_L/Te_median_m_open_S_gp_L)
           printf,1, format='("open(NH) ",4(f7.3))',$
                  stdev(Te_basal_m_open_N_gp_H)/mean(Te_basal_m_open_N_gp_H),      stdev(Te_basal_sdv_open_N_gp_H/Te_basal_m_open_N_gp_H)/mean(Te_basal_sdv_open_N_gp_H/Te_basal_m_open_N_gp_H),      stdev(Te_median_m_open_N_gp_H)/mean(Te_median_m_open_N_gp_H),      stdev(Te_median_sdv_open_N_gp_H/Te_median_m_open_N_gp_H)/mean(Te_median_sdv_open_N_gp_H/Te_median_m_open_N_gp_H)
           printf,1, format='("open(SH) ",4(f7.3))',$
                  stdev(Te_basal_m_open_S_gp_H)/mean(Te_basal_m_open_S_gp_H),      stdev(Te_basal_sdv_open_S_gp_H/Te_basal_m_open_S_gp_H)/mean(Te_basal_sdv_open_S_gp_H/Te_basal_m_open_S_gp_H),      stdev(Te_median_m_open_S_gp_H)/mean(Te_median_m_open_S_gp_H),      stdev(Te_median_sdv_open_S_gp_H/Te_median_m_open_S_gp_H)/mean(Te_median_sdv_open_S_gp_H/Te_median_m_open_S_gp_H)

           printf,1,''
           printf,1,' region(GN)    error(Te_basal)    error(Te_b_sdv/Te_b_m)   error(Te_medio)  error(Te_medio_sdv/Te_medio_m) '
           printf,1, format='("lowlat   ",4(f7.3))',$
                  stdev(Te_basal_m_lowlat_gn)/mean(Te_basal_m_lowlat_gn),      stdev(Te_basal_sdv_lowlat_gn/Te_basal_m_lowlat_gn)/mean(Te_basal_sdv_lowlat_gn/Te_basal_m_lowlat_gn),      stdev(Te_median_m_lowlat_gn)/mean(Te_median_m_lowlat_gn),      stdev(Te_median_sdv_lowlat_gn/Te_median_m_lowlat_gn)/mean(Te_median_sdv_lowlat_gn/Te_median_m_lowlat_gn)
           printf,1, format='("midlat(N)",4(f7.3))',$
                  stdev(Te_basal_m_midlat_N_gn)/mean(Te_basal_m_midlat_N_gn),  stdev(Te_basal_sdv_midlat_N_gn/Te_basal_m_midlat_N_gn)/mean(Te_basal_sdv_midlat_N_gn/Te_basal_m_midlat_N_gn),  stdev(Te_median_m_midlat_N_gn)/mean(Te_median_m_midlat_N_gn),  stdev(Te_median_sdv_midlat_N_gn/Te_median_m_midlat_N_gn)/mean(Te_median_sdv_midlat_N_gn/Te_median_m_midlat_N_gn)
           printf,1, format='("midlat(S)",4(f7.3))',$
                  stdev(Te_basal_m_midlat_S_gn)/mean(Te_basal_m_midlat_S_gn),  stdev(Te_basal_sdv_midlat_S_gn/Te_basal_m_midlat_S_gn)/mean(Te_basal_sdv_midlat_S_gn/Te_basal_m_midlat_S_gn),  stdev(Te_median_m_midlat_S_gn)/mean(Te_median_m_midlat_S_gn),  stdev(Te_median_sdv_midlat_S_gn/Te_median_m_midlat_S_gn)/mean(Te_median_sdv_midlat_S_gn/Te_median_m_midlat_S_gn)
           printf,1, format='("large_OCN",4(f7.3))',$
                  stdev(Te_basal_m_large_OCN_gn)/mean(Te_basal_m_large_OCN_gn),stdev(Te_basal_sdv_large_OCN_gn/Te_basal_m_large_OCN_gn)/mean(Te_basal_sdv_large_OCN_gn/Te_basal_m_large_OCN_gn),stdev(Te_median_m_large_OCN_gn)/mean(Te_median_m_large_OCN_gn),stdev(Te_median_sdv_large_OCN_gn/Te_median_m_large_OCN_gn)/mean(Te_median_sdv_large_OCN_gn/Te_median_m_large_OCN_gn)
           printf,1, format='("large_OCS",4(f7.3))',$
                  stdev(Te_basal_m_large_OCS_gn)/mean(Te_basal_m_large_OCS_gn),stdev(Te_basal_sdv_large_OCS_gn/Te_basal_m_large_OCS_gn)/mean(Te_basal_sdv_large_OCS_gn/Te_basal_m_large_OCS_gn),stdev(Te_median_m_large_OCS_gn)/mean(Te_median_m_large_OCS_gn),stdev(Te_median_sdv_large_OCS_gn/Te_median_m_large_OCS_gn)/mean(Te_median_sdv_large_OCS_gn/Te_median_m_large_OCS_gn)
           printf,1, format='("open(N)  ",4(f7.3))',$
                  stdev(Te_basal_m_open_N_gn)/mean(Te_basal_m_open_N_gn),      stdev(Te_basal_sdv_open_N_gn/Te_basal_m_open_N_gn)/mean(Te_basal_sdv_open_N_gn/Te_basal_m_open_N_gn),      stdev(Te_median_m_open_N_gn)/mean(Te_median_m_open_N_gn),      stdev(Te_median_sdv_open_N_gn/Te_median_m_open_N_gn)/mean(Te_median_sdv_open_N_gn/Te_median_m_open_N_gn)
           printf,1, format='("open(S)  ",4(f7.3))',$
                  stdev(Te_basal_m_open_S_gn)/mean(Te_basal_m_open_S_gn),      stdev(Te_basal_sdv_open_S_gn/Te_basal_m_open_S_gn)/mean(Te_basal_sdv_open_S_gn/Te_basal_m_open_S_gn),      stdev(Te_median_m_open_S_gn)/mean(Te_median_m_open_S_gn),      stdev(Te_median_sdv_open_S_gn/Te_median_m_open_S_gn)/mean(Te_median_sdv_open_S_gn/Te_median_m_open_S_gn)
           printf,1,''

        endif

close,1

print, 'Impresion en --->  Tablas_comparacion_'+instrumento+'_mediana_theilsen_rcerrado_grande_nuevo.txt'
skiptablas:


;Ajuste Hidrostatico
directoEHI:
if keyword_set(EHI) then begin


rstart      = 1.035+0.02*findgen(10)

 filesT = ['traceLDEM_CR2081_euviA-NODECON_reg0.75_safety0.5_errorbox_base_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
           'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_base_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat']
 nf=2

 r2crit_N = 0.8
 nbins = 50
 r2crit_T = 0.75

 alturas = n_elements(rstart)


 read_trace_sampled,filesT[0],alturas
 statloop,filesT[0],rloopmin=1.05,/linear,/FITCUAdr,/altura
 lonmax=360.
 lowlatmax=30.
 instrumento='euvi_ts'
sigT_muT_crit = 0.10
stringT_crit =strmid(sigT_muT_crit,5,4)
;fact=3.
vcrit = 10.0

i_lowlat_gradneg_HI = where(gradT ne -555. AND opclstat eq 2. and f_t gt r2crit_T and r2N gt r2crit_N and abs(footlat) le lowlatmax and gradT le 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_lowlat_gradneg_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_lowlat_gn_'+instrumento+stringT_crit,indexloop_c,rotacion
w3_Tmeanvec0        = Tmmean_c/1.e6
w3_THSvec0          = Tefit_c/1.e6
a0       = w3_Tmeanvec0 - w3_THSvec0
Deltagn0A = ( a0 / mean(w3_Tmeanvec0) ) > (-vcrit) < vcrit   ;medida de consistencia  DEMT - EHI

i_midlat_small_norte_gradpos_HI = where(gradT ne -555. AND opclstat eq 2. and f_t gt r2crit_T and r2N gt r2crit_N and footlat gt 30. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_midlat_small_norte_gradpos_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_midlat_N_gp_'+instrumento+stringT_crit,indexloop_c,rotacion
w2_Tmeanvec1        = Tmmean_c/1.e6
w2_THSvec1          = Tefit_c/1.e6
a1       = w2_Tmeanvec1 - w2_THSvec1
Deltagp1A = ( a1 / mean(w2_Tmeanvec1) ) > (-vcrit) < vcrit

i_midlat_small_sur_gradpos_HI = where(gradT ne -555. AND opclstat eq 2. and f_t gt r2crit_T and r2N gt r2crit_N and footlat le -30. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_midlat_small_sur_gradpos_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_midlat_S_gp_'+instrumento+stringT_crit,indexloop_c,rotacion
w2_Tmeanvec2        = Tmmean_c/1.e6
w2_THSvec2          = Tefit_c/1.e6
a2       = w2_Tmeanvec2 - w2_THSvec2
Deltagp2A = ( a2 / mean(w2_Tmeanvec2) ) > (-vcrit) < vcrit

i_large_OCN_gradpos_HI = where(gradT ne -555. AND opclstat eq 1. and f_t ge r2crit_T and r2N gt r2crit_N and footlat gt +40. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_large_OCN_gradpos_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_OCN_gp_'+instrumento+stringT_crit,indexloop_c,rotacion
w2_Tmeanvec3        = Tmmean_c/1.e6
w2_THSvec3          = Tefit_c/1.e6
a3       = w2_Tmeanvec3 - w2_THSvec3
Deltagp3A = ( a3 / mean(w2_Tmeanvec3) ) > (-vcrit) < vcrit

i_large_OCS_gradpos_HI = where(gradT ne -555. AND opclstat eq 1. and f_t ge r2crit_T and r2N gt r2crit_N and footlat lt -40. and footlat gt -80. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_large_OCS_gradpos_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_OCS_gp_'+instrumento+stringT_crit,indexloop_c,rotacion
w2_Tmeanvec4        = Tmmean_c/1.e6
w2_THSvec4          = Tefit_c/1.e6
a4       = w2_Tmeanvec4 - w2_THSvec4
Deltagp4A = ( a4 / mean(w2_Tmeanvec4) ) > (-vcrit) < vcrit

i_open_norte_gradpos_HI_L = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and r2N gt r2crit_N and footlat lt 68. and footlat gt 0. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_open_norte_gradpos_HI_L
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_openN_L_gp_'+instrumento+stringT_crit,indexloop_c,rotacion
w2_Tmeanvec5        = Tmmean_c/1.e6
w2_THSvec5          = Tefit_c/1.e6
a5       = w2_Tmeanvec5 - w2_THSvec5
Deltagp5A = ( a5 / mean(w2_Tmeanvec5) ) > (-vcrit) < vcrit

i_open_sur_gradpos_HI_L = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and r2N gt r2crit_N and footlat gt -68. and footlat le 0. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_open_sur_gradpos_HI_L
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_openS_L_gp_'+instrumento+stringT_crit,indexloop_c,rotacion
w2_Tmeanvec6        = Tmmean_c/1.e6
w2_THSvec6          = Tefit_c/1.e6
a6       = w2_Tmeanvec6 - w2_THSvec6
Deltagp6A = ( a6 / mean(w2_Tmeanvec6) ) > (-vcrit) < vcrit

i_open_norte_gradpos_HI_H = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and r2N gt r2crit_N and footlat ge 72. and footlat le 80. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_open_norte_gradpos_HI_H
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_openN_H_gp_'+instrumento+stringT_crit,indexloop_c,rotacion
w2_Tmeanvec7        = Tmmean_c/1.e6
w2_THSvec7          = Tefit_c/1.e6
a7       = w2_Tmeanvec7 - w2_THSvec7
Deltagp7A = ( a7 / mean(w2_Tmeanvec7) ) > (-vcrit) < vcrit

i_open_sur_gradpos_HI_H = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and r2N gt r2crit_N and footlat le -72. and footlat ge -80. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_open_sur_gradpos_HI_H
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_openS_H_gp_'+instrumento+stringT_crit,indexloop_c,rotacion
w2_Tmeanvec8        = Tmmean_c/1.e6
w2_THSvec8          = Tefit_c/1.e6
a8       = w2_Tmeanvec8 - w2_THSvec8
Deltagp8A = ( a8 / mean(w2_Tmeanvec8) ) > (-vcrit) < vcrit

openw,1,'Tabla_EHI_'+instrumento+stringT_crit+'test_9regiones_mediana_ts.txt'

        printf,1,'==========================================================================================='
        printf,1,'------------------------------ '+instrumento+stringT_crit+'---------------------------------------------'
        printf,1,'==========================================================================================='
        printf,1,'-------------------------------'+strmid(sigT_muT_crit,5,4)+'---------------------------------'
        printf,1,' region    Tefit    Tmedio   stdev(Tm)/Tmedio    Delta '

        printf,1, 'gp'
        printf,1, 'midlat_N'   ,median(w2_THSvec1)   ,median(w2_Tmeanvec1),median(Deltagp1A)
        printf,1, 'midlat_S'   ,median(w2_THSvec2)   ,median(w2_Tmeanvec2),median(Deltagp2A)
        printf,1, 'OCN'        ,median(w2_THSvec3)   ,median(w2_Tmeanvec3),median(Deltagp3A)
        printf,1, 'OCS'        ,median(w2_THSvec4)   ,median(w2_Tmeanvec4),median(Deltagp4A)
        printf,1, 'open_N_L'     ,median(w2_THSvec5)   ,median(w2_Tmeanvec5),median(Deltagp5A)
        printf,1, 'open_S_L'     ,median(w2_THSvec6)   ,median(w2_Tmeanvec6),median(Deltagp6A)
        printf,1, 'open_N_H'     ,median(w2_THSvec7)   ,median(w2_Tmeanvec7),median(Deltagp7A)
        printf,1, 'open_S_H'     ,median(w2_THSvec8)   ,median(w2_Tmeanvec8),median(Deltagp8A)

        printf,1, 'gn'
        printf,1, 'lowlat'     ,median(w3_THSvec0)   ,median(w3_Tmeanvec0),median(Deltagn0A)

close,1

print, 'Impresion en -----> Tabla_EHI_'+instrumento+stringT_crit+'test_9regiones_mediana_ts.txt'



 read_trace_sampled,filesT[1],alturas
 statloop,filesT[1],rloopmin=1.05,/linear,/FITCUAdr,/altura
 lonmax=180.
 lowlatmax=20.
 instrumento='eit_ts'
 sigT_muT_crit = 0.20
 stringT_crit = strmid(sigT_muT_crit,5,4)
;fact=3.                                                                                                                                        
vcrit = 10.0

i_lowlat_gradneg_HI = where(gradT ne -555. AND opclstat eq 2. and f_t gt r2crit_T and r2N gt r2crit_N and abs(footlat) le lowlatmax and gradT le 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_lowlat_gradneg_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_lowlat_gn_'+instrumento+stringT_crit,indexloop_c,rotacion                                             
w3_Tmeanvec0        = Tmmean_c/1.e6
w3_THSvec0          = Tefit_c/1.e6
a0       = w3_Tmeanvec0 - w3_THSvec0
Deltagn0B = ( a0 / mean(w3_Tmeanvec0) ) > (-vcrit) < vcrit   ;medida de consistencia  DEMT - EHI                                               

i_midlat_small_norte_gradpos_HI = where(gradT ne -555. AND opclstat eq 2. and f_t gt r2crit_T and r2N gt r2crit_N and footlat gt 30. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_midlat_small_norte_gradpos_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_midlat_N_gp_'+instrumento+stringT_crit,indexloop_c,rotacion                                           
w2_Tmeanvec1        = Tmmean_c/1.e6
w2_THSvec1          = Tefit_c/1.e6
a1       = w2_Tmeanvec1 - w2_THSvec1
Deltagp1B = ( a1 / mean(w2_Tmeanvec1) ) > (-vcrit) < vcrit

i_midlat_small_sur_gradpos_HI = where(gradT ne -555. AND opclstat eq 2. and f_t gt r2crit_T and r2N gt r2crit_N and footlat le -30. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_midlat_small_sur_gradpos_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_midlat_S_gp_'+instrumento+stringT_crit,indexloop_c,rotacion                                           
w2_Tmeanvec2        = Tmmean_c/1.e6
w2_THSvec2          = Tefit_c/1.e6
a2       = w2_Tmeanvec2 - w2_THSvec2
Deltagp2B = ( a2 / mean(w2_Tmeanvec2) ) > (-vcrit) < vcrit

i_large_OCN_gradpos_HI = where(gradT ne -555. AND opclstat eq 1. and f_t ge r2crit_T and r2N gt r2crit_N and footlat gt +40. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_large_OCN_gradpos_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_OCN_gp_'+instrumento+stringT_crit,indexloop_c,rotacion                                                
w2_Tmeanvec3        = Tmmean_c/1.e6
w2_THSvec3          = Tefit_c/1.e6
a3       = w2_Tmeanvec3 - w2_THSvec3
Deltagp3B = ( a3 / mean(w2_Tmeanvec3) ) > (-vcrit) < vcrit

i_large_OCS_gradpos_HI = where(gradT ne -555. AND opclstat eq 1. and f_t ge r2crit_T and r2N gt r2crit_N and footlat lt -40. and footlat gt -80. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_large_OCS_gradpos_HI
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_OCS_gp_'+instrumento+stringT_crit,indexloop_c,rotacion                                                
w2_Tmeanvec4        = Tmmean_c/1.e6
w2_THSvec4          = Tefit_c/1.e6
a4       = w2_Tmeanvec4 - w2_THSvec4
Deltagp4B = ( a4 / mean(w2_Tmeanvec4) ) > (-vcrit) < vcrit

i_open_norte_gradpos_HI_L = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and r2N gt r2crit_N and footlat lt 68. and footlat gt 0. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_open_norte_gradpos_HI_L
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_openN_L_gp_'+instrumento+stringT_crit,indexloop_c,rotacion                                            
w2_Tmeanvec5        = Tmmean_c/1.e6
w2_THSvec5          = Tefit_c/1.e6
a5       = w2_Tmeanvec5 - w2_THSvec5
Deltagp5B = ( a5 / mean(w2_Tmeanvec5) ) > (-vcrit) < vcrit

i_open_sur_gradpos_HI_L = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and r2N gt r2crit_N and footlat gt -68. and footlat le 0. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_open_sur_gradpos_HI_L
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_openS_L_gp_'+instrumento+stringT_crit,indexloop_c,rotacion                                            
w2_Tmeanvec6        = Tmmean_c/1.e6
w2_THSvec6          = Tefit_c/1.e6
a6       = w2_Tmeanvec6 - w2_THSvec6
Deltagp6B = ( a6 / mean(w2_Tmeanvec6) ) > (-vcrit) < vcrit

i_open_norte_gradpos_HI_H = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and r2N gt r2crit_N and footlat ge 72. and footlat le 80. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_open_norte_gradpos_HI_H
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_openN_H_gp_'+instrumento+stringT_crit,indexloop_c,rotacion                                            
w2_Tmeanvec7        = Tmmean_c/1.e6
w2_THSvec7          = Tefit_c/1.e6
a7       = w2_Tmeanvec7 - w2_THSvec7
Deltagp7B = ( a7 / mean(w2_Tmeanvec7) ) > (-vcrit) < vcrit

i_open_sur_gradpos_HI_H = where(gradT ne -555. AND opclstat eq 0. and f_t ge r2crit_T and r2N gt r2crit_N and footlat le -72. and footlat ge -80. and gradT gt 0. and footlon le lonmax and Tmstddev/Tmmean lt sigT_muT_crit)
filter, i_open_sur_gradpos_HI_H
Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='EHI_openS_H_gp_'+instrumento+stringT_crit,indexloop_c,rotacion                                            
w2_Tmeanvec8        = Tmmean_c/1.e6
w2_THSvec8          = Tefit_c/1.e6
a8       = w2_Tmeanvec8 - w2_THSvec8
Deltagp8B = ( a8 / mean(w2_Tmeanvec8) ) > (-vcrit) < vcrit


 nbins=50
nombre='EHI_comparacion'
tit='St-LB'
histoplot2B,  Deltagn0B,  Deltagn0A,min=-1,max=1,nbins=nbins,xtit='!9d!3!N'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_lowlat_Te'       ,ndig=5
tit='St-LIN'
histoplot2B,  Deltagp1B,  Deltagp1A,min=-1,max=1,nbins=nbins,xtit='!9d!3!N'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlatN_Te'      ,ndig=5
tit='St-LIS'
histoplot2B,  Deltagp2B,  Deltagp2A,min=-1,max=1,nbins=nbins,xtit='!9d!3!N'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlatS_Te'      ,ndig=5
tit='St-FN'
histoplot2B,  Deltagp3B,  Deltagp3A,min=-1,max=1,nbins=nbins,xtit='!9d!3!N'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCN_Te'          ,ndig=5
tit='St-FS'
histoplot2B,  Deltagp4B,  Deltagp4A,min=-1,max=1,nbins=nbins,xtit='!9d!3!N'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCS_Te'          ,ndig=5
tit='CH-LBN'
histoplot2B,  Deltagp5B,  Deltagp5A,min=-1.5,max=1,nbins=nbins,xtit='!9d!3!N'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_openNL_Te'       ,ndig=5
tit='CH-LBS'
histoplot2B,  Deltagp6B,  Deltagp6A,min=-1.5,max=0.5,nbins=nbins,xtit='!9d!3!N'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_openSL_Te'       ,ndig=5
tit='CH-LAN'
histoplot2B,  Deltagp7B,  Deltagp7A,min=-1.5,max=0.5,nbins=nbins,xtit='!9d!3!N'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_openNH_Te'       ,ndig=5
tit='CH-LAS'
histoplot2B,  Deltagp8B,  Deltagp8A,min=-1.5,max=0.6,nbins=nbins,xtit='!9d!3!N'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_openSH_Te'       ,ndig=5



openw,1,'Tabla_EHI_'+instrumento+stringT_crit+'test_9regiones_mediana.txt'

        printf,1,'==========================================================================================='
        printf,1,'------------------------------ '+instrumento+stringT_crit+'---------------------------------------------'
        printf,1,'==========================================================================================='
        printf,1,'-------------------------------'+strmid(sigT_muT_crit,5,4)+'---------------------------------'
        printf,1,' region    Tefit    Tmedio   stdev(Tm)/Tmedio    Delta '
        
        printf,1, 'gp'
        ;printf,1, 'lowlat'     ,median(w2_THS.vec0)   ,median(w2_Tmean.vec0), median(w2_tmdv.vec0/w2_Tmedian.vec0) ,median(Deltagp0)   
        printf,1, 'midlat_N'   ,median(w2_THSvec1)   ,median(w2_Tmeanvec1),median(Deltagp1B)
        printf,1, 'midlat_S'   ,median(w2_THSvec2)   ,median(w2_Tmeanvec2),median(Deltagp2B)
        printf,1, 'OCN'        ,median(w2_THSvec3)   ,median(w2_Tmeanvec3),median(Deltagp3B)
        printf,1, 'OCS'        ,median(w2_THSvec4)   ,median(w2_Tmeanvec4),median(Deltagp4B)
        printf,1, 'open_N_L'     ,median(w2_THSvec5)   ,median(w2_Tmeanvec5),median(Deltagp5B)
        printf,1, 'open_S_L'     ,median(w2_THSvec6)   ,median(w2_Tmeanvec6),median(Deltagp6B)
        printf,1, 'open_N_H'     ,median(w2_THSvec7)   ,median(w2_Tmeanvec7),median(Deltagp7B)
        printf,1, 'open_S_H'     ,median(w2_THSvec8)   ,median(w2_Tmeanvec8),median(Deltagp8B)

        printf,1, 'gn'
        printf,1, 'lowlat'     ,median(w3_THSvec0)   ,median(w3_Tmeanvec0),median(Deltagn0B)
        ;printf,1, 'midlat_N'   ,median(w3_THS.vec1)   ,median(w3_Tmedian.vec1), median(w3_tmdv.vec1/w3_Tmedian.vec1) ,median(Deltagn1)
        ;printf,1, 'midlat_S'   ,median(w3_THS.vec2)   ,median(w3_Tmedian.vec2), median(w3_tmdv.vec2/w3_Tmedian.vec2) ,median(Deltagn2)
        ;printf,1, 'OCN'        ,median(w3_THS.vec3)   ,median(w3_Tmedian.vec3), median(w3_tmdv.vec3/w3_Tmedian.vec3) ,median(Deltagn3)
        ;printf,1, 'OCS'        ,median(w3_THS.vec4)   ,median(w3_Tmedian.vec4), median(w3_tmdv.vec4/w3_Tmedian.vec4) ,median(Deltagn4)
        ;printf,1, 'open_N'     ,median(w3_THS.vec5)   ,median(w3_Tmedian.vec5), median(w3_tmdv.vec5/w3_Tmedian.vec5) ,median(Deltagn5)
        ;printf,1, 'open_S'     ,median(w3_THS.vec6)   ,median(w3_Tmedian.vec6), median(w3_tmdv.vec6/w3_Tmedian.vec6) ,median(Deltagn6)

close,1

print, 'Impresion en -----> Tabla_EHI_'+instrumento+stringT_crit+'test_9regiones_mediana.txt'

stop
endif

return
end

pro compamin,ind=ind,filelabel=filelabel,decon=decon

common trace_sampled,rad_v,lat_v,lon_v,s_v,Ne_v,Tm_v,WT_v,Er_v,scoreR_v,midcell_v,Npts_v,str_v,stth_v,stph_v,radstart,enrad_v,enlon_v,enlat_v,npar,DEMc_v,lambda_v,L,Tmin,Tmax
common quemierda,alturas
common B_sampled,B_v,Br_v,Bth_v,Bph_v
common opclstatus,opcls,loopL,WTc

common statistic_loops,Nlegs,Nemean,Tmmean,WTmean,Nestddev,Tmstddev,WTstddev,loop_length,betamean,betaapex,Bmean,Br0
common statistic_loops2,opclstat,lambda_N,lambda_p,Ne0,p0,Tefit,gradT,r2N,r2P,r2T,indexloop,leg_status,Tm0,Tm0s,tm0_2,tm0_3,tm0_4,gradt_2,gradt_3,gradt_4,r2T_2,f_t,f_ne
common statistic_loops3,Eh,sH,r2sH,Phir,Fcb
common statistic_loops4,r2Tcuadr,Acuadr_a, s_r0_a,dTmds,r2Ts
;common statistic_loops5,r2Er,Phirfit
common starttrace,strad,stlat,stlon,footrad,footlat,footlon,Rp_rad,Rp_lat,Rp_lon

common stat_filter,Nlegs_c,Nemean_c,Tmmean_c,WTmean_c,Nestddev_c,Tmstddev_c,WTstddev_c,loop_length_c,betamean_c,betaapex_c,Bmean_c,Br0_c
common stat_filter2,opclstat_c,lambda_N_c,lambda_p_c,Ne0_c,p0_c,Tefit_c,gradT_c,r2N_c,r2P_c,r2T_c,indexloop_c,leg_status_c,Tm0_c,Tm0s_c,Nebasal_c,Tbasal_c
common stat_filter3,Eh_c,sH_c,r2sH_c,Phir_c,Fcb_c
common stat_filter4,r2Tcuadr_c,Acuadr_a_c, s_r0_a_c,dTmds_c,r2Ts_c
common stat_filter5,strad_c,stlat_c,stlon_c,footrad_c,footlat_c,footlon_c,Rp_rad_c,Rp_lat_c,Rp_lon_c
;common stat_filter6,r2Er_c,Phirfit_c
common loops,Phir_loop,rad1_loop,rad2_loop,lat1_loop,lat2_loop,lon1_loop,lon2_loop,L_loop,opclstat_loop,r2Er1_loop,r2Er2_loop,Tmmean_loop,Fcb_loop,dTmds1_loop,dTmds2_loop,r2Tcuadr1_loop,r2Tcuadr2_loop,r2T1_loop,r2T2_loop,Ner01_loop,Ner02_loop,Ner11_loop,Ner12_loop,Ner21_loop,Ner22_loop,Ner31_loop,Ner32_loop,Rp_rad1_loop,Rp_lat1_loop,Rp_lon1_loop,Rp_rad2_loop,Rp_lat2_loop,Rp_lon2_loop,TmR11_loop,TmR12_loop,NR11_loop,NR12_loop
common loops_filter,Phir_loop_c,rad1_loop_c,rad2_loop_c,lat1_loop_c,lat2_loop_c,lon1_loop_c,lon2_loop_c,L_loop_c,opclstat_loop_c,r2Er1_loop_c,r2Er2_loop_c,Tmmean_loop_c,Fcb_loop_c,dTmds1_loop_c,dTmds2_loop_c,r2Tcuadr1_loop_c,r2Tcuadr2_loop_c,r2T1_loop_c,r2T2_loop_c,Ner01_loop_c,Ner02_loop_c,Ner11_loop_c,Ner12_loop_c,Ner21_loop_c,Ner22_loop_c,Ner31_loop_c,Ner32_loop_c,Rp_rad1_loop_c,Rp_lat1_loop_c,Rp_lon1_loop_c,Rp_rad2_loop_c,Rp_lat2_loop_c,Rp_lon2_loop_c,TmR11_loop_c,TmR12_loop_c,NR11_loop_c,NR12_loop_c

if not keyword_set(ind)       then ind=[0]
if not keyword_set(filelabel) then filelabel='crap'


 rstart      = 1.035+0.02*findgen(10)
                   
 filesT = ['traceLDEM_CR2081_euviA-NODECON_reg0.75_safety0.5_errorbox_base_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
           'traceLDEM_CR1915_reg0.75_safety0.5_errorbox_base_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat',$
           'traceLDEM_CR2081_euviA-DECON_reg0.75_safety0.5_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.ALBERT.dat']
 nf=2

 r2crit_N = 0.8
 nbins = 50
 r2crit_T = 0.5

 alturas = n_elements(rstart)


 read_trace_sampled,filesT[0],alturas
 statloop,filesT[0],rloopmin=1.05,/linear,/FITCUAdr,/altura

lonmax=360.
 lowlatmax=30.

 i_lowlat_gradneg = where(gradT ne -555. AND opclstat eq 2. and r2N gt r2crit_N and abs(footlat) le lowlatmax  and footlon le lonmax)
 filter,i_lowlat_gradneg
 lambda_N_c_0_A=lambda_N_c
  Nebasal_c_0_A=Nebasal_c

i_lowlat_gradneg = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and abs(footlat) le lowlatmax and gradT le 0. and footlon le lonmax)
 filter,i_lowlat_gradneg
   Tmmean_c_0_A=Tmmean_c
    Bmean_c_0_A=Bmean_c
      Br0_c_0_A=Br0_c
 
 i_midlat_small_norte_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2N gt r2crit_N and footlat gt 30.  and footlon le lonmax)
filter, i_midlat_small_norte_gradpos
lambda_N_c_1_A=lambda_N_c
  Nebasal_c_1_A=Nebasal_c
  i_midlat_small_norte_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat gt 30. and gradT gt 0. and footlon le lonmax)
filter, i_midlat_small_norte_gradpos
  Tmmean_c_1_A=Tmmean_c
    Bmean_c_1_A=Bmean_c
      Br0_c_1_A=Br0_c

i_midlat_small_sur_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2N gt r2crit_N and footlat le -30.  and footlon le lonmax)
filter, i_midlat_small_sur_gradpos
lambda_N_c_2_A=lambda_N_c
  Nebasal_c_2_A=Nebasal_c
 i_midlat_small_sur_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat le -30. and gradT gt 0. and footlon le lonmax)
filter, i_midlat_small_sur_gradpos  
 Tmmean_c_2_A=Tmmean_c
    Bmean_c_2_A=Bmean_c
      Br0_c_2_A=Br0_c

i_large_OCN_gradpos = where(gradT ne -555. AND opclstat eq 1. and r2N ge r2crit_N and footlat gt +40. and footlon le lonmax)
filter, i_large_OCN_gradpos
lambda_N_c_3_A=lambda_N_c
  Nebasal_c_3_A=Nebasal_c
i_large_OCN_gradpos = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat gt +40. and gradT gt 0. and footlon le lonmax)
filter, i_large_OCN_gradpos
   Tmmean_c_3_A=Tmmean_c
    Bmean_c_3_A=Bmean_c
      Br0_c_3_A=Br0_c

i_large_OCS_gradpos = where(gradT ne -555. AND opclstat eq 1. and r2N ge r2crit_N and footlat lt -40. and footlat gt -80. and footlon le lonmax)
filter, i_large_OCS_gradpos
lambda_N_c_4_A=lambda_N_c
  Nebasal_c_4_A=Nebasal_c
i_large_OCS_gradpos = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat lt -40. and footlat gt -80. and gradT gt 0. and footlon le lonmax)
filter, i_large_OCS_gradpos
   Tmmean_c_4_A=Tmmean_c
    Bmean_c_4_A=Bmean_c
      Br0_c_4_A=Br0_c

i_open_norte_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat gt +50. and footlat lt 80. and footlon le lonmax)
filter, i_open_norte_gradpos
lambda_N_c_5_A=lambda_N_c
  Nebasal_c_5_A=Nebasal_c
i_open_norte_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat gt +50. and footlat lt 80. and gradT gt 0. and footlon le lonmax)
filter, i_open_norte_gradpos
   Tmmean_c_5_A=Tmmean_c
    Bmean_c_5_A=Bmean_c
      Br0_c_5_A=Br0_c

i_open_sur_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat lt -50. and footlat gt -80. and footlon le lonmax)
filter, i_open_sur_gradpos
lambda_N_c_6_A=lambda_N_c
  Nebasal_c_6_A=Nebasal_c
i_open_sur_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat lt -50. and footlat gt -80. and gradT gt 0. and footlon le lonmax)
filter, i_open_sur_gradpos
   Tmmean_c_6_A=Tmmean_c
    Bmean_c_6_A=Bmean_c
      Br0_c_6_A=Br0_c

i_streamer = where(gradT ne -555. AND opclstat gt 0. and r2N gt r2crit_N and footlon le lonmax)
 filter,i_streamer
 lambda_N_c_streamer_A=lambda_N_c
  Nebasal_c_streamer_A=Nebasal_c

   Tmmean_c_streamer_A=Tmmean_c
    Bmean_c_streamer_A=Bmean_c

i_southhole = where(gradT ne -555. AND opclstat eq 0. and footlat ge -80. and footlat lt  0. and r2N gt r2crit_N and footlon le lonmax)
 filter,i_southhole
 lambda_N_c_southhole_A=lambda_N_c
  Nebasal_c_southhole_A=Nebasal_c

   Tmmean_c_southhole_A=Tmmean_c
    Bmean_c_southhole_A=Bmean_c
      Br0_c_southhole_A=Br0_c



i_open_sur_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N  and footlat gt -68. and footlat le 0. and footlon le lonmax)
filter, i_open_sur_gradpos_L
lambda_N_c_6_AL=lambda_N_c
  Nebasal_c_6_AL=Nebasal_c
i_open_sur_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T  and footlat gt -68. and footlat le 0. and gradT gt 0. and footlon le lonmax)
filter, i_open_sur_gradpos_L
   Tmmean_c_6_AL=Tmmean_c
    Bmean_c_6_AL=Bmean_c
      Br0_c_6_AL=Br0_c
      
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_sur_gp_euvi_L',indexloop_c,rotacion                                                                                                                                                                                                                                                                                                
;footpoint_map,footlat_c,footlon_c,opclstat_c,filelabel='open_sur_gp_euvi_L',indexloop_c,rotacion                                                                                                                                                                                                                                                                                           

i_open_sur_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat le -72. and footlat ge -80. and footlon le lonmax)
filter, i_open_sur_gradpos_H
lambda_N_c_6_AH=lambda_N_c
  Nebasal_c_6_AH=Nebasal_c
i_open_sur_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat le -72. and footlat ge -80. and gradT gt 0. and footlon le lonmax)
filter, i_open_sur_gradpos_H
   Tmmean_c_6_AH=Tmmean_c
    Bmean_c_6_AH=Bmean_c
      Br0_c_6_AH=Br0_c
      
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_sur_gp_euvi_H',indexloop_c,rotacion                                                                                                                                                                                                                                                                                                
;footpoint_map,footlat_c,footlon_c,opclstat_c,filelabel='open_sur_gp_euvi_H',indexloop_c,rotacion                                                                                                                                                                                                                                                                                           

i_open_norte_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat lt 68. and footlat gt 0. and footlon le lonmax)
filter, i_open_norte_gradpos_L
lambda_N_c_5_AL=lambda_N_c
  Nebasal_c_5_AL=Nebasal_c
i_open_norte_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat lt 68. and footlat gt 0. and gradT gt 0. and footlon le lonmax)
filter, i_open_norte_gradpos_L
   Tmmean_c_5_AL=Tmmean_c
    Bmean_c_5_AL=Bmean_c
      Br0_c_5_AL=Br0_c
      
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_norte_gp_euvi_L',indexloop_c,rotacion                                                                                                                                                                                                                                                                                              
;footpoint_map,footlat_c,footlon_c,opclstat_c,filelabel='open_norte_gp_euvi_L',indexloop_c,rotacion                                                                                                                                                                                                                                                                                         

i_open_norte_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat ge 72. and footlat le 80. and footlon le lonmax)
filter, i_open_norte_gradpos_H
lambda_N_c_5_AH=lambda_N_c
  Nebasal_c_5_AH=Nebasal_c
i_open_norte_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat ge 72. and footlat le 80. and gradT gt 0. and footlon le lonmax)
filter, i_open_norte_gradpos_H
   Tmmean_c_5_AH=Tmmean_c
    Bmean_c_5_AH=Bmean_c
      Br0_c_5_AH=Br0_c
      
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_norte_gp_euvi_H',indexloop_c,rotacion                                                                                                                                                                                                                                                                                              
;footpoint_map,footlat_c,footlon_c,opclstat_c,filelabel='open_norte_gp_euvi_H',indexloop_c,rotacion 


f=1
lonmax=180.
lowlatmax=20.

if keyword_set(decon) then begin 
f=2  
lonmax=360.  
lowlatmax=30.
endif
if not keyword_set(decon) then begin
f=1 
 lonmax=180.
 lowlatmax=20.
endif

 read_trace_sampled,filesT[f],alturas
 statloop,filesT[f],rloopmin=1.05,/linear,/FITCUAdr,/altura                                                   
 i_lowlat_gradneg = where(gradT ne -555. AND opclstat eq 2. and r2N gt r2crit_N and abs(footlat) le lowlatmax  and footlon le lonmax)
 filter,i_lowlat_gradneg
 lambda_N_c_0_B=lambda_N_c
  Nebasal_c_0_B=Nebasal_c

i_lowlat_gradneg = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and abs(footlat) le lowlatmax and gradT le 0. and footlon le lonmax)
 filter,i_lowlat_gradneg
   Tmmean_c_0_B=Tmmean_c
    Bmean_c_0_B=Bmean_c
      Br0_c_0_B=Br0_c

 i_midlat_small_norte_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2N gt r2crit_N and footlat gt 30.  and footlon le lonmax)
filter, i_midlat_small_norte_gradpos
lambda_N_c_1_B=lambda_N_c
  Nebasal_c_1_B=Nebasal_c
  i_midlat_small_norte_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat gt 30. and gradT gt 0. and footlon le lonmax)
filter, i_midlat_small_norte_gradpos
  Tmmean_c_1_B=Tmmean_c
    Bmean_c_1_B=Bmean_c
      Br0_c_1_B=Br0_c

i_midlat_small_sur_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2N gt r2crit_N and footlat le -30.  and footlon le lonmax)
filter, i_midlat_small_sur_gradpos
lambda_N_c_2_B=lambda_N_c
  Nebasal_c_2_B=Nebasal_c
 i_midlat_small_sur_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat le -30. and gradT gt 0. and footlon le lonmax)
filter, i_midlat_small_sur_gradpos
 Tmmean_c_2_B=Tmmean_c
    Bmean_c_2_B=Bmean_c
      Br0_c_2_B=Br0_c

i_large_OCN_gradpos = where(gradT ne -555. AND opclstat eq 1. and r2N ge r2crit_N and footlat gt +40. and footlon le lonmax)
filter, i_large_OCN_gradpos
lambda_N_c_3_B=lambda_N_c
  Nebasal_c_3_B=Nebasal_c
i_large_OCN_gradpos = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat gt +40. and gradT gt 0. and footlon le lonmax)
filter, i_large_OCN_gradpos
   Tmmean_c_3_B=Tmmean_c
    Bmean_c_3_B=Bmean_c
      Br0_c_3_B=Br0_c

i_large_OCS_gradpos = where(gradT ne -555. AND opclstat eq 1. and r2N ge r2crit_N and footlat lt -40. and footlat gt -80. and footlon le lonmax)
filter, i_large_OCS_gradpos
lambda_N_c_4_B=lambda_N_c
  Nebasal_c_4_B=Nebasal_c
i_large_OCS_gradpos = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat lt -40. and footlat gt -80. and gradT gt 0. and footlon le lonmax)
filter, i_large_OCS_gradpos
   Tmmean_c_4_B=Tmmean_c
    Bmean_c_4_B=Bmean_c
      Br0_c_4_B=Br0_c

i_open_norte_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat gt +50. and footlat lt 80. and footlon le lonmax)
filter, i_open_norte_gradpos
lambda_N_c_5_B=lambda_N_c
  Nebasal_c_5_B=Nebasal_c
i_open_norte_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat gt +50. and footlat lt 80. and gradT gt 0. and footlon le lonmax)
filter, i_open_norte_gradpos
   Tmmean_c_5_B=Tmmean_c
    Bmean_c_5_B=Bmean_c
      Br0_c_5_B=Br0_c

i_open_sur_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat lt -50. and footlat gt -80. and footlon le lonmax)
filter, i_open_sur_gradpos
lambda_N_c_6_B=lambda_N_c
  Nebasal_c_6_B=Nebasal_c
i_open_sur_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat lt -50. and footlat gt -80. and gradT gt 0. and footlon le lonmax)
filter, i_open_sur_gradpos
   Tmmean_c_6_B=Tmmean_c
    Bmean_c_6_B=Bmean_c
      Br0_c_6_B=Br0_c

i_streamer = where(gradT ne -555. AND opclstat gt 0. and r2N gt r2crit_N and footlon le lonmax)
 filter,i_streamer
 lambda_N_c_streamer_B=lambda_N_c
  Nebasal_c_streamer_B=Nebasal_c
   Tmmean_c_streamer_B=Tmmean_c
    Bmean_c_streamer_B=Bmean_c

i_southhole = where(gradT ne -555. AND opclstat eq 0. and footlat ge -80. and footlat lt  0. and r2N gt r2crit_N and footlon le lonmax)
 filter,i_southhole
 lambda_N_c_southhole_B=lambda_N_c
  Nebasal_c_southhole_B=Nebasal_c
   Tmmean_c_southhole_B=Tmmean_c
    Bmean_c_southhole_B=Bmean_c
      Br0_c_southhole_B=Br0_c




i_open_sur_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat gt -68. and footlat le 0.  and footlon le lonmax)
filter, i_open_sur_gradpos_L
lambda_N_c_6_BL=lambda_N_c
  Nebasal_c_6_BL=Nebasal_c
i_open_sur_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T  and footlat gt -68. and footlat le 0.  and gradT gt 0. and footlon le lonmax)
filter, i_open_sur_gradpos_L
   Tmmean_c_6_BL=Tmmean_c
    Bmean_c_6_BL=Bmean_c
      Br0_c_6_BL=Br0_c
      
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_sur_gp_eit_L',indexloop_c,rotacion                                                                                                                                                                                                                                                                                                 
;footpoint_map,footlat_c,footlon_c,opclstat_c,filelabel='open_sur_gp_eit_L',indexloop_c,rotacion                                                                                                                                                                                                                                                                                            

i_open_sur_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat le -72. and footlat ge -80. and footlon le lonmax)
filter, i_open_sur_gradpos_H
lambda_N_c_6_BH=lambda_N_c
  Nebasal_c_6_BH=Nebasal_c
i_open_sur_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat le -72. and footlat ge -80. and gradT gt 0. and footlon le lonmax)
filter, i_open_sur_gradpos_H
   Tmmean_c_6_BH=Tmmean_c
    Bmean_c_6_BH=Bmean_c
      Br0_c_6_BH=Br0_c
      
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_sur_gp_eit_H',indexloop_c,rotacion                                                                                                    vv                                                                                                                                                                                             
;footpoint_map,footlat_c,footlon_c,opclstat_c,filelabel='open_sur_gp_eit_H',indexloop_c,rotacion                                                                                                                                                                                                                                                                                            

i_open_norte_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N  and footlat lt 68. and footlat gt 0.  and footlon le lonmax)
filter, i_open_norte_gradpos_L
lambda_N_c_5_BL=lambda_N_c
  Nebasal_c_5_BL=Nebasal_c
i_open_norte_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T  and footlat lt 68. and footlat gt 0.  and gradT gt 0. and footlon le lonmax)
filter, i_open_norte_gradpos_L
   Tmmean_c_5_BL=Tmmean_c
    Bmean_c_5_BL=Bmean_c
      Br0_c_5_BL=Br0_c
      
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_norte_gp_eit_L',indexloop_c,rotacion                                                                                                                                          
;footpoint_map,footlat_c,footlon_c,opclstat_c,filelabel='open_norte_gp_eit_L',indexloop_c,rotacion                                                                                                                                     

i_open_norte_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat ge 72. and footlat le 80. and footlon le lonmax)
filter, i_open_norte_gradpos_H
lambda_N_c_5_BH=lambda_N_c
  Nebasal_c_5_BH=Nebasal_c
i_open_norte_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T  and footlat ge 72. and footlat le 80. and gradT gt 0. and footlon le lonmax)
filter, i_open_norte_gradpos_H
   Tmmean_c_5_BH=Tmmean_c
    Bmean_c_5_BH=Bmean_c
      Br0_c_5_BH=Br0_c
      
;Rpoint_map,Rp_lat_c,Rp_lon_c,opclstat_c,filelabel='open_norte_gp_eit_H',indexloop_c,rotacion                                                                                                                                          
;footpoint_map,footlat_c,footlon_c,opclstat_c,filelabel='open_norte_gp_eit_H',indexloop_c,rotacion   

nombre='comparacion'
if keyword_set(decon) then begin nombre='compa_decon_nodecon' 
 goto, histos_decon
endif

tit='St-LB'
 nbins=50
 histoplot2B,lambda_N_c_0_B     ,lambda_N_c_0_A     ,min=0.04,max=0.2 ,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_lowlat_lambda_N',ndig=5
 histoplot2B, Nebasal_c_0_B/1.e8, Nebasal_c_0_A/1.e8,min=1.00,max=3.00,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_lowlat_Nebasal' ,ndig=6
 histoplot2B,  Tmmean_c_0_B/1.e6,  Tmmean_c_0_A/1.e6,min=0.75,max=1.80,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_lowlat_Te'      ,ndig=6
 ;histoplot2B,  Br0_c_0_B        ,Br0_c_0_A          ,min=0.00,max=15  ,nbins=nbins,xtit='B!D0!N [Gauss]'                ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_lowlat_B0'      ,ndig=6

tit='St-LIN'
 nbins=50
 histoplot2B,lambda_N_c_1_B     ,lambda_N_c_1_A     ,min=0.04,max=0.2,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_N_lambda_N',ndig=5
 histoplot2B, Nebasal_c_1_B/1.e8, Nebasal_c_1_A/1.e8,min=0.75,max=2.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_N_Nebasal' ,ndig=6
 histoplot2B,  Tmmean_c_1_B/1.e6,  Tmmean_c_1_A/1.e6,min=1.00,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_N_Te'      ,ndig=6
 ;histoplot2B,  Br0_c_1_B        ,Br0_c_1_A          ,min=0.00,max=15  ,nbins=nbins,xtit='B!D0!N [Gauss]'                ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_N_B0'      ,ndig=6

tit='St-LIS'
 nbins=50
 histoplot2B,lambda_N_c_2_B     ,lambda_N_c_2_A     ,min=0.04,max=0.25,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_S_lambda_N',ndig=5
 histoplot2B, Nebasal_c_2_B/1.e8, Nebasal_c_2_A/1.e8,min=0.50,max=2.30,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_S_Nebasal' ,ndig=6
 histoplot2B,  Tmmean_c_2_B/1.e6,  Tmmean_c_2_A/1.e6,min=1.00,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_S_Te'      ,ndig=6
 ;histoplot2B,  Br0_c_2_B        ,Br0_c_2_A          ,min=0.00,max=15  ,nbins=nbins,xtit='B!D0!N [Gauss]'                ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_S_B0'      ,ndig=6

tit='St-FN'
 nbins=50
 histoplot2B,lambda_N_c_3_B     ,lambda_N_c_3_A     ,min=0.05,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCN_lambda_N',ndig=5
 histoplot2B, Nebasal_c_3_B/1.e8, Nebasal_c_3_A/1.e8,min=0.50,max=2.00,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCN_Nebasal' ,ndig=6
 histoplot2B,  Tmmean_c_3_B/1.e6,  Tmmean_c_3_A/1.e6,min=0.80,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCN_Te'      ,ndig=6
 ;histoplot2B,  Br0_c_3_B        ,Br0_c_3_A          ,min=0.00,max=15  ,nbins=nbins,xtit='B!D0!N [Gauss]'                ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCN_B0'      ,ndig=6

tit='St-FS'
 nbins=50
 histoplot2B,lambda_N_c_4_B     ,lambda_N_c_4_A     ,min=0.04,max=0.25,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCS_lambda_N',ndig=5
 histoplot2B, Nebasal_c_4_B/1.e8, Nebasal_c_4_A/1.e8,min=0.25,max=2.00,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCS_Nebasal' ,ndig=6
 histoplot2B,  Tmmean_c_4_B/1.e6,  Tmmean_c_4_A/1.e6,min=0.70,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCS_Te'      ,ndig=6
 ;histoplot2B,  Br0_c_4_B        ,Br0_c_4_A          ,min=0.00,max=15  ,nbins=nbins,xtit='B!D0!N [Gauss]'                ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCS_B0'      ,ndig=6


tit='CH-LAS'
 nbins=50
 histoplot2B,lambda_N_c_6_BH     ,lambda_N_c_6_AH     ,min=0.05,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_lambda_N_H',ndig=5
 histoplot2B, Nebasal_c_6_BH/1.e8, Nebasal_c_6_AH/1.e8,min=0.30,max=1.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Nebasal_H' ,ndig=6
 histoplot2B,  Tmmean_c_6_BH/1.e6,  Tmmean_c_6_AH/1.e6,min=0.60,max=1.60,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Te_H'      ,ndig=6

tit='CH-LBS'
 nbins=50
 histoplot2B,lambda_N_c_6_BL     ,lambda_N_c_6_AL     ,min=0.05,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_lambda_N_L',ndig=5
 histoplot2B, Nebasal_c_6_BL/1.e8, Nebasal_c_6_AL/1.e8,min=0.30,max=1.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Nebasal_L' ,ndig=6
 histoplot2B,  Tmmean_c_6_BL/1.e6,  Tmmean_c_6_AL/1.e6,min=0.60,max=1.60,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Te_L'      ,ndig=6

tit='CH-LAN'
 nbins=50
 histoplot2B,lambda_N_c_5_BH     ,lambda_N_c_5_AH     ,min=0.05,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_lambda_N_H',ndig=5
 histoplot2B, Nebasal_c_5_BH/1.e8, Nebasal_c_5_AH/1.e8,min=0.30,max=1.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Nebasal_H' ,ndig=6
 histoplot2B,  Tmmean_c_5_BH/1.e6,  Tmmean_c_5_AH/1.e6,min=0.60,max=1.60,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Te_H'      ,ndig=6

tit='CH-LBN'
 nbins=50
 histoplot2B,lambda_N_c_5_BL     ,lambda_N_c_5_AL     ,min=0.05,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_lambda_N_L',ndig=5
 histoplot2B, Nebasal_c_5_BL/1.e8, Nebasal_c_5_AL/1.e8,min=0.30,max=1.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Nebasal_L' ,ndig=6
 histoplot2B,  Tmmean_c_5_BL/1.e6,  Tmmean_c_5_AL/1.e6,min=0.60,max=1.60,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Te_L'      ,ndig=6


stop
histos_decon:
stop
tit='St-LB'
 nbins=50 
 histoplot2B,/decon,lambda_N_c_0_B     ,lambda_N_c_0_A     ,min=0.04,max=0.18 ,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_lowlat_lambda_N',ndig=5
 histoplot2B,/decon, Nebasal_c_0_B/1.e8, Nebasal_c_0_A/1.e8,min=1.00,max=3.00,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_lowlat_Nebasal' ,ndig=6
 histoplot2B,/decon,  Tmmean_c_0_B/1.e6,  Tmmean_c_0_A/1.e6,min=0.75,max=1.80,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_lowlat_Te'      ,ndig=6
                               
tit='St-LIN'
 nbins=50
 histoplot2B,/decon,lambda_N_c_1_B     ,lambda_N_c_1_A     ,min=0.04,max=0.2,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_N_lambda_N',ndig=5
 histoplot2B,/decon, Nebasal_c_1_B/1.e8, Nebasal_c_1_A/1.e8,min=0.75,max=2.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_N_Nebasal' ,ndig=6
 histoplot2B,/decon,  Tmmean_c_1_B/1.e6,  Tmmean_c_1_A/1.e6,min=1.00,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_N_Te'      ,ndig=6
                               
tit='St-LIS'
 nbins=50
 histoplot2B,/decon,lambda_N_c_2_B     ,lambda_N_c_2_A     ,min=0.04,max=0.20,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_S_lambda_N',ndig=5
 histoplot2B,/decon, Nebasal_c_2_B/1.e8, Nebasal_c_2_A/1.e8,min=0.50,max=2.30,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_S_Nebasal' ,ndig=6
 histoplot2B,/decon,  Tmmean_c_2_B/1.e6,  Tmmean_c_2_A/1.e6,min=1.00,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_midlat_S_Te'      ,ndig=6
                               
tit='St-FN'
 nbins=50
 histoplot2B,/decon,lambda_N_c_3_B     ,lambda_N_c_3_A     ,min=0.05,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCN_lambda_N',ndig=5
 histoplot2B,/decon, Nebasal_c_3_B/1.e8, Nebasal_c_3_A/1.e8,min=0.50,max=2.00,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCN_Nebasal' ,ndig=6
 histoplot2B,/decon,  Tmmean_c_3_B/1.e6,  Tmmean_c_3_A/1.e6,min=0.80,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCN_Te'      ,ndig=6
                               
tit='St-FS'
 nbins=50
 histoplot2B,/decon,lambda_N_c_4_B     ,lambda_N_c_4_A     ,min=0.04,max=0.20,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCS_lambda_N',ndig=5
 histoplot2B,/decon, Nebasal_c_4_B/1.e8, Nebasal_c_4_A/1.e8,min=0.25,max=2.00,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCS_Nebasal' ,ndig=6
 histoplot2B,/decon,  Tmmean_c_4_B/1.e6,  Tmmean_c_4_A/1.e6,min=0.70,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_OCS_Te'      ,ndig=6
                               
tit='CH-LAS'
 nbins=50
 histoplot2B,/decon,lambda_N_c_6_BH     ,lambda_N_c_6_AH     ,min=0.00,max=0.14,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_lambda_N_H',ndig=5
 histoplot2B,/decon, Nebasal_c_6_BH/1.e8, Nebasal_c_6_AH/1.e8,min=0.30,max=1.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Nebasal_H' ,ndig=6
 histoplot2B,/decon,  Tmmean_c_6_BH/1.e6,  Tmmean_c_6_AH/1.e6,min=0.60,max=1.20,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Te_H'      ,ndig=6

tit='CH-LBS'
 nbins=50
 histoplot2B,/decon,lambda_N_c_6_BL     ,lambda_N_c_6_AL     ,min=0.00,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_lambda_N_L',ndig=5
 histoplot2B,/decon, Nebasal_c_6_BL/1.e8, Nebasal_c_6_AL/1.e8,min=0.30,max=1.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Nebasal_L' ,ndig=6
 histoplot2B,/decon,  Tmmean_c_6_BL/1.e6,  Tmmean_c_6_AL/1.e6,min=0.60,max=1.60,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Te_L'      ,ndig=6

tit='CH-LAN'
 nbins=50
 histoplot2B,/decon,lambda_N_c_5_BH     ,lambda_N_c_5_AH     ,min=0.05,max=0.14,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_lambda_N_H',ndig=5
 histoplot2B,/decon, Nebasal_c_5_BH/1.e8, Nebasal_c_5_AH/1.e8,min=0.30,max=1.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Nebasal_H' ,ndig=6
 histoplot2B,/decon,  Tmmean_c_5_BH/1.e6,  Tmmean_c_5_AH/1.e6,min=0.60,max=1.40,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Te_H'      ,ndig=6

tit='CH-LBN'
 nbins=50
 histoplot2B,/decon,lambda_N_c_5_BL     ,lambda_N_c_5_AL     ,min=0.00,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_lambda_N_L',ndig=5
 histoplot2B,/decon, Nebasal_c_5_BL/1.e8, Nebasal_c_5_AL/1.e8,min=0.30,max=2.00,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Nebasal_L' ,ndig=6
 histoplot2B,/decon,  Tmmean_c_5_BL/1.e6,  Tmmean_c_5_AL/1.e6,min=0.60,max=1.60,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Te_L'      ,ndig=6

goto, skipviejos

tit='Open N gp'
 nbins=50
 histoplot2B,lambda_N_c_5_B     ,lambda_N_c_5_A     ,min=0.06,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_lambda_N',ndig=5
 histoplot2B, Nebasal_c_5_B/1.e8, Nebasal_c_5_A/1.e8,min=0.25,max=1.60,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Nebasal' ,ndig=6
 histoplot2B,  Tmmean_c_5_B/1.e6,  Tmmean_c_5_A/1.e6,min=0.70,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_Te'      ,ndig=6
 ;histoplot2B,  Br0_c_5_B        ,Br0_c_5_A          ,min=0.00,max=15  ,nbins=nbins,xtit='B!D0!N [Gauss]'                ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_N_B0'      ,ndig=6

tit='Open S gp'
 nbins=50
 histoplot2B,lambda_N_c_6_B     ,lambda_N_c_6_A     ,min=0.05,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_lambda_N',ndig=5
 histoplot2B, Nebasal_c_6_B/1.e8, Nebasal_c_6_A/1.e8,min=0.30,max=1.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Nebasal' ,ndig=6
 histoplot2B,  Tmmean_c_6_B/1.e6,  Tmmean_c_6_A/1.e6,min=0.60,max=1.60,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_Te'      ,ndig=6
 ;histoplot2B,  Br0_c_6_B        ,Br0_c_6_A          ,min=0.00,max=15  ,nbins=nbins,xtit='B!D0!N [Gauss]'                ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_open_S_B0'      ,ndig=6


tit='Streamer'
 nbins=50
 histoplot2B,lambda_N_c_streamer_B     ,lambda_N_c_streamer_A     ,min=0.05,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_Streamer_lambda_N',ndig=5
 histoplot2B, Nebasal_c_streamer_B/1.e8, Nebasal_c_streamer_A/1.e8,min=0.50,max=2.50,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_Streamer_Nebasal' ,ndig=6
 histoplot2B,  Tmmean_c_streamer_B/1.e6,  Tmmean_c_streamer_A/1.e6,min=0.60,max=2.00,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_Streamer_Te'      ,ndig=6

tit='Open S gp'
 nbins=50
 histoplot2B,lambda_N_c_southhole_B     ,lambda_N_c_southhole_A     ,min=0.05,max=0.18,nbins=nbins,xtit='!9l!3!DN!N [R!DSUN!N]'         ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_CH_lambda_N',ndig=5
 histoplot2B, Nebasal_c_southhole_B/1.e8, Nebasal_c_southhole_A/1.e8,min=0.30,max=2.00,nbins=nbins,xtit='N!De!N basal [10!U8!Ncm!U-3!N]',ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_CH_Nebasal' ,ndig=6
 histoplot2B,  Tmmean_c_southhole_B/1.e6,  Tmmean_c_southhole_A/1.e6,min=0.60,max=1.60,nbins=nbins,xtit='T!De!N [MK]'                   ,ytit='Histograma de Frecuencia',tit=tit,filename=nombre+'_CH_Te'      ,ndig=6
skipviejos:



return
end








pro test,ind=ind,filelabel=filelabel,thebox=thebox,altura=altura

common trace_sampled,rad_v,lat_v,lon_v,s_v,Ne_v,Tm_v,WT_v,Er_v,scoreR_v,midcell_v,Npts_v,str_v,stth_v,stph_v,radstart,enrad_v,enlon_v,enlat_v,npar,DEMc_v,lambda_v,L,Tmin,Tmax
common quemierda,alturas
common B_sampled,B_v,Br_v,Bth_v,Bph_v
common opclstatus,opcls,loopL,WTc  

common statistic_loops,Nlegs,Nemean,Tmmean,WTmean,Nestddev,Tmstddev,WTstddev,loop_length,betamean,betaapex,Bmean,Br0
common statistic_loops2,opclstat,lambda_N,lambda_p,Ne0,p0,Tefit,gradT,r2N,r2P,r2T,indexloop,leg_status,Tm0,Tm0s,tm0_2,tm0_3,tm0_4,gradt_2,gradt_3,gradt_4,r2T_2,f_t,f_ne
common statistic_loops3,Eh,sH,r2sH,Phir,Fcb
common statistic_loops4,r2Tcuadr,Acuadr_a, s_r0_a,dTmds,r2Ts
common starttrace,strad,stlat,stlon,footrad,footlat,footlon,Rp_rad,Rp_lat,Rp_lon 

common stat_filter,Nlegs_c,Nemean_c,Tmmean_c,WTmean_c,Nestddev_c,Tmstddev_c,WTstddev_c,loop_length_c,betamean_c,betaapex_c,Bmean_c,Br0_c
common stat_filter2,opclstat_c,lambda_N_c,lambda_p_c,Ne0_c,p0_c,Tefit_c,gradT_c,r2N_c,r2P_c,r2T_c,indexloop_c,leg_status_c,Tm0_c,Tm0s_c,Nebasal_c,Tbasal_c
common stat_filter3,Eh_c,sH_c,r2sH_c,Phir_c,Fcb_c
common stat_filter4,r2Tcuadr_c,Acuadr_a_c, s_r0_a_c,dTmds_c,r2Ts_c
common stat_filter5,strad_c,stlat_c,stlon_c,footrad_c,footlat_c,footlon_c,Rp_rad_c,Rp_lat_c,Rp_lon_c

common loops,Phir_loop,rad1_loop,rad2_loop,lat1_loop,lat2_loop,lon1_loop,lon2_loop,L_loop,opclstat_loop,r2Er1_loop,r2Er2_loop,Tmmean_loop,Fcb_loop,dTmds1_loop,dTmds2_loop,r2Tcuadr1_loop,r2Tcuadr2_loop,r2T1_loop,r2T2_loop,Ner01_loop,Ner02_loop,Ner11_loop,Ner12_loop,Ner21_loop,Ner22_loop,Ner31_loop,Ner32_loop,Rp_rad1_loop,Rp_lat1_loop,Rp_lon1_loop,Rp_rad2_loop,Rp_lat2_loop,Rp_lon2_loop,TmR11_loop,TmR12_loop,NR11_loop,NR12_loop
common loops_filter,Phir_loop_c,rad1_loop_c,rad2_loop_c,lat1_loop_c,lat2_loop_c,lon1_loop_c,lon2_loop_c,L_loop_c,opclstat_loop_c,r2Er1_loop_c,r2Er2_loop_c,Tmmean_loop_c,Fcb_loop_c,dTmds1_loop_c,dTmds2_loop_c,r2Tcuadr1_loop_c,r2Tcuadr2_loop_c,r2T1_loop_c,r2T2_loop_c,Ner01_loop_c,Ner02_loop_c,Ner11_loop_c,Ner12_loop_c,Ner21_loop_c,Ner22_loop_c,Ner31_loop_c,Ner32_loop_c,Rp_rad1_loop_c,Rp_lat1_loop_c,Rp_lon1_loop_c,Rp_rad2_loop_c,Rp_lat2_loop_c,Rp_lon2_loop_c,TmR11_loop_c,TmR12_loop_c,NR11_loop_c,NR12_loop_c


if not keyword_set(ind)       then ind=[0]
if not keyword_set(filelabel) then filelabel='crap'
if     keyword_set(thebox)    then begin
latmax    = thebox(0)
latmin    = thebox(1)
lonmax    = thebox(2)
lonmin    = thebox(3)
endif

;filesT = ['traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_grid1_expand_radstart-1.045Rs_unifgrid.heating.sampled.v2.CECI.dat',$
;          'traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_grid1_expand_radstart-1.075Rs_unifgrid.heating.sampled.v2.CECI.dat',$
;          'traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_grid1_expand_radstart-1.115Rs_unifgrid.heating.sampled.v2.CECI.dat',$
;          'traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_expand_radstart-1.035Rs_unifgrid.heating.sampled.v2.CECI.dat',$
;          'traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_expand_radstart-1.045Rs_unifgrid.heating.sampled.v2.CECI.dat',$
;          'traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_expand_radstart-1.075Rs_unifgrid.heating.sampled.v2.CECI.dat',$
;          'traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_expand_radstart-1.115Rs_unifgrid.heating.sampled.v2.CECI.dat',$
;          'traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_expand_radstart-1.155Rs_unifgrid.heating.sampled.v2.CECI.dat',$
;          'traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_expand_radstart-1.250Rs_unifgrid.heating.sampled.v2.CECI.dat',$
;          'traceLDEM_CR2081_euviA-DECON_reg0.75_safety1.0_expand_radstart-1.500Rs_unifgrid.heating.sampled.v2.CECI.dat']
;rstart      = [1.045,1.075,1.115,1.035,1.045,1.075,1.115,1.155,1.250,1.500]
                      
;filesT = ['traceLDEM_CR1914_EIT_reg0.75_safety0.5_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.ALBERT.dat']

;filesT = ['traceLDEM_CR1915_EIT_reg0.75_safety0.5_grid0.5_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat']

;filesT = ['traceLDEM_CR2081_euviA-DECON_reg0.75_safety0.5_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.ALBERT.dat']
   
;filesT = ['traceLDEM_CR2081_euviA-NODECON_reg0.75_safety0.5_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.ALBERT.dat']
filesT = ['traceLDEM_CR1915_reg0.75_safety0.5_errorbox_HLL_ureg_radstart-1.035-1.215Rs_unifgrid_v2.heating.sampled.v2.DIEGO.dat']
rstart      = 1.035+0.02*findgen(10)

;filesT = ['traceLDEM_CR1914_eit_l0.75_radstart-1.075Rs_unifgrid.heating.sampled.v2.dat']
;rstart = 1.075

if not keyword_set (altura) then alturas =1.
if     keyword_set (altura) then alturas = n_elements(rstart)

NfilesT     = n_elements(filesT)
Nlineas     = findgen(NfilesT)*0

Nsmallclose = Findgen(NfilesT)*0
Nlargeclose = findgen(NfilesT)*0
Nopen       = findgen(NfilesT)*0

Nsmall_leg  = findgen(NfilesT)*0
Nlarge_leg  = findgen(NfilesT)*0
 Nopen_leg  = findgen(NfilesT)*0

Nof1 = findgen(NfilesT)*0
Nof2 = findgen(NfilesT)*0
Nof  = findgen(NfilesT)*0

Nlf1 = findgen(NfilesT)*0
Nlf2 = findgen(NfilesT)*0
Nlf3 = findgen(NfilesT)*0
Nlf4 = findgen(NfilesT)*0
Nlf  = findgen(NfilesT)*0

Nsf1 = findgen(NfilesT)*0
Nsf2 = findgen(NfilesT)*0
Nsf3 = findgen(NfilesT)*0
Nsf4 = findgen(NfilesT)*0
Nsf  = findgen(NfilesT)*0

marker_ind = intarr(NfilesT)
marker_ind(ind)=1

for  i=0,NfilesT-1 do begin
if marker_ind(i) eq 0 then goto,lainsoportablelevedad

   read_trace_sampled,filesT(i),alturas

   Nlineas(i)=n_elements(rad_v(1,*))

   small_close = where(opcls eq 2) & Nsmallclose(i) = n_elements(small_close)
   large_close = where(opcls eq 1) & Nlargeclose(i) = n_elements(large_close)
   open        = where(opcls eq 0) &      Nopen (i) = n_elements(open)

goto,ejemplo_grafico
window,i,XSIZE=800, YSIZE=900, title=rstart(i)
!p.multi=[0,2,3]

plot,rad_v(0:Npts_v(5000)-1,5000), Ne_v(0:Npts_v(5000)-1,5000),yrange=[-0.3,1.5]*1.e8,xstyle=1,ystyle=1,title='Density vs rad' ,charsize=2
plot,lat_v(0:Npts_v(5000)-1,5000),rad_v(0:Npts_v(5000)-1,5000),                       xstyle=1,ystyle=1,title='loop rad vs lat',charsize=2

plot,rad_v(0:Npts_v(10000)-1,10000), Ne_v(0:Npts_v(10000)-1,10000),yrange=[-0.3,1.5]*1.e8,xstyle=1,ystyle=1,charsize=2
plot,lat_v(0:Npts_v(10000)-1,10000),rad_v(0:Npts_v(10000)-1,10000),                       xstyle=1,ystyle=1,charsize=2

plot,rad_v(0:Npts_v(14000)-1,14000), Ne_v(0:Npts_v(14000)-1,14000),yrange=[-0.3,1.5]*1.e8,xstyle=1,ystyle=1,charsize=2
plot,lat_v(0:Npts_v(14000)-1,14000),rad_v(0:Npts_v(14000)-1,14000),                       xstyle=1,ystyle=1,charsize=2

!p.multi=0
ejemplo_grafico:

;record_gif,'./','cambio_Ne_rstart_distintos.gif','X'

if not keyword_set (altura) then statloop,filesT(i),rloopmin=1.05,/linear,/FITCUAdr
if     keyword_set (altura) then statloop,filesT(i),rloopmin=1.05,/linear,/FITCUAdr,/altura

  ;statloop,filesT(i),rloopmin=1.025,/linear,/fitcuadr,/altura

stop

filelabel='CR-1915 , October 1996'
 footpoint_map,footlat,footlon,opclstat,filelabel=filelabel,indexloop,rotacion

stop

  ; select legs with enough data points
  iok = where(gradT ne -555.)
  footlat_s   = footlat(iok)
  footlon_s   = footlon(iok)
  opclstat_s  = opclstat(iok) 
  indexloop_s = indexloop(iok)
  
  ; create concatened data arrays for the footpoint maps
  if i eq ind(0) then begin
  print,'defino _c'
  footlat_c   = footlat_s
  footlon_c   = footlon_s  
  opclstat_c  = opclstat_s
  indexloop_c = indexloop_s
  help,footlat_c
  endif
  if i gt ind(0) AND marker_ind(i) eq 1 then begin
  print,'concateno'
  footlat_c =[footlat_c,footlat_s]
  footlon_c =[footlon_c,footlon_s]
  opclstat_c=[opclstat_c,opclstat_s]
  indexloop_c=[indexloop_c,indexloop_s]
  help,footlat_c
  endif

;;=====================================Energy=========================================================================
goto,cookbooks

window,6,XSIZE=800, YSIZE=900, title=rstart(i)
!p.multi=[0,1,3]

plot,footlat,Phir,psym=3,charsize=3,xrange=[-90,90],ystyle=1,ytit='Phir'

plot,footlat,Fcb,psym=3,charsize=3,xrange=[-90,90],ystyle=1,ytit='Fcbb'

;plot,latt,Phihh,charsize=3,xrange=[-90,90],ystyle=1,ytit='Phih'

!p.multi=0
cookbooks:
;===========================Análisis de piernas=======================================================================

;===========open

;goto,lainsoportablelevedad
   open_leg=where(opclstat eq 0)            
   Nopen_leg(i)=n_elements(open_leg)
   flopen=footlat(where(opclstat eq 0))

        open_foot1 = where(flopen le  80. and flopen ge  50.) & Nof1(i)=n_elements(open_foot1) ;[50,80]
        open_foot2 = where(flopen le -50. and flopen ge -80.) & Nof2(i)=n_elements(open_foot2) ;[-80,-50]
      
        Nof(i)    = Nof1(i) + Nof2(i)

ofoot=findgen(Nof(i))*0
ofoot(0:Nof1(i)-1)=flopen(open_foot1)
ofoot(Nof1(i):Nof(i)-1)=flopen(open_foot2)

;=========small

   if rstart(i) lt 1.200 then begin ; lo separo porque para rstart altos, esto es -1 y ya no puede hacer Nleg(-1)

      small_leg=where(opclstat eq 2) 
      Nsmall_leg(i)=n_elements(small_leg)

      flsmall=footlat(where(opclstat eq 2))
  
        small_foot1 = where(flsmall lt  30. and flsmall ge   0.) & Nsf1(i)=n_elements(small_foot1) ;[0,30)
        small_foot2 = where(flsmall le  70. and flsmall ge  30.) & Nsf2(i)=n_elements(small_foot2) ;[30,70]
        small_foot3 = where(flsmall lt   0. and flsmall ge -30.) & Nsf3(i)=n_elements(small_foot3) ;[-30,0)
        small_foot4 = where(flsmall lt -30. and flsmall ge -70.) & Nsf4(i)=n_elements(small_foot4) ;[-70,-30)

        Nsf(i)     = Nsf1(i) + Nsf2(i) + Nsf3(i) + Nsf4(i)       
 
sfoot=findgen(Nsf(i))*0
sfoot(0:Nsf1(i)-1)=flsmall(small_foot1)
sfoot(Nsf1(i):Nsf1(i)+Nsf2(i)-1)=flsmall(small_foot2)
sfoot(Nsf1(i)+Nsf2(i):Nsf1(i)+Nsf2(i)+Nsf3(i)-1)=flsmall(small_foot3)
sfoot(Nsf1(i)+Nsf2(i)+Nsf3(i):Nsf(i)-1)=flsmall(small_foot4)

endif else begin

if rstart(i) gt 1.200 then sfoot=findgen(7000)*0

endelse

;=========large
      
   large_leg=(where(opclstat eq 1))            
   Nlarge_leg(i)=n_elements(large_leg)
   fllarge=footlat(where(opclstat eq 1))

        large_foot1 = where(fllarge lt  30. and fllarge ge   0.) & Nlf1(i)=n_elements(large_foot1) ;[0.30)
        large_foot2 = where(fllarge le  70. and fllarge ge  30.) & Nlf2(i)=n_elements(large_foot2) ;[30,70]
        large_foot3 = where(fllarge lt   0. and fllarge ge -30.) & Nlf3(i)=n_elements(large_foot3) ;[-30,0)
        large_foot4 = where(fllarge lt -30. and fllarge ge -70.) & Nlf4(i)=n_elements(large_foot4) ;[-70.-30)

        Nlf(i)     = Nlf1(i) + Nlf2(i) + Nlf3(i) + Nlf4(i)            

lfoot=findgen(Nlf(i))*0
lfoot(0:Nlf1(i)-1)=fllarge(large_foot1)
lfoot(Nlf1(i):Nlf1(i)+Nlf2(i)-1)=fllarge(large_foot2)
lfoot(Nlf1(i)+Nlf2(i):Nlf1(i)+Nlf2(i)+Nlf3(i)-1)=fllarge(large_foot3)
lfoot(Nlf1(i)+Nlf2(i)+Nlf3(i):Nlf(i)-1)=fllarge(large_foot4)

;=============Histograma
;goto,chauhisto

   xmin=-100
   xmax= 100
   nb  = 100 
   No1 = histogram(ofoot,min=xmin,max=xmax,nbins=nb,locations=xrat)
   Ns1 = histogram(sfoot,min=xmin,max=xmax,nbins=nb,locations=xrat) 
   Nl1 = histogram(lfoot,min=xmin,max=xmax,nbins=nb,locations=xrat)

window,i,XSIZE=800, YSIZE=900, title=rstart(i)

!p.multi=[0,1,3]

  plot,xrat,No1,charsize=3,yrange=[0,max([No1,1])],ytit='open_loops',/nodata
    oplot,xrat,No1,psym=10

  plot,xrat,Nl1,charsize=3,yrange=[0,max([Nl1,1])],ytit='large_loops',/nodata
     oplot,xrat,Nl1,psym=10

  plot,xrat,Ns1,charsize=3,yrange=[0,max([Ns1,1])],xtit='footlat',ytit='small_loops',/nodata
    oplot,xrat,Ns1,psym=10

!p.multi=0

chauhisto:
lainsoportablelevedad:

endfor

 footpoint_map,footlat_c,footlon_c,opclstat_c,filelabel=filelabel,indexloop_c,rotacion


;====================================================================================================================

;goto,tografic

  print,'rstart        =',rstart
  print,'Nlineas       =',Nlineas
  print,'Nsmallclose   =',Nsmallclose
  print,'Nlargeclose   =',Nlargeclose
  print,'Nopen         =',Nopen
  print,''
  print,'Análisis de piernas'

  print,'Nsmall_leg    =',Nsmall_leg
  print,'Nlarge_leg    =',Nlarge_leg
  print,'Nopen_leg     =',Nopen_leg
  print,''
  print,'open'
  print,'rsatrt          =',rstart
  print,'footlat[50,80]  =',Nof1
  print,'footlat[-80,-50]=',Nof2
  print,''
  print,'large_close'
  print,'rsatrt          =',rstart
  print,'footlat[-70,-30)=',Nlf4
  print,'footlat[-30,0)  =',Nlf3
  print,'footlat[0,30)   =',Nlf1
  print,'footlat[30,70]  =',Nlf2
  print,''
  print,'small_close'
  print,'rsatrt          =',rstart
  print,'footlat[-70,-30)=',Nsf4
  print,'footlat[-30,0)  =',Nsf3
  print,'footlat[0,30)   =',Nsf1
  print,'footlat[30,70]  =',Nsf2

tografic:

stop

return
end

pro hacer_trace
goto, caca
radstart= 1.035 + 0.02 *findgen(10)
Nrad = n_elements(radstart)
dlat = 2. + fltarr(Nrad)
dlon = 2. + fltarr(Nrad)

   fdips_file='fdips_field_150x180x360_synop_Mr_0.polfil.2081.ubdat'
   ldem_file='LDEM.v3.error_box.2081.euvi.A.base_gauss1_lin_Norm-median_singlStart'
   period ='2081_euviA-DECON_reg0.75_safety0.5_errorbox_base'

   trace_LDEM,fdips_file=fdips_file,ldem_file=ldem_file,period=period,safety=.5,stepmax=3000,/unifgrid_v2,dlat=dlat,dlon=dlon,radstart=radstart
caca:

;rad0=[1.045, 1.075, 1.115, 1.155, 1.250, 1.500]
rad0=[1.035,1.105]
for i=0,1 do begin
   ;fdips_file='fdips_field_150x180x360_synop_Mr_0.polfil.1915.ubdat'
   fdips_file='fdips_field_150x180x360_synop_Mr_0.polfil.2081.ubdat'
   ;fdips_field_150x180x360_synop_Mr_0.polfil.2081.ubdat
   ;ldem_file ='LDEM.v3.error_box.1915.eit.base_gauss1_lin_Norm-median_singlStart'
   ldem_file ='LDEM.v3.error_box.2081.euvi.A.base_gauss1_lin_Norm-median_singlStart'
   period ='2081_euviA-NODECON_reg0.75_safety1.0_grid2'
   ;period ='1915_eit_reg0.75_safety1.0_grid2'
trace_LDEM,fdips_file=fdips_file,ldem_file=ldem_file,period=period,radstart=rad0(i),safety=1.0,stepmax=15000,/unifgrid,dlat=2,dlon=2;,/expand
;trace_LDEM,fdips_file=fdips_file,ldem_file=ldem_file,period=period,radstart=rad0,safety=1.0,stepmax=15000,/unifgrid,dlat=2,dlon=2,/expand
endfor
;caca:
return
end


pro trace_LDEM,fdips_file=fdips_file,$
               ldem_file=ldem_file,$
               period=period,$
               outputfile=outputfile,$
               marcgrid=marcgrid,$
               unifgrid=unifgrid,$
               radstart=radstart,$
               spacing=spacing,$
               fieldtype=fieldtype,$
               safety=safety,$
               stepmax=stepmax,$
               Box=box,$
               dlat=dlat,$
               dlon=dlon,$
               mhd=mhd,$
               dgfw=dgfw,$
               expand=expand
  common comunes,tm,wt,nband,demc,PHI,parametrizacion,Tmin,Tmax,nr,nth,np,rad,lat,lon,lambda,WTc
  common results_tomo,tfbe,sfbe,N_e
  common loss_rate,Er
  common structure ,sph_data
  common structure2,pfss_data 

;+
; PURPOSE: 
; To trace tomographic results along magnetic field lines. 
; To sample the LDEM results that are already traced along magnetic fieldlines,
; keeping only one data point per tomographic cell (voxel), chosen as the median
; point of all the points that are located within each voxel.
;
; INPUTS:
; fdips_file = a file containing a FDIPS output.
; ldem_file  = a file containing a LDEM output.
; period = a string containing the Carrington rotation number.
; outputfile = not in use, output filename is currently created within the code.
; radstart = height [Rsun] where to start to trace, both inwards and outwards.
; spacing, fieldtype, safety = various keywords needed if /marcgrid is used, see
;                              comments in "spherical_field_start_coord.pro".
; box = [lon1,lat1,lon2,lat2] is the angular box where the starting
; points are to be located. If not set the default is full corona.
; nlat,nlon = needed if /unifgrid is used. Default values are: 90,180.
;
; KEYWORDS:
; /unifgrid = set up a uniform angular grid for the starting points.
; /marcgrid = use Marc's tools starting points routine.
; /dgfw     = set up if the double normal LDEM parametrization is used.
;
; OUTPUTS:
; A file containing the results, to be afterwards used as INPUT by the routine
; "sample_traced_ldem". Modificar

;
; FUTURE CHANGES: 
; Make it capable of using magnetic models other than FDIPS.
;
; HISTORY:
; Created by F.A. Nuevo & A.M. Vasquez.
;
; 7/24/15
; Modified by C. Mac Cormack & A.M. Vasquez.
;    - Trazado de los parámetros de la LDEM
;    - Expansión del trazado geométrico hasta 2.5 Rsun
;-

  if not keyword_set(fdips_file) then begin
     print,'set the PFSS model to trace the DEMT results'
     return
  endif
  if not keyword_set(ldem_file ) then begin
     print,'set a DEMT file to be traced'
     return
  endif
  if not keyword_set(period)     then begin
     print,'set a string with the period'
     return
  endif

if keyword_set(expand) then period=period+'_expand'

; Add radstart suffix to the output filename:
  period=period+'_radstart-'+strmid(string(radstart),6,5)+'Rs' 

; Make the output filename:
  if keyword_set(marcgrid) then suffix='_marcgrid'  
  if keyword_set(unifgrid) then suffix='_unifgrid'
  output_file='traceLDEM_CR'+period+suffix+'.heating.sampled.v2.CECI.dat'

; Set parameters for Marc's line-tracing routines:
  if NOT keyword_set(radstart ) then radstart  = 1.5
  if NOT keyword_set(safety   ) then safety    = 0.2
  if NOT keyword_set(stepmax  ) then stepmax   = 30000
  if NOT keyword_set(fieldtype) then fieldtype = 5.0
  if NOT keyword_set(spacing)   then spacing   = 2.0

  print,'-------------------------------------------'
  print,'     Period: ',period
  print,'  LDEM file: ',ldem_file
  print,' FDIPS file: ',fdips_file
  print,'Output file: ',output_file
  print,'-------------------------------------------'

  print,'safety: ',safety
  print,'stepmax: ',stepmax

; Set the FDIPS filename to read:
; PFSSM_model='/data1/DATA/PFSSM/'+fdips_file
  PFSSM_model= fdips_file
; Read the FDIPS model and create a structure to serve as input to Marc's routines:
  if not keyword_set(mhd)  then create_structure    ,PFSSM_model
  if     keyword_set(mhd)  then create_structure_MHD,'/data1/DATA/MHD_SWMF/'+fdips_file
; change the name of the created structure to a new name:
  pfss_data = sph_data

; Set the uniform grid size, in case /unifgrid is used for the starting points. 
; Default size is 90x180.
  if NOT keyword_set(dlat) then dlat = 2   
  if NOT keyword_set(dlon) then dlon = 2

; If BOX was not set use the full corona:
  if NOT keyword_set(box)  then box = [0.,-90,360.,+90.] 
  box=float(box)

; Set up the starting points:
  if keyword_set(marcgrid) then spherical_field_start_coord,pfss_data,fieldtype,spacing,radstart=radstart,bbox=box
  if keyword_set(unifgrid) then sph_field_str_coord_unifang,pfss_data,dlat,dlon        ,radstart=radstart,bbox=box

; And now, do trace the field lines:
  spherical_trace_field,pfss_data,linekind=linekind,linelengths=linelengths,safety=safety,stepmax=stepmax 

; Change the coding for linekind:
  linekind=linekind-2           ; so that 0=open and 1=closed

; Number of total traced lines:
  Nlin_all   = (size(*pfss_data.ptr))(2)
; Maximum number of points along those lines:
  Nptmax     = (size(*pfss_data.ptr))(1)
; Select field lines that were identified as open or closed by
  iOC        = where ( linekind eq 0 or linekind eq 1)
; Number of selected field lines (open or closed)
  Nlin     = n_elements(iOC) 
  print,'there are '+string(Nlin)+' of '+string(Nlin_all)+' field lines that are within  the boundaries'
; only keep the values of the array for selected field lines (open or
; closed) 
;---------------------------------------------------------------
  loopL       = linelengths       (iOC) ; N_lineas
  opcls       = linekind          (iOC) ; N_lineas
  nstep       = (*pfss_data.nstep)(iOC) ; N_lineas
  str_v       = (*pfss_data.str)  (iOC) ; N_lineas
  stth_v      = (*pfss_data.stth) (iOC) ; N_lineas  
  stph_v      = (*pfss_data.stph) (iOC) ; N_lineas  
;-----------------------------------------------------------

; Read the tomographics results and set a few parameters concerning
; the tomographic grid:
  if not keyword_set(dgfw) then $
     read_ldem,ldem_file,/ldem,/gauss1
  if     keyword_set(dgfw) then $
     read_ldem,ldem_file,/ldem,/dgfw
  dr_tom = rad(1)-rad(0)        ; grid radial bin size
  Rmax_tom = rad(nr-3)          ; maximum height for which LDEM was computed

;<--
if keyword_set(expand) then begin
nr=150
rad=1.+dr_tom/2+dr_tom*findgen(Nr)
endif
;<--

; Compute the scoreR for quality-selection purposes:
  ratio = sfbe/tfbe
 ;scoreR=total(    (1.-ratio)^2 , 4 ) / float(nband)
  scoreR=total( abs(1.-ratio)   , 4 ) / float(nband)

  Nptmax_v = 1500                ; ESTO NO ES ROBUSTO, 
;  sin embargo, por la experiencia de haber realizado varios trazados
;  creo que va funcionar. 
;  Ningun sampleo supera este valor de puntos por linea

; Generate the tomographic grid based results
; one data point per tomographic voxel crossed by line.
      Ne_v = fltarr(Nptmax_v,Nlin)
      Tm_v = fltarr(Nptmax_v,Nlin)
      WT_v = fltarr(Nptmax_v,Nlin)
      Er_v = fltarr(Nptmax_v,Nlin)

      npar = (size(lambda))(4)         
  lambda_v = fltarr(Nptmax_v,Nlin,npar)
    DEMc_v = fltarr(Nptmax_v,Nlin)     

  scoreR_v = fltarr(Nptmax_v,Nlin) 
     rad_v = fltarr(Nptmax_v,Nlin)
     lat_v = fltarr(Nptmax_v,Nlin)
     lon_v = fltarr(Nptmax_v,Nlin)
       s_v = fltarr(Nptmax_v,Nlin)
       B_v = fltarr(Nptmax_v,Nlin)
      Br_v = fltarr(Nptmax_v,Nlin)
     Bth_v = fltarr(Nptmax_v,Nlin)
     Bph_v = fltarr(Nptmax_v,Nlin)
 midCell_v = fltarr(Nlin) - 666.
    Npts_v = fltarr(Nlin) - 666. 
   enrad_v = 0. * str_v - 555.
   enlon_v = 0. * str_v - 555.
   enlat_v = 0. * str_v - 555.

; The following double-loop traces the tomographic results along the
; selected field lines:
xxx=0L
  for il = 5279L, Nlin-1 do begin

     ;stop    ;<--

     print,'tracing the DEMT results along the line '+string(il+1)+'    of '+string(Nlin)
     il_all=(findgen(Nlin_all))(iOC(il))
     Np_l      = Nstep(il)      ;  Number of points along the il-line
     
; Build more arrays:   
           s_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
          Ne_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
          Tm_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
          WT_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
          Er_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.  
      lambda_l = fltarr(Np_l,npar) -666. ;fltarr(Nptmax,Nlin) -666.
        DEMc_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
      scoreR_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
          Br_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
         Bth_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
         Bph_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
           B_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
         lab_l = fltarr(Np_l)      -666. ;fltarr(Nptmax,Nlin) -666.
        
; These next five arrays are futures implementacion
  ;Happix    = fltarr(Np_l) -666.
  ;Bappix    = fltarr(Np_l) -666.
  ;Bmean     = fltarr(Np_l) -666.
  ;Bfoot1    = fltarr(Np_l) -666.
  ;Bfoot2    = fltarr(Np_p) -666. 
     
   rad_l  = reform((*pfss_data.ptr) (0:Np_l-1,il_all))
    th_l  = reform((*pfss_data.ptth)(0:Np_l-1,il_all))
   lat_l  = 90. - th_l / !dtor
    ph_l  = reform((*pfss_data.ptph)(0:Np_l-1,il_all))
; Make sure ph_l is in the range [0,2pi]:
  iphneg  = where( ph_l lt 0.    ) & if iphneg(0) ne -1 then ph_l(iphneg)=ph_l(iphneg)+2.*!pi  
  iph5th  = where( ph_l gt 2.*!pi) & if iph5th(0) ne -1 then ph_l(iph5th)=ph_l(iph5th)-2.*!pi
   lon_l  = ph_l/!dtor
      xl  = rad_l * sin(th_l) * cos(ph_l)
      yl  = rad_l * sin(th_l) * sin(ph_l)
      zl  = rad_l * cos(th_l)
     ds2l = (xl(1:Np_l-1)-xl(0:Np_l-2))^2 + $
            (yl(1:Np_l-1)-yl(0:Np_l-2))^2 + $
            (zl(1:Np_l-1)-zl(0:Np_l-2))^2 
     ds2l = [0,ds2l]
;-------------AGREGADO---------------------------------------
; Store coordinates of ending point of all OPEN field lines
if opcls(il) eq 0 then begin
enrad_v(il)=rad_l(Np_l-1)
enlat_v(il)=lat_l(Np_l-1)
enlon_v(il)=lon_l(Np_l-1)
endif 
;-----------------------------------------------------------
;

Np = 1
  for ir = 0,Np_l-1 do begin
      s_l (ir) = total(sqrt(ds2l(0:ir)))
      r0 = rad_l (ir)
     th0 =  th_l(ir)
     ph0 =  ph_l(ir)
     ptc = [r0,th0,ph0]
     irc = get_interpolation_index(*pfss_data.rix,ptc(0))
     ithc= get_interpolation_index(*pfss_data.lat,90-ptc(1)*!radeg)
     iphc= get_interpolation_index(*pfss_data.lon,(ptc(2)*!radeg+360) mod 360)
      Brc= interpolate(*pfss_data.Br ,iphc,ithc,irc)
     Bthc= interpolate(*pfss_data.Bth,iphc,ithc,irc)
     Bphc= interpolate(*pfss_data.Bph,iphc,ithc,irc)  
     
     if r0 eq max(rad)+dr_tom/2 then r0=r0*(1.-1.e-5)
     if r0 lt max(rad)+dr_tom/2 then begin
      determindex,r0,th0,ph0,irad,ilat,ilon
     if irad ne -1 and ilon ne -1 and ilat ne -1 then begin
         lab_l(ir) = (Nth*Np)*irad+(Np)*ilat+ilon+1 ; Voxel label
        if  rad_l(ir) le Rmax_tom+dr_tom/2 then begin ;<--
             Ne_l(ir)   = N_e(irad,ilat,ilon)
             Tm_l(ir)   = Tm (irad,ilat,ilon)
             WT_l(ir)   = WT (irad,ilat,ilon)
             Er_l(ir)   = Er (irad,ilat,ilon)
         lambda_l(ir,*) = lambda(irad,ilat,ilon,*)  ;<-- grabo cada componente
         DEMc_l  (ir)   = DEMc  (irad,ilat,ilon)  ;<--
         scoreR_l(ir)   = scoreR (irad,ilat,ilon) 
        endif                
          Br_l(ir) = Brc
         Bth_l(ir) = Bthc
         Bph_l(ir) = Bphc
           B_l(ir) = sqrt(Brc^2 + Bthc^2 + Bphc^2) 
      endif 
   endif

  endfor                        ; closes radial loop
STOP
; beginning the sampled
;--------------------------------------------------------------------------------------------------

if rad_l(0) gt 2.4 then stop

        line_end = 0
        ivox     = 0
        is       = 0 
        lab0     = lab_l(is)
        while line_end eq 0 do begin
           npp=0
           while lab_l(is) eq lab0 do begin
              npp=npp+1        
              is=is+1
               if lab0 eq -666. or is-1 eq Np_l-1 then goto,nextvoxel
               ;if lab0 eq -666.                   then goto,nextvoxel 
;this line was modified 2013-08-16 by F.A.N. there was not robust enough
 
           endwhile
           ; "npp" should be now the number of points within voxel "lab0" 
           ; "is" should be now the index of the 1st point in the NEXT voxel  
           index=is-npp+indgen(npp)
           ; "index" should be now the 1-D index of all points in
           ; voxel lab0, to be used in arrays *_l
           ind = (median(index))(0)
                Ne_v(ivox,il) =     Ne_l(ind)
                Tm_v(ivox,il) =     Tm_l(ind)
                WT_v(ivox,il) =     WT_l(ind)
                Er_v(ivox,il) =     Er_l(ind)
            Lambda_v(ivox,il,*)=lambda_l(ind,*)
              DEMc_v(ivox,il) =   DEMc_l(ind)  
            scoreR_v(ivox,il) = scoreR_l(ind)
           if npp mod 2 eq 1 then begin  ; does this if npp=odd 
               rad_v(ivox,il) =    rad_l(ind)
               lat_v(ivox,il) =    lat_l(ind)
               lon_v(ivox,il) =    lon_l(ind)
                 s_v(ivox,il) =      s_l(ind)
                 B_v(ivox,il) =      B_l(ind)
                Br_v(ivox,il) =     Br_l(ind) 
               Bth_v(ivox,il) =    Bth_l(ind)
               Bph_v(ivox,il) =    Bph_l(ind)     
           endif else begin             ; does this if npp=even 
             rad_v(ivox,il) = 0.5*(rad_l(ind)+rad_l(ind-1))
             lat_v(ivox,il) = 0.5*(lat_l(ind)+lat_l(ind-1))
             lon_v(ivox,il) = 0.5*(lon_l(ind)+lon_l(ind-1))
               s_v(ivox,il) = 0.5*(  s_l(ind)+  s_l(ind-1))
               B_v(ivox,il) = 0.5*(  B_l(ind)+  B_l(ind-1))
              Br_v(ivox,il) = 0.5*( Br_l(ind)+ Br_l(ind-1))
             Bth_v(ivox,il) = 0.5*(Bth_l(ind)+Bth_l(ind-1))
             Bph_v(ivox,il) = 0.5*(Bph_l(ind)+Bph_l(ind-1))   
           endelse
           ; If this voxel is the maximum of the tom grid
           ; but there are MORE points traced => it is a closed
           ; loop with appex > Rmax_tom. If so, store midCell_v.
           ; Also, do it only if midCell_v was not stored already.
           ; See in Zhenguang's Matlab code that this midCell_v 
           ; is same as his.
           ; Rmax_tom = 1.255 
           ; dr_tom = 0.01
;goto,skip_print
          print,ivox
          print,ind
          print,index
          print,lab_l(index)
          print,rad_l(ind), Rmax_tom - dr_tom/2
          print,max(index),Np_l-1
          print,opcls(il)
          print,midCell_v(il)
skip_print:
;          stop
           if (rad_l(ind) ge Rmax_tom - dr_tom/2) AND (max(index) lt Np_l-1) AND opcls(il) eq 1. then midCell_v(il) = ivox
           ivox = ivox+1 ; increase ivox 
           ;if max (rad_v(*,il)) lt 1.249 then stop ;--> debugeando BORRAR!!!!
           nextvoxel:
            if is-1 eq Np_l-1 then line_end = 1
            if is-1 lt Np_l-1 then     lab0 = lab_l(is)          
         
         endwhile; closes each line's while
        Npts_v(il) = ivox; For each line, record the number of points in vector
; Label small-closed-loops as "2"
   if opcls(il) eq 1. and midCell_v(il) eq -666. then begin
      midcell_v(il) = ( where ( rad_v(0:npts_v(il)-1,il) eq max (rad_v(0:npts_v(il)-1,il))) )(0)
          opcls(il) = 2.
       endif
   if opcls(il) eq 1. and max(rad_v(*,il)) le (Rmax_tom - dr_tom/2) then stop ;xxx=xxx+1
   if opcls(il) eq 1. and max(rad_v(*,il)) le (Rmax_tom - dr_tom/2) then xxx=xxx+1
   if il eq 5278L then STOP
;         stop
;end the sampled
;-------------------------------------------------------------------------------------------
;il=il+1
;endif
endfor                          ; closes lines loop
print,xxx
stop
; Trim all unnecesary information from resulting arrays:
 Npts_max = max(Npts_v)
    Ne_v  = reform(     Ne_v(0:Npts_max-1,*) ) 
    Tm_v  = reform(     Tm_v(0:Npts_max-1,*) ) 
    WT_v  = reform(     WT_v(0:Npts_max-1,*) )
    Er_v  = reform(     Er_v(0:Npts_max-1,*) )
lambda_v  = reform( lambda_v(0:Npts_max-1,*,*) )
  DEMc_v  = reform(   DEMc_v(0:Npts_max-1,*) )  
scoreR_v  = reform( scoreR_v(0:Npts_max-1,*) ) 
   rad_v  = reform(    rad_v(0:Npts_max-1,*) ) 
   lat_v  = reform(    lat_v(0:Npts_max-1,*) ) 
   lon_v  = reform(    lon_v(0:Npts_max-1,*) ) 
     s_v  = reform(      s_v(0:Npts_max-1,*) )
     B_v  = reform(      B_v(0:Npts_max-1,*) )
    Br_v  = reform(     Br_v(0:Npts_max-1,*) )
   Bth_v  = reform(    Bth_v(0:Npts_max-1,*) )
   Bph_v  = reform(    Bph_v(0:Npts_max-1,*) )  
; Save the sampled data:
      openw,1,output_file
   writeu,1,fieldtype,spacing,radstart,Rmax_tom,dr_tom,WTc
   writeu,1,Nlin,Npts_max
   writeu,1,rad_v,lat_v,lon_v,s_v,npts_v,midcell_v,loopL,opcls
   writeu,1,Ne_v,Tm_v,WT_v,Er_v,scoreR_v
   writeu,1,str_v,stth_v,stph_v
   writeu,1,B_v,Br_v,Bth_v,Bph_v   
;------AGREGADO--------------
   writeu,1,enrad_v,enlon_v,enlat_v
;<---------------
   L=0
   if Tmax gt 3.4e6 and Tmax lt 3.6e6 then L=171
   if Tmax gt 3.9e6 and Tmax lt 4.1e6 then L=192
   writeu,1,Tmin,Tmax,L
   writeu,1,npar,DEMc_v
   writeu,1,lambda_v   
;<---------------
  close,  1
return
end


pro determindex,r0,th0,ph0,irad,ilat,ilon
  common comunes,tm,wt,nband,demc,PHI,parametrizacion,Tmin,Tmax,nr,nth,np,rad,lat,lon,lambda,WTc
  common structure2,pfss_data
 ; Purpose: Given the position vector coordinates (r0,th0,ph0)
 ;          find the 3 1D-indexes of the tomographic grid cell
 ;          that contains that position.
 drad = rad(1) - rad (0)
 dlat = lat(1) - lat (0)
 dlon = lon(1) - lon (0)   
 rad0 = r0
 lat0 = 90 - th0/!dtor
 lon0 =      ph0/!dtor
 irad = (where(rad0 ge rad-drad/2 AND rad0 lt rad+drad/2))(0) 
 ilat = (where(lat0 ge lat-dlat/2 AND lat0 lt lat+dlat/2))(0) 
 ilon = (where(lon0 ge lon-dlon/2 AND lon0 lt lon+dlon/2))(0)                
 return
end

pro read_trace_sampled,file,alturas
  common trace_sampled,rad_v,lat_v,lon_v,s_v,Ne_v,Tm_v,WT_v,Er_v,scoreR_v,midcell_v,Npts_v,str_v,stth_v,stph_v,radstart,enrad_v,enlon_v,enlat_v,npar,DEMc_v,lambda_v,L,Tmin,Tmax
  common B_sampled,B_v,Br_v,Bth_v,Bph_v
  common opclstatus,opcls,loopL,WTc  
;+
; PURPOSE:
; To read the output of the routine "trace_LDEM"
;-
  Nlin=0L      
  Npts_max=0.
  fieldtype=0.
  spacing =0. 
  radstart=fltarr(alturas)
  Rmax_tom=0.
  dr_tom=0.
  WTc=0.
  dir='/data1/DATA/MLDT/'
  openr,1,dir+file
  readu,1,fieldtype,spacing,radstart,Rmax_tom,dr_tom,WTc
  readu,1,Nlin,Npts_max
 
      Ne_v = fltarr(Npts_max,Nlin)
      Tm_v = fltarr(Npts_max,Nlin)
      WT_v = fltarr(Npts_max,Nlin)
      Er_v = fltarr(Npts_max,Nlin)
  scoreR_v = fltarr(Npts_max,Nlin)
     rad_v = fltarr(Npts_max,Nlin)
     lat_v = fltarr(Npts_max,Nlin)
     lon_v = fltarr(Npts_max,Nlin)
       s_v = fltarr(Npts_max,Nlin)
       B_v = fltarr(Npts_max,Nlin)
      Br_v = fltarr(Npts_max,Nlin)
     Bth_v = fltarr(Npts_max,Nlin)
     Bph_v = fltarr(Npts_max,Nlin)

 midCell_v = fltarr(Nlin) 
    Npts_v = fltarr(Nlin) 
     opcls = intarr(Nlin) 
     Loopl = fltarr(Nlin) 
     str_v = fltarr(Nlin)   
    stth_v = dblarr(Nlin)   
    stph_v = dblarr(Nlin)    

  readu,1,rad_v,lat_v,lon_v,s_v,npts_v,midcell_v,loopL,opcls
  readu,1,Ne_v,Tm_v,WT_v,Er_v,scoreR_v
  readu,1,str_v,stth_v,stph_v 
  readu,1,B_v,Br_v,Bth_v,Bph_v     
;------AGREGADO--------------
   enrad_v = fltarr(Nlin)   
   enlon_v = fltarr(Nlin)   
   enlat_v = fltarr(Nlin)  
;------AGREGADO--------------
 readu,1,enrad_v,enlon_v,enlat_v
;----------------------------
    Tmin=0.
    Tmax=0.
    L=0
 readu,1,Tmin,Tmax,L
    npar   = 0                      ;<--
    DEMc_v = fltarr(Npts_max,Nlin)  
 readu,1,npar,DEMc_v
  lambda_v = fltarr(Npts_max,Nlin,npar) 
 readu,1,lambda_v
  close,1

  return
end

;make_mapoc,'traceLDEM_CR1914_eit_l0.75_radstart-1.075Rs_unifgrid.heating.sampled.v2.dat','CR1914_90X180blines_r_',1.075,/mdi
;make_mapoc,'traceLDEM_CR1915_eit_l0.75_radstart-1.075Rs_unifgrid.heating.sampled.v2.dat','CR1915_90X180blines_r_',1.075,/mdi
;make_mapoc,'traceLDEM_CR1919_eit_l0.75_radstart-1.075Rs_unifgrid.heating.sampled.v2.dat','CR1919_90X180blines_r_',1.075,/mdi
;make_mapoc,'traceLDEM_CR2081_euviA_l1.0_radstart-1.075Rs_unifgrid.heating.sampled.v2.dat','CR2081_90X180blines_r_',1.075,/mdi
;make_mapoc,'traceLDEM_CR2081_euviA_l0.75_radstart-1.075Rs_unifgrid.heating.sampled.v2.dat','CR2081_90X180blines_r_',1.035,/mdi
pro MAKE_MAPOC,file_input,filesuffix,rc,mdi=mdi,gng=gng
common trace_sampled,rad_v,lat_v,lon_v,s_v,Ne_v,Tm_v,WT_v,Er_v,scoreR_v,midcell_v,Npts_v,str_v,stth_v,stph_v,radstart,enrad_v,enlon_v,enlat_v,npar,DEMc_v,lambda_v,L,Tmin,Tmax
common B_sampled,B_v,Br_v,Bth_v,Bph_v
common opclstatus,opcls,loopL,WTc  

dir='/data/DATA/PFSSM/'

 if keyword_set(mdi) then postsuffix='_MDI.dat'
 if keyword_set(gng) then postsuffix='_GNG.dat'

 stringheight=strmid(string(rc),6,5)
 file_output=filesuffix+stringheight+'_open-close-map'+postsuffix
 print,'-----> O/C: '+file_output
 
read_trace_sampled,file_input,1

stth = stth_v
stph = stph_v

nlat= 90
nlon=180
dlat=180./nlat
dlon=360./nlon
latmin = -90.
lonmin =   0.
lat = latmin + dlat /2. + dlat * findgen(nlat)
lon = lonmin + dlon /2. + dlon * findgen(nlon)

stlon = round(    stph/!dtor)*1.
stlat = round(90.-stth/!dtor)*1.

N = n_elements(stlon)

mapoc = fltarr(1,nlat,nlon)

for i=0,N-1 do begin
  ilat = where(lat eq stlat(i))
  ilon = where(lon eq stlon(i))
  mapoc(0,ilat,ilon) = opcls(i)
endfor

;quedo: 0=abierto o indeterminado
;       1=cerrado

;cambiar al final a:  (open = 10) y (closed = 0.1)

iopen   = where ( mapoc eq 0 )
iclosed = where ( mapoc eq 1 or mapoc eq 2)

mapoc(iopen)   = 10
mapoc(iclosed) = 0.1

 openw,1,dir+file_output
 writeu,1,mapoc
 close,1

return
end

pro statloop,file,rmin=rmin,rmax=rmax,rloopmin=rloopmin,linear=linear,fitcuadr=fitcuadr,altura=altura
common trace_sampled,rad_v,lat_v,lon_v,s_v,Ne_v,Tm_v,WT_v,Er_v,scoreR_v,midcell_v,Npts_v,str_v,stth_v,stph_v,radstart,enrad_v,enlon_v,enlat_v   
common quemierda,alturas
common B_sampled,B_v,Br_v,Bth_v,Bph_v
common opclstatus,opcls,loopL,WTc  
common statistic_loops,Nlegs,Nemean,Tmmean,WTmean,Nestddev,Tmstddev,WTstddev,loop_length,betamean,betaapex,Bmean,Br0
common statistic_loops2,opclstat,lambda_N,lambda_p,Ne0,p0,Tefit,gradT,r2N,r2P,r2T,indexloop,leg_status,Tm0,Tm0s,tm0_2,tm0_3,tm0_4,gradt_2,gradt_3,gradt_4,r2T_2,f_t,f_ne
common statistic_loops3,Eh,sH,r2sH,Phir,Fcb
common statistic_loops4,r2Tcuadr,Acuadr_a, s_r0_a,dTmds,r2Ts
common starttrace,strad,stlat,stlon,footrad,footlat,footlon,Rp_rad,Rp_lat,Rp_lon 
common angle_box,rad_ini,rad_fin,lat_ini,lat_fin,lon_ini,lon_fin

device, retain     = 2
device, true_color = 24
device, decomposed = 0

; Physical constants needed for the HS fits:
  rsun = 6.955e10    ; cm
  gsun = 2.74e4      ; cm/sec²
    kB = 1.38e-16    ; erg/K
    mH = 1.6726e-24  ; gr
     a = 0.08        ; N_He / N_H
    mu = (1.+4.*a)/(1.+2.*a)
    bb = (1.+2.*a)/(2.+3.*a)
 kappa = 9.2e-7      ; erg s ^-1 cm ^-1 K ^-7/2 

if not keyword_set(rmin) then rmin = 1.03 
if not keyword_set(rmax) then rmax = 1.20
if not keyword_set(rloopmin) then rloopmin = 1.07
rminloop=rloopmin

; Read the sampled tomographic traced data
;read_trace_sampled,file
if not keyword_set (altura) then read_trace_sampled,file,0
if     keyword_set (altura) then read_trace_sampled,file,alturas

Nloop = n_elements(loopL)

index0 = where(opcls eq 0.)
index1 = where(opcls eq 1.)
index2 = where(opcls eq 2.)

Nloop0 = n_elements(index0) & if index0(0) eq -1 then Nloop0=0
Nloop1 = n_elements(index1) & if index1(0) eq -1 then Nloop1=0
Nloop2 = n_elements(index2) & if index2(0) eq -1 then Nloop2=0

if Nloop0 + Nloop1 + Nloop2 ne Nloop then stop

Nlegs = Nloop0 + 2*Nloop1 + 2*Nloop2 

; Mean and standard desviation values for each leg
 Nemean = fltarr(Nlegs)-555.
 Tmmean = fltarr(Nlegs)-555.
 WTmean = fltarr(Nlegs)-555.
Nestddev= fltarr(Nlegs)-555.
Tmstddev= fltarr(Nlegs)-555.
WTstddev= fltarr(Nlegs)-555.
; HS fits results for each leg
     Ne0 = fltarr(Nlegs)-555.
lambda_N = fltarr(Nlegs)-555.
   Tefit = fltarr(Nlegs)-555.
     r2N = fltarr(Nlegs)-555.
      P0 = fltarr(Nlegs)-555.
lambda_P = fltarr(Nlegs)-555.
     r2P = fltarr(Nlegs)-555.
   gradT = fltarr(Nlegs)-555.
     Tm0 = fltarr(Nlegs)-555.  ; esto es r

;agregado 5/4/2016 diego
     gradT_2 = fltarr(Nlegs)-555.
     r2T_2 = fltarr(Nlegs)-555.
     Tm0_2 = fltarr(Nlegs)-555.
     error_ladfit = fltarr(Nlegs)-555.
     r2T_new = fltarr(Nlegs)-555.
     r2T_2_new = fltarr(Nlegs)-555.
     r2T_3_new = fltarr(Nlegs)-555.
     gradT_3 = fltarr(Nlegs)-555.
     Tm0_3 = fltarr(Nlegs)-555.
     r2T_3 = fltarr(Nlegs)-555.
     r2N_ts = fltarr(Nlegs)-555.
     lambda_N_ts = fltarr(Nlegs)-555.
     Ne0_ts = fltarr(Nlegs)-555.
     gradT_4 = fltarr(Nlegs)-555.
     Tm0_4 = fltarr(Nlegs)-555.
     f_T  = fltarr(Nlegs)-555.
     f_ne = fltarr(Nlegs)-555.
     r2_lin = fltarr(Nlegs)-555.
     r2_lin_ts = fltarr(Nlegs)-555.
;----.

    Tm0s = fltarr(Nlegs)-555.  ; en cada pierna. esto es s

     r2T = fltarr(Nlegs)-555.
   dTmds = fltarr(Nlegs)-555.
    r2Ts = fltarr(Nlegs)-555.
r2Tcuadr = fltarr(Nlegs)-555.
Acuadr_a = fltarr(Nlegs,3)-555.
  s_r0_a = fltarr(Nlegs)-555.
      Eh = fltarr(Nlegs)-555.

    Phir = fltarr(Nlegs)-963.  ; flujo radiativo
     Fcb = fltarr(Nlegs)-963.  ; Fc en la base

 deltaEh = fltarr(Nlegs)-555.
      sH = fltarr(Nlegs)-555.
    r2sH = fltarr(Nlegs)-555.
betamean = fltarr(Nlegs)-555.
betaapex = fltarr(Nlegs)-555.
   Bmean = fltarr(Nlegs)-555.
     Br0 = fltarr(Nlegs)-555. ;only applied for open lines 

; opclstat=0. if loop is open, opclstat=1. if closed large; opclstat=2 if closed small. 
opclstat  = fltarr(Nlegs)-555.
indexloop = fltarr(Nlegs)-555.
; The following arrays will contain the LOOP length (in Rsun) to which each LEG belongs: 
loop_length=fltarr(Nlegs)-555.
; The following arrays will contain the coordinates of 
; the starting point used for the LOOP to which the LEG belongs:
strad = fltarr(Nlegs)-555.
stlat = fltarr(Nlegs)-555.
stlon = fltarr(Nlegs)-555.
; The following arrays will contain the coordinates of 
; the initial and final points of the LOOP to which each LEG belongs:
rad_ini = fltarr(Nlegs)-555.
lat_ini = fltarr(Nlegs)-555.
lon_ini = fltarr(Nlegs)-555.
rad_fin = fltarr(Nlegs)-555.
lat_fin = fltarr(Nlegs)-555.
lon_fin = fltarr(Nlegs)-555.
; The following arrays will contain the coordinates of 
; the FOOT-POINT of each LEG:
footrad = fltarr(Nlegs)-555.
footlat = fltarr(Nlegs)-555.
footlon = fltarr(Nlegs)-555.

;=======================================                                                                                                                                                                                                     
Rp0_rad = fltarr(Nlegs)-555.
Rp0_lat = fltarr(Nlegs)-555.
Rp0_lon = fltarr(Nlegs)-555.

Rp_rad = fltarr(Nlegs)-555.
Rp_lat = fltarr(Nlegs)-555.
Rp_lon = fltarr(Nlegs)-555.
;======================================= 

; This array will code the "STATUS of LEG" so that:
; leg_status=1 if leg contains the starting point used for the loop,
; leg_status=2 if not.
  leg_status = fltarr(Nlegs) + 1. 

; Initialize ileg index:
  ileg = 0L


; Define minimum number of data points required by leg
  Ndata=5
mierda = fltarr(Nloop) -123. ;debugeango la porqueria ---> BORRAR
ind_mierda=0
; Start analysis of each loop
  for il=0L,Nloop-1 do begin

;stop

; Analysis for OPEN loops:
  if opcls(il) eq 0. then begin

     Ne_l = reform ( Ne_v(0:Npts_v(il)-1,il))
     Tm_l = reform ( Tm_v(0:Npts_v(il)-1,il))
     WT_l = reform ( WT_v(0:Npts_v(il)-1,il))
     Er_l = reform ( Er_v(0:Npts_v(il)-1,il))
 scoreR_l = reform ( scoreR_v(0:Npts_v(il)-1,il)) 
    rad_l = reform (rad_v(0:Npts_v(il)-1,il))
    lat_l = reform (lat_v(0:Npts_v(il)-1,il))
    lon_l = reform (lon_v(0:Npts_v(il)-1,il))
      s_l = reform (  s_v(0:Npts_v(il)-1,il))   
      B_l = reform (  B_v(0:Npts_v(il)-1,il))   
     Br_l = reform ( Br_v(0:Npts_v(il)-1,il))   
 
    rad_ini(ileg) = rad_l(0)
    lat_ini(ileg) = lat_l(0)
    lon_ini(ileg) = lon_l(0)
        Br0(ileg) =  Br_l(0)
;----------------------------------AGREGADO----------------
    rad_fin(ileg) = enrad_v(il)
    lat_fin(ileg) = enlat_v(il) 
    lon_fin(ileg) = enlon_v(il)
;------------------------------------------------------------
    
    footrad(ileg) = rad_ini(ileg)
    footlat(ileg) = lat_ini(ileg)
    footlon(ileg) = lon_ini(ileg)
;----------------------------------------------------------

    rrr=findel(1.075,rad_l)
    Rp0_rad(ileg) = rad_l(rrr)
    Rp0_lat(ileg) = lat_l(rrr)
    Rp0_lon(ileg) = lon_l(rrr)

    Rp_rad(ileg) = Rp0_rad(ileg)
    Rp_lat(ileg) = Rp0_lat(ileg)
    Rp_lon(ileg) = Rp0_lon(ileg)

   ;Select useful data
    p = where ( rad_l ge rmin and rad_l le rmax and Ne_l ne -999. and scoreR_l lt 0.10)

    if p(0) eq -1 then goto,skipnextloop_open

     Ne_l =  Ne_l (p)
     Tm_l =  Tm_l (p)
     WT_l =  WT_l (p)
     Er_l =  Er_l (p) 
    rad_l = rad_l (p)
    lat_l = lat_l (p)
    lon_l = lon_l (p)
      s_l =   s_l (p)
      B_l =   B_l (p)    
    ;make tomographic pressure
    p_l   = kB/bb *Ne_l*Tm_l 
    ;make Beta plasma parameter
   beta_l = p_l/(B_l^2/(8*!pi))

      Nemean(ileg) =   mean(Ne_l)
      Tmmean(ileg) =   mean(Tm_l)
      WTmean(ileg) =   mean(WT_l)
    Nestddev(ileg) = stddev(Ne_l)
    Tmstddev(ileg) = stddev(Tm_l)
    WTstddev(ileg) = stddev(WT_l)
    betamean(ileg) =   mean(beta_l)
       Bmean(ileg) =   mean(B_l)

    if n_elements(p) lt Ndata then goto,skipfitloop_open

    rr1 = 1.07 
    rr1 = 1.06
    rr2 = 1.12 ;1.16
    
    lefts  = n_elements(where(rad_l le rr1))
    rights = n_elements(where(rad_l ge rr2))
    diomes = n_elements(where(rad_l gt rr1 and rad_l le rr2))
    if lefts eq -1 or diomes eq -1 or rights eq -1 then goto,skipfitloop_open
    ;if lefts le 2 or diomes le 2 or rights le 1 then goto,skipfitloop_open ;identifica al menos 2 puntos en el medio.
    ;if min(rad_l) gt rr1 or max(rad_l) lt rr2 then goto,skipfitloop_open 
        

   ;Make HS-fit to Ne(r) for each open leg/loop
      xfit = rad_l
      yfit =  Ne_l
    rminhs = min(rad_l);rmin
    rmaxhs = max(rad_l);rmax 

        if      keyword_set(linear) then fithslinear,xfit,yfit,rminhs,rmaxhs,A,corr2,alin,A_ts,corr2_ts,alin_ts,SSerr_N_cuad,SSerr_N_cuad_ts,r2_linn,r2_linn_ts
        if not  keyword_set(linear) then fiths,xfit,yfit,rminhs,rmaxhs,A,corr2
    
         Ne0(ileg) = A[0] 
    lambda_N(ileg) = 1./A[1]  ; Rsun
              Tfit = mu * mH * gsun * (lambda_N(ileg)*rsun) / kB
       Tefit(ileg) = bb*Tfit
         r2N(ileg) = corr2
         Ne0_ts(ileg) = a_ts[0] ; agregado                                                                              
         lambda_N_ts(ileg) = 1./a_ts[1]
         r2N_ts(ileg) = corr2_ts
         y_lineal_N = alin_ts(0) + alin_ts(1) * 1./xfit

         ep = 0.005
         franja_lineal,1./xfit,alog(yfit),y_lineal_N,ep,yru_N,yrd_N,r2_ts_lin,F1
         f_ne (ileg) = f1
         r2_lin (ileg) = r2_linn
         r2_lin_ts (ileg) = r2_linn_ts
   ;Make HS-fit to p(r) for each open leg/loop    
      yfit = p_l
   
        if      keyword_set(linear) then fithslinear,xfit,yfit,rminhs,rmaxhs,A,corr2;,alin,A_ts,corr2_ts,alin_ts,SSerr_p_cuad,SSerr_p_cuad_ts,r2_linn,r2_linn_ts
        if not  keyword_set(linear) then fiths,xfit,yfit,rminhs,rmaxhs,A,corr2

          p0(ileg) = a[0] 
    lambda_p(ileg) = 1./A[1]  ; Rsun
         r2P(ileg) = corr2
         ;p0_ts(ileg) = a_ts[0] ; agregado
    ;lambda_p_ts(ileg) = 1./a_ts[1]
    ;r2p_ts(ileg) = corr2_ts

   ;Make LINEAR-fit to T(r) for each open leg/loop
           yfit = Tm_l
  
    fitTemp,xfit,yfit,rminhs,rmaxhs,A,corr2
            T0r = A[0]
      Tm0(ileg) = T0r
    gradT(ileg) = A[1]
      r2T(ileg) = corr2 
;-------------.
;agregado 5/4/2016 Testeando diferentes T-fit.
      
fitTemp_ts2,xfit,yfit,rminhs,rmaxhs,a1,b1,corr4
      Tm0_3(ileg) = b1
      gradT_3(ileg) = a1
      r2t_3 (ileg) = corr4
      y_lineal_t = b1 + a1 * xfit
      ep = 0.1
      franja_lineal,xfit,yfit,y_lineal_t,ep,yru_t,yrd_t,SSerr_t,F2
      f_t (ileg) = f2

;fitTemp_ts,xfit,yfit,rminhs,rmaxhs,A_4,fit_4
    ;Tm0_4(ileg) = A_4[0]
     ;gradT_4(ileg) = A_4[1]
 
;saltito
goto, salteando_esto
if  abs(footlat(ileg)) le 30 and r2n(ileg) lt 0.9  then begin
;if ileg eq 1427 then begin
print, ileg, r2t(ileg),footrad(ileg), footlat(ileg), footlon(ileg)
print, il  , Ne0(ileg), lambda_N(ileg),Ne0_ts(ileg),lambda_N_ts(ileg)
print, opcls(il)
loadct,12
verde = 25
azul =100
rojo =200
negro=  0

window,0,xsize=800,ysize=800
!p.multi=[0,2,2]
fitcuadr_N     =  Ne0(ileg)    * exp( -1./lambda_N   (ileg)*(1.-1./xfit) ) 
fitcuadr_N_ts  =  Ne0_ts(ileg) * exp( -1./lambda_N_ts(ileg)*(1.-1./xfit) ) 
fitlin_N       =  alin(0)  + alin(1)    * (1./xfit) 
fitlin_N_ts    = alin_ts(0) + alin_ts(1) * (1./xfit)

plot ,1./xfit,alog(Ne_l),psym=4,yrange=[min(alog(Ne_l))-.2,max(alog(Ne_l))+.2],/nodata
oplot,1./xfit,alog(Ne_l),psym=4
oplot,1./xfit,fitlin_N,thick=2
oplot,1./xfit,fitlin_N_ts,thick=2,color=azul
oplot,1./xfit,yru_n,thick=2,color=verde
oplot,1./xfit,yrd_n,thick=2,color=verde
xyouts,.35*[.75,1.],0.66*[1,1],[r2_lin(ileg),r2_lin_ts(ileg)],/normal,charthick=2,Font=0
xyouts,.35*[0.75],[0.59],['F  ='+strmid(string(float(F1)),4,5)],/normal;,charsize=2
plot, xfit, tm_l, psym=4,/nodata;yrange=[min(tm_l),max(tm_l)],/nodata
oplot, xfit, tm_l, psym=4
f1_puto= tm0  (ileg) + gradt  (ileg)*xfit
;f2_puto= tm0_2(ileg) + gradt_2(ileg)*xfit
f3= tm0_3(ileg) + gradt_3(ileg)*xfit

xyouts,.98-[.3,.2,.1],0.59*[1,1,1],['r2t','lf','ts'],/normal,charthick=3,Font=0
xyouts,.98-[.35,.25,.15],0.57*[1,1,1],[r2t(ileg),r2t_2(ileg),r2t_3(ileg)],/normal,charthick=3,Font=0
;xyouts,.98-[.15],0.61*[1],[boolean_check_t],/normal,charthick=3,Font=0
xyouts,.98-[0.15],[0.61],['F  ='+strmid(string(float(F2)),4,5)],/normal,charsize=2
oplot, xfit,f1_puto ,thick=2
;oplot, xfit,f2_puto ,thick=2,color=rojo
oplot, xfit,f3 ,thick=2,color=azul
oplot,xfit,yru_t,thick=2,color=verde
oplot,xfit,yrd_t,thick=2,color=verde

plot,xfit,Ne_l,psym=4
oplot,xfit,fitcuadr_N   ,thick=2
oplot,xfit,fitcuadr_N_ts,thick=2,color=azul
xyouts,1.-[.7,.6],0.1*[1,1],[r2N(ileg),r2N_ts(ileg)],/normal,charthick=3,Font=0
xyouts,1.-[.7,.6],0.4*[1,1],[SSerr_N_cuad,SSerr_N_cuad_ts],/normal,charthick=3,Font=0
;plot,xfit,fitcuadr_p_ts,thick=2,color=azul
;plot,xfit,alog(Ne_l),psym=4,yrange=[min(alog(Ne_l))-4.,max(alog(Ne_l))+4.]
!p.multi=0
stop
endif
salteando_esto:;saltito

;-------------.

    ;Make LINEAR-fit to T(s) for each open leg/loop ======================
    
           xfit = s_l*rsun    
         rminhs = min(s_l*rsun);smin
         rmaxhs = max(s_l*rsun);smax 
           yfit = Tm_l
    fitTemp,xfit,yfit,rminhs,rmaxhs,A,corr2
            T0s = A[0] ; K
     Tm0s(ileg) = T0s  
   dTmds (ileg) = A[1] ; K/cm
   r2Ts  (ileg) = corr2 

;   ->STOP
;   if  r2N(ileg) lt 0.5  then  r2N(ileg) = -555.
;   if  r2P(ileg) lt 0.5  then  r2P(ileg) = -555.
    if  r2T(ileg) lt 0.5  then  r2T(ileg) = -555.
    if r2Ts(ileg) lt 0.5  then r2Ts(ileg) = -555.
    if r2Ts(ileg) lt 0.5  then goto,skiptestloopopen

      s_l = s_l * rsun ; pass s_l to cm 

; make dT/ds(s), asumiendo que ese gradiente es constante: 
  dTmds_l = dTmds (ileg)  ; DERIV(s_l,Tm_l) esto permite que el gradiente varie, pero es ruidoso.

; make conductive flux 

     ;Fc_l= -kappa*Tm_l^(5./2)*dTmds_l
      Fc_l = -kappa*(T0s +dTmds_l*s_l)^(5./2)*dTmds_l 

; make conductive loss  ;======================================================
     Ec_l = B_l * DERIV(s_l,Fc_l/B_l)   
; make heating rate  =============== 
     Eh_l = Er_l + Ec_l   
      s_l = s_l / rsun ; back s_l to Rsun 

; test diferent models of heating rate    
   Eh(ileg)= mean(Eh_l)
     index = where( Eh_l gt 0) 
   
   if n_elements(index) lt n_elements(Eh_l) then Eh(ileg) = -555.
      
   deltaEh(ileg) = stdev(Eh_l)
            smin = min(s_l)
            smax = max(s_l)
   fitEh,s_l,Eh_l,smin,smax,A,r2

       sH (ileg) = A[1]
      r2sH(ileg) = r2

;..........................................
goto,skiptestloopopen
wn=0
 window,wn,xs=400,ys=800
 !p.multi=[0,1,3]
 !p.charsize=2
 !p.charthick=1
 X=1.+.25*findgen(100)/99.

 plot,rad_l,ne_l/1.e8,psym=4,title='Ne'
 oplot,X,Ne0(ileg)* exp( -(1/lambda_N(ileg))*(1.-1./X) ) /1.e8
 xyouts,0.5*[1,1,1],1.-[.1,.15,.2],[string(Ne0(ileg)/1.e8),string(lambda_N(ileg)),string(r2n(ileg))],/normal

 plot,rad_l,p_l,psym=4,title='P'
 oplot,X,p0(ileg)* exp( -(1/lambda_p(ileg))*(1.-1./X) )
 xyouts,0.5*[1,1,1],(2./3)*1.-[.1,.15,.2],[string(P0(ileg)),string(lambda_p(ileg)),string(r2p(ileg))],/normal

  plot,rad_l,tm_l/1.e6,psym=4,title='Tm'
  oplot,X,(T0r+gradT(ileg)*X)/1.e6
  xyouts,0.5*[1,1,1],(1./3)*1.-[.15,.2,.25],[string(T0r/1.e6),string(gradT(ileg)/1.e6),string(r2t(ileg))],/normal

wn=1

 window,wn,xs=400,ys=800
 !p.multi=[0,1,3]
 !p.charsize=2
 !p.charthick=1

  X=1.+.25*findgen(100)/99. 
  
  plot,rad_l,tm_l/1.e6,psym=4,title='Tm(r)'
  oplot,X,(T0r+gradT(ileg)*X)/1.e6
  xyouts,0.5*[1,1,1],1.-[.1,.15,.2],[string(T0r/1.e6),string(gradT(ileg)/1.e6),string(r2t(ileg))],/normal

  x = min(s_l) + (max(s_l)-min(s_l))*findgen(100)/99
  
  plot,s_l,tm_l/1.e6,psym=4,title='Tm(s)'
  oplot,X,(T0s+dTmds(ileg)*rsun*X)/1.e6
  xyouts,0.5*[1,1,1],(2./3)*1.-[.1,.15,.2],[string(T0s/1.e6),string(dTmds(ileg)/1.e6*rsun),string(r2Ts(ileg))],/normal
  
  plot,s_l,Fc_l,psym=4,title='Fc'

wn=2

 window,wn,xs=400,ys=800
 !p.multi=[0,1,3]
 !p.charsize=3
 !p.charthick=1
 
 plot,rad_l,Er_l,psym=4,title='radiative loss'
 plot,rad_l,Ec_l,psym=4,title='conductive loss'
 plot,rad_l,Eh_l,psym=4,title='heating rate'
 
stop
skiptestloopopen:
;...........................................

   skipfitloop_open:
       opclstat(ileg) = opcls(il)   
    loop_length(ileg) = loopL(il)
          strad(ileg) = str_v(il)
          stlat(ileg) = (90-stth_v(il)/!dtor)
          stlon(ileg) = stph_v(il)/!dtor
   skipnextloop_open:
   indexloop(ileg) = il 
              ileg = ileg+1

 endif else begin 

; Analysis closed loops:
  if max(rad_v(0:Npts_v(il)-1,il)) lt rminloop then goto,skipnextloop

;<---------------------------------------                     
  if opcls(il) eq 2 then begin
      ifirs_1 = 0
      ilast_1 = midcell_v(il)
      ifirs_2 = midcell_v(il)
      ilast_2 = Npts_v(il)-1
  endif
  if opcls(il) eq 1 then begin
      ifirs_1 = 0
      ilast_1 = midcell_v(il)-1
      while Ne_v(ilast_1,il) eq -666. do ilast_1=ilast_1-1
      ifirs_2 = midcell_v(il)
      ilast_2 = Npts_v(il)-1
  endif
 ;<-----------------------------------------
 
  Ne_l1 = reform ( Ne_v(ifirs_1:ilast_1,il))
  Ne_l2 = reform ( Ne_v(ifirs_2:ilast_2,il))
  Tm_l1 = reform ( Tm_v(ifirs_1:ilast_1,il))
  Tm_l2 = reform ( Tm_v(ifirs_2:ilast_2,il))
  WT_l1 = reform ( WT_v(ifirs_1:ilast_1,il))
  WT_l2 = reform ( WT_v(ifirs_2:ilast_2,il))
  Er_l1 = reform ( Er_v(ifirs_1:ilast_1,il))
  Er_l2 = reform ( Er_v(ifirs_2:ilast_2,il))
  scoreR_l1 = reform ( scoreR_v(ifirs_1:ilast_1,il))
  scoreR_l2 = reform ( scoreR_v(ifirs_2:ilast_2,il))
  rad_l1 = reform( rad_v(ifirs_1:ilast_1,il))
  rad_l2 = reform( rad_v(ifirs_2:ilast_2,il))
  lat_l1 = reform( lat_v(ifirs_1:ilast_1,il))
  lat_l2 = reform( lat_v(ifirs_2:ilast_2,il))
  lon_l1 = reform( lon_v(ifirs_1:ilast_1,il))
  lon_l2 = reform( lon_v(ifirs_2:ilast_2,il))
    s_l1 = reform(   s_v(ifirs_1:ilast_1,il))
    s_l2 = loopL(il) - reform(   s_v(ifirs_2:ilast_2,il))
    B_l1 = reform(   B_v(ifirs_1:ilast_1,il))
    B_l2 = reform(   B_v(ifirs_2:ilast_2,il))

 if opcls(il) eq 1. and max(rad_v(*,il)) le 1.25 then begin
mierda(ind_mierda) = max(rad_v(*,il))
ind_mierda=ind_mierda+1
stop
endif

  switching = 'no'
; Make "ileg"   the LEG that contains the starting point, and "ileg+1" the other one:
 ;switch_legs,rad_l1,rad_l2,lat_l1,lat_l2,lon_l1,lon_l2,Ne_l1,Ne_l2,Tm_l1,Tm_l2,WT_l1,WT_l2,scoreR_l1,scoreR_l2,il,switching 
; Make leg_status=2 for ileg+1 (for ileg we already set leg_status=1, by default)
  leg_status(ileg+1) = 2.
; IMPORTANT NOTE: leg_status contains now the correct information ONLY
; if switch_legs was used. If not, this information may be incorrect
; but it will NOT be used anyhow.
; ALBERT'S ADVICE: please *ALWAYS* USE SWITCHING!! It is what you want anyway.

; According to the switching status, associate to each LEG the 
; INITIAL and FINAL coordinates of the LOOP wo which BOTH belong:
  if switching eq 'no' then begin
  rad_ini(ileg)   = rad_l1(0)
  rad_ini(ileg+1) = rad_l1(0)
  rad_fin(ileg)   = rad_l2(n_elements(rad_l2)-1)
  rad_fin(ileg+1) = rad_l2(n_elements(rad_l2)-1)
  lat_ini(ileg)   = lat_l1(0)
  lat_ini(ileg+1) = lat_l1(0)
  lat_fin(ileg)   = lat_l2(n_elements(lat_l2)-1)
  lat_fin(ileg+1) = lat_l2(n_elements(lat_l2)-1)
  lon_ini(ileg)   = lon_l1(0)
  lon_ini(ileg+1) = lon_l1(0)
  lon_fin(ileg)   = lon_l2(n_elements(lon_l2)-1)
  lon_fin(ileg+1) = lon_l2(n_elements(lon_l2)-1)
  endif
  if switching eq 'yes' then begin
  rad_ini(ileg)     = rad_l1(n_elements(rad_l1)-1)
  rad_iOAni(ileg+1) = rad_l1(n_elements(rad_l1)-1)
  rad_fin(ileg)   = rad_l2(0)
  rad_fin(ileg+1) = rad_l2(0)
  lat_ini(ileg)   = lat_l1(n_elements(lat_l1)-1)
  lat_ini(ileg+1) = lat_l1(n_elements(lat_l1)-1)
  lat_fin(ileg)   = lat_l2(0)
  lat_fin(ileg+1) = lat_l2(0)
  lon_ini(ileg)   = lon_l1(n_elements(lon_l1)-1)
  lon_ini(ileg+1) = lon_l1(n_elements(lon_l1)-1)
  lon_fin(ileg)   = lon_l2(0)
  lon_fin(ileg+1) = lon_l2(0)
  endif

; These lines store the FOOT-POINT coordinates for each LEG,
; and they do it correctly independently of the switching status:
  Footrad(ileg)   = rad_ini(ileg)    
  Footrad(ileg+1) = rad_fin(ileg+1)  
  Footlat(ileg)   = lat_ini(ileg)    
  Footlat(ileg+1) = lat_fin(ileg+1)  
  Footlon(ileg)   = lon_ini(ileg)    
  Footlon(ileg+1) = lon_fin(ileg+1)  

  rrr1=findel(1.075,rad_l1)
  rrr2=findel(1.075,rad_l2)
  
  Rp0_rad(ileg)   = rad_l1(rrr1)
  Rp0_rad(ileg+1) = rad_l2(rrr2)
  Rp0_lat(ileg)   = lat_l1(rrr1)
  Rp0_lat(ileg+1) = lat_l2(rrr2)
  Rp0_lon(ileg)   = lon_l1(rrr1)
  Rp0_lon(ileg+1) = lon_l2(rrr2)

  Rp_rad(ileg)   = Rp0_rad(ileg)
  Rp_rad(ileg+1) = Rp0_rad(ileg+1)
  Rp_lat(ileg)   = Rp0_lat(ileg)
  Rp_lat(ileg+1) = Rp0_lat(ileg+1)
  Rp_lon(ileg)   = Rp0_lon(ileg)
  Rp_lon(ileg+1) = Rp0_lon(ileg+1)

; if opcls(il) eq 1. and max(rad_v(*,il)) le 1.2 then stop

  p1 = where ( rad_l1 ge rmin and rad_l1 le rmax and Ne_l1 ne -999. and scoreR_l1 lt 0.1 and WT_l1 ge WTc*1.e6)
  p2 = where ( rad_l2 ge rmin and rad_l2 le rmax and Ne_l2 ne -999. and scoreR_l2 lt 0.1 and WT_l2 ge WTc*1.e6)
  
  if  p1(0) eq -1 or p2(0) eq -1 then goto,skipnextloop


;----------------------------------------------------------------------------------------------------------------
  r0 = 1.025
  s_l1_max = max(s_l1) ; Rsun
  s_l2_max = max(s_l2) ; Rsun
  r_l1_max = max(rad_l1) ; Rsun
  r_l2_max = max(rad_l2) ; Rsun

 ; Fit lineal s_l1 = m1 rad_l1 + b1, usar primeros 5 datos.
 ; Fit lineal s_l2 = m2 rad_l2 + b2
   Npoints=Ndata
   if n_elements(rad_l1) ge Npoints AND n_elements(rad_l2) ge Npoints then begin 

   rad_l1_base = rad_l1(0:Npoints-1) 
   rad_l2_rev  = reverse(rad_l2)  ; da vuelta rad_l2 
   rad_l2_base = rad_l2_rev (0:Npoints-1)

     s_l1_base =   s_l1(0:Npoints-1) 
     s_l2_rev  =   reverse(s_l2)     ; también necesito los últimos s_l2
     s_l2_base =   s_l2_rev(0:Npoints-1) 

;fit s_l1_base = m1 * rad_l1_base + s0r1 
  xfit = rad_l1_base
  yfit =   s_l1_base
  fitr0,xfit,yfit,A,corr2
         S0r1 = A[0]
         m1   = A[1]
         r2s1 = corr2

;fit s_l2_base = m2 * rad_l2_base + s0r2
  xfit = rad_l2_base
  yfit =   s_l2_base
  fitr0,xfit,yfit,A,corr2
         S0r2 = A[0]
         m2   = A[1]
         r2s2 = corr2

    s_l1_r0 = m1 * r0 + s0r1 
    s_l2_r0 = m2 * r0 + s0r2

  s_r0_a(ileg  ) = s_l1_r0 
  s_r0_a(ileg+1) = s_l2_r0 

  endif

;----------------------------------------------------------------------------------------------------------------
 ;STOP
  
   Ne_l1 =  Ne_l1 (p1)
   Ne_l2 =  Ne_l2 (p2)
   Tm_l1 =  Tm_l1 (p1)
   Tm_l2 =  Tm_l2 (p2)
   WT_l1 =  WT_l1 (p1)
   WT_l2 =  WT_l2 (p2)
   Er_l1 =  Er_l1 (p1)
   Er_l2 =  Er_l2 (p2)
  rad_l1 = rad_l1 (p1)
  rad_l2 = rad_l2 (p2)
    s_l1 =   s_l1 (p1)
    s_l2 =   s_l2 (p2)
    B_l1 =   B_l1 (p1)
    B_l2 =   B_l2 (p2)
; tomographic pressure      
  p_l1 = kB/bb *Ne_l1*Tm_l1   
  p_l2 = kB/bb *Ne_l2*Tm_l2   
;make Beta plasma parameter
 beta_l1 = p_l1/(B_l1^2/(8*!pi))
 beta_l2 = p_l2/(B_l2^2/(8*!pi))
 
    Nemean(ileg)   = mean(Ne_l1)
    Nemean(ileg+1) = mean(Ne_l2)
    Tmmean(ileg)   = mean(Tm_l1)
    Tmmean(ileg+1) = mean(Tm_l2)
    WTmean(ileg)   = mean(WT_l1)
    WTmean(ileg+1) = mean(WT_l2)
  Nestddev(ileg)   = stddev(Ne_l1)
  Nestddev(ileg+1) = stddev(Ne_l2)
  Tmstddev(ileg)   = stddev(Tm_l1)
  Tmstddev(ileg+1) = stddev(Tm_l2)
  WTstddev(ileg)   = stddev(WT_l1)
  WTstddev(ileg+1) = stddev(WT_l2)
  betamean(ileg)   = mean(beta_l1)
  betamean(ileg+1) = mean(beta_l2)
  betaapex(ileg)   = beta_l1(n_elements(rad_l1(p1))-1)
  betaapex(ileg+1) = beta_l2(0)
     Bmean(ileg)   = mean(B_l1)
     Bmean(ileg+1) = mean(B_l2)
; if you want to use beta at some height instead <beta> uncomment the
; following lines
;...........................................................
rad0= 1.035
index_l1 = where (abs(rad_l1-rad0) eq min(abs(rad_l1-rad0)))
index_l2 = where (abs(rad_l2-rad0) eq min(abs(rad_l2-rad0)))
;betamean(ileg)   = beta_l1(index_l1(0))
;betamean(ileg+1) = beta_l2(index_l2(0))
;.......................................................... 

if n_elements(p1) lt Ndata  or n_elements(p2) lt Ndata then goto,skipfitloop


rr1 = 1.10
;rl_max = 1.7

;if min(rad_l1) gt rr1 OR min(rad_l2) gt rr1 then goto,skipfitloop ;solo miro piernas, xq elimar el loop entero?

;goto,saltiemosestountoque
r_max1 = max(rad_l1)
r_max2 = max(rad_l2)

;if opcls(il) eq 2. then stop
;if opcls(il) eq 1. and max(rad_v(*,il)) le 1.2 then stop

if r_max1 ge 1.2 then begin  ;igual que las piernas baiertas

    rr1_l1 = 1.07;(max(rad_l1)-1.)*0.25 +1.0
    rr2_l1 = 1.16;(max(rad_l1)-1.)*0.5 +1.0
    lefts_l1  = n_elements(where(rad_l1 le rr1_l1))
    rights_l1 = n_elements(where(rad_l1 ge rr2_l1))
    diomes_l1 = n_elements(where(rad_l1 gt rr1_l1 and rad_l1 le rr2_l1))
 endif else begin

    rr1_l1 = 1.06
    rr2_l1 = (max(rad_l1)-1.)*0.75 +1.0
    lefts_l1  = n_elements(where(rad_l1 le rr1_l1))
    rights_l1 = n_elements(where(rad_l1 ge rr2_l1))
    diomes_l1 = n_elements(where(rad_l1 gt rr1_l1 and rad_l1 le rr2_l1))

 endelse

if r_max2 ge 1.2 then begin
    rr1_l2 = 1.07;(max(rad_l2)-1.)*0.25 +1.0
    rr2_l2 = 1.16;(max(rad_l2)-1.)*0.5 +1.0
    lefts_l2  = n_elements(where(rad_l2 le rr1_l2))
    rights_l2 = n_elements(where(rad_l2 ge rr2_l2))
    diomes_l2 = n_elements(where(rad_l2 gt rr1_l2 and rad_l2 le rr2_l2))
 endif else begin

    rr1_l2 = 1.06
    rr2_l2 = (max(rad_l2)-1.)*0.75 +1.0
    lefts_l2  = n_elements(where(rad_l2 le rr1_l2))
    rights_l2 = n_elements(where(rad_l2 ge rr2_l2))
    diomes_l2 = n_elements(where(rad_l2 gt rr1_l2 and rad_l2 le rr2_l2))
 endelse

if lefts_l1 eq -1 or diomes_l1 eq -1 or rights_l1 eq -1 then goto,skipfitloop  
if lefts_l2 eq -1 or diomes_l2 eq -1 or rights_l2 eq -1 then goto,skipfitloop  

;if lefts_l1 le 2 or diomes_l1 le 2 or rights_l1 le 1 then goto,skipfitloop;lo ultimo se va a cunplir seguro por definicion de max(rad_l?)
;if lefts_l2 le 2 or diomes_l2 le 2 or rights_l2 le 1 then goto,skipfitloop

saltiemosestountoque:


;fits for leg1-------------------------------------- 
  rminhs = min(rad_l1) 
  rmaxhs = max(rad_l1)
  
;HS-fit to Ne(r)
  xfit = rad_l1
  yfit =  Ne_l1

    if     keyword_set(linear) then fithslinear,xfit,yfit,rminhs,rmaxhs,A,corr2,alin,A_ts,corr2_ts,alin_ts,SSerr_N_cuad,SSerr_N_cuad_ts,r2_linn,r2_linn_ts
    if not keyword_set(linear) then fiths,xfit,yfit,rminhs,rmaxhs,A,corr2

       Ne0(ileg) = a[0] 
  lambda_N(ileg) = 1./A[1]  ; Rsun
            Tfit = mu * mH * gsun * (lambda_N(ileg)*rsun) / kB
     Tefit(ileg) = bb*Tfit
     r2N  (ileg) = corr2
     Ne0_ts(ileg) = a_ts[0] ; agregado

     lambda_N_ts(ileg) = 1./a_ts[1]
     r2N_ts(ileg) = corr2_ts
     y_lineal_N = alin_ts(0) + alin_ts(1) * 1./xfit
     ep = 0.01
     ;if ileg eq 2395 then stop
     franja_lineal,1./xfit,alog(yfit),y_lineal_N,ep,yru_N,yrd_N,r2_ts_lin,F1
     f_ne (ileg) =f1
     r2_lin (ileg) = r2_linn
     r2_lin_ts (ileg) = r2_linn_ts
     
     if a[0] gt 1.e10 then stop ;testeando problemas en ajuste

  ;HS-fit to P(r)
  yfit = p_l1
  
    if     keyword_set(linear) then fithslinear,xfit,yfit,rminhs,rmaxhs,A,corr2
    if not keyword_set(linear) then fiths,xfit,yfit,rminhs,rmaxhs,A,corr2

        P0(ileg) = a[0] 
  lambda_P(ileg) = 1./A[1]  ; Rsun
       r2P(ileg) = corr2

  ;linear-fit to T(r)
  yfit = Tm_l1

  fitTemp,xfit,yfit,rminhs,rmaxhs,A,corr2 

         T0r1 = A[0]
    Tm0(ileg) = T0r1
  gradT(ileg) = A[1]
  r2T  (ileg) = corr2
  
;agregado 5/4/2016 Testing ladfit on T-fit.                                                            
fitTemp_ts2,xfit,yfit,rminhs,rmaxhs,a1,b1,corr4
      Tm0_3(ileg) = b1
      gradT_3(ileg) = a1
      r2t_3 (ileg) = corr4
      y_lineal_t = b1 + a1 * xfit
      ep = 0.1
      franja_lineal,xfit,yfit,y_lineal_t,ep,yru_t,yrd_t,SSerr_t,F2
      f_t (ileg) = f2

goto,saltito1
;if r2t(ileg) lt 0.5  then begin
;if footlat(ileg) le 70. and footlat(ileg) ge 30. and r2t(ileg) lt 0.5  then begin
;if ileg eq 2117 then begin;and footlat(ileg) le 70. and footlat(ileg) ge 30. and r2t(ileg) lt 0.5 and f2 le 0.8 then begin
;if  r2n(ileg) lt 0.9 and ileg ge 1628 then begin
if  abs(footlat(ileg)) le 30 and r2n(ileg) lt 0.9  then begin
print, ileg, r2t(ileg),footrad(ileg), footlat(ileg), footlon(ileg)
print, ileg, Ne0(ileg), lambda_N(ileg),Ne0_ts(ileg),lambda_N_ts(ileg)
print,opcls(il)
loadct,12
verde = 25
azul =100
rojo =200
negro=  0
window,0,xsize=800,ysize=800
!p.multi=[0,2,2]
;ploteo ajustes de P                                                                                                                            
fitcuadr_N     =  Ne0(ileg)    * exp( -1./lambda_N   (ileg)*(1.-1./xfit) )
fitcuadr_N_ts  =  Ne0_ts(ileg) * exp( -1./lambda_N_ts(ileg)*(1.-1./xfit) )
fitlin_N    =  alin(0)  + alin(1)    * (1./xfit)
fitlin_N_ts = alin_ts(0) + alin_ts(1) * (1./xfit)
plot,1./xfit,alog(Ne_l1),psym=4,yrange=[min(alog(Ne_l))*.97,max(alog(Ne_l))*1.03],/nodata
oplot,1./xfit,alog(Ne_l1),psym=4
oplot,1./xfit,fitlin_N,thick=2
oplot,1./xfit,fitlin_N_ts,thick=2,color=azul
oplot,1./xfit,yru_n,thick=2,color=verde
oplot,1./xfit,yrd_n,thick=2,color=verde
xyouts,.35*[.75,1.],0.65*[1,1],[r2_lin(ileg),r2_lin_ts(ileg)],/normal,charthick=3,Font=0                               
xyouts,.35*[0.75],[0.59],['F  ='+strmid(string(float(F1)),4,5)],/normal,charsize=2
plot, xfit, tm_l1, psym=4,/nodata;yrange=[min(tm_l),max(tm_l)],/nodata                                                                          
oplot, xfit, tm_l1, psym=4
f1_puto= tm0  (ileg) + gradt  (ileg)*xfit
;f2_puto= tm0_2(ileg) + gradt_2(ileg)*xfit                                                                                                 
f3= tm0_3(ileg) + gradt_3(ileg)*xfit
xyouts,.98-[.3,.2,.1],0.59*[1,1,1],['r2t','lf','ts'],/normal,charthick=3,Font=0
xyouts,.98-[.35,.25,.15],0.57*[1,1,1],[r2t(ileg),r2t_2(ileg),r2t_3(ileg)],/normal,charthick=3,Font=0
;xyouts,.98-[.15],0.61*[1],[boolean_check_t],/normal,charthick=3,Font=0                                                                           
xyouts,.98-[0.15],[0.61],['F  ='+strmid(string(float(F2)),4,5)],/normal,charsize=2
oplot, xfit,f1_puto ,thick=2
;oplot, xfit,f2_puto ,thick=2,color=rojo                                                                                                         
oplot, xfit,f3 ,thick=2,color=azul
oplot,xfit,yru_t,thick=2,color=verde
oplot,xfit,yrd_t,thick=2,color=verde
plot,xfit,Ne_l1,psym=4
oplot,xfit,fitcuadr_N   ,thick=2
oplot,xfit,fitcuadr_N_ts,thick=2,color=azul
xyouts,1.-[.7,.6],0.1*[1,1],[r2N(ileg),r2N_ts(ileg)],/normal,charthick=3,Font=0
xyouts,1.-[.7,.6],0.4*[1,1],[SSerr_N_cuad,SSerr_N_cuad_ts],/normal,charthick=3,Font=0
;plot,xfit,fitcuadr_p_ts,thick=2,color=azul                                                                                                      
;plot,xfit,alog(Ne_l),psym=4,yrange=[min(alog(Ne_l))-4.,max(alog(Ne_l))+4.]                                                                       
!p.multi=0
stop
endif
saltito1:
;------------------- agregado

 ; linear-fit to T(s) ==================================
      xfit = s_l1 *rsun    
    rminhs = min(s_l1*rsun);smin
    rmaxhs = max(s_l1*rsun);smax 
      yfit = Tm_l1
    fitTemp,xfit,yfit,rminhs,rmaxhs,A,corr2

            T0s1 = A[0]
      Tm0s(ileg) = T0s1
    dTmds (ileg) = A[1]
    r2Ts  (ileg) = corr2

   if keyword_set(fitcuadr) then begin
  ; cuadratic-fit to T(s) 
      xfit = s_l1 ;*rsun    
    rminhs = min(s_l1);*rsun);smin
    rmaxhs = max(s_l1);*rsun);smax 
    yfit   = Tm_l1
   fitcuadrTemp,xfit,yfit,rminhs,rmaxhs,A,corr2,T0s1,dTmds(ileg)*rsun
        Acuadr1 = A
 r2Tcuadr(ileg) = corr2
 Acuadr_a(ileg,*) = Acuadr1
  endif

;fits for leg2-------------------------------------- 
  rminhs = min(rad_l2) 
  rmaxhs = max(rad_l2)

  ;HS-fit to Ne(r)
  xfit = rad_l2
  yfit =  Ne_l2

    if     keyword_set(linear) then fithslinear,xfit,yfit,rminhs,rmaxhs,A,corr2,alin,A_ts,corr2_ts,alin_ts,SSerr_N_cuad,SSerr_N_cuad_ts,r2_linn,r2_linn_ts
    if not keyword_set(linear) then fiths,xfit,yfit,rminhs,rmaxhs,A,corr2  

       Ne0(ileg+1) = a[0] 
  lambda_N(ileg+1) = 1./A[1]  ; Rsun
              Tfit = mu * mH * gsun * (lambda_N(ileg+1)*rsun) / kB
     Tefit(ileg+1) = bb*Tfit
     r2N  (ileg+1) = corr2
     Ne0_ts(ileg) = a_ts[0]     ; agregado 
  
     Ne0_ts(ileg+1) = a_ts[0] ; agregado                                          
    lambda_N_ts(ileg+1) = 1./a_ts[1]
    r2N_ts(ileg+1) = corr2_ts
    y_lineal_N = alin_ts(0) + alin_ts(1) * 1./xfit
    ep = 0.005
    franja_lineal,1./xfit,alog(yfit),y_lineal_N,ep,yru_N,yrd_N,r2_ts_lin,F1
    f_ne (ileg+1) = f1
    r2_lin (ileg+1) = r2_linn
    r2_lin_ts (ileg+1) = r2_linn_ts

  ;HS-fit to P(r)
  yfit = p_l2
    if     keyword_set(linear) then fithslinear,xfit,yfit,rminhs,rmaxhs,A,corr2
    if not keyword_set(linear) then fiths,xfit,yfit,rminhs,rmaxhs,A,corr2  
        P0(ileg+1) = a[0] 
  lambda_P(ileg+1) = 1./A[1]  ; Rsun
     r2P  (ileg+1) = corr2

  ;HS-fit to T(r)  
  yfit = Tm_l2
  fitTemp,xfit,yfit,rminhs,rmaxhs,A,corr2 
           T0r2 = A[0]
    Tm0(ileg+1) = T0r2
  gradT(ileg+1) = A[1]
  r2T  (ileg+1) = corr2

  
;agregado 5/4/2016 Testing ladfit on T-fit.                                                                                                                             

fitTemp_ts2,xfit,yfit,rminhs,rmaxhs,a1,b1
      Tm0_3(ileg+1) = b1
      gradT_3(ileg+1) = a1
      r2t_3 (ileg+1) = corr4
      y_lineal_t = b1 + a1 * xfit
      ep = 0.1
      franja_lineal,xfit,yfit,y_lineal_t,ep,yru_t,yrd_t,SSerr_t,F2
      f_t(ileg+1) = f2

goto,saltito2 
;if r2t(ileg) lt 0.5  and ileg ge 1427 then begin
;if footlat(ileg) le 70. and footlat(ileg) ge 30. and r2t(ileg) lt 0.5  then begin
;if r2t(ileg+1) lt 0.5  then begin
;if  r2n(ileg+1) lt 0.9  and ileg ge 1628 then begin
if  abs(footlat(ileg+1)) le 30 and r2n(ileg+1) lt 0.9  then begin
print, ileg+1, r2t(ileg+1),footrad(ileg+1), footlat(ileg+1), footlon(ileg+1)
print, ileg+1, Ne0(ileg+1), lambda_N(ileg+1),Ne0_ts(ileg+1),lambda_N_ts(ileg+1)
print,opcls(il)
loadct,12
verde = 25
azul =100
rojo =200
negro=  0
window,0,xsize=800,ysize=800
!p.multi=[0,2,2]
;ploteo ajustes de P                                                                                                                                                
fitcuadr_N     =  Ne0(ileg+1)    * exp( -1./lambda_N   (ileg+1)*(1.-1./xfit) )
fitcuadr_N_ts  =  Ne0_ts(ileg+1) * exp( -1./lambda_N_ts(ileg+1)*(1.-1./xfit) )
fitlin_N    =  alin(0)  + alin(1)    * (1./xfit)
fitlin_N_ts = alin_ts(0) + alin_ts(1) * (1./xfit)
plot,1./xfit,alog(Ne_l2),psym=4,yrange=[min(alog(Ne_l))-.2,max(alog(Ne_l))+.2],/nodata
oplot,1./xfit,alog(Ne_l2),psym=4
oplot,1./xfit,fitlin_N,thick=2
oplot,1./xfit,fitlin_N_ts,thick=2,color=azul
oplot,1./xfit,yrd_n,thick=2,color=verde
oplot,1./xfit,yru_n,thick=2,color=verde
xyouts,.35*[.75,1.],0.63*[1,1],[r2_lin(ileg+1),r2_lin_ts(ileg+1)],/normal,charthick=3,Font=0                                                    
xyouts,.35*[0.75],[0.59],['F  ='+strmid(string(float(F1)),4,5)],/normal,charsize=2
plot, xfit, tm_l2, psym=4,/nodata;yrange=[min(tm_l),max(tm_l)],/nodata                                                                                                                     
oplot, xfit, tm_l2, psym=4
f1_puto= tm0  (ileg+1) + gradt  (ileg+1)*xfit
;f2_puto= tm0_2(ileg) + gradt_2(ileg)*xfit                                                                                                                       
f3= tm0_3(ileg+1) + gradt_3(ileg+1)*xfit
xyouts,.98-[.3,.2,.1],0.59*[1,1,1],['r2t','lf','ts'],/normal,charthick=3,Font=0
xyouts,.98-[.35,.25,.15],0.57*[1,1,1],[r2t(ileg+1),r2t_2(ileg+1),r2t_3(ileg+1)],/normal,charthick=3,Font=0
;xyouts,.98-[.15],0.61*[1],[boolean_check_t],/normal,charthick=3,Font=0                                                                                      
xyouts,.98-[0.15],[0.61],['F  ='+strmid(string(float(F2)),4,5)],/normal,charsize=2
oplot, xfit,f1_puto ,thick=2
;oplot, xfit,f2_puto ,thick=2,color=rojo                                                                                                                        
oplot, xfit,f3 ,thick=2,color=azul
oplot,xfit,yru_t,thick=2,color=verde
oplot,xfit,yrd_t,thick=2,color=verde

plot,xfit,Ne_l2,psym=4
oplot,xfit,fitcuadr_N   ,thick=2
oplot,xfit,fitcuadr_N_ts,thick=2,color=azul
xyouts,1.-[.7,.6],0.1*[1,1],[r2N(ileg+1),r2N_ts(ileg+1)],/normal,charthick=3,Font=0
xyouts,1.-[.7,.6],0.4*[1,1],[SSerr_N_cuad,SSerr_N_cuad_ts],/normal,charthick=3,Font=0
;plot,xfit,fitcuadr_p_ts,thick=2,color=azul                                                                                                                   
;plot,xfit,alog(Ne_l),psym=4,yrange=[min(alog(Ne_l))-4.,max(alog(Ne_l))+4.]                                                                                              
!p.multi=0
stop
endif
saltito2:
;-----.  

  ;linear-fit to T(s) ==========================================
      xfit = s_l2 *rsun   
    rminhs = min(s_l2*rsun);smin
    rmaxhs = max(s_l2*rsun);smax 
      yfit = Tm_l2
   fitTemp,xfit,yfit,rminhs,rmaxhs,A,corr2
              T0s2 = A[0]
      Tm0s(ileg+1) = T0s2  ;<---
    dTmds (ileg+1) = A[1]
    r2Ts  (ileg+1) = corr2  

 if keyword_set(fitcuadr) then begin
   ;cuadratic-fit to T(s) 
      xfit = s_l2 ;*rsun    
    rminhs = min(s_l2);*rsun;smin
    rmaxhs = max(s_l2);*rsun;smax 
    yfit   = Tm_l2
    fitcuadrTemp,xfit,yfit,rminhs,rmaxhs,A,corr2,T0s2,dTmds(ileg+1)
         Acuadr2 = A
r2Tcuadr(ileg+1) = corr2
Acuadr_a(ileg+1,*) = Acuadr2
 endif
 
;STOP

goto,nocambiarlosr2
   if r2T(ileg) lt 0.5 or r2T(ileg+1) lt 0.5 then begin
      r2T(ileg)   = -555.   
      r2T(ileg+1) = -555.       
   endif

   if r2Ts(ileg) lt 0.5 or r2Ts(ileg+1) lt 0.5 then begin
      r2Ts(ileg)   = -555.   
      r2Ts(ileg+1) = -555.       
    goto,skiptestloopclosed
   endif
nocambiarlosr2:
;stop
;make dT/ds 
  dTmds_l1 = dTmds(ileg);DERIV(s_l1,Tm_l1)
  dTmds_l2 = dTmds(ileg+1);DERIV(s_l2,Tm_l2)     

if keyword_set(fitcuadr) then  dTmds_l1= (2*Acuadr1[0]*s_l1 + Acuadr1[1])/rsun
if keyword_set(fitcuadr) then  dTmds_l2= (2*Acuadr2[0]*s_l2 + Acuadr2[1])/rsun

;  make conductive flux 
;  Fc_l1= -kappa*Tm_l1^(5./2)*dTmds_l1
;  Fc_l2= -kappa*Tm_l2^(5./2)*dTmds_l2   
;  Fc_l1 = -2*kappa*DERIV(S_l1,Tm_l1^(7./2))/7
;  Fc_l2 = -2*kappa*DERIV(S_l2,Tm_l2^(7./2))/7

   Fc_l1= -kappa*(T0s1 +dTmds_l1*s_l1)^(5./2)*dTmds_l1
   Fc_l2= -kappa*(T0s2 +dTmds_l2*s_l2)^(5./2)*dTmds_l2   

if keyword_set(fitcuadr) then   Fc_l1= -kappa*(Acuadr1[0]*s_l1^2 + Acuadr1[1]*s_l1+ Acuadr1[2])^(5./2)*dTmds_l1
if keyword_set(fitcuadr) then   Fc_l2= -kappa*(Acuadr2[0]*s_l2^2 + Acuadr2[1]*s_l2+ Acuadr2[2])^(5./2)*dTmds_l2   

;stop

;Fcb con el ajuste lineal en todos los puntos 
     Tmbase_l1=Tm0(ileg)  +gradT(ileg)  *r0
     Tmbase_l2=Tm0(ileg+1)+gradT(ileg+1)*r0
     Fc2_l1 = -kappa*Tmbase_l1^(5./2)*dTmds(ileg) 
     Fc2_l2 = -kappa*Tmbase_l2^(5./2)*dTmds(ileg+1)
     Fcb(ileg  ) = Fc2_l1 
     Fcb(ileg+1) = Fc2_l2 

if keyword_set(fitcuadr) then begin
     Tmbase_l1=Acuadr1[0]*s_l1_r0^2 + Acuadr1[1]*S_l1_r0+ Acuadr1[2]
     Tmbase_l2=Acuadr2[0]*s_l2_r0^2 + Acuadr2[1]*S_l2_r0+ Acuadr2[2]
     dTmds_l1_base = (2*Acuadr1[0]*s_l1_r0 + Acuadr1[1])/rsun
     dTmds_l2_base = (2*Acuadr2[0]*s_l2_r0 + Acuadr2[1])/rsun
     Fc2_l1 = -kappa*Tmbase_l1^(5./2)*dTmds_l1_base 
     Fc2_l2 = -kappa*Tmbase_l2^(5./2)*dTmds_l2_base
     Fcb(ileg  ) = Fc2_l1 
     Fcb(ileg+1) = Fc2_l2 
endif

;========================================================================;<---
;nuevo ajuste de Temperatura. Necesito T(s(r0))=T(s_li_r0) y dT/ds
;stop

s_l1 = s_l1 * rsun ; pass s_l1 to cm 
s_l2 = s_l2 * rsun ; pass s_l2 to cm 

ss1=n_elements(s_l1)
ss2=n_elements(s_l2)

Numpts=7

if ss1 gt Numpts then begin
s_ref_l1 = s_l1(0:Numpts-1)
endif else begin
if ss1 le Numpts then s_ref_l1=s_l1
endelse

if ss2 gt Numpts then begin
s_ref_l2 = s_l2((ss2-Numpts):ss2-1)
endif else begin
if ss2 le Numpts then s_ref_l2=s_l2
endelse

Tm_ref_l1 = Tm_l1(0:n_elements(s_ref_l1)-1)
Tm_ref_l2 = Tm_l2((n_elements(Tm_l2)-n_elements(s_ref_l2)):n_elements(Tm_l2)-1)

;<---l1
   xfit = s_ref_l1
   yfit = Tm_ref_l1
   fitr0,xfit,yfit,A,r2
       T0_fit1 = A[0]
     dTds_fit1 = A[1]
     r2Ts_fit1 = r2  
      T0_s0_l1 = T0_fit1+dTds_fit1*s_l1_r0*rsun 

;<---l2
   xfit = s_ref_l2
   yfit = Tm_ref_l2
   fitr0,xfit,yfit,A,r2
       T0_fit2 = A[0]
     dTds_fit2 = A[1]
     r2Ts_fit2 = r2
      T0_s0_l2 = T0_fit2+dTds_fit2*s_l2_r0*rsun

;-----------------------Fc2 con el ajuste de Numpts puntos ;<---------------------------------
 
     FcN2_l1 = -kappa*T0_s0_l1^(5./2)*dTds_fit1 
     FcN2_l2 = -kappa*T0_s0_l2^(5./2)*dTds_fit2 
;Aún no lo grabo, vemos cual decidimos usar ;<---

;---------------------prueba de puntos--------------------
goto,yesterday
ss=(findgen(100)/99)*rsun

window,0,XSIZE=800, YSIZE=900
!p.multi=[0,1,2]
!p.charsize=2

  plot,s_l1,Tm_l1,xrange=[2.,20.]*1.e9,yrange=[0.,2.]*1.e6,xstyle='s*rsun',ytitle='Temp_l1',title='Ajuste lineal de Temp vs s. r=1.075',psym=4
 oplot,s_ref_l1,Tm_ref_l1,psym=2
 oplot,ss,T0_fit1+dTds_fit1*ss
 xyouts,[0.3,0.3],[0.65,0.69],['Fcb_old_l1='+string(Fc2_l1),'Fcb_new_l1='+string(FcN2_l1)],/normal

  plot,s_l2,Tm_l2,xrange=[2.,20.]*1.e9,yrange=[0.,2.]*1.e6,xtitle='s*rsun',ytitle='Temp_l2',title='Ajuste lineal de Temp vs s. r=1.075',psym=4 
 oplot,s_ref_l2,Tm_ref_l2,psym=2  
 oplot,ss,T0_fit2+dTds_fit2*ss
 xyouts,[0.3,0.3],[.15,.19],['Fcb_old_l2='+string(Fc2_l2),'Fcb_new_l2='+string(FcN2_l2)],/normal

!p.multi=0

;record_gif,'./','selección_y_ajuste_'+string(il)+'_'+string(opcls(il))+'.gif','X'

yesterday:
;=====================================================================================
;=====================================================================================

;stop

; make conductive loss
    Ec_l1 = B_l1 * DERIV(s_l1,Fc_l1/B_l1)
    Ec_l2 = B_l2 * DERIV(s_l2,Fc_l2/B_l2)    
; make heating rate
    Eh_l1 = Er_l1 + Ec_l1
    Eh_l2 = Er_l2 + Ec_l2

;  extrapolate Er_l down to r0

Er_l1_base  =  Er_l1
Er_l2_base  =  Er_l2

rr_l1 = rad_l1
rr_l2 = rad_l2

;----l1
xfit = rr_l1
yfit = Er_l1_base
fitEr,xfit,yfit,A,r2
Er_l1_r0  = A[0] * exp( A[1]*(r0) )
Er_l1_max = A[0] * exp( A[1]*(r_l1_max) )

;----l2
xfit = rr_l2
yfit = Er_l2_base
fitEr,xfit,yfit,A,r2
Er_l2_r0  = A[0] * exp( A[1]*(r0) )
Er_l2_max = A[0] * exp( A[1]*(r_l2_max) )

;stop

if max(s_l1) lt s_l1_max * rsun then begin   
    s_l1_e = [ s_l1_r0  * rsun, s_l1, s_l1_max * rsun]
    Er_l1_e = [Er_l1_r0,Er_l1,Er_l1_max]
endif
if max(s_l2) lt s_l2_max * rsun then begin   
    s_l2_e = [ s_l2_max * rsun, s_l2, s_l2_r0  * rsun]     ;<--- lo defino acá
    Er_l2_e = [Er_l2_max,Er_l2,Er_l2_r0] ;<---
endif 
if max(s_l1) eq s_l1_max * rsun then begin   
    s_l1_e = [ s_l1_r0  * rsun, s_l1]
    Er_l1_e = [Er_l1_r0,Er_l1]
endif
if max(s_l2) eq s_l2_max * rsun then begin   
    s_l2_e = [ s_l2, s_l2_r0  * rsun]     ;<--- lo defino acá
    Er_l2_e = [Er_l2,Er_l2_r0] ;<---
endif 

     phir_l1 = int_tabulated(s_l1_e,Er_l1_e,/sort) ; flujo radiaivo ;<---
  phir(ileg) = phir_l1                                    ;<--
     phir_l2 = int_tabulated(s_l2_e,Er_l2_e,/sort) ; flujo radiaivo ;<--- di vuelta los datos. si doy vuelta s_l1 sale un - que debería poner?
  phir(ileg+1) = phir_l2                                    ;<---     aunque tmb haya dado vuelta er? (lo pongo) 

;if opcls(il) eq 2 then stop

s_l1 = s_l1 / rsun ; back s_l1 to Rsun 
s_l2 = s_l2 / rsun ; back s_l2 to Rsun

; test diferent models of the heating rate

   Eh(ileg)   = mean (Eh_l1)
   Eh(ileg+1) = mean (Eh_l2)

       index1 = where( Eh_l1 gt 0) 
       index2 = where( Eh_l2 gt 0) 

if n_elements(index1) lt n_elements(Eh_l1) then Eh(ileg)   = -555.
if n_elements(index2) lt n_elements(Eh_l2) then Eh(ileg+1) = -555.

  deltaEh (ileg)   = stdev (Eh_l1)
  deltaEh (ileg+1) = stdev (Eh_l2)
              smin = min(s_l1)
              smax = max(s_l1)
              xfit = s_l1
              yfit = Eh_l1

  fitEh,xfit,yfit,smin,smax,A,r2
              Eh01 = A[0]
          sH(ileg) = A[1]
        r2sH(ileg) = r2
              smin = min(s_l2)
              smax = max(s_l2)
              xfit = s_l2
              yfit = Eh_l2

  fitEh,xfit,yfit,smin,smax,A,r2
              Eh02 = A[0]
        sH(ileg+1) = A[1]
      r2sH(ileg+1) = r2

;...........................................
;if Eh(ileg) lt 0 or Eh(ileg+1) lt 0 then  goto,skiptestloopclosed
;if r2sh(ileg) lt 0.75  or r2sh(ileg+1) lt 0.75  then
goto,skipmordor
if  r2t(ileg) gt 0.98 and r2t(ileg+1) gt 0.5  and opcls(il) eq 2 and gradt(ileg) gt 0 and gradt(ileg+1) gt 0 then begin
  wn=0
  window,wn,xs=400,ys=800
 !p.multi=[0,1,2]
 !p.charsize=2
 !p.charthick=1
 X=1.+.25*findgen(100)/99.
plot,rad_l1,ne_l1/1.e8,psym=4,title='Ne'
oplot,X,Ne0(ileg)* exp( -(1/lambda_N(ileg))*(1.-1./X) ) /1.e8
;oplot,rad_l2,ne_l2/1.e8,psym=5
;oplot,X,Ne0(ileg+1)* exp( -(1/lambda_N(ileg+1))*(1.-1./X) ) /1.e8
 xyouts,0.5*[1,1,1],1.-[.1,.15,.2],[string(Ne0(ileg)/1.e8),string(lambda_N(ileg)),string(r2n(ileg))],/normal
 plot,rad_l1,tm_l1/1.e6,psym=4,title='Tm'
  oplot,X,(T0r1+gradT(ileg)*X)/1.e6
; oplot,rad_l2,tm_l2/1.e6,psym=5
;oplot,X,(T0r2+gradT(ileg+1)*X)/1.e6
  xyouts,0.5*[1,1,1],(1./3)*1.-[.15,.2,.25],[string(T0r1/1.e6),string(gradT(ileg)/1.e6),string(r2t(ileg))],/normal
stop
endif
skipmordor:



; Que loop grafico?

; if opcls(il) eq 1 AND footlat(ileg)*footlat(ileg+1) lt 0. then goto,grafica

; if footlat(ileg)*footlat(ileg+1) lt 0. AND abs(footlat(ileg)) le 30. AND abs(footlat(ileg+1)) le 30. then goto,grafica

 ;if footlat(ileg)*footlat(ileg+1) gt 0. AND abs(footlat(ileg)) le 60. AND abs(footlat(ileg+1)) le 60. then goto,grafica

goto,skiptestloopclosed
;--------------------COMIENZA--------------------------------------
grafica:

; diferents plots for leg1
 
 wn=0
 window,wn,xs=400,ys=900
 ; ps1,'./newfigs/'+'loop_example.eps',0
 ;DEVICE,/INCHES,YSIZE=10.,XSIZE=5.,SCALE_FACTOR=2

 !p.multi=[0,1,3]
 !p.charsize=2.25
 !p.charthick=1
 X=1.+.25*findgen(100)/99.

 plot,rad_l1,ne_l1/1.e8,psym=4,title='Ne(r)-leg1'
 oplot,X,Ne0(ileg)* exp( -(1/lambda_N(ileg))*(1.-1./X) ) /1.e8
 xyouts,0.5*[1,1,1],1.-[.1,.125,.15],[string(Ne0(ileg)/1.e8),string(lambda_N(ileg)),string(r2n(ileg))],/normal

 plot,rad_l1,p_l1,psym=4,title='P(r)-leg1'
 oplot,X,p0(ileg)* exp( -(1/lambda_p(ileg))*(1.-1./X) )
 xyouts,0.5*[1,1,1],(2./3)*1.-[.1,.125,.15],[string(P0(ileg)),string(lambda_p(ileg)),string(r2p(ileg))],/normal

  plot,rad_l1,tm_l1/1.e6,psym=4,title='Tm(r)-leg1'
  oplot,X,(T0r1+gradT(ileg)*X)/1.e6
  xyouts,0.5*[1,1,1],(1./3)*1.-[.2,.225,.25],[string(T0r1/1.e6),string(gradT(ileg)/1.e6),string(r2t(ileg))],/normal

  !p.multi=0

 wn=1
 window,wn,xs=400,ys=600
 !p.multi=[0,1,2]
 !p.charsize=1.5 
  x = min(s_l1) + (max(s_l1)-min(s_l1))*findgen(100)/99
  
  plot,s_l1,tm_l1/1.e6,psym=4,title='Tm(s)-leg1 linear'
  oplot,X,(T0s1+dTmds(ileg)*rsun*X)/1.e6
  xyouts,0.5*[1,1,1],(1.)*1.-[.25,.28,.31],[string(T0s1/1.e6),string(dTmds(ileg)/1.e6*rsun),string(r2Ts(ileg))],/normal

  plot,s_l1,tm_l1/1.e6,psym=4,title='Tm(s)-leg1 cuadr'
  oplot,X,(Acuadr1[0]*(X)^2 + Acuadr1[1]*(X) + Acuadr1[2])/1.e6
  xyouts,0.5*[1],(1./2)*1.-[.35],[string(r2Tcuadr(ileg))],/normal

  !p.multi=0

; plots for leg2
  wn=2
 window,wn,xs=400,ys=900
 !p.multi=[0,1,3]
 !p.charsize=2.25 
 X=1.+.25*findgen(100)/99.

 plot,rad_l2,ne_l2/1.e8,psym=4,title='Ne-leg2'
 oplot,X,Ne0(ileg+1)* exp( -(1/lambda_N(ileg+1))*(1.-1./X) ) /1.e8
 xyouts,0.5*[1,1,1],1.-[.1,.125,.15],[string(Ne0(ileg+1)/1.e8),string(lambda_N(ileg+1)),string(r2n(ileg+1))],/normal

 plot,rad_l2,p_l2,psym=4,title='P-leg2'
 oplot,X,p0(ileg+1)* exp( -(1/lambda_p(ileg+1))*(1.-1./X) )
 xyouts,0.5*[1,1,1],(2./3)*1.-[.1,.125,.15],[string(P0(ileg+1)),string(lambda_p(ileg+1)),string(r2p(ileg+1))],/normal

  plot,rad_l2,tm_l2/1.e6,psym=4,title='Tm-leg2'
  oplot,X,(T0r2+gradT(ileg+1)*X)/1.e6
  xyouts,0.5*[1,1,1],(1./3)*1.-[.2,.225,.25],[string(T0r2/1.e6),string(gradT(ileg+1)/1.e6),string(r2t(ileg+1))],/normal

  !p.multi=0

  wn=3

  window,wn,xs=400,ys=600
  !p.multi=[0,1,2]
  !p.charsize=1.5 
 
  x = min(s_l2) + (max(s_l2)-min(s_l2))*findgen(100)/99
  
  plot,s_l2,tm_l2/1.e6,psym=4,title='Tm(s)-leg2 linear'
  oplot,X,(T0s2+dTmds(ileg+1)*rsun*X)/1.e6
  xyouts,0.5*[1,1,1],(1.)*1.-[.25,.28,.31],[string(T0s2/1.e6),string(dTmds(ileg+1)/1.e6*rsun),string(r2Ts(ileg+1))],/normal

  plot,s_l2,tm_l2/1.e6,psym=4,title='Tm(s)-leg2 cuadr'
  oplot,X,(Acuadr2[0]*(X)^2 + Acuadr2[1]*(X) + Acuadr2[2])/1.e6
  xyouts,0.5*[1],(1./2)*1.-[.35],[string(r2Tcuadr(ileg+1))],/normal

 !p.multi=0


 wn=4
 window,wn,xs=400,ys=600
 !p.multi=[0,1,2]
 !p.charsize=1.5 
 plot,lat_v(ifirs_1:ilast_2,il),rad_v(ifirs_1:ilast_2,il),ystyle=1,ytitle='Rad',xtitle='Lat'
 plot,lon_v(ifirs_1:ilast_2,il),ytitle='Lon'
 !p.multi=0

 stop
;--------------------TERMINA---------------------------------------


goto,skip_otros_graficos
 
stop
  
  plot,s_l1,Fc_l1,psym=4,title='Fc-leg1'
  
 wn=2
 ;window,wn,xs=400,ys=800
 !p.multi=[0,1,3]
 !p.charsize=2
 !p.charthick=1
 
 plot,rad_l1,Er_l1,psym=4,title='radiative loss-leg1'

 plot,rad_l1,Ec_l1,psym=4,title='conductive loss-leg1'
 
 ;plot,rad_l1,Eh_l1,psym=4,title='heating rate-leg1'
 plot,s_l1,Eh_l1,psym=4,title='heating rate-leg1'
oplot,x,Eh01*exp(x/Sh(ileg))
xyouts,0.5*[1,1,1],(1./3)*1.-[.1,.15,.20],[string(Eh01),string(sH(ileg)),string(r2sh(ileg))],/normal
stop

  plot,s_l2,Fc_l2,psym=4,title='Fc-leg2'
 
wn=2

 ;window,wn,xs=400,ys=800
 !p.multi=[0,1,3]
 !p.charsize=2
 !p.charthick=1
 
 plot,rad_l2,Er_l2,psym=4,title='radiative loss-leg2'

 plot,rad_l2,Ec_l2,psym=4,title='conductive loss-leg2'
 
 ;plot,rad_l2,Eh_l2,psym=4,title='heating rate-leg2'
  plot,s_l2,Eh_l2,psym=4,title='heating rate-leg2'
 oplot,x,Eh02*exp(x/Sh(ileg+1))
 xyouts,0.5*[1,1,1],(1./3)*1.-[.1,.15,.20],[string(Eh02),string(sH(ileg+1)),string(r2sh(ileg+1))],/normal
ps2
stop
skip_otros_graficos:

skiptestloopclosed:
;...........................................


  skipfitloop:
     opclstat(ileg)   =      opcls(il)
     opclstat(ileg+1) =      opcls(il)
  loop_length(ileg)   =      loopL(il) 
  loop_length(ileg+1) =      loopL(il)
        strad(ileg)   =      str_v(il)
        stlat(ileg)   = (90-stth_v(il)/!dtor)
        stlon(ileg)   =     stph_v(il)/!dtor  
        strad(ileg+1) =      str_v(il)
        stlat(ileg+1) = (90-stth_v(il)/!dtor)
        stlon(ileg+1) =     stph_v(il)/!dtor
  skipnextloop:
  indexloop(ileg)  = il
  indexloop(ileg+1)= il  
  if gradT(ileg)*gradT(ileg+1) lt 0. then begin
  indexloop(ileg)   = -678.   
  indexloop(ileg+1) = -678.
  endif 

  ileg = ileg+2

endelse
endfor


stop
return
end

  pro switch_legs,rad_l1,rad_l2,lat_l1,lat_l2,lon_l1,lon_l2,Ne_l1,Ne_l2,Tm_l1,Tm_l2,WT_l1,WT_l2,scoreR_l1,scoreR_l2,il,switching
  common trace_sampled,rad_v,lat_v,lon_v,s_v,Ne_v,Tm_v,WT_v,Er_v,scoreR_v,midcell_v,Npts_v,str_v,stth_v,stph_v,radstart,enrad_v,enlon_v,enlat_v   

  str = str_v(il)  &  stth = stth_v(il)  &  stph = stph_v(il)
  xst = str * sin(stth) * cos(stph) 
  yst = str * sin(stth) * sin(stph) 
  zst = str * cos(stth)

  fr1 = abs(rad_l1-radstart) & i1 = (where(fr1 eq min(fr1)))(0)
  fr2 = abs(rad_l2-radstart) & i2 = (where(fr2 eq min(fr2)))(0)

  r1 = rad_l1(i1)  &  th1 = (90.-lat_l1(i1))*!dtor  &  ph1 = lon_l1(i1)*!dtor
  r2 = rad_l2(i2)  &  th2 = (90.-lat_l2(i2))*!dtor  &  ph2 = lon_l2(i2)*!dtor

  x1 = r1 * sin(th1) * cos(ph1)  &  y1 = r1 * sin(th1) * sin(ph1)  &  z1 = r1 * cos(th1)
  x2 = r2 * sin(th2) * cos(ph2)  &  y2 = r2 * sin(th2) * sin(ph2)  &  z2 = r2 * cos(th2)

  d1 = sqrt((x1-xst)^2+(y1-yst)^2+(z1-zst)^2)
  d2 = sqrt((x2-xst)^2+(y2-yst)^2+(z2-zst)^2)

  goto,skiptestswitch
  print,'-----------------------------------------------------------'
  print,'line #:',il
  print,'-----------------------------------------------------------'
  print,'                   r (Rsun)        th (deg)        ph (deg)'
  print,'-----------------------------------------------------------'
  print,'Line  start:',str/1.d,stth/!dtor,stph/!dtor
  print,'Leg-1 start:',r1/1.d,th1/!dtor/1.d,ph1/!dtor/1.d
  print,'Leg-2 start:',r2/1.d,th2/!dtor/1.d,ph2/!dtor/1.d
  print,'Dist. Leg-1:',d1/1.d
  print,'Dist. Leg-2:',d2/1.d
  if d1 le d2 then switching='no'
  if d1 gt d2 then switching='yes'
  print,'Switch legs?: '+switching
  print,'-----------------------------------------------------------'
  ;if switching eq 'YES' then stop ; Descomentar para ver todo switch
  if d1 gt .5 then STOP           ; Descomentar para ver un switch
                                  ; para el cual la Leg1 empezaba
                                  ; a más de 1/2 Rsun del start point.
  skiptestswitch:

  ; SOLO si d1>d2 INTERCAMBIAR las piernas, sino dejarlas como están.
  ; Así, al salir de esta rutina leg1 será SIEMPRE la pierna del START POINT.
  if d1 gt d2 then begin

  rad_tm = rad_l1
  lat_tm = lat_l1
  lon_tm = lon_l1
   Ne_tm =  Ne_l1  
   Tm_tm =  Tm_l1
   WT_tm =  WT_l1
   scoreR_tm = scoreR_l1

  rad_l1 = rad_l2
  lat_l1 = lat_l2
  lon_l1 = lon_l2
   Ne_l1 =  Ne_l2  
   Tm_l1 =  Tm_l2
   WT_l1 =  WT_l2
   scoreR_l1 = scoreR_l2

  rad_l2 = rad_tm
  lat_l2 = lat_tm
  lon_l2 = lon_tm
   Ne_l2 =  Ne_tm  
   Tm_l2 =  Tm_tm
   WT_l2 =  WT_tm
   scoreR_l2 = scoreR_tm
   switching ='yes' ;FEDE
  
  endif

  return
  end


pro fitr0,rr,yy,A,r2   ;<---
A = linfit(rr,yy)
fit =  A[0]+A[1]*rr 
meanyy = mean(yy)
SStot  = total( (yy-meanyy)^2 )
SSerr  = total( (yy-fit    )^2 )
r2     = 1.-SSerr/SStot 
return 
end


pro fithsEr,rr,yy,A,r2
xx= 1/rr
zz= alog(yy)
A = [0.,0.]
Alin = linfit(xx,zz)
A[0] = exp( Alin[0]+ Alin[1])
A[1] = Alin[1]
fit =  A[0] * exp( -A[1]*(1.-1./rr) ) 
meanyy= mean(yy)
SStot = total( (yy-meanyy)^2 )
SSerr = total( (yy-fit   )^2 )
r2    = 1.-SSerr/SStot 
return
end

pro fitEr,rr,yy,A,r2  ;<--- ajusto exponencial común
zz= alog(yy)
A = [0.,0.]
Alin = linfit(rr,zz)
A[0] = exp( Alin[0])
A[1] = Alin[1]
fit =  A[0] * exp( A[1]*(rr) ) 
meanyy= mean(yy)
SStot = total( (yy-meanyy)^2 )
SSerr = total( (yy-fit   )^2 )
r2    = 1.-SSerr/SStot 
return
end


pro fitTemp,rr,yy,Rmin,Rmax,A,r2,fit
p=where(rr ge Rmin and rr le Rmax)
rr=rr(p)
yy=yy(p)
A = linfit(rr,yy)
fit =  A[0]+A[1]*rr 
meanyy= mean(yy)
SStot = total( (yy-meanyy)^2 )
SSerr = total( (yy-fit   )^2 )
r2    = 1.-SSerr/SStot 
return 
end

;---> Agregado 5/4/2016
pro fitTemp_ladfit,rr,yy,Rmin,Rmax,A_2,r2_2
p=where(rr ge Rmin and rr le Rmax)
rr=rr(p)
yy=yy(p)
A_2 = ladfit(rr,yy,absdev=absdev)
;error=absdev
fit_2 =  A_2[0]+A_2[1]*rr
;meanyy= mean(yy)
meanyy= mean(yy)
SStot = total( (yy-meanyy)^2 )
SSerr = total( (yy-fit_2   )^2 )
r2_2    = 1.-SSerr/SStot
return
end
;---.
pro fittemp_robust,rr,yy,Rmin,Rmax,A_3,fit_3
p=where(rr ge Rmin and rr le Rmax)
rr=rr(p)
yy=yy(p)
A_3 = robust_linefit(rr,yy)
fit_3 =  A_3[0]+A_3[1]*rr
meanyy= mean(yy)
;SStot = total( (yy-meanyy)^2 )
;SSerr = total( (yy-fit   )^2 )
;r2_2    = 1.-SSerr/SStot
return
end

pro fitTemp_ts2,x,y,Rmin,Rmax,a1,b1,r2_3
;p=where(x ge Rmin and x le Rmax)
;x=x(p)
;y=y(p)
n=n_elements(x)
nn=n*(n-1)*0.5

xx1=x#replicate(1,n)
yy1=y#replicate(1,n)

xx=xx1
yy=yy1

yb=fltarr(n,n)-100.
xb=fltarr(n,n)-100.
ts=fltarr(n,n)-100.
bb=fltarr(n)-100.

for j=0,n-1 do begin
   for i=0,n-1 do begin
      if j gt i then begin
      xb(j,i)=xx(j,i)-x(i)
      yb(j,i)=yy(j,i)-y(i)
      ts(j,i)=yb(j,i)/xb(j,i)
   endif else begin
         if j lt i then ts(j,i)=0
      endelse
endfor
endfor

for j=0,n-1 do begin
   for i=0,n-1 do begin
      if j gt i then begin
         ts(j,i)=ts(j,i)
      endif else begin
         if j le i then ts(j,i)=0
      endelse
   endfor
endfor
ts1=ts[where(ts ne 0)] 
a1=median(ts1)
;print,a1
for i=0,n-1 do begin
   bb(i)=y(i)-a1*x(i)
endfor

b1=median(bb)
;print,b1
fit =  b1+ a1*x
meanyy= mean(y)
SStot = total( (y-meanyy)^2 )                                                                                                                                          
SSerr = total( (y-fit   )^2 )                                                                                                                                            
r2_3    = 1.-SSerr/SStot 

return
end

pro fithslinear,rr,yy,Rmin,Rmax,A,r2,Alin,A_ts,r2_ts,Alin_ts,SSerr,SSerr_ts,r2_lin,r2_lin_ts
p=where(rr ge Rmin and rr le Rmax)
rr=rr(p)
yy=yy(p)
xx= 1/rr
zz= alog(yy)
A = [0.,0.]
Alin = linfit(xx,zz)
;r2 del ajuste lineal
fit_lin = alin(0)  + alin(1)    * (1./rr) 
meanzz = mean (zz)
sstot_lin = total( (zz - meanzz)^2 )
sserr_lin = total( (zz - fit_lin)^2 ) 
r2_lin = 1.- sserr_lin/sstot_lin
;..
A[0] = exp( Alin[0]+ Alin[1])
A[1] = Alin[1]
fit =  A[0] * exp( -A[1]*(1.-1./rr) )
meanyy= mean(yy)
SStot = total( (yy-meanyy)^2 )
SSerr = total( (yy-fit   )^2 )
r2    = 1.-SSerr/SStot

fitTemp_ts2,xx,zz,Rmin,Rmax,a1,b1
Alin_ts=[b1,a1]
A_ts=[0.,0.]
A_ts[0] = exp( a1 + b1)
A_ts[1] = a1
;r2 ajuste ts
fit_lin_ts = alin_ts(0) + alin_ts(1) * (1./rr)
sserr_lin_ts = total( (zz - fit_lin_ts)^2 ) 
r2_lin_ts = 1.- sserr_lin_ts/sstot_lin
;..
fit_ts =  A_ts[0] * exp( -A_ts[1]*(1.-1./rr) )
meanyy= mean(yy)
SSerr_ts = total( (yy-fit_ts )^2 )
r2_ts    = 1.-SSerr_ts/SStot

return
end

pro franja_lineal,xfit,y,yfit,ep,yru,yrd,r2,F
;obs: y son los datos e yfit los fiteados
n = n_elements(yfit)
eps = ep * median(yfit)
   yru = yfit + eps
   yrd = yfit - eps

 Yin = fltarr(n)-100.
for i=0,n-1 do begin
   if y(i) ge yrd(i) and y(i) le yru(i) then  Yin(i) = 1. ;si estan dentro del rango
   if y(i) lt yrd(i) or y(i)  gt yru(i) then  Yin(i) = 0.  
endfor
nok=where(Yin eq 1.)

;DT = abs(y-yfit)   ;solo es riguroso para loops isotermicos
;Nok=where(DT le eps)

F=float(n_elements(Nok))/float(n) 

meanyy= mean(y)
SStot = total( (y-meanyy)^2 )
SSerr = total( (y-yfit   )^2 )
r2    = 1.-SSerr/SStot
return
end
;----.


pro fitEh,ss,yy,smin,smax,A,r2

A= [-555.,-555]
r2 = -555.
p=where(ss ge smin and ss le smax and yy gt 0.)

if n_elements(p) ge 5 and 2*n_elements(p) gt n_elements(yy) then begin
ss=ss(p)
yy=yy(p)
zz = alog(yy) 
Alin = linfit(ss,zz)
A[0] = exp (Alin[0])
A[1] = 1./Alin[1]
fit =  A[0] * exp(ss/A[1]) 
meanyy= mean(yy)
SStot = total( (yy-meanyy)^2 )
SSerr = total( (yy-fit   )^2 )
r2    = 1.-SSerr/SStot 
endif

return
end


pro footpoint_map,box=box,footlat_c,footlon_c,opclstat_c,filelabel=filelabel,indexloop_c,rotacion,Eh=Eh,sH=sH,r2sH=r2sH

if not keyword_set(box) then box=[0.,-90.,360.,+90.]

!P.CHARTHICK=6
!p.charsize=2

; if rotacion eq 'CR2081' then trace_openclose,rotacion+'_90X180blines_r_',7,1.0,lonvA,latvA,/gng

; colors
coltb = 12
green=20
blue=100-12
dblue=100
red=200-36
dred=200
; Create custom made symbol (psym=8) for scatter plots
 N=25
 A = FINDGEN(N) * (!PI*2/float(N-1))
 f=10.
 USERSYM, COS(A)/f, SIN(A)/f,/FILL

iopen    = where(opclstat_c eq 0.)
ilarge   = where(opclstat_c eq 1.)
ismall   = where(opclstat_c eq 2.)

ps1,'./newfigs/'+filelabel+'_footpoint-map.eps',0
  DEVICE,/INCHES,YSIZE=5,XSIZE=10,SCALE_FACTOR=1
  plot,footlon_c,footlat_c,xr=[box[0],box[2]],yr=[box[1],box[3]],psym=8,$
       title='CR-2081, March 2009',xtitle='Longitude [deg]',ytitle='Latitude [deg]',/nodata,xstyle=1,ystyle=1
loadct,coltb
 if iopen (0) ne -1 then oplot,footlon_c(iopen ),footlat_c(iopen ),color=blue ,th=2,psym=8
 if ilarge(0) ne -1 then oplot,footlon_c(ilarge),footlat_c(ilarge),color=green,th=2,psym=8
 if ismall(0) ne -1 then oplot,footlon_c(ismall),footlat_c(ismall),color=red  ,th=2,psym=8

loadct,0

!p.multi = 0
!P.CHARTHICK=0

;oplot,lonvA,latvA,th=3,psym=8

ps2
return
end

pro trace_openclose,string,ir,height,gng=gng,mdi=mdi,lonvA,latvA
common mapopcl,mapoc
if keyword_set(gng) then load_mapoc,string,height,/gng
if keyword_set(mdi) then load_mapoc,string,height,/mdi
map2d=reform(mapoc(ir,*,*))
map2d=rotate(map2d,4)
Nlon=(size(map2d))(1)
Nlat=(size(map2d))(2)
dt = 2.
lon =   0. + dt/2. + dt * findgen(Nlon)
lat = -90. + dt/2. + dt * findgen(Nlat)
flag=0
for ilon=0,nlon-1 do begin
for ilat=1,nlat-1 do begin
if map2d(ilon,ilat) ne map2d(ilon,ilat-1) then begin
 lonv = lon(ilon)
 latv = mean([lat(ilat-1),lat(ilat)])
 if flag eq 0 then begin
 lonvA = [lonv]
 latvA = [latv]
 flag=1
 endif else begin
 lonvA = [lonvA,lonv]
 latvA = [latvA,latv]
 endelse
endif
endfor
endfor
return
end

pro fitcuadrtemp,rr,yy,Rmin,Rmax,A,r2,T0,gradT
p=where(rr ge Rmin and rr le Rmax)
rr=rr(p)
yy=yy(p)
A2 = T0
A1 = gradT
A0 = 0.0
A=[A0,A1,A2]
ww=yy*0.+1. ;1./yy
fit=curvefit(rr,yy,ww,A,Sigma,function_name='function_cuadr')
meanyy= mean(yy)
SStot = total( (yy-meanyy)^2 )
SSerr = total( (yy-fit   )^2 )
r2    = 1.-SSerr/SStot
return
end

PRO function_cuadr, X, A, F, pder   
   F = A[0]*X^2 + A[1]*X + A[2]
   IF N_PARAMS() GE 4 then pder=[ [X^2], [X], [replicate(1.0, N_ELEMENTS(X))]]
END


pro filter,i

common statistic_loops,Nlegs,Nemean,Tmmean,WTmean,Nestddev,Tmstddev,WTstddev,loop_length,betamean,betaapex,Bmean,Br0
;common statistic_loops2,opclstat,lambda_N,lambda_p,Ne0,p0,Tefit,gradT,r2N,r2P,r2T,indexloop,leg_status,Tm0,Tm0s,f_t,f_ne  
common statistic_loops2,opclstat,lambda_N,lambda_p,Ne0,p0,Tefit,gradT,r2N,r2P,r2T,indexloop,leg_status,Tm0,Tm0s,tm0_2,tm0_3,tm0_4,gradt_2,gradt_3,gradt_4,r2T_2,f_t,f_ne
common statistic_loops3,Eh,sH,r2sH,Phir,Fcb
common statistic_loops4,r2Tcuadr,Acuadr_a, s_r0_a,dTmds,r2Ts
common starttrace,strad,stlat,stlon,footrad,footlat,footlon,Rp_rad,Rp_lat,Rp_lon 

common stat_filter,Nlegs_c,Nemean_c,Tmmean_c,WTmean_c,Nestddev_c,Tmstddev_c,WTstddev_c,loop_length_c,betamean_c,betaapex_c,Bmean_c,Br0_c
common stat_filter2,opclstat_c,lambda_N_c,lambda_p_c,Ne0_c,p0_c,Tefit_c,gradT_c,r2N_c,r2P_c,r2T_c,indexloop_c,leg_status_c,Tm0_c,Tm0s_c,Nebasal_c,Tbasal_c
common stat_filter3,Eh_c,sH_c,r2sH_c,Phir_c,Fcb_c
common stat_filter4,r2Tcuadr_c,Acuadr_a_c, s_r0_a_c,dTmds_c,r2Ts_c
common stat_filter5,strad_c,stlat_c,stlon_c,footrad_c,footlat_c,footlon_c,Rp_rad_c,Rp_lat_c,Rp_lon_c

      Nlegs_c =       Nlegs(i)
     Nemean_c =      Nemean(i)
     Tmmean_c =      Tmmean(i)
     WTmean_c =      WTmean(i)
   Nestddev_c =    Nestddev(i)
   Tmstddev_c =    Tmstddev(i)
   WTstddev_c =    Wtstddev(i)
loop_length_c = loop_length(i)
   betamean_c =    betamean(i)
   betaapex_c =    betaapex(i)
      Bmean_c =       Bmean(i)
        Br0_c =         Br0(i)

   opclstat_c =    opclstat(i)
   lambda_N_c =    lambda_N(i)
   lambda_p_c =    lambda_p(i)
        Ne0_c =         Ne0(i)
    Nebasal_c = Ne0(i) * exp(-1/lambda_N(i)* (1. - 1./1.025))
         p0_c =          p0(i)
      Tefit_c =       Tefit(i)
      gradT_c =       gradT(i)
        r2N_c =         r2N(i)
        r2P_c =         r2P(i)
        r2T_c =         r2T(i)
  indexloop_c =   indexloop(i)
 leg_status_c =  leg_status(i)
        Tm0_c =         Tm0(i)
       Tm0s_c =        Tm0s(i)
     Tbasal_c = Tm0(i) + gradT(i)*1.025       
         Eh_c =          Eh(i)
         sH_c =          sH(i)
       r2sH_c =        r2sH(i)
       Phir_c =        Phir(i)
        Fcb_c =         Fcb(i)

   r2Tcuadr_c =    r2Tcuadr(i)
   Acuadr_a_c =    Acuadr_a(i)
     s_r0_a_c =      s_r0_a(i)
      dTmds_c =       dTmds(i)
       r2Ts_c =        r2Ts(i)
       f_t_c  =         f_t(i)
      f_ne_c  =        f_ne(i)
    footlat_c =     footlat(i)
    footlon_c =     footlon(i)
    footrad_c =     footrad(i)
      strad_c =       strad(i)
      stlat_c =       stlat(i)
      stlon_c =       stlon(i)

     Rp_rad_c =      Rp_rad(i)
     Rp_lat_c =      Rp_lat(i)
     Rp_lon_c =      Rp_lon(i)

return
end

pro hisoplot,data,min=min,max=max,nbins=nbins,xtit=xtit,ytit=ytit,tit=tit,filename=filename,ndig=ndig

ps1,'./newfigs/'+filename+'.eps',0
f = histogram(data,min=min,max=max,nbins=nbins,locations=vbin) & f = f / total(f)
plot,vbin,f,psym=10,charsize=2,xtitle=xtit,ytitle=ytit,title=tit,xstyle=1,thick=3,charthick=2,Font=0

avg        =   mean(data) & print, avg
med        = median(data)
stdev_frac =  stdev(data)/abs(avg)
cant       = long(n_elements(data))

xyouts,0.7*[1,1,1,1],1-[0.18,0.25,0.32,0.38],['m='+strmid(string(med),4,6),'!9m!3='+strmid(string(avg),4,6),'!9s!3/!9m!3='+strmid(string(stdev_frac),4,6),'N='+strmid(string(cant),7,7)],/normal,charthick=1,Font=0

ps2

return
end


pro Rpoint_map,box=box,footlat_c,footlon_c,opclstat_c,filelabel=filelabel,indexloop_c,rotacion,Eh=Eh,sH=sH,r2sH=r2sH

if not keyword_set(box) then box=[0.,-90.,360.,+90.]

!P.CHARTHICK=6
!p.charsize=2.5

; if rotacion eq 'CR2081' then
; trace_openclose,rotacion+'_90X180blines_r_',7,1.0,lonvA,latvA,/gng                                                                            

coltb = 12
green=20
blue=100-12
dblue=100
red=200-36
dred=200

coltb=39
; Create custom made symbol (psym=8) for scatter plots                                                                                                                                                                                       
 N=25
 A = FINDGEN(N) * (!PI*2/float(N-1))
 f=5.
 USERSYM, COS(A)/f, SIN(A)/f,/FILL

cant_pts = n_elements(footlat_c)
print, cant_pts
iopen    = where(opclstat_c eq 0.)
ilarge   = where(opclstat_c eq 1.)
ismall   = where(opclstat_c eq 2.)

ps1,'./newfigs/'+filelabel+'_Rpoint-map.eps',0
  DEVICE,/INCHES,YSIZE=5,XSIZE=10,SCALE_FACTOR=1

  thick=3
;Device, SET_FONT = 'Bookman-LightItalic'                                                                                                                                      
;Device, /BKMAN, /LIGHT                                                                                                                                                        
                
  plot,footlon_c,footlat_c,xr=[box[0],box[2]],yr=[box[1],box[3]],psym=8,$
       title='Physical location of loop at R=1.075',xtitle='Lon [deg]',ytitle='Lat [deg]',xthick=thick,ythick=thick,/nodata,xstyle=1,ystyle=1,font=0
loadct,coltb
 if iopen (0) ne -1 then oplot,footlon_c(iopen ),footlat_c(iopen ),color=200   ,th=2,psym=8
 if ilarge(0) ne -1 then oplot,footlon_c(ilarge),footlat_c(ilarge),color=245   ,th=2,psym=8
 if ismall(0) ne -1 then oplot,footlon_c(ismall),footlat_c(ismall),color=28    ,th=2,psym=8
xyouts,0.92-[0.2],0.1*[1],['pts='+strmid(string(cant_pts),1,14)],/normal,charthick=2,Font=0,charsize=2
stop
loadct,0

!p.multi = 0
!P.CHARTHICK=0

;oplot,lonvA,latvA,th=3,psym=8                                                                                                                                                  
ps2
return
end


pro Rpoint_map2,box=box,footlat,footlon,opclstat,r2T,r2N,r2crit_T,r2crit_N,lowlatmax,lonmax,gradT,filelabel=filelabel,indexloop,rotacion,Eh=Eh,sH=sH,r2sH=r2sH,full=full

if not keyword_set(box) then box=[0.,-90.,360.,+90.]
!P.CHARTHICK=6
!p.charsize=2.5
; if rotacion eq 'CR2081' then                
; trace_openclose,rotacion+'_90X180blines_r_',7,1.0,lonvA,latvA,/gng            
; colors                                      
coltb = 12
green=20
blue=100-12
dblue=100
red=200-36
dred=200

coltb=39
; Create custom made symbol (psym=8) for scatter plots 
 N=25
 A = FINDGEN(N) * (!PI*2/float(N-1))
 f=5.
 USERSYM, COS(A)/f, SIN(A)/f,/FILL
if not keyword_set(full) then begin

i_lowlat_gradneg             = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and abs(footlat) le lowlatmax and gradT le 0. and footlon le lonmax)
i_midlat_small_norte_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat gt  30. and gradT   ge 0. and footlon le lonmax)
i_midlat_small_sur_gradpos   = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat lt -30. and gradT   ge 0. and footlon le lonmax)
i_large_OCN_gradpos          = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat ge +40. and footlat le  80. and gradT ge 0. and footlon le lonmax)
i_large_OCS_gradpos          = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat le -40. and footlat ge -80. and gradT ge 0. and footlon le lonmax)

i_lowlat             = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and abs(footlat) le lowlatmax and footlon le lonmax)
i_midlat_small_norte = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat gt  30. and footlon le lonmax)
i_midlat_small_sur   = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat le -30. and footlon le lonmax)
i_large_OCN          = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat gt +40. and footlon le lonmax)
i_large_OCS          = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat lt -40. and footlat gt -80. and footlon le lonmax)

;i_open_norte_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat gt +50. and footlat lt 80. and gradT gt 0. and footlon le lonmax)
;i_open_sur_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat lt -50. and footlat gt -80. and gradT gt 0. and footlon le lonmax)

i_open_norte_L         = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat le 68. and footlat ge 0. and footlon le lonmax)
i_open_norte_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat le 68. and footlat ge 0. and gradT ge 0. and footlon le lonmax)

i_open_norte_H         = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat ge 72. and footlat le 80. and footlon le lonmax)
i_open_norte_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat ge 72. and footlat le 80. and gradT ge 0. and footlon le lonmax)

i_open_sur_L           = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat ge -68. and footlat le 0. and footlon le lonmax)
i_open_sur_gradpos_L   = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat ge -68. and footlat le 0. and gradT ge 0. and footlon le lonmax)

i_open_sur_H           = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat le -72. and footlat ge -80. and footlon le lonmax)
i_open_sur_gradpos_H   = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat le -72. and footlat ge -80. and gradT ge 0. and footlon le lonmax)
endif

if keyword_set(full) then begin

i_lowlat_gradneg             = where( opclstat eq 2. and abs(footlat) le lowlatmax and footlon le lonmax)
i_midlat_small_norte_gradpos = where( opclstat eq 2. and footlat ge  30. and footlon le lonmax)
i_midlat_small_sur_gradpos   = where( opclstat eq 2. and footlat le -30. and footlon le lonmax)
i_large_OCN_gradpos          = where( opclstat eq 1. and footlat ge +40. and footlat le  80. and footlon le lonmax)
i_large_OCS_gradpos          = where( opclstat eq 1. and footlat le -40. and footlat ge -80. and footlon le lonmax)
;i_open_norte_L              = where( opclstat eq 0. and r2N ge r2crit_N and footlat lt 68. and footlat ge 0. and footlon le lonmax)
i_open_norte_gradpos_L       = where( opclstat eq 0. and footlat le  68. and footlat ge   0. and footlon le lonmax)
;i_open_norte_H              = where( opclstat eq 0. and r2N ge r2crit_N and footlat ge 72. and footlat le 80. and footlon le lonmax)
i_open_norte_gradpos_H       = where( opclstat eq 0. and footlat ge  72. and footlat le  80. and footlon le lonmax)
;i_open_sur_L                = where( opclstat eq 0. and r2N ge r2crit_N and footlat gt -68. and footlat le 0. and footlon le lonmax)
i_open_sur_gradpos_L         = where( opclstat eq 0. and footlat ge -68. and footlat le   0. and footlon le lonmax)
;i_open_sur_H                = where( opclstat eq 0. and footlat le -72. and footlat ge -80. and footlon le lonmax)
i_open_sur_gradpos_H         = where( opclstat eq 0. and footlat le -72. and footlat ge -80. and footlon le lonmax)
endif
stop
ps1,'./newfigs/Rpoint-map'+filelabel+'.eps',0
  DEVICE,/INCHES,YSIZE=5,XSIZE=10,SCALE_FACTOR=1

  thick=3
;Device, SET_FONT = 'Bookman-LightItalic'     
;Device, /BKMAN, /LIGHT                       
;thick=3                                      
  plot,footlon,footlat,xr=[box[0],box[2]],yr=[box[1],box[3]],psym=8,$
       title='Localizacion de lineas en r=1.075 Rs',xtitle='Longitud [deg]',ytitle='Latatitud [deg]',xthick=thick,ythick=thick,/nodata,xstyle=1,ystyle=1,font=0
loadct,coltb
  oplot,footlon(i_lowlat_gradneg),footlat(i_lowlat_gradneg),color=200  ,th=2,psym=8 ;ciano

  oplot,footlon(i_large_OCN_gradpos),footlat(i_large_OCN_gradpos),color=245   ,th=2,psym=8 ;bordo
  oplot,footlon(i_large_OCS_gradpos),footlat(i_large_OCS_gradpos),color=245   ,th=2,psym=8 ;bordo

  oplot,footlon(i_midlat_small_norte_gradpos),footlat(i_midlat_small_norte_gradpos),color=28  ,th=2,psym=8 ;verde
  oplot,footlon(i_midlat_small_sur_gradpos),footlat(i_midlat_small_sur_gradpos),color=28  ,th=2,psym=8 ;verde

  ;oplot,footlon(i_open_norte_gradpos),footlat(i_open_norte_gradpos),color=150   ,th=2,psym=8
  ;oplot,footlon(i_open_sur_gradpos),footlat(i_open_sur_gradpos),color=150   ,th=2,psym=8

  oplot,footlon(i_open_norte_gradpos_L),footlat(i_open_norte_gradpos_L),color=150   ,th=2,psym=8
  oplot,footlon(i_open_sur_gradpos_L),footlat(i_open_sur_gradpos_L),color=150   ,th=2,psym=8

  oplot,footlon(i_open_norte_gradpos_H),footlat(i_open_norte_gradpos_H),color=90   ,th=2,psym=8
  oplot,footlon(i_open_sur_gradpos_H),footlat(i_open_sur_gradpos_H),color=90   ,th=2,psym=8

loadct,0
!p.multi = 0
!P.CHARTHICK=0
ps2
return
end


pro footpoint_map2,box=box,footlat,footlon,opclstat,r2T,r2N,r2crit_T,r2crit_N,lowlatmax,lonmax,gradT,filelabel=filelabel,indexloop,rotacion,Eh=Eh,sH=sH,r2sH=r2sH,full=full

if not keyword_set(box) then box=[0.,-90.,360.,+90.]

!P.CHARTHICK=6
!p.charsize=2.5
; if rotacion eq 'CR2081' then
; trace_openclose,rotacion+'_90X180blines_r_',7,1.0,lonvA,latvA,/gng
; colors
coltb = 12
green=20
blue=100-12
dblue=100
red=200-36
dred=200

coltb=39
; Create custom made symbol (psym=8) for scatter plots                                             
 N=25
 A = FINDGEN(N) * (!PI*2/float(N-1))
 f=5.
 USERSYM, COS(A)/f, SIN(A)/f,/FILL

if not keyword_set(full) then begin
;subregiones de la tesis
i_lowlat_gradneg             = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and abs(footlat) le lowlatmax and gradT le 0. and footlon le lonmax)
i_midlat_small_norte_gradpos = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat gt  30. and gradT gt 0. and footlon le lonmax)
i_midlat_small_sur_gradpos   = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat le -30. and gradT gt 0. and footlon le lonmax)
i_large_OCN_gradpos          = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat gt +40. and footlat le  80. and gradT gt 0. and footlon le lonmax)
i_large_OCS_gradpos          = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat lt -40. and footlat ge -80. and gradT gt 0. and footlon le lonmax)

i_lowlat             = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and abs(footlat) le lowlatmax and footlon le lonmax)
i_midlat_small_norte = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat gt  30. and footlon le lonmax)
i_midlat_small_sur   = where(gradT ne -555. AND opclstat eq 2. and r2T gt r2crit_T and footlat le -30. and footlon le lonmax)
i_large_OCN          = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat gt +40. and footlat le  80. and footlon le lonmax)
i_large_OCS          = where(gradT ne -555. AND opclstat eq 1. and r2T ge r2crit_T and footlat lt -40. and footlat gt -80. and footlon le lonmax)

;i_open_norte_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat gt +50. and footlat lt 80. and gradT gt 0. and footlon le lonmax)
;i_open_sur_gradpos = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat lt -50. and footlat gt -80. and gradT gt 0. and footlon le lonmax)

i_open_norte_L         = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat le 68. and footlat ge 0. and footlon le lonmax)
i_open_norte_gradpos_L = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat le 68. and footlat ge 0. and gradT gt 0. and footlon le lonmax)

i_open_norte_H         = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat ge 72. and footlat le 80. and footlon le lonmax)
i_open_norte_gradpos_H = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat ge 72. and footlat le 80. and gradT gt 0. and footlon le lonmax)

i_open_sur_L           = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat ge -68. and footlat le 0. and footlon le lonmax)
i_open_sur_gradpos_L   = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat ge -68. and footlat le 0. and gradT gt 0. and footlon le lonmax)

i_open_sur_H           = where(gradT ne -555. AND opclstat eq 0. and r2N ge r2crit_N and footlat le -72. and footlat ge -80. and footlon le lonmax)
i_open_sur_gradpos_H   = where(gradT ne -555. AND opclstat eq 0. and r2T ge r2crit_T and footlat le -72. and footlat ge -80. and gradT gt 0. and footlon le lonmax)
endif

if keyword_set(full) then begin
;footpoint_map sin ralear, bien llenitos, sin filtrar lineas

i_lowlat_gradneg             = where( opclstat eq 2. and abs(footlat) le lowlatmax  and footlon le lonmax)
i_midlat_small_norte_gradpos = where( opclstat eq 2. and footlat gt  30. and footlon le lonmax)
i_midlat_small_sur_gradpos   = where( opclstat eq 2. and footlat lt -30. and footlon le lonmax)
i_large_OCN_gradpos          = where( opclstat eq 1. and footlat ge +40. and footlon le lonmax)
i_large_OCS_gradpos          = where( opclstat eq 1. and footlat le -40. and footlon le lonmax)

;i_lowlat = where( opclstat eq 2. and r2T gt r2crit_T and abs(footlat) le lowlatmax and footlon le lonmax)
;i_midlat_small_norte = where( opclstat eq 2. and r2T gt r2crit_T and footlat gt 30. and footlon le lonmax)
;i_midlat_small_sur = where( opclstat eq 2. and r2T gt r2crit_T and footlat le -30.  and footlon le lonmax)
;i_large_OCN = where( opclstat eq 1. and r2T ge r2crit_T and footlat gt +40. and footlon le lonmax)
;i_large_OCS = where( opclstat eq 1. and r2T ge r2crit_T and footlat lt -40. and footlat gt -80. and footlon le lonmax)

;i_open_norte_L         = where( opclstat eq 0. and r2N ge r2crit_N and footlat lt 68. and footlat ge 0. and footlon le lonmax)
i_open_norte_gradpos_L = where( opclstat eq 0. and footlat le  68. and footlat ge   0. and footlon le lonmax)
;i_open_norte_H         = where( opclstat eq 0. and r2N ge r2crit_N and footlat ge 72. and footlat le 80. and footlon le lonmax)
i_open_norte_gradpos_H = where( opclstat eq 0. and footlat ge  72. and footlat le  80. and footlon le lonmax)
;i_open_sur_L           = where( opclstat eq 0. and r2N ge r2crit_N and footlat gt -68. and footlat le 0. and footlon le lonmax)
i_open_sur_gradpos_L   = where( opclstat eq 0. and footlat ge -68. and footlat le   0. and footlon le lonmax)
;i_open_sur_H           = where( opclstat eq 0. and r2N ge r2crit_N and footlat le -72. and footlat ge -80. and footlon le lonmax)
i_open_sur_gradpos_H   = where( opclstat eq 0. and footlat le -72. and footlat ge -80. and footlon le lonmax)

endif

ps1,'./newfigs/footpoint-map'+filelabel+'.eps',0
  DEVICE,/INCHES,YSIZE=5,XSIZE=10,SCALE_FACTOR=1
  thick=3
;Device, SET_FONT = 'Bookman-LightItalic'
;Device, /BKMAN, /LIGHT
;thick=3                       
  plot,footlon,footlat,xr=[box[0],box[2]],yr=[box[1],box[3]],psym=8,$
       title='Localizacion de lineas en r=1.000 Rs',xtitle='Longitud [deg]',ytitle='Latitud [deg]',xthick=thick,ythick=thick,/nodata,xstyle=1,ystyle=1,font=0
loadct,coltb
  oplot,footlon(i_lowlat_gradneg),footlat(i_lowlat_gradneg),color=200  ,th=2,psym=8 ;ciano                                                      

  oplot,footlon(i_large_OCN_gradpos),footlat(i_large_OCN_gradpos),color=245   ,th=2,psym=8 ;bordo                                               
  oplot,footlon(i_large_OCS_gradpos),footlat(i_large_OCS_gradpos),color=245   ,th=2,psym=8 ;bordo                                               

  oplot,footlon(i_midlat_small_norte_gradpos),footlat(i_midlat_small_norte_gradpos),color=28  ,th=2,psym=8 ;verde                               
  oplot,footlon(i_midlat_small_sur_gradpos),footlat(i_midlat_small_sur_gradpos),color=28  ,th=2,psym=8 ;verde                                                                                                                    
  ;oplot,footlon(i_open_norte_gradpos),footlat(i_open_norte_gradpos),color=150   ,th=2,psym=8
  ;oplot,footlon(i_open_sur_gradpos),footlat(i_open_sur_gradpos),color=150   ,th=2,psym=8

  oplot,footlon(i_open_norte_gradpos_L),footlat(i_open_norte_gradpos_L),color=150   ,th=2,psym=8
  oplot,footlon(i_open_sur_gradpos_L),footlat(i_open_sur_gradpos_L),color=150   ,th=2,psym=8

  oplot,footlon(i_open_norte_gradpos_H),footlat(i_open_norte_gradpos_H),color=90   ,th=2,psym=8
  oplot,footlon(i_open_sur_gradpos_H),footlat(i_open_sur_gradpos_H),color=90   ,th=2,psym=8

loadct,0
!p.multi = 0
!P.CHARTHICK=0
;oplot,lonvA,latvA,th=3,psym=8                                            
ps2
return
end



function findel,value,array,matrix=matrix,array=retarray
  on_error,2;Return to caller if an error occurs                                                                                                                                                                                             
diff = abs(array - value)
dum = min(diff,ind)

if keyword_set(retarray) then matrix=1
if keyword_set(matrix) then begin
    sz = size(array)
    ncol = sz[1]
    col = ind mod ncol
    row = ind / ncol
    ind = [col, row]
 endif
return,ind
end

pro histoplot2B,data1,data2,min=min,max=max,nbins=nbins,xtit=xtit,ytit=ytit,tit=tit,filename=filename,ndig=ndig,decon=decon

ps1,'./newfigs/caca'+filename+'.eps',0

  !p.charsize=2
  DEVICE,/INCHES,YSIZE=5,XSIZE=10,SCALE_FACTOR=1

f1 = histogram(data1,min=min,max=max,nbins=nbins,locations=vbin1) & f1 = f1 / total(f1)
f2 = histogram(data2,min=min,max=max,nbins=nbins,locations=vbin2) & f2 = f2 / total(f2)

maxy=max([f1,f2])

 plot,vbin1,f1,psym=10,charsize=2,xtitle=xtit,ytitle=ytit,title=tit,yr=[0,maxy],xr=[min,max],xstyle=1,/nodata,thick=3,charthick=2,Font=0
loadct,12

verde = 25
azul =100
rojo =200
negro=  0
if not keyword_set(decon) then oplot,vbin1,f1,psym=10,th=5,color=rojo
if keyword_set(decon) then oplot,vbin1,f1,psym=10,th=5,color=verde
oplot,vbin2,f2,psym=10,th=5,color=azul
loadct,0

avg1        =  mean(data1)
avg2        =  mean(data2)
med1        = median(data1)
med2        = median(data2)
cant1       = long(n_elements(data1))
cant2       = long(n_elements(data2))
stdev1      = stdev(data1)/ abs(avg1) & print,stdev(data1) 
stdev2      = stdev(data2)/ abs(avg2) & print,stdev(data2)

xyouts,.98-[.4,.3,.2,.1],0.84*[1,1,1,1],['m','!9m!3','!9s!3/!9m!3','N'],/normal,charthick=3,Font=0

loadct,12



if not keyword_set(decon) then xyouts,0.95-[.4,.3,.2,.1],0.78*[1,1,1,1],[strmid(string(med1),5,ndig),strmid(string(avg1),5,ndig),strmid(string(stdev1),4,ndig),strmid(string(cant1),7,7)],/normal,color=[rojo,rojo,rojo,rojo],charthick=3
if keyword_set(decon) then xyouts,0.95-[.4,.3,.2,.1],0.78*[1,1,1,1],[strmid(string(med1),4,ndig),strmid(string(avg1),4,ndig),strmid(string(stdev1),4,ndig),strmid(string(cant1),7,7)],/normal,color=[verde,verde,verde,verde],charthick=3
xyouts,0.95-[.4,.3,.2,.1],0.73*[1,1,1,1],[strmid(string(med2),4,ndig),strmid(string(avg2),4,ndig),strmid(string(stdev2),4,ndig),strmid(string(cant2),7,7)],/normal,color=[azul,azul,azul,azul],charthick=3

;xyouts,.9-[.2,.1],0.7*[1,1],[strmid(string(avg1),4,ndig),strmid(string(stdev1),4,5)],/normal,color=[rojo,rojo],charthick=2                                                         
;xyouts,.9-[.2,.1],0.6*[1,1],[strmid(string(avg2),4,ndig),strmid(string(stdev2),4,5)],/normal,color=[azul,azul],charthick=2                                

if not keyword_set(decon) then xyouts,0.2*[1,1],[0.8,0.75],['CR-1915','CR-2081'],/normal,color=[rojo,azul],charthick=3
;if keyword_set(decon) then xyouts,0.2*[1,1],[0.8,0.75],['con deconv. PSF','sin deconv. PSF'],/normal,color=[verde,azul],charthick=2
if keyword_set(decon) then xyouts,0.68*[1,1],[0.5,0.45],['con deconv. PSF','sin deconv. PSF'],/normal,color=[verde,azul],charthick=2


loadct,0
ps2

return
end

