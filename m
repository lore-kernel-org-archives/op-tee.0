From: Lars Persson <larper@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] optee: Do not send requests to supplicant during shutdown
Date: Mon, 24 Jan 2022 18:47:58 +0100
Message-ID: <c7ffb030-2ca9-96ed-6580-0c7691e3338b@axis.com>
In-Reply-To: <
 <CAFA6WYPNQnKqseZTbb=NyOmswUO=x-CE1CcADZa+Kga_fozB9g@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8126915728472501222=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8126915728472501222==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 2022-01-24 06:56, Sumit Garg wrote:
> Hi Lars,
>=20
> On Thu, 20 Jan 2022 at 16:10, Lars Persson <larper@axis.com> wrote:
>>
>> The addition of a shutdown hook by commit f25889f93184 ("optee:
>> fix tee out of memory failure seen during kexec reboot") introduced a
>> kernel shutdown regression that can be triggered after running the
>> xtest suites.
>>
>> Once the shutdown hook is called it is not possible to communicate any
>> more with the supplicant process because the system is not scheduling
>> task any longer. Thus if the optee driver shutdown path receives a
>> supplicant RPC request from the OP-TEE we will deadlock the kernel's
>> shutdown.
>>
>> This unexpected event will in fact occur after the xtest suite has
>> been run. It seems some cached SHM kept alive a context object which
>> in turn kept alive a session towards a PTA or TA. Closing the session
>> results in a socket RPC command being sent back from OP-TEE.
>>
>> This sequence of events is captured by a 5.15 kernel annotated with
>> extra prints:
>>
>>=C2=A0 Calling OPTEE_SMC_DISABLE_SHM_CACHE
>>=C2=A0 OPTEE_SMC_DISABLE_SHM_CACHE returned 0
>>=C2=A0=C2=A0 freeing SHM ptr 0xFFFFFF8001079380
>>=C2=A0 Calling OPTEE_SMC_DISABLE_SHM_CACHE
>>=C2=A0 OPTEE_SMC_DISABLE_SHM_CACHE returned 0
>>=C2=A0=C2=A0 freeing SHM ptr 0xFFFFFF8001CC5580
>>=C2=A0 Calling OPTEE_SMC_DISABLE_SHM_CACHE
>>=C2=A0 OPTEE_SMC_DISABLE_SHM_CACHE returned 0
>>=C2=A0=C2=A0 freeing SHM ptr 0xFFFFFF8006308A80
>>=C2=A0 Calling OPTEE_SMC_DISABLE_SHM_CACHE
>>=C2=A0 OPTEE_SMC_DISABLE_SHM_CACHE returned 0
>>=C2=A0=C2=A0 freeing SHM ptr 0xFFFFFF8006308B00
>>=C2=A0 optee: optee_handle_rpc: a0=3D0XFFFF0000 a1=3D0XA0 a2=3D0X0
>>=C2=A0 optee: optee_handle_rpc: a0=3D0XFFFF0005 a1=3D0XFFFFFF80 a2=3D0X61E6=
500
>>=C2=A0 optee: handle_rpc_func_cmd: cmd =3D 0XA
>>=C2=A0 optee_supp_thrd_req: func=3D0XA
>>
>=20
> This looks like another side effect (earlier known one is here [1]) of
> shared memory cache being allocated via RPC in a particular client's
> context. There is an appropriate fix from Jens here [2] to rather use
> driver internal tee_contex for RPC allocations. Can you try that and
> let us know if you still observe this issue?
>=20
> [1] https://github.com/OP-TEE/optee_os/issues/1918=20
> <https://github.com/OP-TEE/optee_os/issues/1918>
> [2]=20
> https://lore.kernel.org/lkml/20220114150824.3578829-8-jens.wiklander(a)lina=
ro.org/=20
> <https://lore.kernel.org/lkml/20220114150824.3578829-8-jens.wiklander@lin=
aro.org/>
>=20
> -Sumit
>

Indeed it seems this is the root cause. Backporting the patches to 5.15=20
also fixes our shutdown deadlock.

Nevertheless I prefer to have this extra guard in the supplicant=20
interface to prevent other shutdown deadlocks in the future.

/Lars

--===============8126915728472501222==--

