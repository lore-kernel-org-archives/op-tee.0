From: Elvira Khabirova <e.khabirova@omprussia.ru>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: client UUID: Skip REE kernel login method as well
Date: Tue, 22 Dec 2020 12:24:43 +0300
Message-ID: <20201222122443.5725c0b3@akathisia>
In-Reply-To: <=?utf-8?q?=3C0100017689a4ef7d-0b0fb453-d4af-4a56-a458-863e26585?=
 =?utf-8?q?b76-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2048390094714395057=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2048390094714395057==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Dec 2020 08:50:56 +0000
Vesa J=C3=A4=C3=A4skel=C3=A4inen via OP-TEE <op-tee@lists.trustedfirmware.o=
rg> wrote:

> Hi,
>=20
> On 2020-10-08 08:53, Jens Wiklander wrote:
> > Hi Sumit,
> >=20
> > On Wed, Oct 7, 2020 at 11:27 AM Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> >>
> >> Hi Jens,
> >>
> >> On Thu, 17 Sep 2020 at 19:10, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>>
> >>> Since the addition of session's client UUID generation via commit [1],
> >>> login via REE kernel method was disallowed. So fix that via passing
> >>> nill UUID in case of TEE_IOCTL_LOGIN_REE_KERNEL method as well.
> >>>
> >>> Fixes: e33bcbab16d1 ("tee: add support for session's client UUID genera=
tion") [1]
> >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>> ---
> >>>   drivers/tee/tee_core.c | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>
> >> Would you like to pick up this fix?
> >=20
> > Thanks for the reminder.
> > This looks good to me. I'll pick up this unless someone objects.
> > Vesa, does this look good to you too?
> >=20
> > Cheers,
> > Jens
>=20
> Sorry I have been away for a while from the mailing list.
>=20
> It seems that this is merged -- only thing that came to my mind with=20
> this is that:
>=20
> If we have some kernel protected keys or so -- should we have separate=20
> client UUID for kernel operations.
>=20
> Like when TEE_IOCTL_LOGIN_REE_KERNEL is given then client UUID would be=20
> generated for "kernel".
>=20
> This way we can make sure that kernel owned keys stays for kernel. Nil=20
> UUID is kinda reserved for public login.

Isn't this unnecessary? According to the TEE Internal Core API Specification,
TEE_Identity, a data type that "defines the full identity of a Client", consi=
sts
of a UUID *and* one of the TEE_LOGIN_XXX constants. Therefore, TEE_LOGIN_PUBL=
IC
with a nil UUID is a different client than TEE_LOGIN_REE_KERNEL with a nil UU=
ID.

> Thanks,
> Vesa J=C3=A4=C3=A4skel=C3=A4inen
>=20
> >=20
> >>
> >> -Sumit
> >>
> >>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> >>> index 64637e0..2f6199e 100644
> >>> --- a/drivers/tee/tee_core.c
> >>> +++ b/drivers/tee/tee_core.c
> >>> @@ -200,7 +200,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 =
connection_method,
> >>>          int name_len;
> >>>          int rc;
> >>>
> >>> -       if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC) {
> >>> +       if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC ||
> >>> +           connection_method =3D=3D TEE_IOCTL_LOGIN_REE_KERNEL) {
> >>>                  /* Nil UUID to be passed to TEE environment */
> >>>                  uuid_copy(uuid, &uuid_null);
> >>>                  return 0;
> >>> --
> >>> 2.7.4
> >>>
>=20


--===============2048390094714395057==--

