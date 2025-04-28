From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] small amdtee cleanups
Date: Mon, 28 Apr 2025 16:41:44 +0200
Message-ID: 
 <CAHUa44GCZN197c=FHAmuUkZk0EQLxZ-sbwjvu-08NDjgRA1j2Q@mail.gmail.com>
In-Reply-To: <86167ea5-8bc4-4aa6-a980-8d9e37c776ae@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4026014116818102702=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4026014116818102702==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 4:30=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 4/28/2025 9:27 AM, Jens Wiklander wrote:
> > Hi,
> >
> > On Mon, Apr 21, 2025 at 5:22=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> I just noticed a few small things for amdtee where the error messages
> >> didn't consistently use the driver name.  While fixing that I noticed
> >> the headers weren't sorted.
> >>
> >> These patches fix both issues.
> >>
> >> Mario Limonciello (2):
> >>    tee: Use pr_fmt for messages
> >>    tee: Sort header includes
> >>
> >>   drivers/tee/amdtee/core.c | 16 +++++++++-------
> >>   1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > I'm trying to build this, but I run into some selinux build error. How
> > did you build this?
>
> I used kworkflow (kw b).  It was based off linux-next at the time I
> submitted it.

I wasn't aware of kworkflow. I'm usually building manually locally or
with tuxbuild.

>
> Can you share your .config?  Is it a defconfig?

It's defconfig + CONFIG_CRYPTO_DEV_CCP=3Dy to get AMDTEE enabled. If you
have an easier way, please let me know.

>
> Let me pull the tee tree directly and try again with that tree and I'll
> see if I can reproduce the build error.

The error is:
security/selinux/nlmsgtab.c: In function =E2=80=98selinux_nlmsg_lookup=E2=80=
=99:
security/selinux/nlmsgtab.c:188:33: error:
=E2=80=98NETLINK_ROUTE_SOCKET__NLMSG=E2=80=99 undeclared (first use in this f=
unction);
did you mean =E2=80=98NETLINK_ROUTE_SOCKET__LOCK=E2=80=99?
  188 |                         *perm =3D NETLINK_ROUTE_SOCKET__NLMSG;


Cheers,
Jens

--===============4026014116818102702==--

