From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v1 1/1] tee: optee: Provide special parameter field for
 UUID values
Date: Mon, 19 Apr 2021 15:01:32 +0300
Message-ID: <YH1xHDbFyJ1URYYV@smile.fi.intel.com>
In-Reply-To: <
 <CAHUa44FWJiL1yzHR0jwL2VJG_4t_O6An48v47gORitcaahwmYw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9074459502368411837=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9074459502368411837==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2021 at 01:35:51PM +0200, Jens Wiklander wrote:
> On Thu, Apr 15, 2021 at 4:58 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

Thanks for review, my answer below.

> >                 struct optee_msg_param_tmem tmem;
> >                 struct optee_msg_param_rmem rmem;
> >                 struct optee_msg_param_value value;
> > +               uuid_t uuid;
>=20
> It's nice to get rid of the cast above, but I'm not that keen on the
> change in this struct. This file defines the ABI towards Secure world
> and adding dependencies on external complex types is a larger problem
> than the cast above in my opinion.

I understand.

So, the cast is simply wrong there. Can you add a comment above that cast to
explain that and make it is marked as FIXME? Because there is no guarantee th=
at
internal Linux types can be 1:1 mapped to the ABI of something.

What you need, perhaps, is a middle layer function that will copy u64 data
to uuid_t or so. Also, u64 is not an ABI type, why the respective __uXX
variants are not in use?

--=20
With Best Regards,
Andy Shevchenko



--===============9074459502368411837==--

