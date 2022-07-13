From: Olivier Deprez <Olivier.Deprez@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE MTE support
Date: Wed, 13 Jul 2022 13:38:49 +0000
Message-ID: <VE1PR08MB4976A1A0CE0D3E0C4C30184B9B899@VE1PR08MB4976.eurprd08.prod.outlook.com>
In-Reply-To: <=?utf-8?q?=3CVE1PR08MB4976593CAB0239C2FE9E075C9B899=40VE1PR08MB?=
 =?utf-8?q?4976=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3841077017244360114=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3841077017244360114==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

(in context of testing MTE support when OP-TEE is loaded as a secure partitio=
n on top of SEL2/Hafnium)

I appreciate MTE support is fresh starting with v3.18, bear with me if I miss=
ed details:

1/ noticed using both CFG_TA_PAUTH=3Dy CFG_MEMTAG=3Dy (if permitted) may brea=
k the build

diff --git a/core/tee/tee_svc.c b/core/tee/tee_svc.c
index 03bb174a..59f8afae 100644
--- a/core/tee/tee_svc.c
+++ b/core/tee/tee_svc.c
@@ -365,7 +365,7 @@ const struct tee_props tee_propset_tee[] =3D {
                .name =3D "org.trustedfirmware.optee.cpu.feat_pauth_implement=
ed",
                .prop_type =3D USER_TA_PROP_TYPE_BOOL,
                .get_prop_func =3D get_prop_feat_pauth_implemented
-       }
+       },
 #endif
 #if MEMTAG_IS_ENABLED
        {

2/ there seems to be a problem with CFG_CORE_SEL2_SPMC=3Dy CFG_MEMTAG=3Dy whe=
n it comes to build AArch32 TAs.
I guess CNTVCT only exists with AArch64:

In file included from lib/libutils/ext/arch/arm/memtag.c:6:
lib/libutee/include/arm_user_sysreg.h: In function 'barrier_read_counter_time=
r':
lib/libutee/include/arm_user_sysreg.h:28:9: error: implicit declaration of fu=
nction 'read_cntvct'; did you mean 'read_cntpct'? [-Werror=3Dimplicit-functio=
n-declaration]
   28 |  return read_cntvct();
      |         ^~~~~~~~~~~
      |         read_cntpct
lib/libutee/include/arm_user_sysreg.h:28:9: warning: nested extern declaratio=
n of 'read_cntvct' [-Wnested-externs]

3/ there seems to be a more general problem with using cache operations affec=
ting tags starting with boot_init_memtag
The DC GVA operation triggers an EL1 data abort with DFSC stating alignment f=
ault. I will continue debugging (on FVP) but I thought worth noting, and more=
 importantly confirming if this works on your side (perhaps on qemu?). SEL2 m=
ay miss disabling traps for certain cache operations.

4/ still about boot_init_memtag, it attempts clearing tags on the whole range=
 of TEE_RAM_START / TEE_RAM_PH_SIZE but it seems memory pages aren't marked a=
s normal tagged memory so I wonder if it works as expected. It may be harmles=
s though. Let me know if I miss something.

Thanks & Regards,
Olivier.

--===============3841077017244360114==--

