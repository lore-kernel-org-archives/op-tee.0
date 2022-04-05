From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add missing mutext_destroy in optee_ffa_probe
Date: Tue, 05 Apr 2022 09:02:26 +0200
Message-ID: 
 <CAHUa44F3ic_Fu-pLsZ2sZeC69TSLwKZjegdkCB-xpm=Zm6J4PA@mail.gmail.com>
In-Reply-To: <
 <CAD-N9QWB9HGY=DU1gazbt3e8p4GdG-=CJtD26M59AgAhbagusA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1577374820890879093=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1577374820890879093==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 1, 2022 at 4:00 AM Dongliang Mu <mudongliangabcd@gmail.com> wro=
te:
>
> On Thu, Mar 24, 2022 at 5:33 PM Dongliang Mu <mudongliangabcd@gmail.com> =
wrote:
> >
> > On Thu, Mar 24, 2022 at 4:29 PM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > On Wed, Mar 16, 2022 at 2:51 PM Dongliang Mu <dzm91@hust.edu.cn> wrot=
e:
> > > >
> > > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > > >
> > > > The error handling code of optee_ffa_probe misses the mutex_destroy of
> > > > ffa.mutex when mutext_init succeeds.
> > > >
> > > > Fix this by adding mutex_destory of ffa.mutex at the error handling p=
art
> > > >
> > > > Fixes: aceeafefff73 ("optee: use driver internal tee_context for some=
 rpc")
> > >
> > > I believe this should be
> > > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > > don't you agree?
> >
> > Hi Jen,
> >
> > This commit 4615e5a34b95 is more suitable since mutex_init is introduced =
here.
> >
> > Why did I label the commit aceeafefff73?
> >
> > Because this commit tried to fix the issue, but only added one
> > mutex_destroy for &optee->call_queue.mutex, misses &optee->ffa.mutex.
> >
>
> ping?

I'm picking up this.

Thanks,
Jens

--===============1577374820890879093==--

