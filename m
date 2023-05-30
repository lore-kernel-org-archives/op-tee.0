From: Olivier Deprez <Olivier.Deprez@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee_benchmark pmccfiltr_el0
Date: Tue, 30 May 2023 13:07:20 +0000
Message-ID: <DB9PR08MB679648DBA443974A1B08ECD29B4B9@DB9PR08MB6796.eurprd08.prod.outlook.com>
In-Reply-To: <
 <0323e485-5803-4eed-8a44-86cf4d704d47.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2104447812710696760=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2104447812710696760==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuye,

In general the consensus is that PMU cycle and event counting in EL3 & secure=
 world has to be disabled. I gather this is to avoid probing crypto algorithm=
s timings, or leverage cache-based timing side channels (e.g. spectre).

See Arm ARM D11.5.3 Prohibiting event and cycle counting

Cycle and event counting is disabled by:
https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/include/arch=
/aarch64/el3_common_macros.S#n122

See also https://trustedfirmware-a.readthedocs.io/en/latest/process/security-=
hardening.html#secure-world-mitigation-strategies

Note there are various knobs depending on implemented architecture extensions=
 FEAT_PMUv3 / FEAT_PMUv3pX / FEAT_Debugv8p2

You could try to permit cycle counting in the secure world for the sake of a =
one shot experiment,
but note that this has never been tried, and this should probably not be prod=
uctized as things stand.

Regards,
Olivier.


________________________________
From: =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq@ali=
baba-inc.com>
Sent: 30 May 2023 10:38
To: Jens Wiklander <jens.wiklander@linaro.org>; Olivier Deprez <Olivier.Dep=
rez@arm.com>
Cc: op-tee <op-tee@lists.trustedfirmware.org>; hafnium <hafnium@lists.tru=
stedfirmware.org>; =E9=BB=84=E6=98=8E(=E8=BF=9E=E4=B8=80) <hm281385@alibaba=
-inc.com>
Subject: optee_benchmark pmccfiltr_el0




Hi,

It is confirmed that the problem is related to the pmu register configuration=
 and that pmccntr_el0 can be read at any exception level.

Regards,
Yuye.

------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B45=E6=9C=8826=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 16:59
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro.o=
rg>; Olivier Deprez <olivier.deprez@arm.com>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Aop-tee <op-tee@lists.trustedfirmware.or=
g>; hafnium <hafnium@lists.trustedfirmware.org>; =E9=BB=84=E6=98=8E(=E8=BF=
=9E=E4=B8=80) <hm281385@alibaba-inc.com>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9Aoptee_benchmark pmccfiltr_el0




Hi, Jens, Olivier,

In case of that optee runs at sel1 and hafnium runs at sel2, we want to test =
benchmark by executing the following command at optee_benchmark path:
./out/benchmark ../optee_examples/out/ca/optee_example_hello_world
After entering into the benchmark pta, the bm_timestamp function attempts to =
read the pmccfiltr_el0 register.
In cold boot, the following code will be executed during hafnium initializati=
on:
vm->arch.trapped_features |=3D HF_FEATURE_PERFMON;
This will prevent the secondary vm from accessing the performance counter reg=
isters.
We remove the code, the bm_timestamp function can read pmccfiltr_el0 without =
trapping into hafnium.
But the value of pmccfiltr_el0 remains unchanged and cannot be counted.
We tried to read the register in hafnium and found that there was no change e=
ither.
In contrast, in the normal world, pmccfiltr_el0 counts normally.
Is it related to the pmu register configuration or does sel1 not support the =
pmccfiltr_el0 count at present?

Thanks for the support.

Regards,
Yuye.


--===============2104447812710696760==--

