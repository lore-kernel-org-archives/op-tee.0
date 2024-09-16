From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
Date: Mon, 16 Sep 2024 12:39:13 +0300
Message-ID: <Zuf8wQEwsAX_1hI0@smile.fi.intel.com>
In-Reply-To: <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0322147277862129462=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0322147277862129462==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 12:38:08PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
> > On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
> > > On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
> > >> On Wed, Sep 11, 2024 at 10:41=E2=80=AFPM Andy Shevchenko
> > >> <andriy.shevchenko@linux.intel.com> wrote:
> > >>>
> > >>> Replace the custom approach with the %pUl printk() format specifier.
> > >>> No functional change intended.
> > >=20
> > >> Thanks, the patch looks like a nice simplificatrion.
> > >=20
> > > Thank you for the review.
> > >=20
> > >> Rijo, Devaraj, does this work for you?
> > >=20
> > > Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
> > > but in this driver IIUC it's guid_t (UUID LE).
> >=20
> > No, this does not work for us. I tested this patch, it does not work as e=
xpected.
> >=20
> > %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02=
x%02x%02x).
> > But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x%=
02x%02x%02x%02x%02x.
> >=20
> > Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
> > While, in our TA naming we are using 3 hyphens (-).
>=20
> Ah, good catch! Can somebody add a comment there to explain that this uses
> non-standard human-readable representation of GUID/UUID?
>=20
> P.S. Thank you for testing!

Alternatively we may get rid of that hyphen. I can send a patch.

--=20
With Best Regards,
Andy Shevchenko



--===============0322147277862129462==--

