From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: optee_benchmark pmccfiltr_el0
Date: Fri, 26 May 2023 16:59:29 +0800
Message-ID: 
 <23c88b7e-c7b0-4975-912a-0dde4dbad031.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3649861780965056985=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3649861780965056985==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jens, Olivier,
In case of that optee runs at sel1 and hafnium runs at sel2, we want to test =
benchmark by executing the following command at optee_benchmark path:
./out/benchmark ../optee_examples/out/ca/optee_example_hello_world
After entering into the benchmark pta, the bm_timestamp function attempts to =
read the pmccfiltr_el0 register.=20
In cold boot, the following code will be executed during hafnium initializati=
on:
vm->arch.trapped_features |=3D HF_FEATURE_PERFMON;
This will prevent the secondary vm from accessing the performance counter reg=
isters.=20
We remove the code, the bm_timestamp function can read pmccfiltr_el0 without =
trapping into hafnium.
But the value of pmccfiltr_el0 remains unchanged and cannot be counted.=20
We tried to read the register in hafnium and found that there was no change e=
ither.
In contrast, in the normal world, pmccfiltr_el0 counts normally.=20
Is it related to the pmu register configuration or does sel1 not support the =
pmccfiltr_el0 count at present?
Thanks for the support.
Regards,
Yuye.

--===============3649861780965056985==--

