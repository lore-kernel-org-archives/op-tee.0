From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: Make use of the helper macro LIST_HEAD()
Date: Tue, 15 Feb 2022 07:49:41 +0100
Message-ID: 
 <CAHUa44G0UY9a7v6KTCx4LdChDZyS1Y0zCmKEXzyddsshFLgv8g@mail.gmail.com>
In-Reply-To: <302e8426-5a22-23dd-2b3b-7eb6d0ee2e8d@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2286813756157652805=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2286813756157652805==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 9, 2022 at 8:16 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
>
>
> On 2/9/2022 8:57 AM, Cai Huoqing wrote:
> > Replace "struct list_head head =3D LIST_HEAD_INIT(head)" with
> > "LIST_HEAD(head)" to simplify the code.
> >
> > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > ---
> >  drivers/tee/amdtee/call.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> > index 07f36ac834c8..cec6e70f0ac9 100644
> > --- a/drivers/tee/amdtee/call.c
> > +++ b/drivers/tee/amdtee/call.c
> > @@ -122,7 +122,7 @@ static int amd_params_to_tee_params(struct tee_param =
*tee, u32 count,
> >  }
> >
> >  static DEFINE_MUTEX(ta_refcount_mutex);
> > -static struct list_head ta_list =3D LIST_HEAD_INIT(ta_list);
> > +static LIST_HEAD(ta_list);
> >
>
> Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

I'm picking up this.

Thanks,
Jens

>
> Thanks,
> Rijo
>
> >  static u32 get_ta_refcount(u32 ta_handle)
> >  {
> >

--===============2286813756157652805==--

