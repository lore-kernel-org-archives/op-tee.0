From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
Date: Mon, 16 Sep 2024 12:51:15 +0300
Message-ID: <Zuf_k3z4DBiiMoSp@smile.fi.intel.com>
In-Reply-To: <Zuf8wQEwsAX_1hI0@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4988452136153925699=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4988452136153925699==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 12:39:14PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 16, 2024 at 12:38:08PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
> > > On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
> > > > On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
> > > >> On Wed, Sep 11, 2024 at 10:41=E2=80=AFPM Andy Shevchenko
> > > >> <andriy.shevchenko@linux.intel.com> wrote:
> > > >>>
> > > >>> Replace the custom approach with the %pUl printk() format specifier.
> > > >>> No functional change intended.
> > > >=20
> > > >> Thanks, the patch looks like a nice simplificatrion.
> > > >=20
> > > > Thank you for the review.
> > > >=20
> > > >> Rijo, Devaraj, does this work for you?
> > > >=20
> > > > Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
> > > > but in this driver IIUC it's guid_t (UUID LE).
> > >=20
> > > No, this does not work for us. I tested this patch, it does not work as=
 expected.
> > >=20
> > > %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%=
02x%02x%02x).
> > > But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02=
x%02x%02x%02x%02x%02x.
> > >=20
> > > Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
> > > While, in our TA naming we are using 3 hyphens (-).
> >=20
> > Ah, good catch! Can somebody add a comment there to explain that this uses
> > non-standard human-readable representation of GUID/UUID?
> >=20
> > P.S. Thank you for testing!
>=20
> Alternatively we may get rid of that hyphen. I can send a patch.

Something like this on top of this patch (meaning squashed at the end):

+	/*
+	 * Firmware name uses non-standard human-readable GUID representation:
+	 * %08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x (no last hyphen).
+	 */
+	p =3D strrchr(fw_name, '-');
+	memmove(p, p + 1, strlen(p + 1));
+
 	mutex_lock(&drv_mutex);
 	n =3D request_firmware(&fw, fw_name, &ctx->teedev->dev);

What do you think?

--=20
With Best Regards,
Andy Shevchenko



--===============4988452136153925699==--

