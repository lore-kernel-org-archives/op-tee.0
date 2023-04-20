From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [linux-next:master] BUILD REGRESSION 3cdbc01c40e34c57697f8934f2727a88551696be
Date: Thu, 20 Apr 2023 16:33:37 +0800
Message-ID: <6440f8e1.DHft6gojVbeQoyZh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2472245591090494386=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2472245591090494386==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git master
branch HEAD: 3cdbc01c40e34c57697f8934f2727a88551696be  Add linux-next specifi=
c files for 20230419

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304102354.Q4VOXGTE-lkp(a)intel.com
https://lore.kernel.org/oe-kbuild-all/202304200812.6UqNDVZy-lkp(a)intel.com
https://lore.kernel.org/oe-kbuild-all/202304201027.2upm4i0C-lkp(a)intel.com
https://lore.kernel.org/oe-kbuild-all/202304201216.YgbKeHUJ-lkp(a)intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:184:19: warning: varia=
ble 'dmub' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:138:15: warning: vari=
able 'feature_support' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:124:14: warning: =
no previous prototype for function 'dmub_abm_get_current_backlight' [-Wmissin=
g-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:135:14: warning: =
no previous prototype for function 'dmub_abm_get_target_backlight' [-Wmissing=
-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:146:6: warning: n=
o previous prototype for function 'dmub_abm_set_level' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:167:6: warning: n=
o previous prototype for function 'dmub_abm_set_ambient_level' [-Wmissing-pro=
totypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:189:6: warning: n=
o previous prototype for function 'dmub_abm_init_config' [-Wmissing-prototype=
s]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:221:6: warning: n=
o previous prototype for function 'dmub_abm_set_pause' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:241:6: warning: n=
o previous prototype for function 'dmub_abm_set_pipe' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:263:6: warning: n=
o previous prototype for function 'dmub_abm_set_backlight_level' [-Wmissing-p=
rototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:83:6: warning: no=
 previous prototype for function 'dmub_abm_init' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warni=
ng: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warni=
ng: variable 'link' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:451:16: warning: variable 'j' set but=
 not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1049:6: warning: no previous prototyp=
e for 'gfx_v9_4_3_disable_gpa_mode' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1049:6: warning: no previous prototyp=
e for function 'gfx_v9_4_3_disable_gpa_mode' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1072:6: warning: no previous prototyp=
e for 'gfx_v9_4_3_disable_gpa_mode' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:48:38: warning: unused variable 'gold=
en_settings_gc_9_4_3' [-Wunused-const-variable]
drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h:62: warning: wrong kernel-doc i=
dentifier on line:
drivers/gpu/drm/i915/i915_pmu.h:41: warning: This comment starts with '/**', =
but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_request.h:176: warning: This comment starts with '/=
**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc=
.rst
drivers/gpu/drm/i915/i915_vma.h:145: warning: expecting prototype for i915_vm=
a_offset(). Prototype was for i915_vma_size() instead
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: warning: variable 'ret' is =
uninitialized when used here [-Wuninitialized]
ld.lld: error: .btf.vmlinux.bin.o: unknown file type
phy-mtk-hdmi-mt8195.c:(.text+0x2e2): undefined reference to `__floatundidf'
phy-mtk-hdmi-mt8195.c:(.text+0x2f4): undefined reference to `__ltdf2'
phy-mtk-hdmi-mt8195.c:(.text+0x344): undefined reference to `__gedf2'
riscv64-linux-ld: phy-mtk-hdmi-mt8195.c:(.text+0x312): undefined reference to=
 `__gedf2'
riscv64-linux-ld: phy-mtk-hdmi-mt8195.c:(.text+0x32c): undefined reference to=
 `__ltdf2'

Unverified Error/Warning (likely false positive, please contact us if interes=
ted):

drivers/acpi/property.c:985 acpi_data_prop_read_single() error: potentially d=
ereferencing uninitialized 'obj'.
drivers/firmware/smccc/smccc.c:20:21: sparse: sparse: symbol 'smccc_soc_id_ve=
rsion' was not declared. Should it be static?
drivers/firmware/smccc/smccc.c:21:21: sparse: sparse: symbol 'smccc_soc_id_re=
vision' was not declared. Should it be static?
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:240 mtk_hdmi_pll_calc() warn: impo=
ssible condition '(tmds_clk < 1.483500e+02 * 1000000) =3D> (0.000000e+00-1.84=
4674e+19 < -1.786711e-113)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:242 mtk_hdmi_pll_calc() warn: alwa=
ys true condition '(tmds_clk >=3D 1.483500e+02 * 1000000) =3D> (0-u64max >=3D=
 -1.786711e-113)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:242 mtk_hdmi_pll_calc() warn: impo=
ssible condition '(tmds_clk < 2.967000e+02 * 1000000) =3D> (0.000000e+00-1.84=
4674e+19 < -4.419080e+60)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:244 mtk_hdmi_pll_calc() warn: alwa=
ys true condition '(tmds_clk >=3D 2.967000e+02 * 1000000) =3D> (0-u64max >=3D=
 -4.419080e+60)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298 mtk_hdmi_pll_calc() error: uni=
nitialized symbol 'ret'.
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:331 mtk_hdmi_pll_drv_setting() war=
n: always true condition '(pixel_clk >=3D 7.417500e+01 * 1000000) =3D> (0-u32=
max >=3D -7.223985e-287)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:336 mtk_hdmi_pll_drv_setting() war=
n: impossible condition '(pixel_clk < 7.417500e+01 * 1000000) =3D> (0.000000e=
+00-4.294967e+09 < -7.223985e-287)'
drivers/tee/optee/smc_abi.c:1021 irq_handler() error: uninitialized symbol 'v=
alue_valid'.
drivers/tee/optee/smc_abi.c:1028 irq_handler() error: uninitialized symbol 'v=
alue_pending'.
fs/xfs/scrub/refcount.c: xfs_mount.h is included more than once.
fs/xfs/scrub/refcount.c: xfs_trans_resv.h is included more than once.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- alpha-randconfig-r001-20230420
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|-- alpha-randconfig-r023-20230420
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- arc-buildonly-randconfig-r004-20230419
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|-- arc-randconfig-r043-20230420
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- arm64-randconfig-m041-20230419
|   |-- drivers-tee-optee-smc_abi.c-irq_handler()-error:uninitialized-symbol-=
value_pending-.
|   `-- drivers-tee-optee-smc_abi.c-irq_handler()-error:uninitialized-symbol-=
value_valid-.
|-- arm64-randconfig-r003-20230417
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|-- arm64-randconfig-s031-20230416
|   |-- drivers-firmware-smccc-smccc.c:sparse:sparse:symbol-smccc_soc_id_revi=
sion-was-not-declared.-Should-it-be-static
|   `-- drivers-firmware-smccc-smccc.c:sparse:sparse:symbol-smccc_soc_id_vers=
ion-was-not-declared.-Should-it-be-static
|-- csky-randconfig-m041-20230419
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-error:=
uninitialized-symbol-ret-.
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:a=
lways-true-condition-(tmds_clk-.483500e-)-(-u64max-.786711e-)
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:a=
lways-true-condition-(tmds_clk-.967000e-)-(-u64max-.419080e-)
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:i=
mpossible-condition-(tmds_clk-.483500e-)-(.000000e-.844674e-.786711e-)
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:i=
mpossible-condition-(tmds_clk-.967000e-)-(.000000e-.844674e-.419080e-)
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_drv_setting()=
-warn:always-true-condition-(pixel_clk-.417500e-)-(-u32max-.223985e-)
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_drv_setting()=
-warn:impossible-condition-(pixel_clk-.417500e-)-(.000000e-.294967e-.223985e-)
|-- csky-randconfig-r024-20230417
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- i386-randconfig-m021-20230417
|   `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentiall=
y-dereferencing-uninitialized-obj-.
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- ia64-randconfig-r034-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype=
-for-gfx_v9_4_3_disable_gpa_mode
|-- ia64-randconfig-s043-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype=
-for-gfx_v9_4_3_disable_gpa_mode
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- microblaze-randconfig-m041-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype=
-for-gfx_v9_4_3_disable_gpa_mode
|-- microblaze-randconfig-r004-20230420
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- mips-randconfig-c003-20230420
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype=
-for-gfx_v9_4_3_disable_gpa_mode
|-- mips-randconfig-s041-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:sparse:sp=
arse:cast-truncates-bits-from-constant-value-(ffff-becomes-ff)
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|-- openrisc-randconfig-c003-20230416
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|-- parisc-buildonly-randconfig-r003-20230419
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- riscv-randconfig-r016-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- riscv-randconfig-s052-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|   |-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype=
-for-gfx_v9_4_3_disable_gpa_mode
|   |-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__floatundidf
|   |-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__gedf2
|   |-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__ltdf2
|   |-- riscv64-linux-ld:phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to=
-__gedf2
|   `-- riscv64-linux-ld:phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to=
-__ltdf2
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype=
-for-gfx_v9_4_3_disable_gpa_mode
|-- sparc64-randconfig-s053-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-no=
t-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype=
-for-gfx_v9_4_3_disable_gpa_mode
|-- x86_64-allnoconfig
|   |-- fs-xfs-scrub-refcount.c:xfs_mount.h-is-included-more-than-once.
|   `-- fs-xfs-scrub-refcount.c:xfs_trans_resv.h-is-included-more-than-once.
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warni=
ng:variable-link-set-but-not-used
`-- x86_64-randconfig-m001-20230417
    `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentiall=
y-dereferencing-uninitialized-obj-.
clang_recent_errors
|-- arm64-buildonly-randconfig-r005-20230416
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-un=
initialized-when-used-here
|-- arm64-randconfig-r015-20230417
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-un=
initialized-when-used-here
|-- arm64-randconfig-r036-20230416
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:variab=
le-dmub-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm.c:warning:varia=
ble-feature_support-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:n=
o-previous-prototype-for-function-dmub_abm_get_current_backlight
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:n=
o-previous-prototype-for-function-dmub_abm_get_target_backlight
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:n=
o-previous-prototype-for-function-dmub_abm_init
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:n=
o-previous-prototype-for-function-dmub_abm_init_config
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:n=
o-previous-prototype-for-function-dmub_abm_set_ambient_level
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:n=
o-previous-prototype-for-function-dmub_abm_set_backlight_level
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:n=
o-previous-prototype-for-function-dmub_abm_set_level
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:n=
o-previous-prototype-for-function-dmub_abm_set_pause
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce-dmub_abm_lcd.c:warning:n=
o-previous-prototype-for-function-dmub_abm_set_pipe
|   |-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype=
-for-function-gfx_v9_4_3_disable_gpa_mode
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:unused-variable-golde=
n_settings_gc_9_4_3
|-- hexagon-randconfig-r023-20230417
|   `-- ld.lld:error:.btf.vmlinux.bin.o:unknown-file-type
|-- hexagon-randconfig-r045-20230420
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-un=
initialized-when-used-here
|-- mips-randconfig-r021-20230420
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-un=
initialized-when-used-here
|-- riscv-buildonly-randconfig-r006-20230419
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-un=
initialized-when-used-here
|-- riscv-randconfig-r032-20230416
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-un=
initialized-when-used-here
`-- x86_64-randconfig-a011-20230417
    |-- drivers-gpu-drm-i915-gt-uc-guc_capture_fwif.h:warning:wrong-kernel-do=
c-identifier-on-line:
    |-- drivers-gpu-drm-i915-i915_pmu.h:warning:This-comment-starts-with-but-=
isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    |-- drivers-gpu-drm-i915-i915_request.h:warning:This-comment-starts-with-=
but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    `-- drivers-gpu-drm-i915-i915_vma.h:warning:expecting-prototype-for-i915_=
vma_offset().-Prototype-was-for-i915_vma_size()-instead

elapsed time: 734m

configs tested: 190
configs skipped: 20

tested configs:
alpha                            allyesconfig   gcc =20
alpha        buildonly-randconfig-r005-20230417   gcc =20
alpha                               defconfig   gcc =20
alpha                randconfig-r001-20230416   gcc =20
alpha                randconfig-r001-20230420   gcc =20
alpha                randconfig-r003-20230416   gcc =20
alpha                randconfig-r013-20230416   gcc =20
alpha                randconfig-r023-20230420   gcc =20
arc                              allyesconfig   gcc =20
arc          buildonly-randconfig-r002-20230418   gcc =20
arc          buildonly-randconfig-r004-20230417   gcc =20
arc          buildonly-randconfig-r004-20230419   gcc =20
arc          buildonly-randconfig-r006-20230416   gcc =20
arc                                 defconfig   gcc =20
arc                  randconfig-r043-20230416   gcc =20
arc                  randconfig-r043-20230417   gcc =20
arc                  randconfig-r043-20230419   gcc =20
arc                  randconfig-r043-20230420   gcc =20
arm                              allmodconfig   gcc =20
arm                              allyesconfig   gcc =20
arm                         at91_dt_defconfig   gcc =20
arm                                 defconfig   gcc =20
arm                          ep93xx_defconfig   clang
arm                            hisi_defconfig   gcc =20
arm                        keystone_defconfig   gcc =20
arm                           omap1_defconfig   clang
arm                  randconfig-r006-20230416   gcc =20
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc =20
arm                  randconfig-r046-20230419   gcc =20
arm                  randconfig-r046-20230420   clang
arm                           tegra_defconfig   gcc =20
arm64                            allyesconfig   gcc =20
arm64        buildonly-randconfig-r004-20230418   clang
arm64        buildonly-randconfig-r005-20230416   clang
arm64        buildonly-randconfig-r005-20230419   gcc =20
arm64                               defconfig   gcc =20
arm64                randconfig-r003-20230417   gcc =20
arm64                randconfig-r015-20230417   clang
arm64                randconfig-r036-20230416   clang
csky         buildonly-randconfig-r004-20230416   gcc =20
csky         buildonly-randconfig-r006-20230418   gcc =20
csky                                defconfig   gcc =20
csky                 randconfig-r024-20230417   gcc =20
csky                 randconfig-r025-20230416   gcc =20
csky                 randconfig-r026-20230420   gcc =20
hexagon              randconfig-r005-20230417   clang
hexagon              randconfig-r012-20230417   clang
hexagon              randconfig-r016-20230417   clang
hexagon              randconfig-r023-20230417   clang
hexagon              randconfig-r031-20230418   clang
hexagon              randconfig-r035-20230416   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r041-20230419   clang
hexagon              randconfig-r041-20230420   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
hexagon              randconfig-r045-20230419   clang
hexagon              randconfig-r045-20230420   clang
i386                             allyesconfig   gcc =20
i386                              debian-10.3   gcc =20
i386                                defconfig   gcc =20
i386                 randconfig-a001-20230417   gcc =20
i386                 randconfig-a002-20230417   gcc =20
i386                 randconfig-a003-20230417   gcc =20
i386                 randconfig-a004-20230417   gcc =20
i386                 randconfig-a005-20230417   gcc =20
i386                 randconfig-a006-20230417   gcc =20
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
i386                 randconfig-r006-20230417   gcc =20
ia64                             allmodconfig   gcc =20
ia64                                defconfig   gcc =20
ia64                 randconfig-r022-20230416   gcc =20
ia64                 randconfig-r022-20230417   gcc =20
ia64                 randconfig-r026-20230416   gcc =20
ia64                 randconfig-r034-20230416   gcc =20
ia64                 randconfig-r036-20230418   gcc =20
ia64                            zx1_defconfig   gcc =20
loongarch                        allmodconfig   gcc =20
loongarch                         allnoconfig   gcc =20
loongarch                           defconfig   gcc =20
m68k                             allmodconfig   gcc =20
m68k                          atari_defconfig   gcc =20
m68k                                defconfig   gcc =20
m68k                        m5272c3_defconfig   gcc =20
microblaze   buildonly-randconfig-r003-20230418   gcc =20
microblaze           randconfig-r004-20230420   gcc =20
microblaze           randconfig-r021-20230417   gcc =20
mips                             allmodconfig   gcc =20
mips                             allyesconfig   gcc =20
mips                         cobalt_defconfig   gcc =20
mips                  decstation_64_defconfig   gcc =20
mips                malta_qemu_32r6_defconfig   clang
mips                        omega2p_defconfig   clang
mips                 randconfig-r012-20230416   clang
mips                 randconfig-r014-20230417   gcc =20
mips                 randconfig-r021-20230420   clang
mips                 randconfig-r034-20230418   gcc =20
nios2        buildonly-randconfig-r006-20230417   gcc =20
nios2                               defconfig   gcc =20
nios2                randconfig-r002-20230417   gcc =20
nios2                randconfig-r025-20230417   gcc =20
openrisc     buildonly-randconfig-r001-20230418   gcc =20
openrisc     buildonly-randconfig-r002-20230416   gcc =20
openrisc             randconfig-r011-20230417   gcc =20
parisc       buildonly-randconfig-r002-20230417   gcc =20
parisc       buildonly-randconfig-r003-20230419   gcc =20
parisc                              defconfig   gcc =20
parisc               randconfig-r021-20230416   gcc =20
parisc               randconfig-r023-20230416   gcc =20
parisc               randconfig-r024-20230416   gcc =20
parisc64                            defconfig   gcc =20
powerpc                          allmodconfig   gcc =20
powerpc                           allnoconfig   gcc =20
powerpc                      cm5200_defconfig   gcc =20
powerpc                    gamecube_defconfig   clang
powerpc                    klondike_defconfig   gcc =20
powerpc                      makalu_defconfig   gcc =20
powerpc                mpc7448_hpc2_defconfig   gcc =20
powerpc                     rainier_defconfig   gcc =20
powerpc                     redwood_defconfig   gcc =20
powerpc                     skiroot_defconfig   clang
powerpc                     taishan_defconfig   gcc =20
powerpc                         wii_defconfig   gcc =20
riscv                            allmodconfig   gcc =20
riscv                             allnoconfig   gcc =20
riscv        buildonly-randconfig-r003-20230416   gcc =20
riscv        buildonly-randconfig-r003-20230417   clang
riscv        buildonly-randconfig-r006-20230419   clang
riscv                               defconfig   gcc =20
riscv                randconfig-r005-20230416   clang
riscv                randconfig-r016-20230416   gcc =20
riscv                randconfig-r032-20230416   clang
riscv                randconfig-r032-20230418   clang
riscv                randconfig-r042-20230416   gcc =20
riscv                randconfig-r042-20230417   clang
riscv                randconfig-r042-20230419   clang
riscv                randconfig-r042-20230420   gcc =20
riscv                          rv32_defconfig   gcc =20
s390                             allmodconfig   gcc =20
s390                             allyesconfig   gcc =20
s390                                defconfig   gcc =20
s390                 randconfig-r002-20230420   clang
s390                 randconfig-r003-20230420   clang
s390                 randconfig-r044-20230416   gcc =20
s390                 randconfig-r044-20230417   clang
s390                 randconfig-r044-20230419   clang
s390                 randconfig-r044-20230420   gcc =20
sh                               allmodconfig   gcc =20
sh           buildonly-randconfig-r001-20230416   gcc =20
sh                         ecovec24_defconfig   gcc =20
sh                          r7785rp_defconfig   gcc =20
sh                   randconfig-r004-20230417   gcc =20
sh                   randconfig-r011-20230416   gcc =20
sh                          rsk7264_defconfig   gcc =20
sparc                               defconfig   gcc =20
sparc                       sparc32_defconfig   gcc =20
sparc64      buildonly-randconfig-r002-20230419   gcc =20
sparc64              randconfig-r026-20230417   gcc =20
um                             i386_defconfig   gcc =20
um                           x86_64_defconfig   gcc =20
x86_64                            allnoconfig   gcc =20
x86_64                           allyesconfig   gcc =20
x86_64                              defconfig   gcc =20
x86_64                                  kexec   gcc =20
x86_64               randconfig-a001-20230417   gcc =20
x86_64               randconfig-a002-20230417   gcc =20
x86_64               randconfig-a003-20230417   gcc =20
x86_64               randconfig-a004-20230417   gcc =20
x86_64               randconfig-a005-20230417   gcc =20
x86_64               randconfig-a006-20230417   gcc =20
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64                           rhel-8.3-bpf   gcc =20
x86_64                         rhel-8.3-kunit   gcc =20
x86_64                           rhel-8.3-kvm   gcc =20
x86_64                           rhel-8.3-syz   gcc =20
x86_64                               rhel-8.3   gcc =20
xtensa               randconfig-r015-20230416   gcc =20
xtensa                    smp_lx200_defconfig   gcc =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--===============2472245591090494386==--

