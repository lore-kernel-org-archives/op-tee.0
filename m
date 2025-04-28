From: Mario Limonciello <superm1@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] small amdtee cleanups
Date: Mon, 28 Apr 2025 12:47:17 -0500
Message-ID: <1a9cc4b2-9cb3-4c8b-a1e6-66388f1b2e8c@kernel.org>
In-Reply-To: <
 <CAHUa44GCZN197c=FHAmuUkZk0EQLxZ-sbwjvu-08NDjgRA1j2Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1569514715103631874=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1569514715103631874==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 4/28/2025 9:41 AM, Jens Wiklander wrote:
> On Mon, Apr 28, 2025 at 4:30=E2=80=AFPM Mario Limonciello <superm1@kernel=
.org> wrote:
>>
>> On 4/28/2025 9:27 AM, Jens Wiklander wrote:
>>> Hi,
>>>
>>> On Mon, Apr 21, 2025 at 5:22=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
>>>>
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> I just noticed a few small things for amdtee where the error messages
>>>> didn't consistently use the driver name.  While fixing that I noticed
>>>> the headers weren't sorted.
>>>>
>>>> These patches fix both issues.
>>>>
>>>> Mario Limonciello (2):
>>>>     tee: Use pr_fmt for messages
>>>>     tee: Sort header includes
>>>>
>>>>    drivers/tee/amdtee/core.c | 16 +++++++++-------
>>>>    1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> I'm trying to build this, but I run into some selinux build error. How
>>> did you build this?
>>
>> I used kworkflow (kw b).  It was based off linux-next at the time I
>> submitted it.
>=20
> I wasn't aware of kworkflow. I'm usually building manually locally or
> with tuxbuild.
>=20
>>
>> Can you share your .config?  Is it a defconfig?
>=20
> It's defconfig + CONFIG_CRYPTO_DEV_CCP=3Dy to get AMDTEE enabled. If you
> have an easier way, please let me know.
>=20
>>
>> Let me pull the tee tree directly and try again with that tree and I'll
>> see if I can reproduce the build error.
>=20
> The error is:
> security/selinux/nlmsgtab.c: In function =E2=80=98selinux_nlmsg_lookup=E2=
=80=99:
> security/selinux/nlmsgtab.c:188:33: error:
> =E2=80=98NETLINK_ROUTE_SOCKET__NLMSG=E2=80=99 undeclared (first use in this=
 function);
> did you mean =E2=80=98NETLINK_ROUTE_SOCKET__LOCK=E2=80=99?
>    188 |                         *perm =3D NETLINK_ROUTE_SOCKET__NLMSG;
>=20
>=20
> Cheers,
> Jens

Hmm, I couldn't reproduce.  I did defconfig + CONFIG_AMDTEE=3Dm

Here's your tree I based it from (tee/next):

9d172b0d7150c (HEAD) tee: Sort header includes
931240733ee67 tee: Use pr_fmt for messages
34e4aaeff2a84 (tee/next) Merge branch 'tee_for_v6_16' into next
26104d8156737 tee: optee: smc: remove unnecessary NULL check before=20
release_firmware()
8ffd015db85fe (tag: v6.15-rc2, tip/x86/platform) Linux 6.15-rc2

I also tried with this successfully.

=E2=9D=AF make drivers/tee/amdtee/ -j16 W=3D1
   CC [M]  drivers/tee/amdtee/core.o
   CC [M]  drivers/tee/amdtee/call.o
   CC [M]  drivers/tee/amdtee/shm_pool.o
   LD [M]  drivers/tee/amdtee/amdtee.o

--===============1569514715103631874==--

