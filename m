From: Lars Persson <larper@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Do not send requests to supplicant during shutdown
Date: Thu, 20 Jan 2022 08:58:41 +0100
Message-ID: <2541b86e-59bc-0f6a-841d-92aee05e15f2@axis.com>
In-Reply-To: <20220120010216.GC89184@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0769914856407603202=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0769914856407603202==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 2022-01-20 02:02, Tyler Hicks wrote:
> On 2022-01-19 18:49:33, Lars Persson wrote:
>> The addition of a shutdown hook by commit f25889f93184 ("optee:
>> fix tee out of memory failure seen during kexec reboot") introduced a
>> kernel shutdown regression that can be triggered after running the
>> xtest suites.
>>=20
>> Once the shutdown hook is called it is not possible to communicate any
>> more with the supplicant process because the system is not scheduling
>> task any longer. Thus if the optee driver shutdown path receives a
>> supplicant RPC request from the OP-TEE we will deadlock the kernel's
>> shutdown.
>=20
> The system that I'm working on, and initially developed the kexec fixes
> for, doesn't use a supplicant process so that would explain why I
> haven't seen this issue.
>=20
> What I'm a little unclear about is why the new(ish) .shutdown hook would
> be the cause for this deadlock because it doesn't disable scheduling of
> tasks (unless I'm forgetting something). Does disabling the shm cache
> also cause tasks to no longer be scheduled? I'm having trouble finding
> the documentation that describes this operation and my memory is fuzzy
> since it has been a while since I've worked on OP-TEE issues.
>=20

I tried to look for an explicit disable of the scheduler starting from=20
do_sys_reboot but that was impossible to find. It might be hidden=20
somewhere in the use of the system_state variable.

Anyways since the do_sys_reboot system call is the last step of shutting=20
down a system, any interaction with user-space will be a BadThing. The=20
supplicant would typically be killed by the init process already in a=20
clean shutdown, and if it wasn't, then device_shutdown() will remove the=20
block devices that the file-system depends on. Any page fault in the=20
supplicant would thus kill it. I am sure there is somewhere a piece of=20
code that disables task scheduling before calling device_shutdown=20
because so many crazy things could happen otherwise.

>> Introduce a shutdown state in the optee device object to return an
>> immediate error to all RPC requests in the shutdown path.
>>=20
>> Fixes: f25889f93184 ("optee: fix tee out of memory failure seen during kex=
ec reboot
>=20
> Minor syntax error at the end of this line as it is missing the closing
> double quotes and parenthesis.
>=20

Thanks. Let's see if Jens makes a fixup for this. Otherwise I can submit=20
a v2.

/Lars

--===============0769914856407603202==--

