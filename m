From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v1 1/1] tee: optee: Provide special parameter field for
 UUID values
Date: Mon, 19 Apr 2021 17:41:56 +0300
Message-ID: 
 <CAHp75VfUrNmrCgX4WQqwc-CCBv2niDp0iwidc0LvJOx+A-mfcA@mail.gmail.com>
In-Reply-To: <
 <CAHUa44GOZL=2Owua2fD79EnBuzVAh-Oh3nZ=cA1TQy0NAgNMaw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8972456641322198882=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8972456641322198882==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2021 at 5:30 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> On Mon, Apr 19, 2021 at 3:40 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Apr 19, 2021 at 4:30 PM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > > On Mon, Apr 19, 2021 at 2:01 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Apr 19, 2021 at 01:35:51PM +0200, Jens Wiklander wrote:
> > > > > On Thu, Apr 15, 2021 at 4:58 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > Thanks for review, my answer below.
> > > >
> > > > > >                 struct optee_msg_param_tmem tmem;
> > > > > >                 struct optee_msg_param_rmem rmem;
> > > > > >                 struct optee_msg_param_value value;
> > > > > > +               uuid_t uuid;
> > > > >
> > > > > It's nice to get rid of the cast above, but I'm not that keen on the
> > > > > change in this struct. This file defines the ABI towards Secure wor=
ld
> > > > > and adding dependencies on external complex types is a larger probl=
em
> > > > > than the cast above in my opinion.
> > > >
> > > > I understand.
> > > >
> > > > So, the cast is simply wrong there. Can you add a comment above that =
cast to
> > > > explain that and make it is marked as FIXME? Because there is no guar=
antee that
> > > > internal Linux types can be 1:1 mapped to the ABI of something.
> > >
> > > We might as well fix it directly instead. How about storing the
> > > intermediate result in a proper uuid_t and then export it as:
> > > export_uuid((u8 *)&msg_arg->params[1].u.uuid, &myuuid);
> >
> > Still a casting here.
> > With u64 members you have a (potential) endianness issue (consider
> > BE-32 platform). Also you never know that a b c translates properly to
> > byte array.
> >
> > I would rather see a custom function
> >
> > optee_import_uuid(param, uuid_t *uuid)
> > {
> >   u8 uuid_raw[UUID_SIZE];
> >
> >   put_unaligned_le64(&uuid_raw[0], param.a); // not sure about endianness
> >   put_unaligned_le64(&uuid_raw[0], param.b); // ditto
>
> I believe it's a memcpy() we want then, since UUIDs are supposed to be
> transmitted using a big endian memory pattern.
> We should perhaps add
> u8 octets[24];
> to that union. Then should the result be well defined using export_uuid().

Right, if you do that, it would be wonderful!

> >   import_uuid();
> > }
> >
> > > > What you need, perhaps, is a middle layer function that will copy u64=
 data
> > > > to uuid_t or so. Also, u64 is not an ABI type, why the respective __u=
XX
> > > > variants are not in use?
> > >
> > > Does it make any difference? The file isn't shared with user space and
> > > I need to sync the file manually anyway since OP-TEE doesn't have the
> > > same include files.
> >
> > Yes. It gives a hint that these are ABI (that's why I felt free to add
> > a member to the union. I have no idea that's an ABI). Optionally a
> > comment suggesting that.
>
> It does say that it defines a protocol at the beginning of the file, I
> can add ABI too if you think that helps.

I read the structure definition, perhaps some clarification on a data
type level would be nice.

Thanks!

--=20
With Best Regards,
Andy Shevchenko

--===============8972456641322198882==--

