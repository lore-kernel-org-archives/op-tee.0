From: Dongliang Mu <mudongliangabcd@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add missing mutext_destroy in optee_ffa_probe
Date: Fri, 01 Apr 2022 10:00:16 +0800
Message-ID: 
 <CAD-N9QWB9HGY=DU1gazbt3e8p4GdG-=CJtD26M59AgAhbagusA@mail.gmail.com>
In-Reply-To: <
 <CAD-N9QU=_M2_=GsQii8R85o46PnsxcLqJGFKA0UANbRWAFnjHQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4960162178658825740=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4960162178658825740==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2022 at 5:33 PM Dongliang Mu <mudongliangabcd@gmail.com> wr=
ote:
>
> On Thu, Mar 24, 2022 at 4:29 PM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > On Wed, Mar 16, 2022 at 2:51 PM Dongliang Mu <dzm91@hust.edu.cn> wrote:
> > >
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > The error handling code of optee_ffa_probe misses the mutex_destroy of
> > > ffa.mutex when mutext_init succeeds.
> > >
> > > Fix this by adding mutex_destory of ffa.mutex at the error handling part
> > >
> > > Fixes: aceeafefff73 ("optee: use driver internal tee_context for some r=
pc")
> >
> > I believe this should be
> > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > don't you agree?
>
> Hi Jen,
>
> This commit 4615e5a34b95 is more suitable since mutex_init is introduced he=
re.
>
> Why did I label the commit aceeafefff73?
>
> Because this commit tried to fix the issue, but only added one
> mutex_destroy for &optee->call_queue.mutex, misses &optee->ffa.mutex.
>

ping?

> >
> > Thanks,
> > Jens
> >
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/tee/optee/ffa_abi.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > > index f744ab15bf2c..30a6119a2b16 100644
> > > --- a/drivers/tee/optee/ffa_abi.c
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -894,6 +894,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)
> > >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn,=
 NULL);
> > >         optee_supp_uninit(&optee->supp);
> > >         mutex_destroy(&optee->call_queue.mutex);
> > > +       mutex_destroy(&optee->ffa.mutex);
> > >  err_unreg_supp_teedev:
> > >         tee_device_unregister(optee->supp_teedev);
> > >  err_unreg_teedev:
> > > --
> > > 2.25.1
> > >

--===============4960162178658825740==--

