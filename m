From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
Date: Wed, 18 Sep 2024 12:54:46 +0300
Message-ID: <ZuqjZswbhLY1iEfr@smile.fi.intel.com>
In-Reply-To: <94e37138-ae66-4336-93ac-79683f2058aa@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5770157731123895949=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5770157731123895949==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 09:22:19AM +0200, Jerome Forissier wrote:
> On 9/16/24 11:38, Andy Shevchenko wrote:
> > On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
> >> On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
> >>> On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
> >>>> On Wed, Sep 11, 2024 at 10:41=E2=80=AFPM Andy Shevchenko
> >>>> <andriy.shevchenko@linux.intel.com> wrote:
> >>>>>
> >>>>> Replace the custom approach with the %pUl printk() format specifier.
> >>>>> No functional change intended.
> >>>
> >>>> Thanks, the patch looks like a nice simplificatrion.
> >>>
> >>> Thank you for the review.
> >>>
> >>>> Rijo, Devaraj, does this work for you?
> >>>
> >>> Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
> >>> but in this driver IIUC it's guid_t (UUID LE).
> >>
> >> No, this does not work for us. I tested this patch, it does not work as =
expected.
> >>
> >> %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%0=
2x%02x%02x).
> >> But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x=
%02x%02x%02x%02x%02x.
> >>
> >> Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
> >> While, in our TA naming we are using 3 hyphens (-).
> >=20
> > Ah, good catch! Can somebody add a comment there to explain that this uses
> > non-standard human-readable representation of GUID/UUID?
>=20
> Could this be due to some copying/pasting from the OP-TEE code base which h=
ad
> a similar mistake prior to v2.3.0 [1][2][3]?
>=20
> [1] https://github.com/OP-TEE/optee_os/blob/2.3.0/CHANGELOG.md?plain=3D1#L4=
0-L45
> [2] https://github.com/OP-TEE/optee_client/commit/a5b1ffcd26e3
> [3] https://github.com/OP-TEE/optee_client/commit/365657667f89

Interesting... Is somebody going to update this to follow the proper format?
(yes, I understand that the old one has still to be supported)

> > P.S. Thank you for testing!

--=20
With Best Regards,
Andy Shevchenko



--===============5770157731123895949==--

