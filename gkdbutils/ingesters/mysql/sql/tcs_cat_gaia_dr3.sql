CREATE TABLE `tcs_cat_gaia_dr3` (
  `solution_id` bigint,
  `designation` varchar(40),
  `source_id` bigint NOT NULL,
  `random_index` bigint,
  `ref_epoch` double,
  `ra` double NOT NULL,
  `ra_error` float,
  `dec` double NOT NULL,
  `dec_error` float,
  `parallax` double,
  `parallax_error` float,
  `parallax_over_error` float,
  `pm` float,
  `pmra` double,
  `pmra_error` float,
  `pmdec` double,
  `pmdec_error` float,
  `ra_dec_corr` float,
  `ra_parallax_corr` float,
  `ra_pmra_corr` float,
  `ra_pmdec_corr` float,
  `dec_parallax_corr` float,
  `dec_pmra_corr` float,
  `dec_pmdec_corr` float,
  `parallax_pmra_corr` float,
  `parallax_pmdec_corr` float,
  `pmra_pmdec_corr` float,
  `astrometric_n_obs_al` smallint,
  `astrometric_n_obs_ac` smallint,
  `astrometric_n_good_obs_al` smallint,
  `astrometric_n_bad_obs_al` smallint,
  `astrometric_gof_al` float,
  `astrometric_chi2_al` float,
  `astrometric_excess_noise` float,
  `astrometric_excess_noise_sig` float,
  `astrometric_params_solved` tinyint,
  `astrometric_primary_flag` tinyint unsigned,
  `nu_eff_used_in_astrometry` float,
  `pseudocolour` float,
  `pseudocolour_error` float,
  `ra_pseudocolour_corr` float,
  `dec_pseudocolour_corr` float,
  `parallax_pseudocolour_corr` float,
  `pmra_pseudocolour_corr` float,
  `pmdec_pseudocolour_corr` float,
  `astrometric_matched_transits` smallint,
  `visibility_periods_used` smallint,
  `astrometric_sigma5d_max` float,
  `matched_transits` smallint,
  `new_matched_transits` smallint,
  `matched_transits_removed` smallint,
  `ipd_gof_harmonic_amplitude` float,
  `ipd_gof_harmonic_phase` float,
  `ipd_frac_multi_peak` tinyint,
  `ipd_frac_odd_win` tinyint,
  `ruwe` float,
  `scan_direction_strength_k1` float,
  `scan_direction_strength_k2` float,
  `scan_direction_strength_k3` float,
  `scan_direction_strength_k4` float,
  `scan_direction_mean_k1` float,
  `scan_direction_mean_k2` float,
  `scan_direction_mean_k3` float,
  `scan_direction_mean_k4` float,
  `duplicated_source` tinyint unsigned,
  `phot_g_n_obs` smallint,
  `phot_g_mean_flux` double,
  `phot_g_mean_flux_error` float,
  `phot_g_mean_flux_over_error` float,
  `phot_g_mean_mag` float,
  `phot_bp_n_obs` smallint,
  `phot_bp_mean_flux` double,
  `phot_bp_mean_flux_error` float,
  `phot_bp_mean_flux_over_error` float,
  `phot_bp_mean_mag` float,
  `phot_rp_n_obs` smallint,
  `phot_rp_mean_flux` double,
  `phot_rp_mean_flux_error` float,
  `phot_rp_mean_flux_over_error` float,
  `phot_rp_mean_mag` float,
  `phot_bp_rp_excess_factor` float,
  `phot_bp_n_contaminated_transits` smallint,
  `phot_bp_n_blended_transits` smallint,
  `phot_rp_n_contaminated_transits` smallint,
  `phot_rp_n_blended_transits` smallint,
  `phot_proc_mode` tinyint,
  `bp_rp` float,
  `bp_g` float,
  `g_rp` float,
  `radial_velocity` float,
  `radial_velocity_error` float,
  `rv_method_used` tinyint,
  `rv_nb_transits` smallint,
  `rv_nb_deblended_transits` smallint,
  `rv_visibility_periods_used` smallint,
  `rv_expected_sig_to_noise` float,
  `rv_renormalised_gof` float,
  `rv_chisq_pvalue` float,
  `rv_time_duration` float,
  `rv_amplitude_robust` float,
  `rv_template_teff` float,
  `rv_template_logg` float,
  `rv_template_fe_h` float,
  `rv_atm_param_origin` smallint,
  `vbroad` float,
  `vbroad_error` float,
  `vbroad_nb_transits` smallint,
  `grvs_mag` float,
  `grvs_mag_error` float,
  `grvs_mag_nb_transits` smallint,
  `rvs_spec_sig_to_noise` float,
  `phot_variable_flag` varchar(40),
  `l` double,
  `b` double,
  `ecl_lon` double,
  `ecl_lat` double,
  `in_qso_candidates` tinyint unsigned,
  `in_galaxy_candidates` tinyint unsigned,
  `non_single_star` smallint,
  `has_xp_continuous` tinyint unsigned,
  `has_xp_sampled` tinyint unsigned,
  `has_rvs` tinyint unsigned,
  `has_epoch_photometry` tinyint unsigned,
  `has_epoch_rv` tinyint unsigned,
  `has_mcmc_gspphot` tinyint unsigned,
  `has_mcmc_msc` tinyint unsigned,
  `in_andromeda_survey` tinyint unsigned,
  `classprob_dsc_combmod_quasar` float,
  `classprob_dsc_combmod_galaxy` float,
  `classprob_dsc_combmod_star` float,
  `teff_gspphot` float,
  `teff_gspphot_lower` float,
  `teff_gspphot_upper` float,
  `logg_gspphot` float,
  `logg_gspphot_lower` float,
  `logg_gspphot_upper` float,
  `mh_gspphot` float,
  `mh_gspphot_lower` float,
  `mh_gspphot_upper` float,
  `distance_gspphot` float,
  `distance_gspphot_lower` float,
  `distance_gspphot_upper` float,
  `azero_gspphot` float,
  `azero_gspphot_lower` float,
  `azero_gspphot_upper` float,
  `ag_gspphot` float,
  `ag_gspphot_lower` float,
  `ag_gspphot_upper` float,
  `ebpminrp_gspphot` float,
  `ebpminrp_gspphot_lower` float,
  `ebpminrp_gspphot_upper` float,
  `libname_gspphot` varchar(40),
  `htm10ID` int(11) NOT NULL, 
  `htm13ID` int(11) NOT NULL,
  `htm16ID` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`source_id`),
  KEY `idx_ra` (`ra`),
  KEY `idx_dec` (`dec`),
  KEY `idx_ra_dec` (`ra`,`dec`),
  KEY `idx_htm10ID` (`htm10ID`),
  KEY `idx_htm13ID` (`htm13ID`),
  KEY `idx_htm16ID` (`htm16ID`),
  KEY `idx_phot_g_mag` (`phot_g_mean_mag`),
  KEY `idx_phot_bp_mag` (`phot_bp_mean_mag`),
  KEY `idx_phot_rp_mag` (`phot_rp_mean_mag`)
) ENGINE=MyISAM
;
