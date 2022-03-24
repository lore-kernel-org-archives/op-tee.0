From: Dongliang Mu <mudongliangabcd@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add missing mutext_destroy in optee_ffa_probe
Date: Thu, 24 Mar 2022 17:33:12 +0800
Message-ID: 
 <CAD-N9QU=_M2_=GsQii8R85o46PnsxcLqJGFKA0UANbRWAFnjHQ@mail.gmail.com>
In-Reply-To: <
 <CAHUa44FiumE97drc11vBdr46Zh2uWysk--bn2AZnaw==5bTphA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7356699194851613441=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7356699194851613441==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2022 at 4:29 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> On Wed, Mar 16, 2022 at 2:51 PM Dongliang Mu <dzm91@hust.edu.cn> wrote:
> >
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > The error handling code of optee_ffa_probe misses the mutex_destroy of
> > ffa.mutex when mutext_init succeeds.
> >
> > Fix this by adding mutex_destory of ffa.mutex at the error handling part
> >
> > Fixes: aceeafefff73 ("optee: use driver internal tee_context for some rpc=
")
>
> I believe this should be
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> don't you agree?

Hi Jen,

This commit 4615e5a34b95 is more suitable since mutex_init is introduced here.

Why did I label the commit aceeafefff73?

Because this commit tried to fix the issue, but only added one
mutex_destroy for &optee->call_queue.mutex, misses &optee->ffa.mutex.

>
> Thanks,
> Jens
>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index f744ab15bf2c..30a6119a2b16 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -894,6 +894,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, N=
ULL);
> >         optee_supp_uninit(&optee->supp);
> >         mutex_destroy(&optee->call_queue.mutex);
> > +       mutex_destroy(&optee->ffa.mutex);
> >  err_unreg_supp_teedev:
> >         tee_device_unregister(optee->supp_teedev);
> >  err_unreg_teedev:
> > --
> > 2.25.1
> >

--===============7356699194851613441==--

