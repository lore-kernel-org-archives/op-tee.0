From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: optee_benchmark found optee_os function vm_set_ctx() spent much time
Date: Mon, 26 Jun 2023 09:50:34 +0200
Message-ID: 
 <CAHUa44FUqg-1fnMDRyUX7AtO8A0S_8KGbRK231n=vp4s0q4ePg@mail.gmail.com>
In-Reply-To: <
 <88d54731-d577-45f7-aca0-9d0ef1059cef.haiyuan.ghy@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6579415583163729991=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6579415583163729991==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Comments below.

On Fri, Jun 23, 2023 at 3:10=E2=80=AFAM =E9=AB=98=E6=B5=B7=E6=BA=90(=E7=A0=81=
=E6=BA=90) <haiyuan.ghy@alibaba-inc.com> wrote:

> Hi, Jens, Olivier:
>
>     I'm a colleague of Yuye, and we are doing optee benchmark and
> performance optimization.
>     We are using optee_os/optee_client/optee_examples/optee_benchmark
> version 3.20.0
>
>     We think the host API TEEC_InvokeCommand() is sensitive of delay,
> namely TEE framework like OpenEnclave called ECALL.
>     So we remove all prints in hello_world_ta.c
> 's TA_InvokeCommandEntryPoint(), host test TEEC_InvokeCommand() 10k times
> to calculate average time cost.
>     We tested on an ArmV9 data-center server,  and we got average time is
> about 20 us.
>
>     After using optee_benchmark tool, we found optee_os
> function user_ta_enter() took most of time.
>     Specially, user_ta_enter() calls ts_push_current_session()
> and ts_pop_current_session(), then calls vm_set_ctx() twice, which spend
> 7 us and 2 us respectively, mostly of 20 us delay.
>     I added logs to print some pointers,  following is the log
> in update_current_ctx()
>
>
[JW] That's interesting.


> I found that many InvokeCommand repeat following pattern
>
> E/TC:??? 000 user_ta_enter:155 =3D=3D=3D=3D=3D=3D session 0x8940b5d80 func =
2 cmd 4,
> call ts_push_current_session
>
> E/TC:??? 000 update_current_ctx:29 session 0x8940b5d80 tsd 0x89008dd38
> tsd->ctx 0x0 ctx 0x8940b5d28
>
> E/TC:??? 000 user_ta_enter:199 =3D=3D=3D=3D=3D=3D session 0x8940b5d80 func =
2 cmd 4,
> call ts_pop_current_session
>
> E/TC:??? 000 update_current_ctx:29 session 0x0 tsd 0x89008dd38 tsd->ctx
> 0x8940b5d28 ctx 0x0
>
> I noticed many InvokeCommand use the same ctx pointer like 0x8940b5d28
>

[JW] I guess that's because you're calling the same TA repeatedly.


>
> My question is:
>     Can many InvokeCommand avoid setting tsd->ctx to Non-NULL ctx, then
> NULL ctx, to remove the vm_set_ctx() cost of time?
>     Is there any optimization method, likely many InvokeCommand in the
> same session reuse the same Non-NULL ctx, to reduce average delay of
> ECALLs?
>

[JW] Does it make any difference if you compile OP-TEE with
CFG_CORE_PREALLOC_EL0_TBLS=3Dy ?

The next step (with CFG_CORE_PREALLOC_EL0_TBLS=3Dy) is to see which part of
vm_set_ctx() we should try to optimize or if we should try to find a way of
delaying the call to vm_set_ctx().

Cheers,
Jens


>
> Thanks. Best wishes.
>
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AOlivier Deprez<Olivier.Deprez@arm.com>
> =E6=97=A5 =E6=9C=9F=EF=BC=9A2023=E5=B9=B405=E6=9C=8830=E6=97=A5 21:07:20
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander<jens.wiklander@linaro.=
org>; =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C)<
> meijianqiang.mjq(a)alibaba-inc.com>
> =E6=8A=84 =E9=80=81=EF=BC=9Aop-tee<op-tee@lists.trustedfirmware.org>; haf=
nium<
> hafnium(a)lists.trustedfirmware.org>; =E9=BB=84=E6=98=8E<hm281385@alibaba=
-inc.com>
> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: optee_benchmark pmccfiltr_el0
>
> Hi Yuye,
>
> In general the consensus is that PMU cycle and event counting in EL3 &
> secure world has to be disabled. I gather this is to avoid probing crypto
> algorithms timings, or leverage cache-based timing side channels (e.g.
> spectre).
>
> See Arm ARM D11.5.3 Prohibiting event and cycle counting
>
> Cycle and event counting is disabled by:
>
> https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/include/ar=
ch/aarch64/el3_common_macros.S#n122
>
> See also
> https://trustedfirmware-a.readthedocs.io/en/latest/process/security-hardeni=
ng.html#secure-world-mitigation-strategies
>
> Note there are various knobs depending on implemented architecture
> extensions FEAT_PMUv3 / FEAT_PMUv3pX / FEAT_Debugv8p2
>
> You could try to permit cycle counting in the secure world for the sake of
> a one shot experiment,
> but note that this has never been tried, and this should probably not be
> productized as things stand.
>
> Regards,
> Olivier.
>
>
> ------------------------------
> *From:* =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq(a=
)alibaba-inc.com>
> *Sent:* 30 May 2023 10:38
> *To:* Jens Wiklander <jens.wiklander@linaro.org>; Olivier Deprez <
> Olivier.Deprez(a)arm.com>
> *Cc:* op-tee <op-tee@lists.trustedfirmware.org>; hafnium <
> hafnium(a)lists.trustedfirmware.org>; =E9=BB=84=E6=98=8E(=E8=BF=9E=E4=B8=80=
) <hm281385@alibaba-inc.com>
> *Subject:* optee_benchmark pmccfiltr_el0
>
>
>
>
> Hi,
>
> It is confirmed that the problem is related to the pmu register
> configuration and that pmccntr_el0 can be read at any exception level.
>
> Regards,
> Yuye.
>
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B45=E6=9C=8826=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 16:59
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro=
.org>; Olivier Deprez <
> olivier.deprez(a)arm.com>
> =E6=8A=84 =E9=80=81=EF=BC=9Aop-tee <op-tee@lists.trustedfirmware.org>; ha=
fnium <
> hafnium(a)lists.trustedfirmware.org>; =E9=BB=84=E6=98=8E(=E8=BF=9E=E4=B8=80=
) <hm281385@alibaba-inc.com>
> =E4=B8=BB =E9=A2=98=EF=BC=9Aoptee_benchmark pmccfiltr_el0
>
>
>
>
> Hi, Jens, Olivier,
>
> In case of that optee runs at sel1 and hafnium runs at sel2, we want to
> test benchmark by executing the following command at optee_benchmark path:
> ./out/benchmark ../optee_examples/out/ca/optee_example_hello_world
> After entering into the benchmark pta, the bm_timestamp function attempts
> to read the pmccfiltr_el0 register.
> In cold boot, the following code will be executed during hafnium
> initialization:
> vm->arch.trapped_features |=3D HF_FEATURE_PERFMON;
> This will prevent the secondary vm from accessing the performance counter
> registers.
> We remove the code, the bm_timestamp function can read pmccfiltr_el0
> without trapping into hafnium.
> But the value of pmccfiltr_el0 remains unchanged and cannot be counted.
> We tried to read the register in hafnium and found that there was no
> change either.
> In contrast, in the normal world, pmccfiltr_el0 counts normally.
> Is it related to the pmu register configuration or does sel1 not support
> the pmccfiltr_el0 count at present?
>
> Thanks for the support.
>
> Regards,
> Yuye.
>
>
>
>

--===============6579415583163729991==--

