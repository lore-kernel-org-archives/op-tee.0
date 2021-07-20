From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
Date: Tue, 20 Jul 2021 13:15:17 -0500
Message-ID: <20210720181517.GF3232@sequoia>
In-Reply-To: <bc3f4bdd-b833-d58c-f7d7-6670bcbd8ef8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2110734408155667002=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2110734408155667002==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-07-20 10:57:18, Florian Fainelli wrote:
>=20
>=20
> On 7/19/2021 7:32 PM, Florian Fainelli wrote:
> >=20
> >=20
> > On 7/19/2021 3:49 AM, Jens Wiklander wrote:
> > > Hi,
> > >=20
> > > On Fri, Jul 16, 2021 at 4:48 AM Vikas Gupta
> > > <vikas.gupta@broadcom.com> wrote:
> > > >=20
> > > > Hi Allen/Tyler,
> > > > =C2=A0 The patch looks good to me.
> > >=20
> > > Thanks.
> > >=20
> > > Rafal, is it OK if I include this patch together with the rest of the
> > > patches in this patch set in a pull request to arm-soc?
> >=20
> > I can take those patches through the Broadcom ARM SoC pull request,
> > Rafal would that work for you? We seem to have a bit of a maintainer
> > coverage blind spot for that directory.
>=20
> Applied to drivers/fixes: https://github.com/Broadcom/stblinux/commit/4ecd7=
97b7e16eb7f1b86fbfd7e4a7887b192535b

Thanks, Florian, but note that you won't be able to build that branch
since the commit uses a new function (tee_shm_alloc_kernel_buf()) that's
added earlier in the full series. It seems like it is going to be easier
for this to all go through Jens.

Tyler

> --=20
> Florian
>=20

--===============2110734408155667002==--

