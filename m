From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCHv2 2/2] hwrng: optee: fix wait use case
Date: Thu, 06 Aug 2020 12:27:51 +0530
Message-ID: 
 <CAFA6WYMSXGKXx2vM2qcTLpRUugQUphM8Gn5YvPX9fTj3MHvXqQ@mail.gmail.com>
In-Reply-To: <20200806063040.GA27943@trex>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0495095647505037897=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0495095647505037897==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Aug 2020 at 12:00, Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 06/08/20, Sumit Garg wrote:
> > On Thu, 6 Aug 2020 at 02:08, Jorge Ramirez-Ortiz, Foundries
> > <jorge@foundries.io> wrote:
> > >
> > > On 05/08/20, Sumit Garg wrote:
> > > > Apologies for my delayed response as I was busy with some other tasks
> > > > along with holidays.
> > >
> > > no pb! was just making sure this wasnt falling through some cracks.
> > >
> > > >
> > > > On Fri, 24 Jul 2020 at 19:53, Jorge Ramirez-Ortiz, Foundries
> > > > <jorge@foundries.io> wrote:
> > > > >
> > > > > On 24/07/20, Sumit Garg wrote:
> > > > > > On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundr=
ies.io> wrote:
> > > > > > >
> > > > > > > The current code waits for data to be available before attempti=
ng a
> > > > > > > second read. However the second read would not be executed as t=
he
> > > > > > > while loop exits.
> > > > > > >
> > > > > > > This fix does not wait if all data has been read and reads a se=
cond
> > > > > > > time if only partial data was retrieved on the first read.
> > > > > > >
> > > > > > > This fix also does not attempt to read if not data is requested.
> > > > > >
> > > > > > I am not sure how this is possible, can you elaborate?
> > > > >
> > > > > currently, if the user sets max 0, get_optee_rng_data will regardle=
ss
> > > > > issuese a call to the secure world requesting 0 bytes from the RNG
> > > > >
> > > >
> > > > This case is already handled by core API: rng_dev_read().
> > >
> > > ah ok good point, you are right
> > > but yeah, there is no consequence to the actual patch.
> > >
> >
> > So, at least you could get rid of the corresponding text from commit mess=
age.
> >
> > > >
> > > > > with this patch, this request is avoided.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > > > > > ---
> > > > > > >  v2: tidy up the while loop to avoid reading when no data is re=
quested
> > > > > > >
> > > > > > >  drivers/char/hw_random/optee-rng.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/=
hw_random/optee-rng.c
> > > > > > > index 5bc4700c4dae..a99d82949981 100644
> > > > > > > --- a/drivers/char/hw_random/optee-rng.c
> > > > > > > +++ b/drivers/char/hw_random/optee-rng.c
> > > > > > > @@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *r=
ng, void *buf, size_t max, bool wait)
> > > > > > >         if (max > MAX_ENTROPY_REQ_SZ)
> > > > > > >                 max =3D MAX_ENTROPY_REQ_SZ;
> > > > > > >
> > > > > > > -       while (read =3D=3D 0) {
> > > > > > > +       while (read < max) {
> > > > > > >                 rng_size =3D get_optee_rng_data(pvt_data, data,=
 (max - read));
> > > > > > >
> > > > > > >                 data +=3D rng_size;
> > > > > > >                 read +=3D rng_size;
> > > > > > >
> > > > > > >                 if (wait && pvt_data->data_rate) {
> > > > > > > -                       if (timeout-- =3D=3D 0)
> > > > > > > +                       if ((timeout-- =3D=3D 0) || (read =3D=
=3D max))
> > > > > >
> > > > > > If read =3D=3D max, would there be any sleep?
> > > > >
> > > > > no but I see no reason why there should be a wait since we already =
have
> > > > > all the data that we need; the msleep is only required when we need=
 to
> > > > > wait for the RNG to generate entropy for the number of bytes we are
> > > > > requesting. if we are requesting 0 bytes, the entropy is already
> > > > > available. at leat this is what makes sense to me.
> > > > >
> > > >
> > > > Wouldn't it lead to a call as msleep(0); that means no wait as well?
> > >
> > > I dont understand: there is no reason to wait if read =3D=3D max and th=
is
> > > patch will not wait: if read =3D=3D max it calls 'return read'
> > >
> > > am I misunderstanding your point?
> >
> > What I mean is that we shouldn't require this extra check here as
> > there wasn't any wait if read =3D=3D max with existing implementation too.
>
> um, I am getting confused Sumit
>
> with the exisiting implementation (the one we aim to replace), if get_optee=
_rng_data reads all the values requested on the first call (ie, read =3D 0) w=
ith wait set to true, the call will wait with msleep(0). Which is unnecessary=
 and waits for a jiffy (ie, the call to msleep 0 will schedule a one jiffy ti=
meout interrruptible)
>
> with this alternative implementation, msleep(0) does not get called.
>
> are we in synch?

Ah, I see msleep(0) also by default schedules timeout for 1 jiffy. So
we are in sync now. Probably you can clarify this in commit message as
well to avoid confusion.

-Sumit

>
> >
> > -Sumit
> >
> > >
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > > >
> > > > > > -Sumit
> > > > > >
> > > > > > >                                 return read;
> > > > > > >                         msleep((1000 * (max - read)) / pvt_data=
->data_rate);
> > > > > > >                 } else {
> > > > > > > --
> > > > > > > 2.17.1
> > > > > > >

--===============0495095647505037897==--

