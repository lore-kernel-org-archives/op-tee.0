From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [Hafnium] Boot arguments for S-EL1 with SPMC at S-EL2
Date: Mon, 27 Mar 2023 11:08:35 +0800
Message-ID: 
 <d101daba-6c34-4211-acf6-05e48d035c1e.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8630984697934686744=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8630984697934686744==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, Olivier,
Whether Boot Information Blob is a file similar to manifest.dtb or sp.pkg?=20
How do I generate this blob?=20
Does it need to be packaged into atf firmware at compile phase=EF=BC=9F
Thanks.
Regards,
Yuye.
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.com>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B43=E6=9C=8821=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) 22:37
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro.o=
rg>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Ahafnium(a)lists.trustedfirmware.org <hafn=
ium@lists.trustedfirmware.org>; OP-TEE TrustedFirmware <op-tee@lists.trus=
tedfirmware.org>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [Hafnium] Boot arguments for S-EL1 wi=
th SPMC at S-EL2
Hi Jens,
See comments inline [OD].
Regards,
Olivier.
________________________________
From: Jens Wiklander via Hafnium <hafnium@lists.trustedfirmware.org>
Sent: 21 March 2023 09:30
To: Olivier Deprez <Olivier.Deprez@arm.com>
Cc: hafnium(a)lists.trustedfirmware.org <hafnium@lists.trustedfirmware.org>=
; OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Subject: [Hafnium] Boot arguments for S-EL1 with SPMC at S-EL2
Hi Olivier,
I'm trying to implement a relocatable OP-TEE binary so it can be
loaded at different physical addresses without the need to recompile
it. This means that in the case with Hafnium when changing
"load-address" or "entrypoint-offset" in the OP-TEE SP manifest
there's no need to recompile OP-TEE. For this to work OP-TEE must be
able to figure out which memory range it's supposed to reside in.
[OD] Fair enough, I believe that would conflate into some generic PIE support?
I can see how this helps with the multi OP-TEE instances use case, perhaps?
Currently, OP-TEE knows the entry point address from PC and "memory
size" from X0. However, the "memory size" is from the "load-address"
so "entrypoint-offset" must be subtracted from PC in order to know the
allocated memory range.
Do you have ideas on how OP-TEE at runtime can determine the allocated
memory range?
[OD] The standard way would be to use the FF-A boot protocol e.g. if you add =
this to OP-TEE's SP manifest:
+ /* Boot protocol */
+ gp-register-num =3D <0x0>;
+
+ /* Boot Info */
+ boot-info {
+ compatible =3D "arm,ffa-manifest-boot-info";
+ ffa_manifest;
+ };
See https://trustedfirmware-a.readthedocs.io/en/latest/components/secure-part=
ition-manager.html#passing-boot-data-to-the-sp <https://trustedfirmware-a.rea=
dthedocs.io/en/latest/components/secure-partition-manager.html#passing-boot-d=
ata-to-the-sp >
At SP entry, x0 contains the address of a 'Boot Information Blob' (FF-A v1.1 =
REL0 section 5.4.2) starting with a Boot Information Header (Table 5.9).
The SP manifest DT address can be extracted from a Boot Information Descripto=
r (Table 5.8).
Eventually the SP is able to parse its own SP manifest, into which it finds F=
F-A standard fields (load-address...) in addition to any impdef field added.
Note the partition size is not standarded (it should probably be), so for sta=
rters you can add your own memsize field.
There is some sample usage in TF-a-tests:
https://git.trustedfirmware.org/TF-A/tf-a-tests.git/tree/spm/cactus/cactus_ma=
in.c#n146 <https://git.trustedfirmware.org/TF-A/tf-a-tests.git/tree/spm/cactu=
s/cactus_main.c#n146 >
and also in context of EDKII/StMM:
https://github.com/odeprez/edk2/commit/7066c913cb227056d68ea99de5e92f2067fe78=
7e <https://github.com/odeprez/edk2/commit/7066c913cb227056d68ea99de5e92f2067=
fe787e >
Thanks,
Jens
--
Hafnium mailing list -- hafnium(a)lists.trustedfirmware.org
To unsubscribe send an email to hafnium-leave(a)lists.trustedfirmware.org

--===============8630984697934686744==--

